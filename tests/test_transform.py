import pandas as pd

from sales_data_pipeline.transform import transform_sales_data


def test_total_amount():
    df = pd.DataFrame({
        "order_id": [1],
        "customer": ["Alice"],
        "product": ["Laptop"],
        "quantity": [2],
        "price": [100.00],
        "order_date": ["2026-09-01"],
    })

    result = transform_sales_data(df)

    assert result["total_amount"].iloc[0] == 200.00


def test_order_date_is_datetime():
    df = pd.DataFrame({
        "order_id": [1],
        "customer": ["Alice"],
        "product": ["Laptop"],
        "quantity": [1],
        "price": [100.00],
        "order_date": ["2026-09-01"],
    })

    result = transform_sales_data(df)

    assert pd.api.types.is_datetime64_any_dtype(result["order_date"])