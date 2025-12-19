# SQL Case Study: Danny's Diner Analysis

## Project Overview
Analysis of customer behavior and restaurant operations for Danny’s Diner using MySQL. This project transforms raw transactional data into business insights regarding spending, loyalty, and menu performance.

## Analytical Process
The analysis followed a structured workflow to ensure data accuracy and logical consistency:
- **Data Integration**: Joined transactional datasets (`sales`) with reference tables (`menu`, `members`) using primary/foreign key relationships.
- **Logic Implementation**: Developed complex calculations using `CASE WHEN` to handle dynamic business rules, such as loyalty point multipliers.
- **Data Ranking**: Utilized Window Functions (`DENSE_RANK`) to identify first-time purchases and favorite items without losing data on ties.
- **Optimization**: Used Common Table Expressions (CTEs) to break down multi-step queries into readable, modular blocks.

## Applied Skills
- **Joins**: Inner Joins for data merging.
- **Aggregations**: `SUM`, `COUNT`, `DISTINCT` for revenue and visit metrics.
- **Window Functions**: `DENSE_RANK`, `PARTITION BY`.
- **Logic Control**: `CASE WHEN`, `BETWEEN`, `DATE_ADD`.

## Repository Content
- [schema.sql](schema.sql): Database definition and data insertion scripts.
- [analysis.sql](analysis.sql): SQL solutions for 10 core business questions.
- [README.md](README.md): Project documentation.

## Key Findings
- **Retention**: Customer A is the top spender and most frequent visitor.
- **Product**: Ramen is the most popular menu item based on order volume.
- **Membership**: Loyalty programs show a significant increase in points generated during the first week of enrollment.

- ---
## 📊 Case Study Questions & Results

### 1. What is the total amount each customer spent at the restaurant?
| customer_id | total_spent |
| :---: | :---: |
| A | 76 |
| B | 74 |
| C | 36 |

### 2. How many days has each customer visited the restaurant?
| customer_id | visit_count |
| :---: | :---: |
| A | 4 |
| B | 6 |
| C | 2 |

### 3. What was the first item from the menu purchased by each customer?
| customer_id | product_name |
| :---: | :---: |
| A | curry |
| A | sushi |
| B | curry |
| C | ramen |

### 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
| product_name | most_purchased |
| :---: | :---: |
| ramen | 8 |

### 5. Which item was the most popular for each customer?
| customer_id | product_name | order_count |
| :---: | :---: | :---: |
| A | ramen | 3 |
| B | curry | 2 |
| B | ramen | 2 |
| B | sushi | 2 |
| C | ramen | 3 |

### 6. Which item was purchased first by the customer after they became a member?
| customer_id | product_name |
| :---: | :---: |
| A | curry |
| B | sushi |

### 7. Which item was purchased just before the customer became a member?
| customer_id | product_name | order_date |
| :---: | :---: | :---: |
| A | sushi | 2021-01-01 |
| A | curry | 2021-01-01 |
| B | sushi | 2021-01-04 |

### 8. What is the total items and amount spent for each member before they became a member?
| customer_id | total_items | total_spent |
| :---: | :---: | :---: |
| A | 2 | 25 |
| B | 3 | 40 |

### 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
| customer_id | total_points |
| :---: | :---: |
| A | 860 |
| B | 940 |
| C | 360 |

### 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
| customer_id | total_points |
| :---: | :---: |
| A | 1370 |
| B | 820 |
