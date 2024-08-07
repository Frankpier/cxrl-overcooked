import os

from ament_index_python.packages import get_package_share_directory

from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, SetEnvironmentVariable
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node


def generate_launch_description():
    cx_overcooked_dir = get_package_share_directory('cx_overcooked')

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

    cx_lifecycle_manager = Node(
        package='cx_lifecycle_nodes_manager',
        executable='lifecycle_manager_node',
        name='cx_lifecycle_manager',
        output='screen',
        emulate_tty=True,
        parameters=[{"node_names_to_manage": lc_nodes}]
    )

    # The lauchdescription to populate with defined CMDS
    ld = LaunchDescription()

    ld.add_action(declare_clips_manager_params_file)
    ld.add_action(declare_clips_executive_params_file)
    ld.add_action(declare_clips_features_manager_params_file)

    ld.add_action(cx_node)
    ld.add_action(cx_lifecycle_manager)

    return ld
