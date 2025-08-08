


SYSTEM_MESSAGE_1 = """You are a helpful assistant that categorizes motivations for decisions in an economic experiment, considering performance outcomes and redistribution choices.

**Context:**
Two participants attempt to solve up to 24 problems in 10 minutes. The participant who solves the most problems (Y, the winner) receives earnings proportional to their performance; the other (X, the loser) receives nothing.

A third party - the Decision Maker (DM) - can redistribute some of Y's earnings to X. After making their decision, the DM provides a written motivation. Your task is to classify these motivations into one of the following categories exhaustive and exclusive categories (choose only one from the list):

**"libertarian"**: Appeals to rules, procedures, or default entitlements - regardless of performance.

**"meritocrat - does not mention margin"**: Arguments based on performance or effort, but with no reference to the size of the performance gap.

**"meritocrat - does mention the margin"**: Arguments based on performance that explicitly reference the size of the performance gap or the relative number of problems solved.

**"egalitarian"**: Arguments favoring equal outcomes without any reference to merit, performance, or effort.

**"compensate"**: Motivation centers on helping the loser out, without merit-based or equality-based reasoning.

**"fairness"**: Vague or general appeals to fairness without further elaboration.

**"logic"**: The DM states that their choice was the logical or obvious one, without justification rooted in merit, fairness, or equality.

**"incentives"**: The motivation focuses on encouraging future effort or behavior (e.g., rewarding winners to incentivize performance).

**"no reason"**: The DM gives no coherent reason, or simply restates their decision, or no reason at all.

**"misunderstand"**: The DM clearly misunderstands the rules of the task or the meaning of the redistribution.

"""

SYSTEM_MESSAGE_2 = """You are a helpful assistant that categorizes motivations for decisions in an economic experiment, considering performance outcomes and redistribution choices.

**Context:**
Two participants attempt to solve up to 24 problems in 10 minutes. The participant who solves the most problems (Y, the winner) receives earnings proportional to their performance; the other (X, the loser) receives nothing.

A third party - the Decision Maker (DM) - can redistribute some of Y's earnings to X. After making their decision, the DM provides a written motivation. Your task is to classify these motivations into one of the following categories exhaustive and exclusive categories (choose only one from the list):

**"libertarian"**: Appeals to rules, procedures, or default entitlements - regardless of performance.

**"meritocrat - does not mention margin"**: Arguments based on performance or effort, but with no reference to the size of the performance gap.

**"meritocrat - does mention the margin"**: Arguments based on performance that explicitly reference the size of the performance gap or the relative number of problems solved.

**"egalitarian"**: Arguments favoring equal outcomes without any reference to merit, performance, or effort.

**"fairness"**: Vague or general appeals to fairness without further elaboration.

**"other"**: Motivation cannot be classified into any of the above categories.

"""

