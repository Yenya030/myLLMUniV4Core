v. 0.9 Uniswap
Uniswap. v4-core
5th September 2024

Contents
1 Changelog 7
2 Introduction 8
3 Projectscope 9
4 Methodology 11
5 Ourfindings 12
6 MajorIssues 13
CVF-1. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
CVF-2. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
CVF-3. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
CVF-4. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
CVF-5. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
CVF-6. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
CVF-7. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
CVF-8. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
CVF-9. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
CVF-10. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
CVF-11. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
CVF-12. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
CVF-13. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
CVF-14. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
CVF-15. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
CVF-16. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
CVF-17. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
7 ModerateIssues 22
CVF-18. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
CVF-19. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
CVF-20. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
CVF-21. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
CVF-22. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
CVF-23. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
CVF-24. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
CVF-25. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
CVF-26. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
CVF-27. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
CVF-28. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
CVF-29. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
CVF-30. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
CVF-31. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26

CVF-32. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
CVF-33. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
CVF-34. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
CVF-35. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
CVF-36. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
CVF-37. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
CVF-38. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
CVF-39. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
CVF-40. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
CVF-41. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
CVF-42. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
CVF-43. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
CVF-44. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
CVF-45. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
CVF-46. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
CVF-47. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 33
CVF-48. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 33
CVF-49. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
CVF-50. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
8 MinorIssues 35
CVF-51. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 35
CVF-52. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 35
CVF-53. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 35
CVF-54. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 36
CVF-55. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 36
CVF-56. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 36
CVF-57. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
CVF-58. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
CVF-59. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
CVF-60. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 38
CVF-61. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 38
CVF-62. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 38
CVF-63. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
CVF-64. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
CVF-65. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
CVF-66. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 40
CVF-67. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 40
CVF-68. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 40
CVF-69. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
CVF-70. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
CVF-71. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
CVF-72. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
CVF-73. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42
CVF-74. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42
CVF-75. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42

CVF-76. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 43
CVF-77. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 43
CVF-78. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 43
CVF-79. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 43
CVF-80. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
CVF-81. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
CVF-82. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
CVF-83. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 45
CVF-84. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 45
CVF-85. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 45
CVF-86. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
CVF-87. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
CVF-88. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
CVF-89. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
CVF-90. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 47
CVF-91. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 47
CVF-92. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 47
CVF-93. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 47
CVF-94. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 48
CVF-95. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 48
CVF-96. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 48
CVF-97. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49
CVF-98. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49
CVF-99. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49
CVF-100. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 50
CVF-101. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 50
CVF-102. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 50
CVF-103. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 51
CVF-104. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 51
CVF-105. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 51
CVF-106. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 52
CVF-107. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 52
CVF-108. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 52
CVF-109. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53
CVF-110. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53
CVF-111. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53
CVF-112. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 54
CVF-113. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 54
CVF-114. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 54
CVF-115. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 55
CVF-116. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 55
CVF-117. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 55
CVF-118. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 56
CVF-119. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 56
CVF-120. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 56
CVF-121. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 56

CVF-122. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57
CVF-123. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57
CVF-124. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57
CVF-125. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 58
CVF-126. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 59
CVF-127. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 60
CVF-128. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 60
CVF-129. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 60
CVF-130. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 60
CVF-131. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 61
CVF-132. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 61
CVF-133. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 61
CVF-134. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 62
CVF-135. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 62
CVF-136. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 62
CVF-137. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 63
CVF-138. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 63
CVF-139. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 63
CVF-140. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 64
CVF-141. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 64
CVF-142. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 64
CVF-143. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 64
CVF-144. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 65
CVF-145. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 65
CVF-146. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 65
CVF-147. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 66
CVF-148. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 66
CVF-149. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 66
CVF-150. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 66
CVF-151. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 67
CVF-152. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 67
CVF-153. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 67
CVF-154. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 67
CVF-155. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 68
CVF-156. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 68
CVF-157. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 68
CVF-158. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 69
CVF-159. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 69
CVF-160. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 69
CVF-161. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 70
CVF-162. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 70
CVF-163. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 70
CVF-164. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 71
CVF-165. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 71
CVF-166. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 71
CVF-167. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 72

CVF-168. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 72
CVF-169. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 72
CVF-170. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 73
CVF-171. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 73
CVF-172. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 73
CVF-173. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 73
CVF-174. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 74
CVF-175. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 74
CVF-176. Reported . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 74

1 Changelog
| #   | Date     | Author          | Description    |
| --- | -------- | --------------- | -------------- |
| 0.1 | 05.09.24 | A. Zveryanskaya | Initial Draft  |
| 0.2 | 05.09.24 | A. Zveryanskaya | Minor revision |
| 0.9 | 05.09.24 | A. Zveryanskaya | Release        |
7

2 Introduction
Allmodificationstothisdocumentareprohibited. Violatorswillbeprosecutedtothe
fullextentoftheU.S.law.
The following document provides the result of the audit performed by ABDK Consulting
(Mikhail Vladimirov and Dmitry Khovratovich) at the customer request. The audit goal is a
general review of the smart contracts structure, critical/major bugs detection and issuing
the general recommendations.
Uniswap V4, the latest iteration of the Uniswap protocol, is a significant advancement in
decentralized exchanges (DEXs) and automated market makers (AMMs).
8

| 3 Project scope |     |     |
| --------------- | --- | --- |
We were asked to review:
• Original Code
Files:
/
| ERC6909.sol  | ERC6909Claims.sol  | Extsload.sol    |
| ------------ | ------------------ | --------------- |
| Exttload.sol | NoDelegateCall.sol | PoolManager.sol |
ProtocolFees.sol
interfaces/callback/
IUnlockCallback.sol
interfaces/external/
| IERC20Minimal.sol | IERC6909Claims.sol |     |
| ----------------- | ------------------ | --- |
interfaces/
| IExtsload.sol | IExttload.sol | IHooks.sol |
| ------------- | ------------- | ---------- |
IProtocolFeeCon-
| IPoolManager.sol |     | IProtocolFees.sol |
| ---------------- | --- | ----------------- |
troller.sol
libraries/
| BitMath.sol            | CurrencyDelta.sol | CustomRevert.sol          |
| ---------------------- | ----------------- | ------------------------- |
| UnsafeMath.sol         | FixedPoint96.sol  | FixedPoint128.sol         |
| FullMath.sol           | Hooks.sol         | LiquidityMath.sol         |
| Lock.sol               | LPFeeLibrary.sol  | NonZeroDeltaCount.sol     |
| ParseBytes.sol         | Pool.sol          | Position.sol              |
| ProtocolFeeLibrary.sol | Reserves.sol      | SafeCast.sol              |
| SqrtPriceMath.sol      | StateLibrary.sol  | SwapMath.sol              |
| TickBitmap.sol         | TickMath.sol      | TransientStateLibrary.sol |
9

types/
| BalanceDelta.sol | BeforeSwapDelta.sol | Currency.sol |
| ---------------- | ------------------- | ------------ |
| PoolId.sol       | PoolKey.sol         | Slot0.sol    |
Allfoundissueswereleftasis.
Afterfixingtheindicatedissues,thesmartcontractsshouldbere-audited.
10

4 Methodology
The methodology is not a strict formal procedure, but rather a selection of methods and
tactics combined differently and tuned for each particular project, depending on the
project structure and technologies used, as well as on client expectations from the audit.
• GeneralCodeAssessment. The code is reviewed for clarity, consistency, style,
and for whether it follows best code practices applicable to the particular
programming language used. We check indentation, naming convention,
commented code blocks, code duplication, confusing names, confusing, irrelevant,
or missing comments etc. At this phase we also understand overall code structure.
• EntityUsageAnalysis. Usages of various entities defined in the code are analysed.
This includes both: internal usages from other parts of the code as well as potential
external usages. We check that entities are defined in proper places as well as their
visibilityscopesandaccesslevelsarerelevant. Atthisphase,weunderstandoverall
system architecture and how different parts of the code are related to each other.
• AccessControlAnalysis. For those entities, that could be accessed externally,
access control measures are analysed. We check that access control is relevant
and done properly. At this phase, we understand user roles and permissions, as
well as what assets the system ought to protect.
• CodeLogicAnalysis. The code logic of particular functions is analysed for
correctness and efficiency. We check if code actually does what it is supposed to
do, if that algorithms are optimal and correct, and if proper data types are used. We
also make sure that external libraries used in the code are up to date and relevant to
the tasks they solve in the code. At this phase we also understand data structures
used and the purposes they are used for.
We classify issues by the following severity levels:
• Criticalissue directly affects the smart contract functionality and may cause a
significant loss.
• Majorissue is either a solid performance problem or a sign of misuse: a slight code
modification or environment change may lead to loss of funds or data. Sometimes it
is an abuse of unclear code behaviour which should be double checked.
• Moderateissue is not an immediate problem, but rather suboptimal performance in
edge cases, an obviously bad code practice, or a situation where the code is
correct only in certain business flows.
• Recommendations contain code style, best practices and other suggestions.
11

| 5        | Our       | findings  |                |         |
| -------- | --------- | --------- | -------------- | ------- |
| We found | 17 major, | and a few | less important | issues. |
17 0
12

