from faker import Faker
import pandas as pd
import random
from datetime import datetime, timedelta
from pathlib import Path

fake = Faker("ru_RU")
random.seed(42)

BASE_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = BASE_DIR / "data"
DATA_DIR.mkdir(exist_ok=True)

USERS_COUNT = 1000
CATEGORIES = [
    "Смартфоны",
    "Ноутбуки",
    "Планшеты",
    "Телевизоры",
    "Наушники",
    "Умные часы",
    "Игровые приставки",
    "Мониторы",
    "Клавиатуры",
    "Мыши"
]

BRANDS = [
    "Apple",
    "Samsung",
    "Xiaomi",
    "Huawei",
    "Lenovo",
    "Asus",
    "MSI",
    "Sony",
    "LG",
    "Acer"
]

DEVICES = [
    "Desktop",
    "Mobile",
    "Tablet"
]

TRAFFIC = [
    "Google",
    "Direct",
    "Telegram",
    "YouTube",
    "VK",
    "Email"
]

users = []

for i in range(1, USERS_COUNT + 1):
    users.append({
        "id": i,
        "first_name": fake.first_name(),
        "last_name": fake.last_name(),
        "email": fake.unique.email(),
        "gender": random.choice(["М", "Ж"]),
        "birth_date": fake.date_between(
            start_date="-60y",
            end_date="-18y"
        ),
        "city": fake.city(),
        "registration_date": fake.date_between(
            start_date="-2y",
            end_date="today"
        )
    })

users_df = pd.DataFrame(users)
users_df.to_csv(DATA_DIR / "users.csv", index=False)

categories = []

for i, category in enumerate(CATEGORIES, start=1):
    categories.append({
        "id": i,
        "name": category
    })

pd.DataFrame(categories).to_csv(
    DATA_DIR / "categories.csv",
    index=False
)

products = []

for i in range(1, 501):

    category = random.randint(1, len(CATEGORIES))

    products.append({
        "id": i,
        "name": f"Товар {i}",
        "category_id": category,
        "brand": random.choice(BRANDS),
        "price": random.randint(3000, 250000)
    })

pd.DataFrame(products).to_csv(
    DATA_DIR / "products.csv",
    index=False
)

orders = []

for i in range(1, 8001):

    orders.append({
        "id": i,
        "user_id": random.randint(1, USERS_COUNT),
        "order_date": fake.date_time_between(
            start_date="-2y",
            end_date="now"
        ),
        "status": random.choice([
            "paid",
            "delivered",
            "cancelled"
        ]),
        "payment_method": random.choice([
            "card",
            "sbp",
            "credit"
        ]),
        "total_amount": random.randint(
            3000,
            200000
        )
    })

pd.DataFrame(orders).to_csv(
    DATA_DIR / "orders.csv",
    index=False
)

items = []

item_id = 1

for order in orders:

    for _ in range(random.randint(1, 5)):

        product = random.randint(1, 500)

        items.append({
            "id": item_id,
            "order_id": order["id"],
            "product_id": product,
            "quantity": random.randint(1, 3),
            "unit_price": random.randint(
                3000,
                250000
            )
        })

        item_id += 1

pd.DataFrame(items).to_csv(
    DATA_DIR / "order_items.csv",
    index=False
)

sessions = []

for i in range(1, 30001):

    sessions.append({
        "id": i,
        "user_id": random.randint(1, USERS_COUNT),
        "session_date": fake.date_time_between(
            start_date="-2y",
            end_date="now"
        ),
        "device": random.choice(DEVICES),
        "traffic_source": random.choice(TRAFFIC),
        "duration": random.randint(
            20,
            2400
        )
    })

pd.DataFrame(sessions).to_csv(
    DATA_DIR / "sessions.csv",
    index=False
)

print("Данные успешно сгенерированы!")