SYSTEM_MESSAGE_3 = """You are a helpful assistant that categorizes motivations for decisions in an economic experiment, considering performance outcomes and redistribution choices.

**Context:**
Two participants attempt to solve up to 24 problems in 10 minutes. The participant who solves the most problems (Y, the winner) receives earnings proportional to their performance; the other (X, the loser) receives nothing.

A third party - the Decision Maker (DM) - can redistribute some of Y's earnings to X. After making their decision, the DM provides a written motivation. Your task is to classify these motivations into one of the following categories exhaustive and exclusive categories (choose only one from the list):

**"libertarian"**: Appeals to rules, procedures, or default entitlements - regardless of performance.

**"meritocrat - does not mention margin"**: Arguments based on performance or effort, but with no reference to the size of the performance gap.

**"meritocrat - does mention the margin"**: Arguments based on performance that explicitly reference the size of the performance gap or the relative number of problems solved.

**"egalitarian"**: Arguments favoring equal outcomes without any reference to merit, performance, or effort.

**"compensate"**: Motivation centers on helping the loser out, without merit-based or equality-based reasoning.

**"fairness"**: Vague or general appeals to fairness without further elaboration.

**"logic"**: The DM states that their choice was the logical or obvious one, without justification rooted in merit, fairness, or equality.

**"incentives"**: The motivation focuses on encouraging future effort or behavior (e.g., rewarding winners to incentivize performance).

**"no reason"**: The DM gives no coherent reason, or simply restates their decision, or no reason at all.

**"misunderstand"**: The DM clearly misunderstands the rules of the task or the meaning of the redistribution.

Example 1:
Input: "the rules"
Category: libertarian


Example 2:
Input: "The numbers where so close it isn't fair to that participants time to not get a bonus"
Category: meritocrat - does mention the margin


Example 3:
Input: "The instructions said that the person with fewer correct answers would get nothing and the person with the most correct answers would get .15 per correct answer. Changing the bonus would not be right or moral."
Category: libertarian


Example 4:
Input: "Although Participant Y solved 16 problems and Participant X solved 12 problems, I feel both should be compensated. Participant X should get something for solving the problems although they did not complete as many."
Category: meritocrat - does not mention margin


Example 5:
Input: "since they both took their time to solve the tasks they both deserve to receive a bonus, i allocated 2 dollars to participant Y because he solved more and the rest $1.15 goes tp participant X"
Category: meritocrat - does not mention margin


Example 6:
Input: "It appears to me that X did better in their grouping than Y did in their's. Thus, a sharing of the wealth is appropriate."
Category: misunderstand


Example 7:
Input: "I had no reason to take what they earned."
Category: libertarian


Example 8:
Input: "I chose to allocate some of the earnings of participant Y to participant X since he solved fewer problems, and it would be fair to redistribute some in this instance."
Category: meritocrat - does not mention margin


Example 9:
Input: "Xdid answer 11 questions. Even though Yanswered 4 more wuestions-I feel X should be given something for trying to answer as many as she could."
Category: meritocrat - does not mention margin


Example 10:
Input: "I feel like participant X lost by 6 to participant Y. Because of their results being close, I feel like participant X should b rewarded something for solving some right."
Category: meritocrat - does mention the margin


Example 11:
Input: "maybe I failed to understand you fully but if one is getting 15 cents for each questin answered correctly, then participant x deserved to get sth agter answering 20 correct questions. Thats why I sacrificed 1 dollar.,"
Category: misunderstand


Example 12:
Input: "The one participant guessed slightly less correct, so I felt like they deserved some money, but not fully half."
Category: meritocrat - does mention the margin


Example 13:
Input: "to be a good person and share"
Category: egalitarian


Example 14:
Input: "Participan y deserved the full payment"
Category: meritocrat - does not mention margin


Example 15:
Input: "I believe they should receive something for participating."
Category: meritocrat - does not mention margin


Example 16:
Input: "Because he solved 1 less than participant Y hence equal distribution seemed a bit fair"
Category: meritocrat - does mention the margin


Example 17:
Input: "Y did better and should therefore benefit more than X"
Category: meritocrat - does not mention margin


Example 18:
Input: "It promotes fairness."
Category: fairness


Example 19:
Input: "The rules were to only compensate whoever answered more questions than the other."
Category: libertarian


Example 20:
Input: "The main motivation is to acknowledge the efforts made by the other participant. It feels like a fair decision."
Category: meritocrat - does not mention margin


Example 21:
Input: "equality"
Category: egalitarian


Example 22:
Input: "Even though it doesn't follow the stated rules, it seemed fair to compensate the person for answering 15 questions."
Category: meritocrat - does not mention margin


Example 23:
Input: "Share equally in the outcome"
Category: egalitarian


Example 24:
Input: "Participant Y did solve more problems than Participant X, but only a few more.  Participant should receive a reward for their time and effort, and the number of problems they solved."
Category: meritocrat - does mention the margin


Example 25:
Input: "X performed twice as well as Y so I wanted X to keep 2/3rds of the $."
Category: meritocrat - does mention the margin


Example 26:
Input: "To encourage participant X to solve more problems next time"
Category: incentives


Example 27:
Input: "They both participated and solved problems."
Category: meritocrat - does not mention margin


Example 28:
Input: "I think that participant X should also be recognized for the work they did."
Category: meritocrat - does not mention margin


Example 29:
Input: "I considered participant X's effort hence giving the 1 dollar"
Category: meritocrat - does not mention margin


Example 30:
Input: "I think it's only fair to reward the person that got the most correct"
Category: meritocrat - does not mention margin


Example 31:
Input: "X put forth a reasonable amount of effort and solved only 6 fewer questions than participant Y."
Category: meritocrat - does mention the margin


Example 32:
Input: "My decision was based on the fact that both participated and the chances that one would end up with nothing and one would end up with all would not be fair. The amount was able to be split to a more even amount for both participants. Also, I feel according to the rules the winner should still benefit more than the loser and thought that something slightly more/less than half would be sufficient enough. This is all due to the fact that I , being the decision maker, is aware of the rules for the participants of the previous study."
Category: meritocrat - does not mention margin


Example 33:
Input: "The fact that Y got almost twice as many right as X was my primary driver. Because Y did better did not mean they should have to redistribute their earnings at all."
Category: meritocrat - does mention the margin


Example 34:
Input: "fairness over competition"
Category: fairness


Example 35:
Input: "I feel as if both tried. The higher performer deserves more but the other individual should be compensated also."
Category: meritocrat - does not mention margin


Example 36:
Input: "I thought it was fair that the person who did the work should get paid more."
Category: meritocrat - does not mention margin


Example 37:
Input: "Participate X has completed way more questions than Participate Y and it seems like they didnt try to compete for the earnings"
Category: meritocrat - does mention the margin


Example 38:
Input: "I calculated approximately what the value of 12 versus 19 would produce out of the total of 2.85 in total earnings. I redistributed one dollar to participant X from this total leaving the remainder for participant Y based on their 19 answers. Y still earned more but in a more fair and just fashion, yes, it was fair in my opinion to give the dollar to X based on the 12 answers achieved."
Category: meritocrat - does mention the margin


Example 39:
Input: "I chose this amount because person x completed about half as many questions as person y."
Category: meritocrat - does mention the margin


Example 40:
Input: "BECAUSE HE PARTICIPATED IN DOING SLIGHTLY LESS QUESTIONS THAN y"
Category: meritocrat - does mention the margin


Example 41:
Input: "I thought is was a more fair distribution of funds based on the productivity of the participants."
Category: meritocrat - does mention the margin


Example 42:
Input: "I would give 1.00 to participant X to recognize their significantly greater effort and performance compared to participant Y."
Category: meritocrat - does mention the margin


Example 43:
Input: "participant x also participated it is only fair if he is paid something for the time he took to answer the questions"
Category: meritocrat - does not mention margin


Example 44:
Input: "If the decision-making task was purely chance, I would say to share the money. But if time and thought went into solving the problems, Participant Y earned the money. That was based on skill and intellect.  I am okay with getting paid for skill and intellect."
Category: meritocrat - does not mention margin


Example 45:
Input: "I felt it was fair to give the other person at least some bonus because they solved only 1 less problem correctly."
Category: meritocrat - does mention the margin


Example 46:
Input: "Participant Y solved double the problems that participant X solved. So I figured it was fair to stick with the way they were told the money would be distributed. I gave it all to the participant who solved the most problems."
Category: libertarian


Example 47:
Input: "because it seem like the most logical answer"
Category: logic


Example 48:
Input: "Participate x did solve 11 problems and deserves some sort of compensation"
Category: meritocrat - does not mention margin


Example 49:
Input: "Assuming that both participants spent the same amount of total time on the task and put forth the same effort, I'm not sure one should be rewarded more for performing faster. Some people just don't test as quickly as others and I'm generally a fan of quality over quantity. It's hard to determine this without more information, but my inclination given that most participants completed around 14-16 problems is to divide the money equally."
Category: meritocrat - does mention the margin


Example 50:
Input: "Participant Y should earn more, but participant X should also earn something."
Category: meritocrat - does not mention margin


Example 51:
Input: "My decision to give $0.00 of participant Ys earnings to participant X was motivated by a commitment to fairness, merit, and respecting agreed-upon rules. Both participants were informed of the conditions before the task began: only the higher performer would be rewarded. Participant Y earned the payout by solving more problems, while participant X did not meet the threshold to earn money. Redistributing the earnings afterward would undermine the integrity of the incentive structure and create uncertainty for participants who relied on the original rules. Upholding the terms that were clearly communicated and agreed upon supports trust and fairness in the study."
Category: libertarian


Example 52:
Input: "It is fair not to distribute anything because the rules were clear, and earnings were to be based on relative performance, and you solved for more than 15 times times X 10"
Category: libertarian


Example 53:
Input: "Participant x participated and answered 8 questions, as a little reward for taking part in the participation."
Category: meritocrat - does not mention margin


Example 54:
Input: "Gave them half."
Category: no reason


Example 55:
Input: "Both exhibited good effort"
Category: meritocrat - does not mention margin


Example 56:
Input: "Assuming Player X tried their best, they deserve something for their time."
Category: meritocrat - does mention the margin


Example 57:
Input: "They participated and answered few. Just gave them the share of their earning amongst the total of 25 in that they tried and didn't manage to solve more. Was motivated by their effort"
Category: meritocrat - does mention the margin


Example 58:
Input: "Participant Y won the competition fair and square by answering more questions. I don't think it's fair to take any of their earnings away and give it to Participant X."
Category: meritocrat - does not mention margin


Example 59:
Input: "The rules of how the money would be distributed were clearly stated and I'm assuming that Participant X was aware of this, so it's not fair to penalize Participant Y and take away from their earnings when they did nothing wrong."
Category: libertarian


Example 60:
Input: "The rules in the game were that they would receive nothing if they did not meet the parameters. They did not do as many puzzles as the other, so they got zero. I don't think it is fair to punish the person that won!"
Category: meritocrat - does not mention margin


Example 61:
Input: "I like to give"
Category: no reason


Example 62:
Input: "Y earned the money fairly by solving more problems under the same conditions. Changing this now could undermine the principle of merit-based earnings."
Category: meritocrat - does not mention margin


Example 63:
Input: "That person did almost as many problems and should be compensated accordingly."
Category: meritocrat - does mention the margin


Example 64:
Input: "Want to share a small amount"
Category: no reason


Example 65:
Input: "Because I don't think it's reasonable for one person to get all the money, and the other person to get none -- even if Participant X didn't solve any problems, they still put in a certain amount of time and effort that deserves to be rewarded."
Category: meritocrat - does not mention margin


Example 66:
Input: "I'm  not really interested in sharing my winnings."
Category: misunderstand


Example 67:
Input: "I wanted the participants to get paid according to how well they did in relation to eachother, not just if one got more answers that the other"
Category: meritocrat - does mention the margin


Example 68:
Input: "If I distribute 0, will receive zero and I will get 2.85"
Category: misunderstand


Example 69:
Input: "Since X earned 2.1, I decided to simply give half of it to Y. That way they both have an equal amount."
Category: egalitarian


Example 70:
Input: "Candidate X had nothing even after completing 10 problems"
Category: meritocrat - does not mention margin


Example 71:
Input: "I would award 0.10 only, and keep in mind , thats being generous.  I think the participant that provided the correct answers should be awarded the amount deserved."
Category: meritocrat - does not mention margin


Example 72:
Input: "I felt that participant X did solve a fair amount of problems, and the fact they earned nothing because they were one correct answer short of meeting participant Y's correct answers doesn't feel entirely fair to me. I decided to give them a decent bonus, but I did not give them a majority of participant Y's earnings because that did not feel fair for participant Y."
Category: meritocrat - does mention the margin


Example 73:
Input: "Because the description participant x and y received clearly said that if you answered fewer questions correctly than the other participant, then you would receive nothing. Since participant x answered fewer questions correctly, I chose to stay with the determined payout in order to uphold the rules."
Category: libertarian


Example 74:
Input: "the fact that the participant participated should be remunerated"
Category: meritocrat - does not mention margin


Example 75:
Input: "the reward effort is slightly while fairness and merit based performance"
Category: no reason


Example 76:
Input: "Participant X scored a little below Participant Y and according to the the instructions participant who scored lower would not get anything so i do not think it will be nice to give out from the other participant price."
Category: meritocrat - does mention the margin


Example 77:
Input: "The person may not have gotten as many answers correct, but they at least deserve an almost even amount of compensation for their time and efforts"
Category: meritocrat - does mention the margin


Example 78:
Input: "Although person X did not get as many as person Y, I feel that person X at least tried their best and should be compensated even a little. Person Y clearly just knew more than person X which may be an unfair advantage."
Category: meritocrat - does not mention margin


Example 79:
Input: "Both worked hard and deserve some compensation for their efforts."
Category: meritocrat - does not mention margin


Example 80:
Input: "He still answered a majority of the questions, so, there should be some reward"
Category: meritocrat - does mention the margin


Example 81:
Input: "I think participant y won their earnings fairly"
Category: libertarian


Example 82:
Input: "i think that the they both have the same amount of things"
Category: no reason


Example 83:
Input: "Participant Y solved only 3 more problems than participant X"
Category: meritocrat - does mention the margin


Example 84:
Input: "So the participant that didnt receive anything received a little"
Category: meritocrat - does not mention margin


Example 85:
Input: "should get something for just showing up"
Category: meritocrat - does not mention margin


Example 86:
Input: "I feel for trying participant X deserves something"
Category: meritocrat - does not mention margin


Example 87:
Input: "I was just trying to make it even. They both tried hard."
Category: meritocrat - does not mention margin


Example 88:
Input: "Solved almost as many problems so should receive something."
Category: meritocrat - does not mention margin


Example 89:
Input: "Because the participant get the score of 11 which is a trial."
Category: no reason


Example 90:
Input: "The participants were told upfront how earnings would be determined and paid out.  They did not have to participate.  Everything was clear and fair."
Category: libertarian


Example 91:
Input: "I did not feel they should be penalized for not getting as many answers. I redistributed the payment to give the person with more correct answers double the amount, 0.10 for correct answers to the person with the most and 0.05 for the correct answers to the person with less correct. I based this off of what I would feel is fair if I were the second person."
Category: meritocrat - does mention the margin


Example 92:
Input: "I think the other participant should earn at least a little something. I decided to give the cents of the participant Y's earnings to X. Participant Y will get a solid number and X will get at least something."
Category: meritocrat - does not mention margin


Example 93:
Input: "They played the game together they get the share equally."
Category: egalitarian


Example 94:
Input: "i want participant Y to have a share also"
Category: compensate


Example 95:
Input: "just sounded logical"
Category: no reason


Example 96:
Input: "I don't see any reason to redistribute funds that were earned according to a protocol understood by both parties."
Category: libertarian


Example 97:
Input: "The instructions were clear that they would only get a bonus if they solved at least as many as the other participant. I see no reason to change that."
Category: libertarian


Example 98:
Input: "The person solved less problems than the other party and that is the payment"
Category: meritocrat - does not mention margin


Example 99:
Input: "X should be compensated for trying."
Category: meritocrat - does not mention margin


Example 100:
Input: "Participant X should earn at least something for participating, but not more than participant Y"
Category: meritocrat - does not mention margin


Example 101:
Input: "the rules"
Category: libertarian


Example 102:
Input: "The numbers where so close it isn't fair to that participants time to not get a bonus"
Category: meritocrat - does mention the margin


Example 103:
Input: "The instructions said that the person with fewer correct answers would get nothing and the person with the most correct answers would get .15 per correct answer. Changing the bonus would not be right or moral."
Category: libertarian


Example 104:
Input: "Although Participant Y solved 16 problems and Participant X solved 12 problems, I feel both should be compensated. Participant X should get something for solving the problems although they did not complete as many."
Category: meritocrat - does mention the margin


Example 105:
Input: "since they both took their time to solve the tasks they both deserve to receive a bonus, i allocated 2 dollars to participant Y because he solved more and the rest $1.15 goes tp participant X"
Category: meritocrat - does not mention margin


Example 106:
Input: "It appears to me that X did better in their grouping than Y did in their's. Thus, a sharing of the wealth is appropriate."
Category: no reason


Example 107:
Input: "I had no reason to take what they earned."
Category: libertarian


Example 108:
Input: "I chose to allocate some of the earnings of participant Y to participant X since he solved fewer problems, and it would be fair to redistribute some in this instance."
Category: meritocrat - does not mention margin


Example 109:
Input: "Xdid answer 11 questions. Even though Yanswered 4 more wuestions-I feel X should be given something for trying to answer as many as she could."
Category: meritocrat - does mention the margin


Example 110:
Input: "I feel like participant X lost by 6 to participant Y. Because of their results being close, I feel like participant X should b rewarded something for solving some right."
Category: meritocrat - does mention the margin


Example 111:
Input: "maybe I failed to understand you fully but if one is getting 15 cents for each questin answered correctly, then participant x deserved to get sth agter answering 20 correct questions. Thats why I sacrificed 1 dollar.,"
Category: meritocrat - does not mention margin


Example 112:
Input: "The one participant guessed slightly less correct, so I felt like they deserved some money, but not fully half."
Category: meritocrat - does mention the margin


Example 113:
Input: "to be a good person and share"
Category: no reason


Example 114:
Input: "Participan y deserved the full payment"
Category: meritocrat - does not mention margin


Example 115:
Input: "I believe they should receive something for participating."
Category: meritocrat - does not mention margin


Example 116:
Input: "Because he solved 1 less than participant Y hence equal distribution seemed a bit fair"
Category: meritocrat - does mention the margin


Example 117:
Input: "Y did better and should therefore benefit more than X"
Category: meritocrat - does not mention margin


Example 118:
Input: "It promotes fairness."
Category: fairness


Example 119:
Input: "The rules were to only compensate whoever answered more questions than the other."
Category: libertarian


Example 120:
Input: "The main motivation is to acknowledge the efforts made by the other participant. It feels like a fair decision."
Category: meritocrat - does not mention margin


Example 121:
Input: "Because it was only a difference of a few, so I think each deserves something"
Category: meritocrat - does mention the margin


Example 122:
Input: "I felt that the participant who got nothing should at least get a little bonus for solving some of the problems."
Category: meritocrat - does not mention margin


Example 123:
Input: "I did not choose to redistribute any of participant Y's earnings based on very clear rules from the beginning-the participants would only be paid if they performed as well as if not better than their partner. Both participants agreed to those terms, and Y earned the money correctly by doing better than X. To alter the outcome now would cast an undeserving shadow of doubt on the fairness and transparency of the agreement that had been initially reached."
Category: libertarian


Example 124:
Input: "I feel like Participant X should get something for their effort as they answered some questions correctly. However, Participant Y should get the larger reward since their performance was better."
Category: meritocrat - does not mention margin


Example 125:
Input: "I felt that there should be an equitable distribution of the earnings. I felt that was the fair thing to do since they both performed almost the same."
Category: meritocrat - does mention the margin


Example 126:
Input: "it was the effort of y to earn his money"
Category: meritocrat - does not mention margin


Example 127:
Input: "because I believe if you have the chance to be fair then do it!!"
Category: fairness


Example 128:
Input: "It's only fair to get the share since he participated."
Category: meritocrat - does not mention margin


Example 129:
Input: "Participant X solved 2 problems, while Participant Y solved 7, which is a substantial difference. Participant X did not meet the threshold to earn anything according to the original rules."
Category: meritocrat - does mention the margin


Example 130:
Input: "The reward should be more or less proportional to the number of questions answered correctly."
Category: meritocrat - does mention the margin


Example 131:
Input: "Person x took part in the work so compensating them would be good"
Category: meritocrat - does not mention margin


Example 132:
Input: "I believe its equal and fair"
Category: fairness


Example 133:
Input: "The answer is 0 because the rules said only the person who solved at least as many problems as the other would earn money. Since Y solved more than X, Y earned the money fairly. Changing that would go against the rules both agreed to."
Category: libertarian


Example 134:
Input: "I wanted to make them have equal amount"
Category: egalitarian


Example 135:
Input: "Participant X showed good results and should receive a small bonus"
Category: meritocrat - does not mention margin


Example 136:
Input: "The rules were known up front, they should be followed."
Category: libertarian


Example 137:
Input: "Participant Y should keep their full $2.70, and participant X should receive $0.00, as per the original terms of the task. This preserves the integrity of the incentive system and rewards performance as agreed."
Category: libertarian


Example 138:
Input: "Participant X solved at least as many problems as Participant Y. It doesnt seem fair at all for them to have even done some work and received nothing."
Category: no reason


Example 139:
Input: "want to give them at least a little"
Category: no reason


Example 140:
Input: "X answered 4 questions and should be compensated accordingly regardless of the disparity between X & Y"
Category: meritocrat - does mention the margin


Example 141:
Input: "Because Y perform better and should be rewarded better than X."
Category: meritocrat - does not mention margin


Example 142:
Input: "They still got some questions right and the first person wont miss the 59 cents"
Category: meritocrat - does not mention margin


Example 143:
Input: "I would like to be completely fair and give the other participant a deserving amount."
Category: meritocrat - does not mention margin


Example 144:
Input: "Even though participant x got less than participant y, they still did do something, so I think they should get some compensation."
Category: meritocrat - does not mention margin


Example 145:
Input: "Person x should also be given a certain share of the amount. The amount I have choosen is to try and equalise both of them."
Category: egalitarian


Example 146:
Input: "Redistributing it would give the loser the impression that this sort of thing would happen again.  They might rely on it happening again in the future, or even feel entitled to it.  Also, redistributing it would have demotivated the winner so they wouldn't have tried as hard in the future and would have looked for other people to do well around."
Category: incentives


Example 147:
Input: "It may feel fair to share the earnings for effort, but this would go against the agreed competitive incentive structure if something was given"
Category: libertarian


Example 148:
Input: "If the amounts were not distributed then the other person would have got nothing for his time and effort"
Category: meritocrat - does not mention margin


Example 149:
Input: "Person Y clearly deserved more for solving more, but Person X did pretty well.  I did not want to penalize Y for the sake of X so tried to be fair and go with what I would have felt comfortable doing myself."
Category: meritocrat - does mention the margin


Example 150:
Input: "It was random"
Category: no reason


Example 151:
Input: "The study described how the outcome would be applied."
Category: libertarian


Example 152:
Input: "Because I think its unfair/unkind to ask someone to do something like solve problems and then not pay them for it when that is the entire reason we are all here."
Category: meritocrat - does not mention margin


Example 153:
Input: "I think the other participant deserves a little something for their work, even though they didn't outperform. I didn't want to take away too much from the winner's earnings as this goes against what they were told about payments."
Category: meritocrat - does not mention margin


Example 154:
Input: "I think that that is a good amount to give as it seems average and not too small and not too large"
Category: no reason


Example 155:
Input: "The participant earned the money; therefore should get all the money."
Category: meritocrat - does not mention margin


Example 156:
Input: "So far as they are partners the reward should be shared, if one is not selfless enough he can just give any amount he wants to give."
Category: misunderstand


Example 157:
Input: "based on the rules, person Y should get all of the money for solving significantly more problems than person X.  Person Y should not be penalized just to make things appear more 'fair' toward person X."
Category: libertarian


Example 158:
Input: "Y worked so very much harder, and I did not feel that they should have any funds removed.  Had the payment been larger I may have decided to take a bit for X, but the payment was not large."
Category: meritocrat - does not mention margin


Example 159:
Input: "I think it's fair for them to earn one-third of the distribution considering they answered only 3 questions less correctly, 70% compared to the winner."
Category: meritocrat - does mention the margin


Example 160:
Input: "Redistributing  and sharing"
Category: no reason


Example 161:
Input: "Given that they all made efforts to solve the problem and that, I believe each should be paid based on the efforts made"
Category: meritocrat - does not mention margin


Example 162:
Input: "I believe that figure will be enough"
Category: no reason


Example 163:
Input: "Seems fair, as long as the effort was put in."
Category: meritocrat - does not mention margin


Example 164:
Input: "Even though X was not able to solve he should be compensated for at least attempting it."
Category: meritocrat - does not mention margin


Example 165:
Input: "I thought that participation in a work activity should be paid at least a small amount and thought the 2 participants were advised in advance that an adjustment might take place so some adjustment is fair"
Category: meritocrat - does not mention margin


Example 166:
Input: "I chose not to redistribute earnings because Participant Y performed significantly better than Participant X and earned their reward according to the rules both agreed to beforehand. Redistributing would undermine the fairness of a system based on relative performance and would penalize Y despite their superior results. Upholding the original rules maintains consistency and respects the integrity of the task."
Category: libertarian


Example 167:
Input: "It seems unfair for one to get nothing when they both were correct about the same number of times."
Category: meritocrat - does mention the margin


Example 168:
Input: "The all-or-nothing reward system seemed excessive, but the better performer should receive a bonus for their performance."
Category: meritocrat - does not mention margin


Example 169:
Input: "Both parties contributed effort to the project, both should be rewarded."
Category: meritocrat - does not mention margin


Example 170:
Input: "I think people should receive what they earn"
Category: no reason


Example 171:
Input: "The motivation for the distribution decision was anchored on the agreed standard rules beforehand with participant Y earning the reward as a greed. As such, taking from participants would undermine the game expectations and fairness."
Category: libertarian


Example 172:
Input: "The original rules that both parties agreed to have not changed.  B should not be penalized because of an arbitrary decisionmaker."
Category: libertarian


Example 173:
Input: "I don't like the idea of wealth redistribution, even in tiny amounts like this."
Category: libertarian


Example 174:
Input: "X got some problems correct as well, just fewer than Y. there shouldn't be all-or-nothing rewards."
Category: meritocrat - does not mention margin


Example 175:
Input: "Participant X was 2 problems short on what Participant Y solve which involved some effort. Fraction earning goes to acknowledge that effort."
Category: meritocrat - does mention the margin


Example 176:
Input: "As close to 50% should be fair."
Category: fairness


Example 177:
Input: "person y won easily and deserves the money"
Category: meritocrat - does not mention margin


Example 178:
Input: "I wanted to be fair to each participant"
Category: fairness


Example 179:
Input: "I feel that distributing money like that isn't equitable and doesn't result in positive consequences."
Category: no reason


Example 180:
Input: "I am assuming that Participant X put time and effort into answering the questions also. It j7st seemed fair."
Category: meritocrat - does not mention margin


Example 181:
Input: "They were due 1/3 of the total winnings due to their response rate, nothing else."
Category: meritocrat - does not mention margin


Example 182:
Input: "because Y only earn 0.07 and it would not increase x that much"
Category: no reason


Example 183:
Input: "I followed your established rules."
Category: libertarian


Example 184:
Input: "Looking at the distribution it is clear to me that player x worked hard and put in effort. I don't think it is fair that reward is only tied to success. While a higher reward being given to Y for being more successful is fine, I think as long as both players made an effort there should be some reward, that feels more fair to me. Therefore I have X $1 because that felt like a more fair allocation to me."
Category: meritocrat - does not mention margin


Example 185:
Input: "He solved 13 problems. It costs 1 usd"
Category: meritocrat - does not mention margin


Example 186:
Input: "The one who earned the money should keep it."
Category: libertarian


Example 187:
Input: "Fairness and equal sharing"
Category: fairness


Example 188:
Input: "That is the agreement you made with the two participants, so I am going to honor it."
Category: libertarian


Example 189:
Input: "It will be best to make the candidate have a feel of some rewards to make the candidate try harder"
Category: incentives


Example 190:
Input: "I mostly based it out of the rules that each participant agreed upon before they started the task. It would be very unfair to reward participant X with anything."
Category: libertarian


Example 191:
Input: "It stated it would pay .15 per answer, thus .15 X 4"
Category: no reason


Example 192:
Input: "The other participant correctly did 7 more puzzles than the other one. But, the one that did 10 also did a good job of getting that many correct. I think they deserve something for their effort."
Category: meritocrat - does mention the margin


Example 193:
Input: "Participant X did almost as well and deserved some compensation, but not as much as Y."
Category: meritocrat - does mention the margin


Example 194:
Input: "The participants were told that there would be a final round that may affect their distributions. I allocated a nominal amount to the losing participant."
Category: compensate


Example 195:
Input: "Participant A solved about half the problems of B so they should get at least a small reward."
Category: meritocrat - does mention the margin


Example 196:
Input: "The two participants scores were reasonably close, but Y still solved a few more problems. I thought my distribution of the total earned was fair given the number of problems each person solved."
Category: meritocrat - does mention the margin


Example 197:
Input: "I think they participated well, but not as good at the other participant"
Category: meritocrat - does not mention margin


Example 198:
Input: "It was a semi even distribution between the two people"
Category: meritocrat - does mention the margin


Example 199:
Input: "I think that they should still be compensated for participating. They can get the extra cents made."
Category: meritocrat - does not mention margin


Example 200:
Input: "The rules were explained ahead of time. If someone didn't think they'd be strong, they shouldn't invest the time. (But politically, I want some redistribution from high earners! This case was low stakes, so I figured my morals were still ok.)"
Category: libertarian
"""



SYSTEMS_LIST = [SYSTEM_MESSAGE_1, SYSTEM_MESSAGE_2, SYSTEM_MESSAGE_3]