|     | 6          | Major    |      |     | Issues |     |          |                |
| --- | ---------- | -------- | ---- | --- | ------ | --- | -------- | -------------- |
|     | CVF-1      | Reported |      |     |        |     |          |                |
|     | • Category |          | Flaw |     |        |     | • Source | TickBitmap.sol |
Description Here local variables of a type narrower than 256 bits are accessed
as it they were 256 bit wide. Solidity documentation warns that: “if you access
variables of a type that spans less than 256 bits (for example uint64, address, or
bytes16), you cannot make any assumptions about bits not part of the encoding of
the type” (https://docs.soliditylang.org/en/v0.8.26/assembly.html#access-to-external-
variables-functions-and-libraries).
Recommendation Properly clean extra bits between using narrow variables as recom-
mended in the documentation: “to be safe, always clear the data properly before you use
|     | it in a context |     | where | this is | important”. |     |     |     |
| --- | --------------- | --- | ----- | ------- | ----------- | --- | --- | --- |
(cid:7) (cid:4)
|     |     | sdiv(tick, |     | tickSpacing), |     |     |     |     |
| --- | --- | ---------- | --- | ------------- | --- | --- | --- | --- |
22
(cid:6) (cid:5)
(cid:7) (cid:4)
|     |     | slt(smod(tick, |     |     | tickSpacing), |     | 0)  |     |
| --- | --- | -------------- | --- | --- | ------------- | --- | --- | --- |
24 (cid:6) (cid:5)
(cid:7) (cid:4)
|     | wordPos | :=  | sar(8, | tick) |     |     |     |     |
| --- | ------- | --- | ------ | ----- | --- | --- | --- | --- |
36
|     | bitPos | :=  | and(tick, |     | 0xff) |     |     |     |
| --- | ------ | --- | --------- | --- | ----- | --- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
|     | if smod(tick, |     | tickSpacing) |     |     | {   |     |     |
| --- | ------------- | --- | ------------ | --- | --- | --- | --- | --- |
53 (cid:6) (cid:5)
(cid:7) (cid:4)
|     | mstore(0x20, |     |     | tick) |     |     |     |     |
| --- | ------------ | --- | --- | ----- | --- | --- | --- | --- |
55
|     | mstore(0x40, |     |     | tickSpacing) |     |     |     |     |
| --- | ------------ | --- | --- | ------------ | --- | --- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
| 59  | tick | := sdiv(tick, |     | tickSpacing) |     |     |     |     |
| --- | ---- | ------------- | --- | ------------ | --- | --- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
|     | mstore(0, |     | sar(8, | tick)) |     |     |     |     |
| --- | --------- | --- | ------ | ------ | --- | --- | --- | --- |
62 (cid:6) (cid:5)
(cid:7) (cid:4)
|     | sstore(slot, |     | xor(sload(slot), |     |     | shl(and(tick, |     | 0xff), 1))) |
| --- | ------------ | --- | ---------------- | --- | --- | ------------- | --- | ----------- |
68 (cid:6) (cid:5)
13

| CVF-2      | Reported |      |     |     |     |          |              |
| ---------- | -------- | ---- | --- | --- | --- | -------- | ------------ |
| • Category |          | Flaw |     |     |     | • Source | Position.sol |
Description Here local variables of a type narrower than 256 bits are accessed
as it they were 256 bit wide. Solidity documentation warns that: “if you access
variables of a type that spans less than 256 bits (for example uint64, address, or
bytes16), you cannot make any assumptions about bits not part of the encoding of
the type” (https://docs.soliditylang.org/en/v0.8.26/assembly.html#access-to-external-
variables-functions-and-libraries).
Recommendation Properly clean extra bits between using narrow variables as recom-
mended in the documentation: “to be safe, always clear the data properly before you use
| it in a context |     | where this | is  | important”. |     |     |     |
| --------------- | --- | ---------- | --- | ----------- | --- | --- | --- |
(cid:7) (cid:4)
| mstore(0x06, |     | tickUpper) |     | // [0x23, |     | 0x26) |     |
| ------------ | --- | ---------- | --- | --------- | --- | ----- | --- |
44
| mstore(0x03, |     | tickLower) |           | // [0x20, |     | 0x23) |     |
| ------------ | --- | ---------- | --------- | --------- | --- | ----- | --- |
| mstore(0,    |     | owner)     | // [0x0c, | 0x20)     |     |       |     |
(cid:6) (cid:5)
| CVF-3      | Reported |      |     |     |     |          |              |
| ---------- | -------- | ---- | --- | --- | --- | -------- | ------------ |
| • Category |          | Flaw |     |     |     | • Source | TickMath.sol |
Description Here local variables of a type narrower than 256 bits are accessed
as it they were 256 bit wide. Solidity documentation warns that: “if you access
variables of a type that spans less than 256 bits (for example uint64, address, or
bytes16), you cannot make any assumptions about bits not part of the encoding of
the type” (https://docs.soliditylang.org/en/v0.8.26/assembly.html#access-to-external-
variables-functions-and-libraries).
Recommendation Properly clean extra bits between using narrow variables as recom-
mended in the documentation: “to be safe, always clear the data properly before you use
| it in a context |     | where this | is  | important”. |     |     |     |
| --------------- | --- | ---------- | --- | ----------- | --- | --- | --- |
(cid:7) (cid:4)
| let mask | :=  | sar(255, |     | tick) |     |     |     |
| -------- | --- | -------- | --- | ----- | --- | --- | --- |
55 (cid:6) (cid:5)
(cid:7) (cid:4)
| absTick | :=  | xor(mask, |     | add(mask, | tick)) |     |     |
| ------- | --- | --------- | --- | --------- | ------ | --- | --- |
59 (cid:6) (cid:5)
14

| CVF-4      | Reported |     |     |          |                   |
| ---------- | -------- | --- | --- | -------- | ----------------- |
| • Category | Flaw     |     |     | • Source | SqrtPriceMath.sol |
Description Here local variables of a type narrower than 256 bits are accessed
as it they were 256 bit wide. Solidity documentation warns that: “if you access
variables of a type that spans less than 256 bits (for example uint64, address, or
bytes16), you cannot make any assumptions about bits not part of the encoding of
the type” (https://docs.soliditylang.org/en/v0.8.26/assembly.html#access-to-external-
variables-functions-and-libraries).
Recommendation Properly clean extra bits between using narrow variables as recom-
mended in the documentation: “to be safe, always clear the data properly before you use
| it in a context | where this | is important”. |     |     |     |
| --------------- | ---------- | -------------- | --- | --- | --- |
(cid:7) (cid:4)
| if  | iszero(gt(sqrtPX96, |     | quotient)) | {   |     |
| --- | ------------------- | --- | ---------- | --- | --- |
105 (cid:6) (cid:5)
(cid:7) (cid:4)
| if or(iszero(sqrtPX96), |     |     | iszero(liquidity)) |     | {   |
| ----------------------- | --- | --- | ------------------ | --- | --- |
131 (cid:6) (cid:5)
(cid:7) (cid:4)
| if or(iszero(sqrtPX96), |     |     | iszero(liquidity)) |     | {   |
| ----------------------- | --- | --- | ------------------ | --- | --- |
157 (cid:6) (cid:5)
(cid:7) (cid:4)
| if  | iszero(sqrtPriceAX96) |     | {   |     |     |
| --- | --------------------- | --- | --- | --- | --- |
187
(cid:6) (cid:5)
(cid:7) (cid:4)
| let diff | := sub(a, | b)  |     |     |     |
| -------- | --------- | --- | --- | --- | --- |
205
(cid:6) (cid:5)
15

| CVF-5      | Reported |     |          |              |
| ---------- | -------- | --- | -------- | ------------ |
| • Category | Flaw     |     | • Source | SwapMath.sol |
Description Here local variables of a type narrower than 256 bits are accessed
as it they were 256 bit wide. Solidity documentation warns that: “if you access
variables of a type that spans less than 256 bits (for example uint64, address, or
bytes16), you cannot make any assumptions about bits not part of the encoding of
the type” (https://docs.soliditylang.org/en/v0.8.26/assembly.html#access-to-external-
variables-functions-and-libraries).
Recommendation Properly clean extra bits between using narrow variables as recom-
mended in the documentation: “to be safe, always clear the data properly before you use
| it in a context | where this | is important”. |     |     |
| --------------- | ---------- | -------------- | --- | --- |
(cid:7) (cid:4)
let nextOrLimit := xor(lt(sqrtPriceNextX96, sqrtPriceLimitX96),
29
(cid:44)→
zeroForOne)
| let symDiff | := xor(sqrtPriceNextX96, |     | sqrtPriceLimitX96) |     |
| ----------- | ------------------------ | --- | ------------------ | --- |
30
| sqrtPriceTargetX96      |     | := xor(sqrtPriceLimitX96, |     | mul(symDiff, |
| ----------------------- | --- | ------------------------- | --- | ------------ |
| (cid:44)→ nextOrLimit)) |     |                           |     |              |
(cid:6) (cid:5)
| CVF-6      | Reported   |     |          |              |
| ---------- | ---------- | --- | -------- | ------------ |
| • Category | Procedural |     | • Source | SwapMath.sol |
Description Underflow shouldn’t be possible here, but the logic that is supposed to
guaranteethisisinotherfiles. Relyingonitintroduceshiddenrelationshipbetweendistant
code parts.
| Recommendation | Use | safe subtraction. |     |     |
| -------------- | --- | ----------------- | --- | --- |
(cid:7) (cid:4)
| feeAmount | = uint256(-amountRemaining) |     | - amountIn; |     |
| --------- | --------------------------- | --- | ----------- | --- |
78 (cid:6) (cid:5)
16

| CVF-7      | Reported |      |     |     |     |          |                        |
| ---------- | -------- | ---- | --- | --- | --- | -------- | ---------------------- |
| • Category |          | Flaw |     |     |     | • Source | ProtocolFeeLibrary.sol |
Description Here local variables of a type narrower than 256 bits are accessed
as it they were 256 bit wide. Solidity documentation warns that: “if you access
variables of a type that spans less than 256 bits (for example uint64, address, or
bytes16), you cannot make any assumptions about bits not part of the encoding of
the type” (https://docs.soliditylang.org/en/v0.8.26/assembly.html#access-to-external-
variables-functions-and-libraries).
Recommendation Properly clean extra bits between using narrow variables as recom-
mended in the documentation: “to be safe, always clear the data properly before you use
| it in a context | where | this | is important”. |     |     |     |     |
| --------------- | ----- | ---- | -------------- | --- | --- | --- | --- |
(cid:7) (cid:4)
| let isOneForZeroFeeOk |     |     |     | := lt(self, |     | FEE_1_THRESHOLD) |     |
| --------------------- | --- | --- | --- | ----------- | --- | ---------------- | --- |
27 (cid:6) (cid:5)
(cid:7) (cid:4)
| let numerator |     | :=  | mul(self, |     | lpFee) |     |     |
| ------------- | --- | --- | --------- | --- | ------ | --- | --- |
38 (cid:6) (cid:5)
(cid:7) (cid:4)
| swapFee | :=  | sub(add(self, |     | lpFee), |     | divRoundingUp) |     |
| ------- | --- | ------------- | --- | ------- | --- | -------------- | --- |
40 (cid:6) (cid:5)
| CVF-8          | Reported |                    |              |     |           |          |          |
| -------------- | -------- | ------------------ | ------------ | --- | --------- | -------- | -------- |
| • Category     |          | Overflow/Underflow |              |     |           | • Source | Pool.sol |
| Description    | Phantom  |                    | overflow     | is  | possible  | here.    |          |
| Recommendation |          | Use                | the “mulDiv” |     | function. |          |          |
(cid:7) (cid:4)
uint256 delta = (step.amountIn + step.feeAmount) * protocolFee /
384
| (cid:44)→ | ProtocolFeeLibrary.PIPS_DENOMINATOR; |     |     |     |     |     |     |
| --------- | ------------------------------------ | --- | --- | --- | --- | --- | --- |
(cid:6) (cid:5)
17

| CVF-9      | Reported |     |          |          |
| ---------- | -------- | --- | -------- | -------- |
| • Category | Flaw     |     | • Source | Pool.sol |
Description Here local variables of a type narrower than 256 bits are accessed
as it they were 256 bit wide. Solidity documentation warns that: “if you access
variables of a type that spans less than 256 bits (for example uint64, address, or
bytes16), you cannot make any assumptions about bits not part of the encoding of
the type” (https://docs.soliditylang.org/en/v0.8.26/assembly.html#access-to-external-
variables-functions-and-libraries).
Recommendation Properly clean extra bits between using narrow variables as recom-
mended in the documentation: “to be safe, always clear the data properly before you use
| it in a context | where this | is important”. |     |     |
| --------------- | ---------- | -------------- | --- | --- |
(cid:7) (cid:4)
liquidityGrossAfter,
552 (cid:6) (cid:5)
(cid:7) (cid:4)
| shl(128, | liquidityNet) |     |     |     |
| -------- | ------------- | --- | --- | --- |
554 (cid:6) (cid:5)
| CVF-10     | Reported           |     |          |                       |
| ---------- | ------------------ | --- | -------- | --------------------- |
| • Category | Overflow/Underflow |     | • Source | NonZeroDeltaCount.sol |
Description Relying on business-level constraints for preventing low-level problems,
such as underflow is a bid practice, as it introduces hidden relationships in the code.
| Recommendation | Add | proper underflow | check. |     |
| -------------- | --- | ---------------- | ------ | --- |
(cid:7) (cid:4)
/// Current usage ensures this will not happen because we call
28
(cid:44)→ decrement with known boundaries (only up to the number of
| (cid:44)→ times | we call | increment). |     |     |
| --------------- | ------- | ----------- | --- | --- |
(cid:6) (cid:5)
| CVF-11     | Reported |          |          |              |
| ---------- | -------- | -------- | -------- | ------------ |
| • Category | Unclear  | behavior | • Source | Reserves.sol |
Description This doesn’t allow distinguishing value == 0 and value == ZERO_BALANCE.
Recommendation Explicitly forbid passing “ZERO_BALANCE” as “value”.
(cid:7) (cid:4)
| if (value | == 0) value | = ZERO_BALANCE; |     |     |
| --------- | ----------- | --------------- | --- | --- |
19
(cid:6) (cid:5)
18

| CVF-12     | Reported |     |          |                           |
| ---------- | -------- | --- | -------- | ------------------------- |
| • Category | Flaw     |     | • Source | TransientStateLibrary.sol |
Description Here local variables of a type narrower than 256 bits are accessed
as it they were 256 bit wide. Solidity documentation warns that: “if you access
variables of a type that spans less than 256 bits (for example uint64, address, or
bytes16), you cannot make any assumptions about bits not part of the encoding of
the type” (https://docs.soliditylang.org/en/v0.8.26/assembly.html#access-to-external-
variables-functions-and-libraries).
Recommendation Properly clean extra bits between using narrow variables as recom-
mended in the documentation: “to be safe, always clear the data properly before you use
| it in a context | where this | is important”. |     |     |
| --------------- | ---------- | -------------- | --- | --- |
(cid:7) (cid:4)
| mstore(32, | currency) |     |     |     |
| ---------- | --------- | --- | --- | --- |
30 (cid:6) (cid:5)
(cid:7) (cid:4)
| mstore(0, | caller_) |     |     |     |
| --------- | -------- | --- | --- | --- |
47
| mstore(32, | currency) |     |     |     |
| ---------- | --------- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-13     | Reported |     |          |                   |
| ---------- | -------- | --- | -------- | ----------------- |
| • Category | Flaw     |     | • Source | CurrencyDelta.sol |
Description Here local variables of a type narrower than 256 bits are accessed
as it they were 256 bit wide. Solidity documentation warns that: “if you access
variables of a type that spans less than 256 bits (for example uint64, address, or
bytes16), you cannot make any assumptions about bits not part of the encoding of
the type” (https://docs.soliditylang.org/en/v0.8.26/assembly.html#access-to-external-
variables-functions-and-libraries).
Recommendation Properly clean extra bits between using narrow variables as recom-
mended in the documentation: “to be safe, always clear the data properly before you use
| it in a context | where this | is important”. |     |     |
| --------------- | ---------- | -------------- | --- | --- |
(cid:7) (cid:4)
| mstore(0, | caller_) |     |     |     |
| --------- | -------- | --- | --- | --- |
12
| mstore(32, | currency) |     |     |     |
| ---------- | --------- | --- | --- | --- |
(cid:6) (cid:5)
19

| CVF-14     | Reported |     |          |                   |
| ---------- | -------- | --- | -------- | ----------------- |
| • Category | Flaw     |     | • Source | LiquidityMath.sol |
Description Here local variables of a type narrower than 256 bits are accessed
as it they were 256 bit wide. Solidity documentation warns that: “if you access
variables of a type that spans less than 256 bits (for example uint64, address, or
bytes16), you cannot make any assumptions about bits not part of the encoding of
the type” (https://docs.soliditylang.org/en/v0.8.26/assembly.html#access-to-external-
variables-functions-and-libraries).
Recommendation Properly clean extra bits between using narrow variables as recom-
mended in the documentation: “to be safe, always clear the data properly before you use
| it in a context | where this | is important”. |     |     |
| --------------- | ---------- | -------------- | --- | --- |
(cid:7) (cid:4)
| z := add(x, | y)  |     |     |     |
| ----------- | --- | --- | --- | --- |
12 (cid:6) (cid:5)
| CVF-15     | Reported |     |          |              |
| ---------- | -------- | --- | -------- | ------------ |
| • Category | Flaw     |     | • Source | Extsload.sol |
Description This assumes that the copied ABI offset is 0x20 which is not actually guar-
anteed.
Recommendation Explicitly store the 0x20 value at the memory offset zero.
(cid:7) (cid:4)
// Copy the abi offset of dynamic array and the length of the array
42
| (cid:44)→ to    | memory. |       |     |     |
| --------------- | ------- | ----- | --- | --- |
| calldatacopy(0, | 0x04,   | 0x40) |     |     |
(cid:6) (cid:5)
| CVF-16     | Reported |     |          |              |
| ---------- | -------- | --- | -------- | ------------ |
| • Category | Flaw     |     | • Source | Exttload.sol |
Description This assumes that the copied ABI offset is 0x20 which is not actually guar-
anteed.
Recommendation Explicitly store the 0x20 value at the memory offset zero.
(cid:7) (cid:4)
// Copy the abi offset of dynamic array and the length of the array
23
| (cid:44)→ to    | memory. |       |     |     |
| --------------- | ------- | ----- | --- | --- |
| calldatacopy(0, | 0x04,   | 0x40) |     |     |
(cid:6) (cid:5)
20

|     | CVF-17     | Reported         |     |          |                  |
| --- | ---------- | ---------------- | --- | -------- | ---------------- |
|     | • Category | Unclear behavior |     | • Source | ProtocolFees.sol |
Description As “data” is allowed to be shorter than 32 bytes, this could read after the
|     | “data” contents. |                       |       |         |           |
| --- | ---------------- | --------------------- | ----- | ------- | --------- |
|     | Recommendation   | Require “data.length“ | to be | exactly | 32 bytes. |
(cid:7) (cid:4)
| 80  | returnData | := mload(add(_data, | 0x20)) |     |     |
| --- | ---------- | ------------------- | ------ | --- | --- |
(cid:6) (cid:5)
21

| 7           | Moderate          | Issues        |              |              |
| ----------- | ----------------- | ------------- | ------------ | ------------ |
| CVF-18      | Reported          |               |              |              |
| • Category  | Procedural        |               | • Source     | Currency.sol |
| Description | Any data returned | by the failed | call is lost | here.        |
Recommendation Included the data, returned by the failed call, into the error.
(cid:7) (cid:4)
| mstore(0x00, | 0xf4b3b1bc) | // `NativeTransferFailed()`. |     |     |
| ------------ | ----------- | ---------------------------- | --- | --- |
46
| revert(0x1c, | 0x04) |     |     |     |
| ------------ | ----- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-19      | Reported          |               |              |              |
| ----------- | ----------------- | ------------- | ------------ | ------------ |
| • Category  | Procedural        |               | • Source     | Currency.sol |
| Description | Any data returned | by the failed | call is lost | here.        |
Recommendation Included the data, returned by the failed call, into the error.
(cid:7) (cid:4)
| mstore(0x00, | 0xf27f64e4) | // `ERC20TransferFailed()`. |     |     |
| ------------ | ----------- | --------------------------- | --- | --- |
64
| revert(0x1c, | 0x04) |     |     |     |
| ------------ | ----- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-20     | Reported      |     |          |              |
| ---------- | ------------- | --- | -------- | ------------ |
| • Category | Documentation |     | • Source | Currency.sol |
Description The comment is inaccurate, as this line doesn’t restore, but rather set to zero
the overwritten part of the free memory pointer. Such technic looks like a dirty hack.
Recommendation Use memory referred by the free memory pointer rather than the first
two memory slots. This would make memory access a bit more expensive, but will make
| restoring | the free memory | pointer unnecessary. |     |     |
| --------- | --------------- | -------------------- | --- | --- |
(cid:7) (cid:4)
mstore(0x34, 0) // Restore the part of the free memory pointer that
67
| (cid:44)→ was | overwritten. |     |     |     |
| ------------- | ------------ | --- | --- | --- |
(cid:6) (cid:5)
22

| CVF-21      | Reported |         |           |       |            |           |
| ----------- | -------- | ------- | --------- | ----- | ---------- | --------- |
| • Category  |          | Unclear | behavior  |       | • Source   | Slot0.sol |
| Description | The      | maximum | fee value | looks | arbitrary. |           |
Recommendation Implement support for the full fees range, i.e. up to 100%.
(cid:7) (cid:4)
* the maximum is 1000 - meaning the maximum protocol fee is 0.1%
20 (cid:6) (cid:5)
| CVF-22     | Reported |            |     |     |          |           |
| ---------- | -------- | ---------- | --- | --- | -------- | --------- |
| • Category |          | Suboptimal |     |     | • Source | Slot0.sol |
Recommendation The bitwise “and“ is redundant, as Solidity permits junk in unused bits
| of narrow | types. |     |     |     |     |     |
| --------- | ------ | --- | --- | --- | --- | --- |
(cid:7) (cid:4)
| _sqrtPriceX96 |     | := and(MASK_160_BITS, |     |     | _packed) |     |
| ------------- | --- | --------------------- | --- | --- | -------- | --- |
42 (cid:6) (cid:5)
(cid:7) (cid:4)
_protocolFee := and(MASK_24_BITS, shr(PROTOCOL_FEE_OFFSET, _packed))
54 (cid:6) (cid:5)
(cid:7) (cid:4)
| _lpFee | := and(MASK_24_BITS, |     |     | shr(LP_FEE_OFFSET, |     | _packed)) |
| ------ | -------------------- | --- | --- | ------------------ | --- | --------- |
60 (cid:6) (cid:5)
| CVF-23     | Reported |            |     |     |          |           |
| ---------- | -------- | ---------- | --- | --- | -------- | --------- |
| • Category |          | Suboptimal |     |     | • Source | Slot0.sol |
Recommendation The “signextend” opcode is redundant, as Solidity permits junk in
| unused bits | of  | narrow types. |     |     |     |     |
| ----------- | --- | ------------- | --- | --- | --- | --- |
(cid:7) (cid:4)
| _tick | := signextend(2, |     | shr(TICK_OFFSET, |     | _packed)) |     |
| ----- | ---------------- | --- | ---------------- | --- | --------- | --- |
48 (cid:6) (cid:5)
23

| CVF-24 |            | Reported   |     |     |     |     |          |              |     |     |
| ------ | ---------- | ---------- | --- | --- | --- | --- | -------- | ------------ | --- | --- |
|        | • Category | Suboptimal |     |     |     |     | • Source | SafeCast.sol |     |     |
RecommendationThiscouldbesimplifiedas: functiontoUint160(uint256x)internalpure
returns (uint160 y) { if ((y = uint160(x)) != x) _revertOverflow(); }
(cid:7) (cid:4)
function toUint160(uint256 x) internal pure returns (uint160) {
21
|     | if     | (x >=       | 1 << | 160) | _revertOverflow(); |     |     |     |     |     |
| --- | ------ | ----------- | ---- | ---- | ------------------ | --- | --- | --- | --- | --- |
|     | return | uint160(x); |      |      |                    |     |     |     |     |     |
}
(cid:6) (cid:5)
| CVF-25 |            | Reported   |     |     |     |     |          |              |     |     |
| ------ | ---------- | ---------- | --- | --- | --- | --- | -------- | ------------ | --- | --- |
|        | • Category | Suboptimal |     |     |     |     | • Source | SafeCast.sol |     |     |
RecommendationThiscouldbesimplifiedas: functiontoUint128(uint256x)internalpure
returns (uint128 y) { if ((y = uint128(x)) != x) _revertOverflow(); }
(cid:7) (cid:4)
function toUint128(uint256 x) internal pure returns (uint128) {
29
|     | if  | (x >= | 1 << | 128) | _revertOverflow(); |     |     |     |     |     |
| --- | --- | ----- | ---- | ---- | ------------------ | --- | --- | --- | --- | --- |
30
|     | return | uint128(x); |     |     |     |     |     |     |     |     |
| --- | ------ | ----------- | --- | --- | --- | --- | --- | --- | --- | --- |
}
(cid:6) (cid:5)
| CVF-26 |            | Reported   |     |     |     |     |          |              |     |     |
| ------ | ---------- | ---------- | --- | --- | --- | --- | -------- | ------------ | --- | --- |
|        | • Category | Suboptimal |     |     |     |     | • Source | SafeCast.sol |     |     |
Recommendation This could be simplified as: function toInt128(int256 x) internal pure
| returns | (int128 | y)  | { if ((y | = int128(x)) |     | != x) _revertOverflow(); |     |     | }   |     |
| ------- | ------- | --- | -------- | ------------ | --- | ------------------------ | --- | --- | --- | --- |
(cid:7) (cid:4)
| function |     | toInt128(int256 |     |     | x)  | internal | pure | returns | (int128) | {   |
| -------- | --- | --------------- | --- | --- | --- | -------- | ---- | ------- | -------- | --- |
37
|     | unchecked |         | {   |      |               |     |        |     |             |        |
| --- | --------- | ------- | --- | ---- | ------------- | --- | ------ | --- | ----------- | ------ |
|     |           | if (((1 | <<  | 127) | + uint256(x)) |     | >> 128 | ==  | uint256(0)) | return |
(cid:44)→ int128(x);
_revertOverflow();
40
}
}
(cid:6) (cid:5)
24

| CVF-27     | Reported   |     |     |          |              |
| ---------- | ---------- | --- | --- | -------- | ------------ |
| • Category | Suboptimal |     |     | • Source | SafeCast.sol |
Recommendation This could be simplified as: function toInt256(uint256 x) internal pure
| returns (int256 | y) { | if ((y = int256(x)) | < 0) _revertOverflow(); |     | }   |
| --------------- | ---- | ------------------- | ----------------------- | --- | --- |
(cid:7) (cid:4)
function toInt256(uint256 x) internal pure returns (int256) {
47
| if (int256(x) |     | >= 0) return | int256(x); |     |     |
| ------------- | --- | ------------ | ---------- | --- | --- |
_revertOverflow();
}
50
(cid:6) (cid:5)
| CVF-28     | Reported   |     |     |          |              |
| ---------- | ---------- | --- | --- | -------- | ------------ |
| • Category | Suboptimal |     |     | • Source | SafeCast.sol |
Recommendation This could be simplified as: function toInt128(uint256 x) internal pure
returns (int128 y) { y = int128(int256(x)); if (y < 0 || uint128(y) != x) _revertOverflow(); }
(cid:7) (cid:4)
function toInt128(uint256 x) internal pure returns (int128) {
55
| if (x  | >= 1               | << 127) _revertOverflow(); |     |     |     |
| ------ | ------------------ | -------------------------- | --- | --- | --- |
| return | int128(int256(x)); |                            |     |     |     |
}
(cid:6) (cid:5)
| CVF-29     | Reported   |     |     |          |             |
| ---------- | ---------- | --- | --- | -------- | ----------- |
| • Category | Suboptimal |     |     | • Source | BitMath.sol |
RecommendationThisfunctioncouldbesignificantlyoptimized. Seethisimplementation:
https://github.com/Vectorized/solady/blob/main/src/utils/LibBit.sol#L12-L28
(cid:7) (cid:4)
function mostSignificantBit(uint256 x) internal pure returns (uint8
13
| (cid:44)→ r) | {   |     |     |     |     |
| ------------ | --- | --- | --- | --- | --- |
(cid:6) (cid:5)
25

| CVF-30     | Reported   |     |     |          |             |
| ---------- | ---------- | --- | --- | -------- | ----------- |
| • Category | Suboptimal |     |     | • Source | BitMath.sol |
RecommendationThisfunctioncouldbesignificantlyoptimized. Seethisimplementation:
https://github.com/Vectorized/solady/blob/main/src/utils/LibBit.sol#L47-L69
(cid:7) (cid:4)
function leastSignificantBit(uint256 x) internal pure returns (uint8
55
| (cid:44)→ r) | {   |     |     |     |     |
| ------------ | --- | --- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-31     | Reported   |     |     |          |              |
| ---------- | ---------- | --- | --- | -------- | ------------ |
| • Category | Suboptimal |     |     | • Source | FullMath.sol |
DescriptionWhilethisfunctionisveryefficientinageneralcase,forspecificcasesbetter
approachesdoexist. Forexample, when“a”, “b”, or“denominator“isaknownpowerof2,
multiplication or division could be replace with shift. When “denominator” is known at the
compile time, its modular inverse and shift should be precomputer. Also, if “denominator”
fitsinto128bits,simplemathtrickscouldbeused: https://medium.com/coinmonks/math-
in-solidity-part-3-percents-and-proportions-4db014e080b1#4821
Recommendation Implement efficient versions of this function for specific cases.
(cid:7) (cid:4)
function mulDiv(uint256 a, uint256 b, uint256 denominator) internal
14
| (cid:44)→ pure | returns | (uint256 | result) | {   |     |
| -------------- | ------- | -------- | ------- | --- | --- |
(cid:6) (cid:5)
| CVF-32     | Reported   |     |     |          |                |
| ---------- | ---------- | --- | --- | -------- | -------------- |
| • Category | Suboptimal |     |     | • Source | TickBitmap.sol |
Recommendation This function could be simplified by adding (tickSpacing « 24) to the
tick value before the division, and subtracting 2^24 from the division result. This would
make the division effectively unsigned, so no need to subtract one from the result in case
| of a negative | tick. |     |     |     |     |
| ------------- | ----- | --- | --- | --- | --- |
(cid:7) (cid:4)
function compress(int24 tick, int24 tickSpacing) internal pure
16
| (cid:44)→ returns | (int24 | compressed) |     | {   |     |
| ----------------- | ------ | ----------- | --- | --- | --- |
(cid:6) (cid:5)
26

| CVF-33     | Reported |                  |          |                |
| ---------- | -------- | ---------------- | -------- | -------------- |
| • Category |          | Unclear behavior | • Source | TickBitmap.sol |
Description This function permits negative tick spacings, which is weird.
Recommendation Make the “tickSpacing” argument unsigned or explicitly forbid negative
| “tickSpacing” | values. |     |     |     |
| ------------- | ------- | --- | --- | --- |
(cid:7) (cid:4)
16 function compress(int24 tick, int24 tickSpacing) internal pure
| (cid:44)→ | returns | (int24 compressed) | {   |     |
| --------- | ------- | ------------------ | --- | --- |
(cid:6) (cid:5)
| CVF-34     | Reported |                  |          |                |
| ---------- | -------- | ---------------- | -------- | -------------- |
| • Category |          | Unclear behavior | • Source | TickBitmap.sol |
Description This works correctly only when “tick” is a factor of “tickSpacing“.
Recommendation Explicitly forbid “tick” values that are not factors of “tickSpacing” or do
| proper | compression | here. |     |     |
| ------ | ----------- | ----- | --- | --- |
(cid:7) (cid:4)
| tick | := sdiv(tick, | tickSpacing) |     |     |
| ---- | ------------- | ------------ | --- | --- |
59 (cid:6) (cid:5)
27

| CVF-35     | Reported |     |          |                  |
| ---------- | -------- | --- | -------- | ---------------- |
| • Category | Flaw     |     | • Source | CustomRevert.sol |
Description Here local variables of a type narrower than 256 bits are accessed
as it they were 256 bit wide. Solidity documentation warns that: “if you access
variables of a type that spans less than 256 bits (for example uint64, address, or
bytes16), you cannot make any assumptions about bits not part of the encoding of
the type” (https://docs.soliditylang.org/en/v0.8.26/assembly.html#access-to-external-
variables-functions-and-libraries).
Recommendation Properly clean extra bits between using narrow variables as recom-
mended in the documentation: “to be safe, always clear the data properly before you use
| it in a context | where | this is important”. |     |     |
| --------------- | ----- | ------------------- | --- | --- |
(cid:7) (cid:4)
| mstore(0x04, | value) |     |     |     |
| ------------ | ------ | --- | --- | --- |
40 (cid:6) (cid:5)
(cid:7) (cid:4)
| mstore(0x04, | value1) |     |     |     |
| ------------ | ------- | --- | --- | --- |
49
| mstore(0x24, | value2) |     |     |     |
| ------------ | ------- | --- | --- | --- |
50 (cid:6) (cid:5)
(cid:7) (cid:4)
| mstore(0x04, | value1) |     |     |     |
| ------------ | ------- | --- | --- | --- |
59
| 60 mstore(0x24, | value2) |     |     |     |
| --------------- | ------- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-36     | Reported   |     |          |              |
| ---------- | ---------- | --- | -------- | ------------ |
| • Category | Procedural |     | • Source | Position.sol |
Description While the “mulDiv” function is very efficient in a generic case, for specific
| cases better | approaches | do exist. |     |     |
| ------------ | ---------- | --------- | --- | --- |
Recommendation Implement and use here the “mulShr” function similar to “mulDiv” but
| doing right | shift instead | of division. |     |     |
| ----------- | ------------- | ------------ | --- | --- |
(cid:7) (cid:4)
78 FullMath.mulDiv(feeGrowthInside0X128 - self.feeGrowthInside0LastX128
| (cid:44)→ | , liquidity, | FixedPoint128.Q128); |     |     |
| --------- | ------------ | -------------------- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
FullMath.mulDiv(feeGrowthInside1X128 - self.feeGrowthInside1LastX128
80
| (cid:44)→ | , liquidity, | FixedPoint128.Q128); |     |     |
| --------- | ------------ | -------------------- | --- | --- |
(cid:6) (cid:5)
28

|     | CVF-37      | Reported |         |          |     |              |          |              |
| --- | ----------- | -------- | ------- | -------- | --- | ------------ | -------- | ------------ |
|     | • Category  | Unclear  |         | behavior |     |              | • Source | TickMath.sol |
|     | Description | This     | assumes | MIN_TICK |     | = -MAX_TICK. |          |              |
Recommendation Do not rely on that assumption and use both, the “MIN_TICK” and the
|     | “MAX_TICK” | constants. |     |     |     |     |     |     |
| --- | ---------- | ---------- | --- | --- | --- | --- | --- | --- |
(cid:7) (cid:4)
| 63  | if gt(absTick, |     | MAX_TICK) |     | {   |     |     |     |
| --- | -------------- | --- | --------- | --- | --- | --- | --- | --- |
(cid:6) (cid:5)
|     | CVF-38     | Reported   |     |     |     |     |          |              |
| --- | ---------- | ---------- | --- | --- | --- | --- | -------- | ------------ |
|     | • Category | Suboptimal |     |     |     |     | • Source | TickMath.sol |
DescriptionItcouldmakesensetoperformafewmoreiterationsestimatingthelogarithm,
|     | in order | to make | the “getSqrtPriceAtTick” |     |     | call | more rare. |     |
| --- | -------- | ------- | ------------------------ | --- | --- | ---- | ---------- | --- |
RecommendationPerformexperimentstoempiricallyfindtheoptimalnumberofiterations.
(cid:7) (cid:4)
tick = tickLow == tickHi ? tickLow : getSqrtPriceAtTick(tickHi) <=
269
|     | (cid:44)→ | sqrtPriceX96 |     | ? tickHi |     | : tickLow; |     |     |
| --- | --------- | ------------ | --- | -------- | --- | ---------- | --- | --- |
(cid:6) (cid:5)
|     | CVF-39      | Reported |     |          |       |          |           |              |
| --- | ----------- | -------- | --- | -------- | ----- | -------- | --------- | ------------ |
|     | • Category  | Unclear  |     | behavior |       |          | • Source  | SwapMath.sol |
|     | Description | There    | is  | no range | check | for this | argument. |              |
Recommendation Add a check to ensure feePips <= MAX_FEE_PIPS.
(cid:7) (cid:4)
|     | uint24 | feePips |     |     |     |     |     |     |
| --- | ------ | ------- | --- | --- | --- | --- | --- | --- |
51
(cid:6) (cid:5)
29

| CVF-40     | Reported |                  |     |     |     |          |                        |
| ---------- | -------- | ---------------- | --- | --- | --- | -------- | ---------------------- |
| • Category |          | Unclear behavior |     |     |     | • Source | ProtocolFeeLibrary.sol |
Description It seems that here “self” is not a tightly packed pair of fees, but rather just a
single fee. In other placed, the “uint16” is used for a single fee, while “uint24” is used for
| a packed       | pair of | fees.   |          |      |     |              |     |
| -------------- | ------- | ------- | -------- | ---- | --- | ------------ | --- |
| Recommendation |         | Use the | “uint16” | type | for | “self” here. |     |
(cid:7) (cid:4)
| let numerator |     | := mul(self, |     | lpFee) |     |     |     |
| ------------- | --- | ------------ | --- | ------ | --- | --- | --- |
38
(cid:6) (cid:5)
| CVF-41         | Reported |                  |       |        |         |                |          |
| -------------- | -------- | ---------------- | ----- | ------ | ------- | -------------- | -------- |
| • Category     |          | Unclear behavior |       |        |         | • Source       | Pool.sol |
| Description    | There    | are no           | range | checks | for     | the arguments. |          |
| Recommendation |          | Add proper       | range |        | checks. |                |          |
(cid:7) (cid:4)
function initialize(State storage self, uint160 sqrtPriceX96, uint24
100
| (cid:44)→ | protocolFee, |     | uint24 | lpFee) |     |     |     |
| --------- | ------------ | --- | ------ | ------ | --- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
function setProtocolFee(State storage self, uint24 protocolFee)
112
| (cid:44)→ internal |     | {   |     |     |     |     |     |
| ------------------ | --- | --- | --- | --- | --- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
118 function setLPFee(State storage self, uint24 lpFee) internal {
(cid:6) (cid:5)
| CVF-42     | Reported |               |     |     |     |          |          |
| ---------- | -------- | ------------- | --- | --- | --- | -------- | -------- |
| • Category |          | Documentation |     |     |     | • Source | Pool.sol |
Description Despite the comment, this code doesn’t actually add fees somewhere, but
| rather calculates |     | the amounts | that | ought    | to  | be added. |     |
| ----------------- | --- | ----------- | ---- | -------- | --- | --------- | --- |
| Recommendation    |     | Rephrase    | the  | comment. |     |           |     |
(cid:7) (cid:4)
// Fees earned from LPing are added to the user's currency delta.
194
feeDelta = toBalanceDelta(feesOwed0.toInt128(), feesOwed1.toInt128()
| (cid:44)→ ); |     |     |     |     |     |     |     |
| ------------ | --- | --- | --- | --- | --- | --- | --- |
(cid:6) (cid:5)
30

|     | CVF-43 |          | Reported   |     |     |     |          |          |
| --- | ------ | -------- | ---------- | --- | --- | --- | -------- | -------- |
|     | •      | Category | Suboptimal |     |     |     | • Source | Pool.sol |
Description This logic seems redundant, as the initial fee growth values for a tick doesn’t
matter.
Recommendation Remove this logic and leave zero initial values.
(cid:7) (cid:4)
535 // by convention, we assume that all growth before a tick was
|     |     | (cid:44)→ initialized          |                       | happened | _below_ |     | the tick                     |     |
| --- | --- | ------------------------------ | --------------------- | -------- | ------- | --- | ---------------------------- | --- |
|     | if  | (tick                          | <= self.slot0.tick()) |          |         | {   |                              |     |
|     |     | Reported.feeGrowthOutside0X128 |                       |          |         |     | = self.feeGrowthGlobal0X128; |     |
|     |     | Reported.feeGrowthOutside1X128 |                       |          |         |     | = self.feeGrowthGlobal1X128; |     |
}
(cid:6) (cid:5)
|     | CVF-44 |          | Reported |          |     |     |          |                |
| --- | ------ | -------- | -------- | -------- | --- | --- | -------- | -------------- |
|     | •      | Category | Unclear  | behavior |     |     | • Source | ParseBytes.sol |
Description There is no length check for the “result” array, so data after the array could
|     | be read        | here. |     |        |        |        |     |     |
| --- | -------------- | ----- | --- | ------ | ------ | ------ | --- | --- |
|     | Recommendation |       | Add | proper | length | check. |     |     |
(cid:7) (cid:4)
|     | selector |     | := mload(add(result, |     |     | 0x20)) |     |     |
| --- | -------- | --- | -------------------- | --- | --- | ------ | --- | --- |
12
(cid:6) (cid:5)
(cid:7) (cid:4)
| 19  | lpFee | :=  | mload(add(result, |     |     | 0x60)) |     |     |
| --- | ----- | --- | ----------------- | --- | --- | ------ | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
|     | hookReturn |     | := mload(add(result, |     |     |     | 0x40)) |     |
| --- | ---------- | --- | -------------------- | --- | --- | --- | ------ | --- |
26 (cid:6) (cid:5)
31

| CVF-45     | Reported   |     |          |           |     |     |
| ---------- | ---------- | --- | -------- | --------- | --- | --- |
| • Category | Suboptimal |     | • Source | Hooks.sol |     |     |
Description This way of error reporting doesn’t allow distinguishing the following two
situations: i) a call failed with no revert reason, and ii) a call failed with “FailedHookCall”
error.
Recommendation Consider either always bubbling up the unchanged revert reason re-
turned by a call, or (preferred) to always wrap the revert reason, returned by a call, into a
named error.
| (cid:7)                     |     |     |     |     |     | (cid:4) |
| --------------------------- | --- | --- | --- | --- | --- | ------- |
| if iszero(returndatasize()) |     | {   |     |     |     |         |
132
| // if | the call failed | without | a revert | reason, | revert with | `   |
| ----- | --------------- | ------- | -------- | ------- | ----------- | --- |
(cid:44)→ FailedHookCall()`
| mstore(0,    | 0x36bc48c5) |     |     |     |     |     |
| ------------ | ----------- | --- | --- | --- | --- | --- |
| revert(0x1c, | 0x04)       |     |     |     |     |     |
}
| // bubble         | up revert            |     |          |                  |     |         |
| ----------------- | -------------------- | --- | -------- | ---------------- | --- | ------- |
| returndatacopy(0, | 0, returndatasize()) |     |          |                  |     |         |
| revert(0,         | returndatasize())    |     |          |                  |     |         |
| (cid:6)           |                      |     |          |                  |     | (cid:5) |
| CVF-46            | Reported             |     |          |                  |     |         |
| • Category        | Suboptimal           |     | • Source | StateLibrary.sol |     |         |
Description This zeros high bits of the free memory counter regardless of what was the
| original value | of these bits.   |              |       |     |     |         |
| -------------- | ---------------- | ------------ | ----- | --- | --- | ------- |
| Recommendation | Properly restore | the original | bits. |     |     |         |
| (cid:7)        |                  |              |       |     |     | (cid:4) |
| mstore(0x26,   | 0) // rewrite    | 0x26         | to 0  |     |     |         |
| 262 (cid:6)    |                  |              |       |     |     | (cid:5) |
32

| CVF-47     | Reported |        |     |          |                   |
| ---------- | -------- | ------ | --- | -------- | ----------------- |
| • Category | Bad      | naming |     | • Source | IProtocolFees.sol |
Description The semantics of the arguments and returned values is unclear.
RecommendationGivedescriptivenamestotheunnamedargumentsandreturnedvalues
| and/or | explain then | in documentation | comments. |     |     |
| ------ | ------------ | ---------------- | --------- | --- | --- |
(cid:7) (cid:4)
23 function protocolFeesAccrued(Currency) external view returns (
| (cid:44)→ | uint256); |     |     |     |     |
| --------- | --------- | --- | --- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
function setProtocolFee(PoolKey memory key, uint24) external;
26
(cid:6) (cid:5)
(cid:7) (cid:4)
32 function collectProtocolFees(address, Currency, uint256) external
| (cid:44)→ | returns | (uint256); |     |     |     |
| --------- | ------- | ---------- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-48     | Reported   |     |     |          |             |
| ---------- | ---------- | --- | --- | -------- | ----------- |
| • Category | Procedural |     |     | • Source | ERC6909.sol |
Description Here a low-level underflow check is used to enforce a business-level con-
straint, which is a bad practice, as it makes code more error-prone and harder to read.
Recommendation Implement explicit balance and allowance checks.
(cid:7) (cid:4)
| 36 balanceOf[msg.sender][id] |     |     | -= amount; |     |     |
| ---------------------------- | --- | --- | ---------- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
if (allowed != type(uint256).max) allowance[sender][msg.sender][
48
|     | (cid:44)→ id] | = allowed | - amount; |     |     |
| --- | ------------- | --------- | --------- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
| 51 balanceOf[sender][id] |     |     | -= amount; |     |     |
| ------------------------ | --- | --- | ---------- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
| balanceOf[sender][id] |     |     | -= amount; |     |     |
| --------------------- | --- | --- | ---------- | --- | --- |
96 (cid:6) (cid:5)
33

|     | CVF-49     | Reported   |     |     |          |                   |
| --- | ---------- | ---------- | --- | --- | -------- | ----------------- |
|     | • Category | Procedural |     |     | • Source | ERC6909Claims.sol |
Description Here a low-level underflow check is used to enforce a business-level con-
straint, which is a bad practice, as it makes code more error-prone and harder to read.
|     | Recommendation | Implement | an explicit | allowance | check. |     |
| --- | -------------- | --------- | ----------- | --------- | ------ | --- |
(cid:7) (cid:4)
| 18  | allowance[from][sender][id] |     | =   | senderAllowance |     | - amount; |
| --- | --------------------------- | --- | --- | --------------- | --- | --------- |
(cid:6) (cid:5)
|     | CVF-50     | Reported   |     |     |          |                  |
| --- | ---------- | ---------- | --- | --- | -------- | ---------------- |
|     | • Category | Procedural |     |     | • Source | ProtocolFees.sol |
Description Here a low-level underflow check is used to enforce a business-level con-
straint, which is a bad practice, as it makes code more error-prone and harder to read.
|     | Recommendation | Implement | an explicit | balance | check. |     |
| --- | -------------- | --------- | ----------- | ------- | ------ | --- |
(cid:7) (cid:4)
|     | protocolFeesAccrued[currency] |     |     | -= amountCollected; |     |     |
| --- | ----------------------------- | --- | --- | ------------------- | --- | --- |
53 (cid:6) (cid:5)
34

| 8           | Minor        | Issues      |                  |              |
| ----------- | ------------ | ----------- | ---------------- | ------------ |
| CVF-51      | Reported     |             |                  |              |
| • Category  | Procedural   |             | • Source         | Currency.sol |
| Description | This version | requirement | looks arbitrary. |              |
Recommendation Specify as “^0.8.0” unless there is something special regarding this
particular version. Also relevant for: PoolKey.sol, BalanceDelta.sol, Slot0.sol, PoolId.sol,
BeforeSwapDelta.sol, SafeCast.sol, BitMath.sol, FullMath.sol, FixedPoint128.sol,Tick-
Bitmap.sol, Position.sol,TickMath.sol, UnsafeMath.sol, FixedPoint96.sol, SqrtPrice-
Math.sol, SwapMath.sol, ProtocolFeeLibrary.sol, LPFeeLibrary.sol, Pool.sol, Parse-
Bytes.sol, Hooks.sol, Lock.sol, NonZeroDeltaCount.sol, Reserves.sol, StateLibrary.sol,
TransientStateLibrary.sol, CurrencyDelta.sol, LiquidityMath.sol, IERC20Minimal.sol, IUn-
lockCallback.sol, IExttload.sol, IHooks.sol, IProtocolFeeController.sol, IProtocolFees.sol,
IPoolManager.sol, Exttload.sol, NoDelegateCall.sol, ProtocolFees.sol, PoolManager.sol.
(cid:7) (cid:4)
| pragma | solidity ^0.8.20; |     |     |     |
| ------ | ----------------- | --- | --- | --- |
2
(cid:6) (cid:5)
| CVF-52     | Reported   |     |          |              |
| ---------- | ---------- | --- | -------- | ------------ |
| • Category | Procedural |     | • Source | Currency.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity ^0.8.20; |     |     |     |
| ------ | ----------------- | --- | --- | --- |
2 (cid:6) (cid:5)
| CVF-53     | Reported   |     |          |              |
| ---------- | ---------- | --- | -------- | ------------ |
| • Category | Procedural |     | • Source | Currency.sol |
Recommendation This library should be moved into a separate file named “CurrencyLi-
brary.sol”.
(cid:7) (cid:4)
| library | CurrencyLibrary | {   |     |     |
| ------- | --------------- | --- | --- | --- |
29 (cid:6) (cid:5)
35

| CVF-54     | Reported   |     |          |              |
| ---------- | ---------- | --- | -------- | ------------ |
| • Category | Suboptimal |     | • Source | Currency.sol |
Recommendation This errors could be made more useful by adding certain parameters
into them.
(cid:7) (cid:4)
| error NativeTransferFailed(); |     |     |     |     |
| ----------------------------- | --- | --- | --- | --- |
31
(cid:6) (cid:5)
(cid:7) (cid:4)
| error ERC20TransferFailed(); |     |     |     |     |
| ---------------------------- | --- | --- | --- | --- |
34
(cid:6) (cid:5)
| CVF-55     | Reported   |     |          |             |
| ---------- | ---------- | --- | -------- | ----------- |
| • Category | Procedural |     | • Source | PoolKey.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity | ^0.8.19; |     |     |
| ------ | -------- | -------- | --- | --- |
2 (cid:6) (cid:5)
| CVF-56         | Reported      |                   |               |             |
| -------------- | ------------- | ----------------- | ------------- | ----------- |
| • Category     | Documentation |                   | • Source      | PoolKey.sol |
| Description    | Here “the     | first bit” sounds | ambiguous.    |             |
| Recommendation | Rephrase      | as “the           | highest bit”. |             |
(cid:7) (cid:4)
13 /// @notice The pool swap fee, capped at 1_000_000. If the first bit
(cid:44)→ is 1, the pool has a dynamic fee and must be exactly equal to
| (cid:44)→ | 0x800000 |     |     |     |
| --------- | -------- | --- | --- | --- |
(cid:6) (cid:5)
36

| CVF-57     | Reported   |     |     |          |                  |
| ---------- | ---------- | --- | --- | -------- | ---------------- |
| • Category | Procedural |     |     | • Source | BalanceDelta.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity ^0.8.20; |     |     |     |     |
| ------ | ----------------- | --- | --- | --- | --- |
2 (cid:6) (cid:5)
| CVF-58     | Reported   |     |     |          |                  |
| ---------- | ---------- | --- | --- | -------- | ---------------- |
| • Category | Suboptimal |     |     | • Source | BalanceDelta.sol |
Recommendation This could be simplified as: balanceDelta := or(shl(128, _amount0),
| shr(128(shl(128, | _amount1)))) |     |     |     |     |
| ---------------- | ------------ | --- | --- | --- | --- |
(cid:7) (cid:4)
balanceDelta := or(shl(128, _amount0), and(sub(shl(128, 1), 1),
16
| (cid:44)→ _amount1)) |     |     |     |     |     |
| -------------------- | --- | --- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-59     | Reported   |     |     |          |                  |
| ---------- | ---------- | --- | --- | -------- | ---------------- |
| • Category | Procedural |     |     | • Source | BalanceDelta.sol |
Recommendation The functionality of these calls is quite simple and could be also incor-
| porated into | the assembly | blocks | for efficiency. |     |     |
| ------------ | ------------ | ------ | --------------- | --- | --- |
(cid:7) (cid:4)
| return | toBalanceDelta(res0.toInt128(), |     |     | res1.toInt128()); |     |
| ------ | ------------------------------- | --- | --- | ----------------- | --- |
31
(cid:6) (cid:5)
(cid:7) (cid:4)
| return | toBalanceDelta(res0.toInt128(), |     |     | res1.toInt128()); |     |
| ------ | ------------------------------- | --- | --- | ----------------- | --- |
45 (cid:6) (cid:5)
37

| CVF-60     | Reported |            |     |     |     |     |          |           |
| ---------- | -------- | ---------- | --- | --- | --- | --- | -------- | --------- |
| • Category |          | Procedural |     |     |     |     | • Source | Slot0.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity | ^0.8.20; |     |     |     |     |     |     |
| ------ | -------- | -------- | --- | --- | --- | --- | --- | --- |
2 (cid:6) (cid:5)
| CVF-61     | Reported |            |     |     |     |     |          |           |
| ---------- | -------- | ---------- | --- | --- | --- | --- | -------- | --------- |
| • Category |          | Suboptimal |     |     |     |     | • Source | Slot0.sol |
Description So there are actually two fields for protocol fees, rather than one.
| Recommendation |     | Reflect | this | in  | the “layout” |     | section above. |     |
| -------------- | --- | ------- | ---- | --- | ------------ | --- | -------------- | --- |
(cid:7) (cid:4)
* Protocol fee, expressed in hundredths of a bip, upper 12 bits are
19
| (cid:44)→ for | 1->0, | and | the | lower |     | 12 are | for 0->1 |     |
| ------------- | ----- | --- | --- | ----- | --- | ------ | -------- | --- |
(cid:6) (cid:5)
| CVF-62         | Reported |               |        |     |               |       |             |           |
| -------------- | -------- | ------------- | ------ | --- | ------------- | ----- | ----------- | --------- |
| • Category     |          | Documentation |        |     |               |       | • Source    | Slot0.sol |
| Description    | The      | number        | format |     | for thsi      | value | is unclear. |           |
| Recommendation |          | Explain       | in     | the | documentation |       | comment.    |           |
(cid:7) (cid:4)
* Used for the lp fee, either static at initialize or dynamic via
24
| (cid:44)→ hook |        |     |     |     |     |     |     |     |
| -------------- | ------ | --- | --- | --- | --- | --- | --- | --- |
| * uint24       | lpFee; |     |     |     |     |     |     |     |
(cid:6) (cid:5)
38

CVF-63 Reported
• Category Readability • Source Slot0.sol
Recommendation This value could be rendered as “type(uint160).max”.
(cid:7) (cid:4)
uint160 internal constant MASK_160_BITS = 0
32
(cid:44)→ x00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
(cid:6) (cid:5)
CVF-64 Reported
• Category Readability • Source Slot0.sol
Recommendation This value could be rendered as “type(uint24).max”.
(cid:7) (cid:4)
uint24 internal constant MASK_24_BITS = 0xFFFFFF;
33 (cid:6) (cid:5)
CVF-65 Reported
• Category Suboptimal • Source Slot0.sol
Description A protocol fee value is actually a pair of numbers, so using the “uint24” type
for it is confusing.
Recommendation Use a user-defined type wrapping “uint24”.
(cid:7) (cid:4)
function protocolFee(Slot0 _packed) internal pure returns (uint24
52
(cid:44)→ _protocolFee) {
(cid:6) (cid:5)
(cid:7) (cid:4)
function setProtocolFee(Slot0 _packed, uint24 _protocolFee) internal
77
(cid:44)→ pure returns (Slot0 _result) {
(cid:6) (cid:5)
39

| CVF-66         | Reported |            |                    |           |       |              |           |
| -------------- | -------- | ---------- | ------------------ | --------- | ----- | ------------ | --------- |
| • Category     |          | Suboptimal |                    |           |       | • Source     | Slot0.sol |
| Description    | The      | value      | “not(MAX_160_BITS” |           |       | is constant. |           |
| Recommendation |          | Don’t      | calculate          | it in run | time. |              |           |
(cid:7) (cid:4)
_result := or(and(not(MASK_160_BITS), _packed), and(MASK_160_BITS,
67
| (cid:44)→ _sqrtPriceX96)) |     |     |     |     |     |     |     |
| ------------------------- | --- | --- | --- | --- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-67     | Reported |            |     |     |     |          |           |
| ---------- | -------- | ---------- | --- | --- | --- | -------- | --------- |
| • Category |          | Suboptimal |     |     |     | • Source | Slot0.sol |
Description The value “not(shl(TICK_OFFSET, MASK_24_BITS))” is constant.
| Recommendation |     | Don’t | calculate | it in run | time. |     |     |
| -------------- | --- | ----- | --------- | --------- | ----- | --- | --- |
(cid:7) (cid:4)
_result := or(and(not(shl(TICK_OFFSET, MASK_24_BITS)), _packed), shl
73
| (cid:44)→ (TICK_OFFSET, |     |     | and(MASK_24_BITS, |     |     | _tick))) |     |
| ----------------------- | --- | --- | ----------------- | --- | --- | -------- | --- |
(cid:6) (cid:5)
| CVF-68     | Reported |            |     |     |     |          |           |
| ---------- | -------- | ---------- | --- | --- | --- | -------- | --------- |
| • Category |          | Suboptimal |     |     |     | • Source | Slot0.sol |
Description The value “not(shl(PROTOCOL_FEE_OFFSET, MASK_24_BITS))” is constant.
| Recommendation |     | Don’t | calculate | it in run | time. |     |     |
| -------------- | --- | ----- | --------- | --------- | ----- | --- | --- |
(cid:7) (cid:4)
| and(not(shl(PROTOCOL_FEE_OFFSET, |     |     |     |     | MASK_24_BITS)), |     | _packed), |
| -------------------------------- | --- | --- | --- | --- | --------------- | --- | --------- |
81 (cid:6) (cid:5)
40

| CVF-69     | Reported   |     |     |          |           |     |
| ---------- | ---------- | --- | --- | -------- | --------- | --- |
| • Category | Suboptimal |     |     | • Source | Slot0.sol |     |
Description The value “not(shl(LP_FEE_OFFSET, MASK_24_BITS))” is constant.
| Recommendation | Don’t | calculate | it in run time. |     |     |     |
| -------------- | ----- | --------- | --------------- | --- | --- | --- |
(cid:7) (cid:4)
| or(and(not(shl(LP_FEE_OFFSET, |     |     | MASK_24_BITS)), |     | _packed), | shl( |
| ----------------------------- | --- | --- | --------------- | --- | --------- | ---- |
90
| (cid:44)→ LP_FEE_OFFSET, |     | and(MASK_24_BITS, |     | _lpFee))) |     |     |
| ------------------------ | --- | ----------------- | --- | --------- | --- | --- |
(cid:6) (cid:5)
| CVF-70     | Reported   |     |     |          |            |     |
| ---------- | ---------- | --- | --- | -------- | ---------- | --- |
| • Category | Procedural |     |     | • Source | PoolId.sol |     |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity | ^0.8.20; |     |     |     |     |
| ------ | -------- | -------- | --- | --- | --- | --- |
2
(cid:6) (cid:5)
| CVF-71         | Reported   |           |                  |          |            |     |
| -------------- | ---------- | --------- | ---------------- | -------- | ---------- | --- |
| • Category     | Suboptimal |           |                  | • Source | PoolId.sol |     |
| Description    | The value  | “mul(32,  | 5)” is constant. |          |            |     |
| Recommendation | Don’t      | calculate | it in run time.  |          |            |     |
(cid:7) (cid:4)
| poolId | := keccak256(poolKey, |     | mul(32, | 5)) |     |     |
| ------ | --------------------- | --- | ------- | --- | --- | --- |
13 (cid:6) (cid:5)
| CVF-72     | Reported   |     |     |          |                     |     |
| ---------- | ---------- | --- | --- | -------- | ------------------- | --- |
| • Category | Procedural |     |     | • Source | BeforeSwapDelta.sol |     |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity | ^0.8.20; |     |     |     |     |
| ------ | -------- | -------- | --- | --- | --- | --- |
2 (cid:6) (cid:5)
41

| CVF-73     | Reported   |     |     |          |                     |
| ---------- | ---------- | --- | --- | -------- | ------------------- |
| • Category | Suboptimal |     |     | • Source | BeforeSwapDelta.sol |
Description As this type actually encapsulates two values, using the “int256” type for
| internal representation |     | doesn’t   | make much | sense. |     |
| ----------------------- | --- | --------- | --------- | ------ | --- |
| Recommendation          | Use | “bytes32” | instead.  |        |     |
(cid:7) (cid:4)
7 // Upper 128 bits is the delta in specified tokens. Lower 128 bits
(cid:44)→ is delta in unspecified tokens (to match the afterSwap hook)
| type BeforeSwapDelta |     | is  | int256; |     |     |
| -------------------- | --- | --- | ------- | --- | --- |
(cid:6) (cid:5)
| CVF-74         | Reported   |               |                 |              |                     |
| -------------- | ---------- | ------------- | --------------- | ------------ | ------------------- |
| • Category     | Suboptimal |               |                 | • Source     | BeforeSwapDelta.sol |
| Description    | The value  | “sub(shl(128, | 1), 1)”         | is constant. |                     |
| Recommendation | Don’t      | calculate     | it in run time. |              |                     |
(cid:7) (cid:4)
beforeSwapDelta := or(shl(128, deltaSpecified), and(sub(shl(128, 1),
16
| (cid:44)→ | 1), deltaUnspecified)) |     |     |     |     |
| --------- | ---------------------- | --- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-75     | Reported   |     |     |          |              |
| ---------- | ---------- | --- | --- | -------- | ------------ |
| • Category | Procedural |     |     | • Source | SafeCast.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity | ^0.8.20; |     |     |     |
| ------ | -------- | -------- | --- | --- | --- |
2 (cid:6) (cid:5)
42

| CVF-76     | Reported   |     |          |             |
| ---------- | ---------- | --- | -------- | ----------- |
| • Category | Procedural |     | • Source | BitMath.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | ^0.8.20; |     |     |     |
| --------------- | -------- | --- | --- | --- |
2 (cid:6) (cid:5)
| CVF-77     | Reported   |     |          |              |
| ---------- | ---------- | --- | -------- | ------------ |
| • Category | Procedural |     | • Source | FullMath.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | ^0.8.20; |     |     |     |
| --------------- | -------- | --- | --- | --- |
2
(cid:6) (cid:5)
| CVF-78     | Reported   |     |          |              |
| ---------- | ---------- | --- | -------- | ------------ |
| • Category | Suboptimal |     | • Source | FullMath.sol |
Description The value “mulmod(a, b, denominator)” was already calculated inside the
| “mulDiv” function. |       |                        |        |     |
| ------------------ | ----- | ---------------------- | ------ | --- |
| Recommendation     | Reuse | the already calculated | value. |     |
(cid:7) (cid:4)
| if (mulmod(a, | b, denominator) | != 0) | {   |     |
| ------------- | --------------- | ----- | --- | --- |
112 (cid:6) (cid:5)
| CVF-79     | Reported   |     |          |                   |
| ---------- | ---------- | --- | -------- | ----------------- |
| • Category | Procedural |     | • Source | FixedPoint128.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | ^0.8.20; |     |     |     |
| --------------- | -------- | --- | --- | --- |
2
(cid:6) (cid:5)
43

| CVF-80      | Reported     |               |                |          |                   |
| ----------- | ------------ | ------------- | -------------- | -------- | ----------------- |
| • Category  | Procedural   |               |                | • Source | FixedPoint128.sol |
| Description | This library | consists only | of a constant. |          |                   |
Recommendation Move the constant to the top level and remove the library.
(cid:7) (cid:4)
| library | FixedPoint128 | {   |     |     |     |
| ------- | ------------- | --- | --- | --- | --- |
6 (cid:6) (cid:5)
| CVF-81     | Reported   |     |     |          |                |
| ---------- | ---------- | --- | --- | -------- | -------------- |
| • Category | Procedural |     |     | • Source | TickBitmap.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity | ^0.8.20; |     |     |     |
| ------ | -------- | -------- | --- | --- | --- |
2
(cid:6) (cid:5)
| CVF-82     | Reported   |     |     |          |                |
| ---------- | ---------- | --- | --- | -------- | -------------- |
| • Category | Suboptimal |     |     | • Source | TickBitmap.sol |
Description The subexpression “1 « bitPos” is calculated twice.
RecommendationCalculateonceandreuseorcalculatelikethis: unchecked{mask=(1«
| uint256(bitPos) | + 1) | - 1; } |     |     |     |
| --------------- | ---- | ------ | --- | --- | --- |
(cid:7) (cid:4)
| uint256 | mask = | (1 << bitPos) | - 1 + | (1 << bitPos); |     |
| ------- | ------ | ------------- | ----- | -------------- | --- |
92 (cid:6) (cid:5)
44

| CVF-83     | Reported   |          |                |     |
| ---------- | ---------- | -------- | -------------- | --- |
| • Category | Procedural | • Source | TickBitmap.sol |     |
RecommendationMultiplicationby“tickSpacing”shouldbedoneinoneplaceoutsidethe
ternary operator.
(cid:7) (cid:4)
? (compressed - int24(uint24(bitPos - BitMath.mostSignificantBit(
99
(cid:44)→ masked)))) * tickSpacing
| 100 : (compressed | - int24(uint24(bitPos))) | * tickSpacing; |     |     |
| ----------------- | ------------------------ | -------------- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
? (compressed + int24(uint24(BitMath.leastSignificantBit(masked) -
112
(cid:44)→ bitPos))) * tickSpacing
| : (compressed | + int24(uint24(type(uint8).max |     | - bitPos))) | *   |
| ------------- | ------------------------------ | --- | ----------- | --- |
(cid:44)→ tickSpacing;
(cid:6) (cid:5)
| CVF-84     | Reported   |          |                |     |
| ---------- | ---------- | -------- | -------------- | --- |
| • Category | Procedural | • Source | TickBitmap.sol |     |
Recommendation Subtraction from “compressed” should be done in one place outside
| the ternary operator. |     |     |     |     |
| --------------------- | --- | --- | --- | --- |
(cid:7) (cid:4)
? (compressed - int24(uint24(bitPos - BitMath.mostSignificantBit(
99
(cid:44)→ masked)))) * tickSpacing
| : (compressed | - int24(uint24(bitPos))) | * tickSpacing; |     |     |
| ------------- | ------------------------ | -------------- | --- | --- |
100
(cid:6) (cid:5)
| CVF-85     | Reported   |          |                |     |
| ---------- | ---------- | -------- | -------------- | --- |
| • Category | Procedural | • Source | TickBitmap.sol |     |
Recommendation Addition to “compressed” should be done in one place outside the
ternary operator.
(cid:7) (cid:4)
? (compressed + int24(uint24(BitMath.leastSignificantBit(masked) -
112
(cid:44)→ bitPos))) * tickSpacing
| : (compressed | + int24(uint24(type(uint8).max |     | - bitPos))) | *   |
| ------------- | ------------------------------ | --- | ----------- | --- |
(cid:44)→ tickSpacing;
(cid:6) (cid:5)
45

| CVF-86     | Reported   |          |                  |
| ---------- | ---------- | -------- | ---------------- |
| • Category | Procedural | • Source | CustomRevert.sol |
Description Specifying a compiler version range without upper bound is a bad practice,
as it is impossible to guarantee compatibility with future major releases.
Recommendation Specify as “^0.8.0”. Also relevant for: IERC6909Claims.sol,
IExtsload.sol, IExttload.sol, Extsload.sol, Exttload.sol, ERC6909Claims.sol,ERC6909.sol.
(cid:7) (cid:4)
| pragma solidity | >=0.8.4; |     |     |
| --------------- | -------- | --- | --- |
2
(cid:6) (cid:5)
| CVF-87     | Reported   |          |                  |
| ---------- | ---------- | -------- | ---------------- |
| • Category | Procedural | • Source | CustomRevert.sol |
Description This version requirement is inconsistent with other files in this code base.
(cid:7) (cid:4)
| pragma solidity | >=0.8.4; |     |     |
| --------------- | -------- | --- | --- |
2
(cid:6) (cid:5)
| CVF-88     | Reported   |          |              |
| ---------- | ---------- | -------- | ------------ |
| • Category | Procedural | • Source | Position.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | ^0.8.20; |     |     |
| --------------- | -------- | --- | --- |
2 (cid:6) (cid:5)
| CVF-89     | Reported   |          |              |
| ---------- | ---------- | -------- | ------------ |
| • Category | Suboptimal | • Source | Position.sol |
Recommendation This error could be made more useful by adding certain parameters
into it.
(cid:7) (cid:4)
error CannotUpdateEmptyPosition();
16 (cid:6) (cid:5)
46

| CVF-90     | Reported   |     |     |                     |
| ---------- | ---------- | --- | --- | ------------------- |
| • Category | Procedural |     | •   | Source TickMath.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | ^0.8.20; |     |     |     |
| --------------- | -------- | --- | --- | --- |
2 (cid:6) (cid:5)
| CVF-91     | Reported   |     |     |                     |
| ---------- | ---------- | --- | --- | ------------------- |
| • Category | Suboptimal |     | •   | Source TickMath.sol |
Recommendation These errors could be made more useful by adding some parameters
into them.
(cid:7) (cid:4)
| error InvalidTick(); |     |     |     |     |
| -------------------- | --- | --- | --- | --- |
9 (cid:6) (cid:5)
(cid:7) (cid:4)
| error InvalidSqrtPrice(); |     |     |     |     |
| ------------------------- | --- | --- | --- | --- |
11 (cid:6) (cid:5)
| CVF-92     | Reported   |     |     |                     |
| ---------- | ---------- | --- | --- | ------------------- |
| • Category | Suboptimal |     | •   | Source TickMath.sol |
Recommendation This expression should use the “MAX_SQRT_PRICE” and
| “MIN_SQRT_PRICE” | constants | instead | of hardcoded | values. |
| ---------------- | --------- | ------- | ------------ | ------- |
(cid:7) (cid:4)
1461446703485210103287273052203988822378723970342 - 4295128739 - 1;
29 (cid:6) (cid:5)
| CVF-93     | Reported   |     |     |                     |
| ---------- | ---------- | --- | --- | ------------------- |
| • Category | Suboptimal |     | •   | Source TickMath.sol |
Recommendation This could be simplified as: MAX_TICK - MAX_TICK % tickSpacing
(cid:7) (cid:4)
| return (MAX_TICK | / tickSpacing) |     | * tickSpacing; |     |
| ---------------- | -------------- | --- | -------------- | --- |
34 (cid:6) (cid:5)
47

| CVF-94     | Reported |            |     |     |          |              |
| ---------- | -------- | ---------- | --- | --- | -------- | ------------ |
| • Category |          | Suboptimal |     |     | • Source | TickMath.sol |
Recommendation This could be simplified as: MIN_TICK - MIN_TICK % tickSpacing
(cid:7) (cid:4)
| return | (MIN_TICK | /   | tickSpacing) | *   | tickSpacing; |     |
| ------ | --------- | --- | ------------ | --- | ------------ | --- |
41
(cid:6) (cid:5)
| CVF-95         | Reported |                 |          |               |          |              |
| -------------- | -------- | --------------- | -------- | ------------- | -------- | ------------ |
| • Category     |          | Procedural      |          |               | • Source | TickMath.sol |
| Description    | The      | value “shl(128, | 1)”      | is calculated | twice.   |              |
| Recommendation |          | Calculate       | once and | reuse.        |          |              |
(cid:7) (cid:4)
| price | := xor(shl(128, |     | 1), mul(xor(shl(128, |     |     | 1), 0 |
| ----- | --------------- | --- | -------------------- | --- | --- | ----- |
75
(cid:44)→ xfffcb933bd6fad37aa2d162d1a594001), and(absTick, 0x1)))
(cid:6) (cid:5)
| CVF-96     | Reported |            |     |     |          |              |
| ---------- | -------- | ---------- | --- | --- | -------- | ------------ |
| • Category |          | Suboptimal |     |     | • Source | TickMath.sol |
Description The value “xor(shl(128, 1), 0xfffcb933bd6fad37aa2d162d1a594001)” is
| actually       | a constant. |          |            |                 |     |     |
| -------------- | ----------- | -------- | ---------- | --------------- | --- | --- |
| Recommendation |             | Hardcode | it instead | of calculating. |     |     |
(cid:7) (cid:4)
| price | := xor(shl(128, |     | 1), mul(xor(shl(128, |     |     | 1), 0 |
| ----- | --------------- | --- | -------------------- | --- | --- | ----- |
75
(cid:44)→ xfffcb933bd6fad37aa2d162d1a594001), and(absTick, 0x1)))
(cid:6) (cid:5)
48

| CVF-97     | Reported   |          |              |
| ---------- | ---------- | -------- | ------------ |
| • Category | Suboptimal | • Source | TickMath.sol |
DescriptionTheseerrorboundsseemtobefoundanalyticallyandcouldbetoopessimistic.
Recommendation Iterate throw all valid ticks to empirically find the exact error bounds.
(cid:7) (cid:4)
| int24 tickLow | = int24((log_sqrt10001 | -   |     |
| ------------- | ---------------------- | --- | --- |
266
| (cid:44)→ 3402992956809132418596140100660247210)   |                        |     | >> 128); |
| -------------------------------------------------- | ---------------------- | --- | -------- |
| int24 tickHi                                       | = int24((log_sqrt10001 | +   |          |
| (cid:44)→ 291339464771989622907027621153398088495) |                        |     | >> 128); |
(cid:6) (cid:5)
| CVF-98     | Reported   |          |                |
| ---------- | ---------- | -------- | -------------- |
| • Category | Procedural | • Source | UnsafeMath.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | ^0.8.20; |     |     |
| --------------- | -------- | --- | --- |
2 (cid:6) (cid:5)
| CVF-99     | Reported   |          |                  |
| ---------- | ---------- | -------- | ---------------- |
| • Category | Procedural | • Source | FixedPoint96.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | ^0.8.20; |     |     |
| --------------- | -------- | --- | --- |
2
(cid:6) (cid:5)
49

| CVF-100     | Reported     |               |               |          |                  |
| ----------- | ------------ | ------------- | ------------- | -------- | ---------------- |
| • Category  | Procedural   |               |               | • Source | FixedPoint96.sol |
| Description | This library | consists only | of constants. |          |                  |
Recommendation Move the constants to the top level and remove the library.
(cid:7) (cid:4)
| library | FixedPoint96 | {   |     |     |     |
| ------- | ------------ | --- | --- | --- | --- |
7 (cid:6) (cid:5)
| CVF-101    | Reported   |     |     |          |                   |
| ---------- | ---------- | --- | --- | -------- | ----------------- |
| • Category | Procedural |     |     | • Source | SqrtPriceMath.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity | ^0.8.20; |     |     |     |
| ------ | -------- | -------- | --- | --- | --- |
2
(cid:6) (cid:5)
| CVF-102    | Reported   |     |     |          |                   |
| ---------- | ---------- | --- | --- | -------- | ----------------- |
| • Category | Suboptimal |     |     | • Source | SqrtPriceMath.sol |
Recommendation These errors could be made more useful by adding certain parameters
into them.
(cid:7) (cid:4)
| error | InvalidPriceOrLiquidity(); |     |     |     |     |
| ----- | -------------------------- | --- | --- | --- | --- |
15
| error | InvalidPrice();       |     |     |     |     |
| ----- | --------------------- | --- | --- | --- | --- |
| error | NotEnoughLiquidity(); |     |     |     |     |
| error | PriceOverflow();      |     |     |     |     |
(cid:6) (cid:5)
50

| CVF-103     | Reported   |             |      |                   |          |                   |
| ----------- | ---------- | ----------- | ---- | ----------------- | -------- | ----------------- |
| • Category  | Procedural |             |      |                   | • Source | SqrtPriceMath.sol |
| Description | This       | line is the | same | in both branches. |          |                   |
Recommendation Do this calculation in one place before the conditional statement.
(cid:7) (cid:4)
| uint256 | product | = amount |     | * sqrtPX96; |     |     |
| ------- | ------- | -------- | --- | ----------- | --- | --- |
42 (cid:6) (cid:5)
(cid:7) (cid:4)
| uint256 | product | = amount |     | * sqrtPX96; |     |     |
| ------- | ------- | -------- | --- | ----------- | --- | --- |
55 (cid:6) (cid:5)
| CVF-104    | Reported   |     |     |     |          |                   |
| ---------- | ---------- | --- | --- | --- | -------- | ----------------- |
| • Category | Suboptimal |     |     |     | • Source | SqrtPriceMath.sol |
Description The “mulDiv” function is very efficient in a generic case, while for particular
| cases better | approaches |     | could | exist. |     |     |
| ------------ | ---------- | --- | ----- | ------ | --- | --- |
Recommendation Implement and use here a “shlDiv” function similar to “mulDiv” but
| performing | left shift | instead | of  | multiplication. |     |     |
| ---------- | ---------- | ------- | --- | --------------- | --- | --- |
(cid:7) (cid:4)
| : FullMath.mulDiv(amount, |     |     |     | FixedPoint96.Q96, |     | liquidity) |
| ------------------------- | --- | --- | --- | ----------------- | --- | ---------- |
92 (cid:6) (cid:5)
| CVF-105    | Reported   |     |     |     |          |              |
| ---------- | ---------- | --- | --- | --- | -------- | ------------ |
| • Category | Procedural |     |     |     | • Source | SwapMath.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity | ^0.8.20; |     |     |     |     |
| ------ | -------- | -------- | --- | --- | --- | --- |
2 (cid:6) (cid:5)
51

| CVF-106    | Reported   |     |     |          |              |     |
| ---------- | ---------- | --- | --- | -------- | ------------ | --- |
| • Category | Suboptimal |     |     | • Source | SwapMath.sol |     |
Description The value “MAX_FEE_PIPS - _feePips” is calculated twice.
| Recommendation | Calculate | once and | reuse. |     |     |     |
| -------------- | --------- | -------- | ------ | --- | --- | --- |
(cid:7) (cid:4)
| FullMath.mulDiv(uint256(-amountRemaining), |     |     |     |     | MAX_FEE_PIPS | -   |
| ------------------------------------------ | --- | --- | --- | --- | ------------ | --- |
60
|     | (cid:44)→ _feePips, | MAX_FEE_PIPS); |     |     |     |     |
| --- | ------------------- | -------------- | --- | --- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
|     | : FullMath.mulDivRoundingUp(amountIn, |     |     |     | _feePips, | MAX_FEE_PIPS |
| --- | ------------------------------------- | --- | --- | --- | --------- | ------------ |
69
|     | (cid:44)→ - _feePips); |     |     |     |     |     |
| --- | ---------------------- | --- | --- | --- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
100 feeAmount = FullMath.mulDivRoundingUp(amountIn, _feePips,
| (cid:44)→ | MAX_FEE_PIPS - | _feePips); |     |     |     |     |
| --------- | -------------- | ---------- | --- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-107    | Reported   |     |     |          |              |     |
| ---------- | ---------- | --- | --- | -------- | ------------ | --- |
| • Category | Suboptimal |     |     | • Source | SwapMath.sol |     |
Description The value “-amountRemaining” is calculated twice.
| Recommendation | Calculate | once and | reuse. |     |     |     |
| -------------- | --------- | -------- | ------ | --- | --- | --- |
(cid:7) (cid:4)
FullMath.mulDiv(uint256(-amountRemaining), MAX_FEE_PIPS - _feePips,
60
| (cid:44)→ | MAX_FEE_PIPS); |     |     |     |     |     |
| --------- | -------------- | --- | --- | --- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
| feeAmount | = uint256(-amountRemaining) |     |     | - amountIn; |     |     |
| --------- | --------------------------- | --- | --- | ----------- | --- | --- |
78 (cid:6) (cid:5)
| CVF-108    | Reported   |     |     |          |                        |     |
| ---------- | ---------- | --- | --- | -------- | ---------------------- | --- |
| • Category | Procedural |     |     | • Source | ProtocolFeeLibrary.sol |     |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity ^0.8.20; |     |     |     |     |     |
| ------ | ----------------- | --- | --- | --- | --- | --- |
2
(cid:6) (cid:5)
52

| CVF-109        | Reported |            |       |       |            |       |        |                        |     |
| -------------- | -------- | ---------- | ----- | ----- | ---------- | ----- | ------ | ---------------------- | --- |
| • Category     |          | Suboptimal |       |       |            | •     | Source | ProtocolFeeLibrary.sol |     |
| Description    | This     | value      | looks | quite | arbitrary. |       |        |                        |     |
| Recommendation |          | Support    |       | full  | fees range | up to | 100%.  |                        |     |
(cid:7) (cid:4)
| // Max | protocol |     | fee | is 0.1% | (1000 | pips) |     |     |     |
| ------ | -------- | --- | --- | ------- | ----- | ----- | --- | --- | --- |
5
| uint16 | public | constant |     | MAX_PROTOCOL_FEE |     |     | =   | 1000; |     |
| ------ | ------ | -------- | --- | ---------------- | --- | --- | --- | ----- | --- |
(cid:6) (cid:5)
| CVF-110    | Reported |            |     |     |     |     |        |                        |     |
| ---------- | -------- | ---------- | --- | --- | --- | --- | ------ | ---------------------- | --- |
| • Category |          | Suboptimal |     |     |     | •   | Source | ProtocolFeeLibrary.sol |     |
Description These values actually depend on the value of the “MAX_PROTOCL_FEE”
constant.
Recommendation Derive these values from the “MAX_PROTOCL_FEE” constant.
(cid:7) (cid:4)
| uint24 | internal |     | constant |     | FEE_0_THRESHOLD |     | =   | 1001; |     |
| ------ | -------- | --- | -------- | --- | --------------- | --- | --- | ----- | --- |
9
| uint24 | internal |     | constant |     | FEE_1_THRESHOLD |     | =   | 1001 | << 12; |
| ------ | -------- | --- | -------- | --- | --------------- | --- | --- | ---- | ------ |
10 (cid:6) (cid:5)
| CVF-111    | Reported |            |     |     |     |     |        |                  |     |
| ---------- | -------- | ---------- | --- | --- | --- | --- | ------ | ---------------- | --- |
| • Category |          | Procedural |     |     |     | •   | Source | LPFeeLibrary.sol |     |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity |     | ^0.8.20; |     |     |     |     |     |     |
| ------ | -------- | --- | -------- | --- | --- | --- | --- | --- | --- |
2
(cid:6) (cid:5)
53

| CVF-112    | Reported   |     |          |                  |
| ---------- | ---------- | --- | -------- | ---------------- |
| • Category | Suboptimal |     | • Source | LPFeeLibrary.sol |
Recommendation This error could be made more useful by adding certain parameters
into it.
(cid:7) (cid:4)
| error FeeTooLarge(); |     |     |     |     |
| -------------------- | --- | --- | --- | --- |
12
(cid:6) (cid:5)
| CVF-113    | Reported   |     |          |          |
| ---------- | ---------- | --- | -------- | -------- |
| • Category | Procedural |     | • Source | Pool.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity ^0.8.20; |     |     |     |
| ------ | ----------------- | --- | --- | --- |
2 (cid:6) (cid:5)
| CVF-114     | Reported     |                    |                |          |
| ----------- | ------------ | ------------------ | -------------- | -------- |
| • Category  | Suboptimal   |                    | • Source       | Pool.sol |
| Description | Setting each | field individually | is suboptimal. |          |
Recommendation Implement a function to pack all the components in a “slot0” value at
once.
(cid:7) (cid:4)
self.slot0 = Slot0.wrap(bytes32(0)).setSqrtPriceX96(sqrtPriceX96).
108
| (cid:44)→ setTick(tick).setProtocolFee(protocolFee) |     |     |     |     |
| --------------------------------------------------- | --- | --- | --- | --- |
.setLpFee(lpFee);
(cid:6) (cid:5)
54

| CVF-115        | Reported         |        |           |          |     |
| -------------- | ---------------- | ------ | --------- | -------- | --- |
| • Category     | Unclear behavior |        | • Source  | Pool.sol |     |
| Recommendation | These functions  | should | emit some | events.  |     |
(cid:7) (cid:4)
function setProtocolFee(State storage self, uint24 protocolFee)
112
| (cid:44)→ internal | {   |     |     |     |     |
| ------------------ | --- | --- | --- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
function setLPFee(State storage self, uint24 lpFee) internal {
118
(cid:6) (cid:5)
| CVF-116    | Reported   |     |          |          |     |
| ---------- | ---------- | --- | -------- | -------- | --- |
| • Category | Suboptimal |     | • Source | Pool.sol |     |
Description This check does more harm than good. It solves minor problem that apprear
rarely at cost of making the most comnon use case more expensive.
| Recommendation | Remove this | check. |     |     |     |
| -------------- | ----------- | ------ | --- | --- | --- |
(cid:7) (cid:4)
| if (!exactInput | && (swapFee | ==  | LPFeeLibrary.MAX_LP_FEE)) |     | {   |
| --------------- | ----------- | --- | ------------------------- | --- | --- |
315
InvalidFeeForExactOut.selector.revertWith();
}
(cid:6) (cid:5)
| CVF-117        | Reported     |        |                  |          |     |
| -------------- | ------------ | ------ | ---------------- | -------- | --- |
| • Category     | Procedural   |        | • Source         | Pool.sol |     |
| Recommendation | These checks | should | be done earlier. |          |     |
(cid:7) (cid:4)
| if (params.sqrtPriceLimitX96 |     | <=  | TickMath.MIN_SQRT_PRICE) |     | {   |
| ---------------------------- | --- | --- | ------------------------ | --- | --- |
325
PriceLimitOutOfBounds.selector.revertWith(params.
(cid:44)→ sqrtPriceLimitX96);
}
(cid:6) (cid:5)
(cid:7) (cid:4)
| if (params.sqrtPriceLimitX96 |     | >=  | TickMath.MAX_SQRT_PRICE) |     | {   |
| ---------------------------- | --- | --- | ------------------------ | --- | --- |
332
PriceLimitOutOfBounds.selector.revertWith(params.
(cid:44)→ sqrtPriceLimitX96);
}
(cid:6) (cid:5)
55

| CVF-118    | Reported   |     |     |          |          |
| ---------- | ---------- | --- | --- | -------- | -------- |
| • Category | Suboptimal |     |     | • Source | Pool.sol |
Recommendation This condition could be simplified as: state.amountSpecifiedRemaining
| != 0 && state.sqrtPriceX96 |     | != params.sqrtPriceLimitX96 |     |     |     |
| -------------------------- | --- | --------------------------- | --- | --- | --- |
(cid:7) (cid:4)
340
(cid:6) (cid:5)
| CVF-119    | Reported    |     |     |          |          |
| ---------- | ----------- | --- | --- | -------- | -------- |
| • Category | Readability |     |     | • Source | Pool.sol |
Recommendation Removing the logical “not” from this condition and interchanging cor-
| responding | branches | would make | code more | readable. |     |
| ---------- | -------- | ---------- | --------- | --------- | --- |
(cid:7) (cid:4)
| if (!exactInput) |     | {   |     |     |     |
| ---------------- | --- | --- | --- | --- | --- |
366 (cid:6) (cid:5)
| CVF-120    | Reported    |     |     |          |          |
| ---------- | ----------- | --- | --- | -------- | -------- |
| • Category | Readability |     |     | • Source | Pool.sol |
Recommendation This line could be simplified using the “-=” operator.
(cid:7) (cid:4)
state.amountCalculated = state.amountCalculated - (step.amountIn +
370
| (cid:44)→ | step.feeAmount).toInt256(); |     |     |     |     |
| --------- | --------------------------- | --- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-121    | Reported    |     |     |          |          |
| ---------- | ----------- | --- | --- | -------- | -------- |
| • Category | Readability |     |     | • Source | Pool.sol |
Recommendation This line could be simplified using the “+=” operator.
(cid:7) (cid:4)
state.amountCalculated = state.amountCalculated + step.amountOut.
376
| (cid:44)→ | toInt256(); |     |     |     |     |
| --------- | ----------- | --- | --- | --- | --- |
(cid:6) (cid:5)
56

| CVF-122     | Reported    |                   |                |          |
| ----------- | ----------- | ----------------- | -------------- | -------- |
| • Category  | Suboptimal  |                   | • Source       | Pool.sol |
| Description | Setting two | fields separately | is suboptimal. |          |
Recommendation Implement a function to set both fields at once.
(cid:7) (cid:4)
self.slot0 = slot0Start.setTick(state.tick).setSqrtPriceX96(state.
431
| (cid:44)→ sqrtPriceX96); |     |     |     |     |
| ------------------------ | --- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-123    | Reported   |     |          |                |
| ---------- | ---------- | --- | -------- | -------------- |
| • Category | Procedural |     | • Source | ParseBytes.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
2
(cid:6) (cid:5)
| CVF-124    | Reported   |     |          |           |
| ---------- | ---------- | --- | -------- | --------- |
| • Category | Procedural |     | • Source | Hooks.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity | ^0.8.24; |     |     |
| ------ | -------- | -------- | --- | --- |
2 (cid:6) (cid:5)
57

CVF-125 Reported
• Category Suboptimal • Source Hooks.sol
Recommendation These errors could be made more useful by adding certain parameters
into them.
(cid:7) (cid:4)
error InvalidHookResponse();
70 (cid:6) (cid:5)
(cid:7) (cid:4)
error FailedHookCall();
73 (cid:6) (cid:5)
(cid:7) (cid:4)
error HookDeltaExceedsSwapAmount();
76 (cid:6) (cid:5)
58

| CVF-126    | Reported   |     |                  |
| ---------- | ---------- | --- | ---------------- |
| • Category | Suboptimal | •   | Source Hooks.sol |
Recommendation It would me more efficient to convert “permissions” into a bit mask and
| then compare | with the corresponding | bits of “self” | at once. |
| ------------ | ---------------------- | -------------- | -------- |
(cid:7) (cid:4)
| permissions.beforeInitialize |     | != self.hasPermission( |     |
| ---------------------------- | --- | ---------------------- | --- |
84
| (cid:44)→ BEFORE_INITIALIZE_FLAG) |     |     |                     |
| --------------------------------- | --- | --- | ------------------- |
| || permissions.afterInitialize    |     | !=  | self.hasPermission( |
(cid:44)→ AFTER_INITIALIZE_FLAG)
| || permissions.beforeAddLiquidity |     |     | != self.hasPermission( |
| --------------------------------- | --- | --- | ---------------------- |
(cid:44)→ BEFORE_ADD_LIQUIDITY_FLAG)
| || permissions.afterAddLiquidity |     |     | != self.hasPermission( |
| -------------------------------- | --- | --- | ---------------------- |
(cid:44)→ AFTER_ADD_LIQUIDITY_FLAG)
| || permissions.beforeRemoveLiquidity |     |     | != self.hasPermission( |
| ------------------------------------ | --- | --- | ---------------------- |
(cid:44)→ BEFORE_REMOVE_LIQUIDITY_FLAG)
| || permissions.afterRemoveLiquidity |     |     | != self.hasPermission( |
| ----------------------------------- | --- | --- | ---------------------- |
(cid:44)→ AFTER_REMOVE_LIQUIDITY_FLAG)
|| permissions.beforeSwap != self.hasPermission(BEFORE_SWAP_FLAG
90
(cid:44)→ )
|| permissions.afterSwap != self.hasPermission(AFTER_SWAP_FLAG)
| || permissions.beforeDonate |     | != self.hasPermission( |     |
| --------------------------- | --- | ---------------------- | --- |
(cid:44)→
BEFORE_DONATE_FLAG)
| || permissions.afterDonate |     | != self.hasPermission( |     |
| -------------------------- | --- | ---------------------- | --- |
(cid:44)→ AFTER_DONATE_FLAG)
| || permissions.beforeSwapReturnDelta |     |     | != self.hasPermission( |
| ------------------------------------ | --- | --- | ---------------------- |
(cid:44)→ BEFORE_SWAP_RETURNS_DELTA_FLAG)
| || permissions.afterSwapReturnDelta |     |     | != self.hasPermission( |
| ----------------------------------- | --- | --- | ---------------------- |
(cid:44)→ AFTER_SWAP_RETURNS_DELTA_FLAG)
| || permissions.afterAddLiquidityReturnDelta |     |     | != self. |
| ------------------------------------------- | --- | --- | -------- |
(cid:44)→ hasPermission(AFTER_ADD_LIQUIDITY_RETURNS_DELTA_FLAG)
| || permissions.afterRemoveLiquidityReturnDelta |     |     |     |
| ---------------------------------------------- | --- | --- | --- |
!= self.hasPermission(
(cid:44)→ AFTER_REMOVE_LIQUIDITY_RETURNS_DELTA_FLAG)
(cid:6) (cid:5)
59

| CVF-127    | Reported   |     |          |          |
| ---------- | ---------- | --- | -------- | -------- |
| • Category | Procedural |     | • Source | Lock.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity | ^0.8.20; |     |     |
| ------ | -------- | -------- | --- | --- |
2 (cid:6) (cid:5)
| CVF-128        | Reported    |             |          |          |
| -------------- | ----------- | ----------- | -------- | -------- |
| • Category     | Procedural  |             | • Source | Lock.sol |
| Description    | This import | isn’t used. |          |          |
| Recommendation | Remove      | it.         |          |          |
(cid:7) (cid:4)
| import | {IHooks} | from "../interfaces/IHooks.sol"; |     |     |
| ------ | -------- | -------------------------------- | --- | --- |
4
(cid:6) (cid:5)
| CVF-129    | Reported   |     |          |                       |
| ---------- | ---------- | --- | -------- | --------------------- |
| • Category | Procedural |     | • Source | NonZeroDeltaCount.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity | ^0.8.20; |     |     |
| ------ | -------- | -------- | --- | --- |
2 (cid:6) (cid:5)
| CVF-130        | Reported    |             |          |                       |
| -------------- | ----------- | ----------- | -------- | --------------------- |
| • Category     | Procedural  |             | • Source | NonZeroDeltaCount.sol |
| Description    | This import | isn’t used. |          |                       |
| Recommendation | Remove      | it.         |          |                       |
(cid:7) (cid:4)
| import | {IHooks} | from "../interfaces/IHooks.sol"; |     |     |
| ------ | -------- | -------------------------------- | --- | --- |
4 (cid:6) (cid:5)
60

| CVF-131    | Reported   |     |     |          |              |
| ---------- | ---------- | --- | --- | -------- | ------------ |
| • Category | Procedural |     |     | • Source | Reserves.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity ^0.8.20; |     |     |     |     |
| ------ | ----------------- | --- | --- | --- | --- |
2 (cid:6) (cid:5)
| CVF-132    | Reported   |     |     |          |                  |
| ---------- | ---------- | --- | --- | -------- | ---------------- |
| • Category | Procedural |     |     | • Source | StateLibrary.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity ^0.8.21; |     |     |     |     |
| ------ | ----------------- | --- | --- | --- | --- |
2
(cid:6) (cid:5)
| CVF-133    | Reported   |     |     |          |                  |
| ---------- | ---------- | --- | --- | -------- | ---------------- |
| • Category | Procedural |     |     | • Source | StateLibrary.sol |
RecommendationThesebitwise“and”operationsareredundant,asSoliditytoleratesjunk
| in unused | bits of narrow | types. |     |     |     |
| --------- | -------------- | ------ | --- | --- | --- |
(cid:7) (cid:4)
sqrtPriceX96 := and(data, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
58
| (cid:44)→ | )   |     |     |     |     |
| --------- | --- | --- | --- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
| protocolFee | := and(shr(184, |     | data), | 0xFFFFFF) |     |
| ----------- | --------------- | --- | ------ | --------- | --- |
62
(cid:6) (cid:5)
(cid:7) (cid:4)
| lpFee | := and(shr(208, | data), | 0xFFFFFF) |     |     |
| ----- | --------------- | ------ | --------- | --- | --- |
64
(cid:6) (cid:5)
(cid:7) (cid:4)
liquidityGross := and(firstWord, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
96
(cid:6) (cid:5)
(cid:7) (cid:4)
liquidityGross := and(value, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
121 (cid:6) (cid:5)
61

| CVF-134    | Reported   |     |     |     |          |                  |
| ---------- | ---------- | --- | --- | --- | -------- | ---------------- |
| • Category | Procedural |     |     |     | • Source | StateLibrary.sol |
Recommendation The “signextend” operation is redundant as Solidity tolerates junk in
| unused | bits of narrow | types. |     |     |     |     |
| ------ | -------------- | ------ | --- | --- | --- | --- |
(cid:7) (cid:4)
| tick | := signextend(2, |     | shr(160, | data)) |     |     |
| ---- | ---------------- | --- | -------- | ------ | --- | --- |
60
(cid:6) (cid:5)
| CVF-135    | Reported   |     |     |     |          |                           |
| ---------- | ---------- | --- | --- | --- | -------- | ------------------------- |
| • Category | Procedural |     |     |     | • Source | TransientStateLibrary.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity | ^0.8.21; |     |     |     |     |
| ------ | -------- | -------- | --- | --- | --- | --- |
2 (cid:6) (cid:5)
| CVF-136    | Reported   |     |     |     |          |                           |
| ---------- | ---------- | --- | --- | --- | -------- | ------------------------- |
| • Category | Procedural |     |     |     | • Source | TransientStateLibrary.sol |
Description Solidity compiler is smart enough to precompute constant hash expressions.
Recommendation Use hash expressions instead of hardcoded hashes.
(cid:7) (cid:4)
| /// bytes32(uint256(keccak256("ReservesOf")) |     |     |     |     |     | - 1) |
| -------------------------------------------- | --- | --- | --- | --- | --- | ---- |
10
| bytes32 | public | constant | RESERVES_OF_SLOT |     | =   |     |
| ------- | ------ | -------- | ---------------- | --- | --- | --- |
0x1e0745a7db1623981f0b2a5d4232364c00787266eb75ad546f190e6cebe9bd95;
(cid:6) (cid:5)
(cid:7) (cid:4)
// The slot holding the number of nonzero deltas. bytes32(uint256(
13
| (cid:44)→ | keccak256("NonzeroDeltaCount")) |          |                          |     | - 1) |     |
| --------- | ------------------------------- | -------- | ------------------------ | --- | ---- | --- |
| bytes32   | public                          | constant | NONZERO_DELTA_COUNT_SLOT |     |      | =   |
0x7d4b3164c6e45b97e7d87b7125a44c5828d005af88f9d751cfd78729c5d99a0b;
(cid:6) (cid:5)
(cid:7) (cid:4)
// The slot holding the unlocked state, transiently. bytes32(uint256
17
| (cid:44)→ | (keccak256("Unlocked")) |          |                  | - 1) |     |     |
| --------- | ----------------------- | -------- | ---------------- | ---- | --- | --- |
| bytes32   | public                  | constant | IS_UNLOCKED_SLOT |      | =   |     |
0xc090fc4683624cfc3884e9d8de5eca132f2d0ec062aff75d43c0465d5ceeab23;
(cid:6) (cid:5)
62

| CVF-137    | Reported   |     |          |                   |
| ---------- | ---------- | --- | -------- | ----------------- |
| • Category | Procedural |     | • Source | CurrencyDelta.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity ^0.8.20; |     |     |     |
| ------ | ----------------- | --- | --- | --- |
2 (cid:6) (cid:5)
| CVF-138    | Reported   |     |          |                   |
| ---------- | ---------- | --- | -------- | ----------------- |
| • Category | Procedural |     | • Source | LiquidityMath.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity ^0.8.20; |     |     |     |
| ------ | ----------------- | --- | --- | --- |
2
(cid:6) (cid:5)
| CVF-139    | Reported   |     |          |                   |
| ---------- | ---------- | --- | -------- | ----------------- |
| • Category | Procedural |     | • Source | LiquidityMath.sol |
Description The only function implemented in this library is actually not liquidity specific.
It just adds an int128 value to a uint128 value and returns the result as uint128.
Recommendation Move the function into a generic utility library and remove this library.
(cid:7) (cid:4)
| library | LiquidityMath | {   |     |     |
| ------- | ------------- | --- | --- | --- |
5 (cid:6) (cid:5)
63

| CVF-140    | Reported |            |     |     |     |          |                   |
| ---------- | -------- | ---------- | --- | --- | --- | -------- | ----------------- |
| • Category |          | Procedural |     |     |     | • Source | LiquidityMath.sol |
Recommendation This function could be implemented in pure Solidity like this: uint256
result = uint256(int256(uint256(x)) + int256(y)); if ((z = uint128(result)) != result) revert
SafeCastOverflow();
(cid:7) (cid:4)
function addDelta(uint128 x, int128 y) internal pure returns (
10
| (cid:44)→ uint128 |     | z) { |     |     |     |     |     |
| ----------------- | --- | ---- | --- | --- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-141        | Reported |               |     |           |         |                 |                   |
| -------------- | -------- | ------------- | --- | --------- | ------- | --------------- | ----------------- |
| • Category     |          | Documentation |     |           |         | • Source        | IERC20Minimal.sol |
| Description    | Here     | “balance      | of  | a token”  | sounds  | ambiguous.      |                   |
| Recommendation |          | Rephrase      |     | as “token | balance | of an account”. |                   |
(cid:7) (cid:4)
| /// @notice |     | Returns | the | balance | of  | a token |     |
| ----------- | --- | ------- | --- | ------- | --- | ------- | --- |
7
(cid:6) (cid:5)
| CVF-142    | Reported |            |     |     |     |          |                    |
| ---------- | -------- | ---------- | --- | --- | --- | -------- | ------------------ |
| • Category |          | Procedural |     |     |     | • Source | IERC6909Claims.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity | >=0.8.0; |     |     |     |     |     |
| ------ | -------- | -------- | --- | --- | --- | --- | --- |
2 (cid:6) (cid:5)
| CVF-143        | Reported |         |           |        |       |              |                    |
| -------------- | -------- | ------- | --------- | ------ | ----- | ------------ | ------------------ |
| • Category     |          | Unclear | behavior  |        |       | • Source     | IERC6909Claims.sol |
| Recommendation |          | This    | interface | misses | event | definitions. |                    |
(cid:7) (cid:4)
| interface | IERC6909Claims |     |     | {   |     |     |     |
| --------- | -------------- | --- | --- | --- | --- | --- | --- |
4 (cid:6) (cid:5)
64

| CVF-144     | Reported      |          |                 |          |                    |
| ----------- | ------------- | -------- | --------------- | -------- | ------------------ |
| • Category  | Documentation |          |                 | • Source | IERC6909Claims.sol |
| Description | The returned  | value is | not documented. |          |                    |
Recommendation Give a descriptive name to the returned value and/or describe in the
| documentation | comment. |     |     |     |     |
| ------------- | -------- | --- | --- | --- | --- |
(cid:7) (cid:4)
28 function transfer(address receiver, uint256 id, uint256 amount)
| (cid:44)→ external | returns | (bool); |     |     |     |
| ------------------ | ------- | ------- | --- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
function transferFrom(address sender, address receiver, uint256 id,
35
| (cid:44)→ uint256 | amount) | external | returns | (bool); |     |
| ----------------- | ------- | -------- | ------- | ------- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
function approve(address spender, uint256 id, uint256 amount)
41
| (cid:44)→ external | returns | (bool); |     |     |     |
| ------------------ | ------- | ------- | --- | --- | --- |
(cid:6) (cid:5)
(cid:7) (cid:4)
function setOperator(address spender, bool approved) external
46
| (cid:44)→ returns | (bool); |     |     |     |     |
| ----------------- | ------- | --- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-145    | Reported   |     |     |          |     |
| ---------- | ---------- | --- | --- | -------- | --- |
| • Category | Procedural |     |     | • Source |     |
Description Specifying a compiler version range without upper bound is a bad practice,
as it is impossible to guarantee compatibility with future major releases.
| Recommendation | Specify | as “^0.6.0 | || ^0.7.0 | || ^0.8.0”. |     |
| -------------- | ------- | ---------- | --------- | ----------- | --- |
(cid:7) (cid:4)
| pragma | solidity >=0.6.0; |     |     |     |     |
| ------ | ----------------- | --- | --- | --- | --- |
2
(cid:6) (cid:5)
| CVF-146    | Reported   |     |     |          |               |
| ---------- | ---------- | --- | --- | -------- | ------------- |
| • Category | Procedural |     |     | • Source | IExtsload.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity >=0.6.0; |     |     |     |     |
| ------ | ----------------- | --- | --- | --- | --- |
2 (cid:6) (cid:5)
65

| CVF-147    | Reported      |          |               |
| ---------- | ------------- | -------- | ------------- |
| • Category | Documentation | • Source | IExtsload.sol |
Recommendation It would be more reasonable to return an array of “bytes32“ values.
(cid:7) (cid:4)
/// @return value The value of the sload-ed slots concatenated as
13
| (cid:44)→ dynamic | bytes |     |     |
| ----------------- | ----- | --- | --- |
(cid:6) (cid:5)
| CVF-148    | Reported   |          |               |
| ---------- | ---------- | -------- | ------------- |
| • Category | Procedural | • Source | IExttload.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | >=0.8.24; |     |     |
| --------------- | --------- | --- | --- |
2 (cid:6) (cid:5)
| CVF-149    | Reported   |          |            |
| ---------- | ---------- | -------- | ---------- |
| • Category | Procedural | • Source | IHooks.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | ^0.8.24; |     |     |
| --------------- | -------- | --- | --- |
2
(cid:6) (cid:5)
| CVF-150    | Reported   |          |                            |
| ---------- | ---------- | -------- | -------------------------- |
| • Category | Procedural | • Source | IProtocolFeeController.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | ^0.8.20; |     |     |
| --------------- | -------- | --- | --- |
2 (cid:6) (cid:5)
66

| CVF-151    | Reported      |     |          |                            |
| ---------- | ------------- | --- | -------- | -------------------------- |
| • Category | Documentation |     | • Source | IProtocolFeeController.sol |
Description The number format of the returned value is unclear.
| Recommendation | Explain | in the documentation | comment. |     |
| -------------- | ------- | -------------------- | -------- | --- |
(cid:7) (cid:4)
function protocolFeeForPool(PoolKey memory poolKey) external view
10
| (cid:44)→ returns | (uint24); |     |     |     |
| ----------------- | --------- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-152    | Reported   |     |          |                   |
| ---------- | ---------- | --- | -------- | ----------------- |
| • Category | Procedural |     | • Source | IProtocolFees.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | ^0.8.19; |     |     |     |
| --------------- | -------- | --- | --- | --- |
2
(cid:6) (cid:5)
| CVF-153    | Reported   |     |          |                   |
| ---------- | ---------- | --- | -------- | ----------------- |
| • Category | Suboptimal |     | • Source | IProtocolFees.sol |
Recommendation This error could be made more useful by adding certain parameters
into it.
(cid:7) (cid:4)
| error InvalidProtocolFee(); |     |     |     |     |
| --------------------------- | --- | --- | --- | --- |
13 (cid:6) (cid:5)
| CVF-154        | Reported     |        |             |                   |
| -------------- | ------------ | ------ | ----------- | ----------------- |
| • Category     | Procedural   |        | • Source    | IProtocolFees.sol |
| Recommendation | The argument | should | be indexed. |                   |
(cid:7) (cid:4)
event ProtocolFeeControllerUpdated(address protocolFeeController);
18
(cid:6) (cid:5)
67

| CVF-155    | Reported   |     |          |                  |
| ---------- | ---------- | --- | -------- | ---------------- |
| • Category | Procedural |     | • Source | IPoolManager.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | ^0.8.24; |     |     |     |
| --------------- | -------- | --- | --- | --- |
2 (cid:6) (cid:5)
| CVF-156    | Reported   |     |          |                  |
| ---------- | ---------- | --- | -------- | ---------------- |
| • Category | Suboptimal |     | • Source | IPoolManager.sol |
Recommendation These errors could be made more useful by adding certain parameters
into them.
(cid:7) (cid:4)
| error CurrencyNotSettled(); |     |     |     |     |
| --------------------------- | --- | --- | --- | --- |
18 (cid:6) (cid:5)
(cid:7) (cid:4)
| error PoolNotInitialized(); |     |     |     |     |
| --------------------------- | --- | --- | --- | --- |
21 (cid:6) (cid:5)
(cid:7) (cid:4)
| error TickSpacingTooLarge(); |     |     |     |     |
| ---------------------------- | --- | --- | --- | --- |
30 (cid:6) (cid:5)
(cid:7) (cid:4)
| error TickSpacingTooSmall(); |     |     |     |     |
| ---------------------------- | --- | --- | --- | --- |
33
(cid:6) (cid:5)
(cid:7) (cid:4)
| error CurrenciesOutOfOrderOrEqual(); |     |     |     |     |
| ------------------------------------ | --- | --- | --- | --- |
36
(cid:6) (cid:5)
| CVF-157        | Reported   |                  |             |                  |
| -------------- | ---------- | ---------------- | ----------- | ---------------- |
| • Category     | Procedural |                  | • Source    | IPoolManager.sol |
| Recommendation | The “id”   | parameter should | be indexed. |                  |
(cid:7) (cid:4)
56 PoolId id, Currency indexed currency0, Currency indexed currency1,
| (cid:44)→ uint24 | fee, int24 | tickSpacing, | IHooks | hooks |
| ---------------- | ---------- | ------------ | ------ | ----- |
(cid:6) (cid:5)
68

| CVF-158        |     | Reported   |           |     |        |     |          |                  |     |
| -------------- | --- | ---------- | --------- | --- | ------ | --- | -------- | ---------------- | --- |
| • Category     |     | Procedural |           |     |        |     | • Source | IPoolManager.sol |     |
| Recommendation |     | This       | parameter |     | should | be  | indexed. |                  |     |
(cid:7) (cid:4)
| address | sender, |     |     |     |     |     |     |     |     |
| ------- | ------- | --- | --- | --- | --- | --- | --- | --- | --- |
80
(cid:6) (cid:5)
| CVF-159    |     | Reported   |     |     |     |     |          |                  |     |
| ---------- | --- | ---------- | --- | --- | --- | --- | -------- | ---------------- | --- |
| • Category |     | Procedural |     |     |     |     | • Source | IPoolManager.sol |     |
Recommendation These functions should be replaced by constants.
(cid:7) (cid:4)
| /// @notice |     | Returns | the | constant |     | representing |     | the | maximum |
| ----------- | --- | ------- | --- | -------- | --- | ------------ | --- | --- | ------- |
89
| (cid:44)→ | tickSpacing |                    | for | an initialized |          |     | pool | key     |          |
| --------- | ----------- | ------------------ | --- | -------------- | -------- | --- | ---- | ------- | -------- |
| function  |             | MAX_TICK_SPACING() |     |                | external |     | view | returns | (int24); |
90 (cid:6) (cid:5)
(cid:7) (cid:4)
| /// @notice |     | Returns | the | constant |     | representing |     | the | minimum |
| ----------- | --- | ------- | --- | -------- | --- | ------------ | --- | --- | ------- |
92
| (cid:44)→ | tickSpacing |                    | for | an initialized |          |     | pool | key     |          |
| --------- | ----------- | ------------------ | --- | -------------- | -------- | --- | ---- | ------- | -------- |
| function  |             | MIN_TICK_SPACING() |     |                | external |     | view | returns | (int24); |
(cid:6) (cid:5)
| CVF-160     |     | Reported      |        |        |          |       |             |                  |     |
| ----------- | --- | ------------- | ------ | ------ | -------- | ----- | ----------- | ---------------- | --- |
| • Category  |     | Bad           | naming |        |          |       | • Source    | IPoolManager.sol |     |
| Description |     | The semantics |        | of the | returned | value | is unclear. |                  |     |
Recommendation Give a descriptive name to the returned value and/or explain the se-
| mantics | in the | documentation |     | comment. |     |     |     |     |     |
| ------- | ------ | ------------- | --- | -------- | --- | --- | --- | --- | --- |
(cid:7) (cid:4)
| returns | (int24 |     | tick); |     |     |     |     |     |     |
| ------- | ------ | --- | ------ | --- | --- | --- | --- | --- | --- |
103 (cid:6) (cid:5)
69

| CVF-161        | Reported |               |               |         |          |                   |                  |     |
| -------------- | -------- | ------------- | ------------- | ------- | -------- | ----------------- | ---------------- | --- |
| • Category     |          | Documentation |               |         |          | • Source          | IPoolManager.sol |     |
| Description    | This     | phrase        | is confusing. |         |          |                   |                  |     |
| Recommendation |          | Explain       | a             | typical | use case | for the function. |                  |     |
(cid:7) (cid:4)
| /// @notice |     | All operations |     |     | go through | this | function |     |
| ----------- | --- | -------------- | --- | --- | ---------- | ---- | -------- | --- |
105 (cid:6) (cid:5)
| CVF-162        | Reported |               |        |     |              |          |                  |     |
| -------------- | -------- | ------------- | ------ | --- | ------------ | -------- | ---------------- | --- |
| • Category     |          | Documentation |        |     |              | • Source | IPoolManager.sol |     |
| Description    | The      | returned      | values |     | are actually | unnamed. |                  |     |
| Recommendation |          | Give          | names  | to  | the returned | values.  |                  |     |
(cid:7) (cid:4)
| /// @return |     | callerDelta |     | The | balance | delta | of the caller | of  |
| ----------- | --- | ----------- | --- | --- | ------- | ----- | ------------- | --- |
125
(cid:44)→ modifyLiquidity. This is the total of both principal and fee
| (cid:44)→ deltas. |     |     |     |     |     |     |     |     |
| ----------------- | --- | --- | --- | --- | --- | --- | --- | --- |
/// @return feeDelta The balance delta of the fees generated in the
(cid:44)→ liquidity range. Returned for informational purposes.
(cid:6) (cid:5)
| CVF-163        | Reported |               |        |     |              |          |                  |     |
| -------------- | -------- | ------------- | ------ | --- | ------------ | -------- | ---------------- | --- |
| • Category     |          | Documentation |        |     |              | • Source | IPoolManager.sol |     |
| Description    | The      | returned      | value  | is  | actually     | unnamed. |                  |     |
| Recommendation |          | Give          | a name | to  | the returned | value.   |                  |     |
(cid:7) (cid:4)
/// @return swapDelta The balance delta of the address swapping
141 (cid:6) (cid:5)
70

| CVF-164     | Reported      |                 |                   |                  |
| ----------- | ------------- | --------------- | ----------------- | ---------------- |
| • Category  | Bad naming    |                 | • Source          | IPoolManager.sol |
| Description | The semantics | of the returned | value is unclear. |                  |
Recommendation Give a descriptive name to the returned value and/or explain in the
| documentation | comment. |     |     |     |
| ------------- | -------- | --- | --- | --- |
(cid:7) (cid:4)
| 152 returns | (BalanceDelta); |     |     |     |
| ----------- | --------------- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-165    | Reported   |     |          |     |
| ---------- | ---------- | --- | -------- | --- |
| • Category | Procedural |     | • Source |     |
Description Specifying a compiler version range without upper bound is a bad practice,
as it is impossible to guarantee compatibility with future major releases.
| Recommendation | Specify | as “^0.6.0 | || ^0.7.0 || ^0.8.0”. |     |
| -------------- | ------- | ---------- | --------------------- | --- |
(cid:7) (cid:4)
| pragma | solidity >=0.6.0; |     |     |     |
| ------ | ----------------- | --- | --- | --- |
2 (cid:6) (cid:5)
| CVF-166    | Reported   |     |          |              |
| ---------- | ---------- | --- | -------- | ------------ |
| • Category | Procedural |     | • Source | Extsload.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity >=0.6.0; |     |     |     |
| ------ | ----------------- | --- | --- | --- |
2
(cid:6) (cid:5)
71

| CVF-167    | Reported   |          |             |
| ---------- | ---------- | -------- | ----------- |
| • Category | Procedural | • Source | ERC6909.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | >=0.8.0; |     |     |
| --------------- | -------- | --- | --- |
2 (cid:6) (cid:5)
| CVF-168    | Reported   |          |             |
| ---------- | ---------- | -------- | ----------- |
| • Category | Bad naming | • Source | ERC6909.sol |
Description The semantics of keys and values for these mappings is unclear.
Recommendation Give descriptive names to the keys and values and/or explain in docu-
mentation comments.
(cid:7) (cid:4)
mapping(address => mapping(address => bool)) public isOperator;
25
(cid:6) (cid:5)
(cid:7) (cid:4)
mapping(address => mapping(uint256 => uint256)) public balanceOf;
27
(cid:6) (cid:5)
(cid:7) (cid:4)
mapping(address => mapping(address => mapping(uint256 => uint256)))
29
| (cid:44)→ public | allowance; |     |     |
| ---------------- | ---------- | --- | --- |
(cid:6) (cid:5)
| CVF-169    | Reported   |          |              |
| ---------- | ---------- | -------- | ------------ |
| • Category | Procedural | • Source | Exttload.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | >=0.8.24; |     |     |
| --------------- | --------- | --- | --- |
2 (cid:6) (cid:5)
72

| CVF-170    | Reported   |          |                    |
| ---------- | ---------- | -------- | ------------------ |
| • Category | Procedural | • Source | NoDelegateCall.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | ^0.8.20; |     |     |
| --------------- | -------- | --- | --- |
2 (cid:6) (cid:5)
| CVF-171    | Reported   |          |                   |
| ---------- | ---------- | -------- | ----------------- |
| • Category | Procedural | • Source | ERC6909Claims.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | >=0.8.0; |     |     |
| --------------- | -------- | --- | --- |
2
(cid:6) (cid:5)
| CVF-172    | Reported   |          |                  |
| ---------- | ---------- | -------- | ---------------- |
| • Category | Procedural | • Source | ProtocolFees.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma solidity | ^0.8.19; |     |     |
| --------------- | -------- | --- | --- |
2 (cid:6) (cid:5)
| CVF-173    | Reported         |          |                  |
| ---------- | ---------------- | -------- | ---------------- |
| • Category | Unclear behavior | • Source | ProtocolFees.sol |
Description This event is emitted even if nothing actually changed.
(cid:7) (cid:4)
emit ProtocolFeeControllerUpdated(address(controller));
33
(cid:6) (cid:5)
73

| CVF-174        | Reported |            |       |              |             |        |                  |
| -------------- | -------- | ---------- | ----- | ------------ | ----------- | ------ | ---------------- |
| • Category     |          | Procedural |       |              | •           | Source | ProtocolFees.sol |
| Description    | The      | “data”     | value | is converted | to “uint24” |        | twice.           |
| Recommendation |          | Convert    | once  | and reuse.   |             |        |                  |
(cid:7) (cid:4)
(success, protocolFee) = (returnData == uint24(returnData)) &&
84
| (cid:44)→ uint24(returnData).isValidProtocolFee() |     |     |     |     |     |     |     |
| ------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
(cid:6) (cid:5)
| CVF-175    | Reported |            |     |     |     |        |                 |
| ---------- | -------- | ---------- | --- | --- | --- | ------ | --------------- |
| • Category |          | Procedural |     |     | •   | Source | PoolManager.sol |
Description This version requirement is inconsistent with other files in this code base.
Recommendation Use the same compiler version requirement across the code base.
(cid:7) (cid:4)
| pragma | solidity | ^0.8.24; |     |     |     |     |     |
| ------ | -------- | -------- | --- | --- | --- | --- | --- |
2
(cid:6) (cid:5)
| CVF-176    | Reported |            |     |     |     |        |                 |
| ---------- | -------- | ---------- | --- | --- | --- | ------ | --------------- |
| • Category |          | Procedural |     |     | •   | Source | PoolManager.sol |
Recommendation It is a good practice to put a comment into an empty block to explain
| why the block | is  | empty. |     |     |     |     |     |
| ------------- | --- | ------ | --- | --- | --- | --- | --- |
(cid:7) (cid:4)
| constructor(uint256 |     |     | controllerGasLimit) |     |     | ProtocolFees( |     |
| ------------------- | --- | --- | ------------------- | --- | --- | ------------- | --- |
98
| (cid:44)→ controllerGasLimit) |     |     |     | {}  |     |     |     |
| ----------------------------- | --- | --- | --- | --- | --- | --- | --- |
(cid:6) (cid:5)
74

dmitry@abdkconsulting.com abdk.consulting
twitter.com/ABDKconsulting linkedin.com/company/abdk-consulting