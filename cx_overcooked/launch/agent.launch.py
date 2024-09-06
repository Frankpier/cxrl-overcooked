import os

from ament_index_python.packages import get_package_share_directory

from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, SetEnvironmentVariable
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node


def generate_launch_description():
    cx_overcooked_dir = get_package_share_directory('cx_overcooked')
    
    dummy_skiller_file = LaunchConfiguration('dummy_skiller_file')

    clips_manager_params_file = LaunchConfiguration(
        'clips_manager_params_file')
    clips_executive_params_file = LaunchConfiguration(
        'clips_executive_params_file')
    clips_features_manager_params_file = LaunchConfiguration(
        'clips_features_manager_params_file')

    lc_nodes = ["clips_features_manager", "clips_executive"]

    declare_clips_manager_params_file = DeclareLaunchArgument(
        'clips_manager_params_file',
        default_value=os.path.join(cx_overcooked_dir, 'params', 'agent.yaml'),
        description='Path to the file containing clips_manager node params')
    declare_clips_executive_params_file = DeclareLaunchArgument(
        'clips_executive_params_file',
        default_value=os.path.join(
            cx_overcooked_dir, 'params', 'agent.yaml'),
        description='Path to the file containing clips_executive node params')
    declare_clips_features_manager_params_file = DeclareLaunchArgument(
        'clips_features_manager_params_file',
        default_value=os.path.join(
            cx_overcooked_dir,
            'params',
            'clips_features_manager.yaml'),
        description='Path to the file containing clips_features_manager params')
    declare_dummy_skiller_file = DeclareLaunchArgument(
        'dummy_skiller_file',
        default_value=os.path.join(
            cx_overcooked_dir, 'params', 'dummy_skiller.yaml'),
        description='Path to the file containing dummy skiller params')

    cx_node = Node(
        package='cx_bringup',
        executable='cx_node',
        output='screen',
        emulate_tty=True,
        parameters=[
            # Important to let CLIPS know where the executive and features
            # config is
            {"agent_dir": cx_overcooked_dir},
            {"clips_executive_config": clips_executive_params_file},
            {"clips_features_manager_config": clips_features_manager_params_file},
            clips_features_manager_params_file,
            clips_manager_params_file,
            clips_executive_params_file
        ]
    )

    robot1_dummy_skill_node = Node(
        package='cx_example_skill_nodes',
        executable='dummy_skill_node',
        name='robot1_skill_node',
        output='screen',
        emulate_tty=True,
        parameters=[{"robot_id": "robot1"}, dummy_skiller_file]
    )

    cx_lifecycle_manager = Node(
        package='cx_lifecycle_nodes_manager',
        executable='lifecycle_manager_node',
        name='cx_lifecycle_manager',
        output='screen',
        emulate_tty=True,
        parameters=[{"node_names_to_manage": lc_nodes}]
    )

    config = os.path.join(cx_overcooked_dir, 'params', 'training-config.yaml')

    cxrl_training_node = Node(
        package='cx_reinforcement_learning',
        executable='cxrl_training',
        namespace='cxrl_training',
        name='overcooked_training_node',
        output='screen',
        emulate_tty=True,
        parameters= [config]
    )

    # The lauchdescription to populate with defined CMDS
    ld = LaunchDescription()

    ld.add_action(declare_clips_manager_params_file)
    ld.add_action(declare_clips_executive_params_file)
    ld.add_action(declare_clips_features_manager_params_file)
    ld.add_action(declare_dummy_skiller_file)
    ld.add_action(robot1_dummy_skill_node)
    ld.add_action(cx_node)
    ld.add_action(cx_lifecycle_manager)
    ld.add_action(cxrl_training_node)

    return ld
