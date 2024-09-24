from cx_reinforcement_learning.cxrl_gym import CXRLGym


class OvercookedEnv(CXRLGym):
    def __init__(self):
        number_of_robots = 1
        step_wait_time = 5
        reset_wait_time = 5
        self.reward_in_episode = 0
        super().__init__(number_of_robots, step_wait_time, reset_wait_time)

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
        self.get_logger().info("Generating action space...")
        action_space =  ["MOVE-PLATE-FROM-SINK-TO-COUNTER#order#1",
                         "MOVE-PLATE-FROM-SINK-TO-COUNTER#order#2",
                         "MOVE-PLATE-FROM-SINK-TO-COUNTER#order#3",
                         "PUT-COOKED-BEEF-ON-PLATE#order#1",
                         "PUT-COOKED-BEEF-ON-PLATE#order#2",
                         "PUT-COOKED-BEEF-ON-PLATE#order#3",
                         "PUT-BUN-ON-PLATE#order#1",
                         "PUT-BUN-ON-PLATE#order#2",
                         "PUT-BUN-ON-PLATE#order#3",
                         "PUT-CHEESE-ON-PLATE#order#1",
                         "PUT-CHEESE-ON-PLATE#order#2",
                         "PUT-CHEESE-ON-PLATE#order#3",
                         "PUT-CHOPPED-LETTUCE-ON-PLATE#order#1",
                         "PUT-CHOPPED-LETTUCE-ON-PLATE#order#2",
                         "PUT-CHOPPED-LETTUCE-ON-PLATE#order#3",
                         "PUT-CHOPPED-TOMATO-ON-PLATE#order#1",
                         "PUT-CHOPPED-TOMATO-ON-PLATE#order#2",
                         "PUT-CHOPPED-TOMATO-ON-PLATE#order#3",
                         "DELIVER-PLATE#order#1",
                         "DELIVER-PLATE#order#2",
                         "DELIVER-PLATE#order#3"
                        ]       
        return action_space

    def render(self):
        pass

    