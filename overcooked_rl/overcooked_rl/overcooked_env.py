from cx_reinforcement_learning.cxrl_gym import CXRLGym
from rclpy.node import Node


class OvercookedEnv(CXRLGym):
    def __init__(self, node: Node):
        self.reward_in_episode = 0
        super().__init__(node)

    def step(self, action):
        with open("log-episode-reward.txt", 'a+') as f:
            f.write(f"{self.action_dict[action]} \n")
        state, reward, done, truncated, info = super().step(action)
        self.reward_in_episode += reward
        return state, reward, done, truncated, info
    
    def reset(self, seed: int = None, options: dict[str, any] = None):
        with open("log-episode-reward.txt", 'a+') as f:
            f.write(f"{self.reward_in_episode} \n")
        self.reward_in_episode = 0
        return super().reset(seed=seed)
    
    def generate_action_space(self):
        self.node.get_logger().info("Generating action space...")
        action_space =  ["MOVE-PLATE-FROM-SINK-TO-COUNTER#order#1",
                         "MOVE-PLATE-FROM-SINK-TO-COUNTER#order#2",
                         "MOVE-PLATE-FROM-SINK-TO-COUNTER#order#3",
                         "MOVE-PLATE-FROM-SINK-TO-COUNTER#order#4",
                         "MOVE-PLATE-FROM-SINK-TO-COUNTER#order#5",
                         "PUT-COOKED-BEEF-ON-PLATE#order#1",
                         "PUT-COOKED-BEEF-ON-PLATE#order#2",
                         "PUT-COOKED-BEEF-ON-PLATE#order#3",
                         "PUT-COOKED-BEEF-ON-PLATE#order#4",
                         "PUT-COOKED-BEEF-ON-PLATE#order#5",
                         "PUT-BUN-ON-PLATE#order#1",
                         "PUT-BUN-ON-PLATE#order#2",
                         "PUT-BUN-ON-PLATE#order#3",
                         "PUT-BUN-ON-PLATE#order#4",
                         "PUT-BUN-ON-PLATE#order#5",
                         "PUT-CHEESE-ON-PLATE#order#1",
                         "PUT-CHEESE-ON-PLATE#order#2",
                         "PUT-CHEESE-ON-PLATE#order#3",
                         "PUT-CHEESE-ON-PLATE#order#4",
                         "PUT-CHEESE-ON-PLATE#order#5",
                         "PUT-CHOPPED-LETTUCE-ON-PLATE#order#1",
                         "PUT-CHOPPED-LETTUCE-ON-PLATE#order#2",
                         "PUT-CHOPPED-LETTUCE-ON-PLATE#order#3",
                         "PUT-CHOPPED-LETTUCE-ON-PLATE#order#4",
                         "PUT-CHOPPED-LETTUCE-ON-PLATE#order#5",
                         "PUT-CHOPPED-TOMATO-ON-PLATE#order#1",
                         "PUT-CHOPPED-TOMATO-ON-PLATE#order#2",
                         "PUT-CHOPPED-TOMATO-ON-PLATE#order#3",
                         "PUT-CHOPPED-TOMATO-ON-PLATE#order#4",
                         "PUT-CHOPPED-TOMATO-ON-PLATE#order#5",
                         "DELIVER-PLATE#order#1",
                         "DELIVER-PLATE#order#2",
                         "DELIVER-PLATE#order#3",
                         "DELIVER-PLATE#order#4",
                         "DELIVER-PLATE#order#5"
                        ]       
        return action_space

    def render(self):
        pass

    