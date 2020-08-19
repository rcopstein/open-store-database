--
-- # Open Store Database Seed
-- Adds default products to the database
--

INSERT INTO public."PRICING" VALUES ('02de5eb8-5e60-43a4-8568-b82cebf8fffe', 20000, 'CAD');
INSERT INTO public."PRICING" VALUES ('92de2793-53bb-43c3-a787-728359e8a02e', 5000, 'CAD');
INSERT INTO public."PRICING" VALUES ('c05afa04-f322-46ac-9472-8be4a41fe10f', 15000, 'BRL');
INSERT INTO public."PRICING" VALUES ('8b6f3e19-13a5-441f-80af-46652fe7a606', 50000, 'BRL');
INSERT INTO public."PRICING" VALUES ('556193f6-9d31-4e29-9388-4f6b872110a5', 100, 'CAD');
INSERT INTO public."PRICING" VALUES ('5732c596-bd89-45ca-8244-6564a1e2c4cd', 300, 'BRL');

INSERT INTO public."PRODUCT" VALUES ('10b8b0ad-22e2-406e-896b-dbf22e17ad1c', 'Fantastic Circle', 'A statement. The purest art form ever seen.', 'SHOE');
INSERT INTO public."PRODUCT" VALUES ('da5e2eff-146e-409b-92ac-eb5a5e40a7db', 'Spherical Amusement', 'A classic. Nothing beats the roundness.', 'SHOE');
INSERT INTO public."PRODUCT" VALUES ('48b81eb2-119b-4961-b78b-2fe0ecc061a3', 'Rounded Marvel', 'The one that runs in circles. Combining beauty and convenience in one unmistakably unique product.', 'CASE');

INSERT INTO public."PRODUCT_CASE" VALUES ('48b81eb2-119b-4961-b78b-2fe0ecc061a3', 'Mr. Circle and the Circlettes');

INSERT INTO public."PRODUCT_SHOE" VALUES ('10b8b0ad-22e2-406e-896b-dbf22e17ad1c', 'Roundy Boi');
INSERT INTO public."PRODUCT_SHOE" VALUES ('da5e2eff-146e-409b-92ac-eb5a5e40a7db', 'Unknown');

INSERT INTO public."STOCK" VALUES ('91821148-473f-4f4e-bfe2-cc3d147fccd0', 9);
INSERT INTO public."STOCK" VALUES ('9692b006-9c10-41be-a982-73b8da28d4c7', 3);
INSERT INTO public."STOCK" VALUES ('56c50943-bcad-4e6f-9b9c-f0dee8a589f0', 7);
INSERT INTO public."STOCK" VALUES ('0e1ba29d-65a4-48d4-b01c-7accf4fe4439', 5);

INSERT INTO public."UNIT" VALUES ('10b8b0ad-22e2-406e-896b-dbf22e17ad1c', '91821148-473f-4f4e-bfe2-cc3d147fccd0', 'SHOE');
INSERT INTO public."UNIT" VALUES ('10b8b0ad-22e2-406e-896b-dbf22e17ad1c', '9692b006-9c10-41be-a982-73b8da28d4c7', 'SHOE');
INSERT INTO public."UNIT" VALUES ('48b81eb2-119b-4961-b78b-2fe0ecc061a3', '56c50943-bcad-4e6f-9b9c-f0dee8a589f0', 'CASE');
INSERT INTO public."UNIT" VALUES ('48b81eb2-119b-4961-b78b-2fe0ecc061a3', '6c4dfaf8-b8f6-40a9-b2a8-6c7f87d5e6cc', 'CASE');
INSERT INTO public."UNIT" VALUES ('da5e2eff-146e-409b-92ac-eb5a5e40a7db', '0e1ba29d-65a4-48d4-b01c-7accf4fe4439', 'SHOE');

INSERT INTO public."UNIT_CASE" VALUES ('56c50943-bcad-4e6f-9b9c-f0dee8a589f0', 'iPhone 11');
INSERT INTO public."UNIT_CASE" VALUES ('6c4dfaf8-b8f6-40a9-b2a8-6c7f87d5e6cc', 'iPhone 11 Pro');

INSERT INTO public."UNIT_PRICE" VALUES ('9692b006-9c10-41be-a982-73b8da28d4c7', '02de5eb8-5e60-43a4-8568-b82cebf8fffe');
INSERT INTO public."UNIT_PRICE" VALUES ('9692b006-9c10-41be-a982-73b8da28d4c7', '8b6f3e19-13a5-441f-80af-46652fe7a606');
INSERT INTO public."UNIT_PRICE" VALUES ('56c50943-bcad-4e6f-9b9c-f0dee8a589f0', '556193f6-9d31-4e29-9388-4f6b872110a5');
INSERT INTO public."UNIT_PRICE" VALUES ('56c50943-bcad-4e6f-9b9c-f0dee8a589f0', '5732c596-bd89-45ca-8244-6564a1e2c4cd');
INSERT INTO public."UNIT_PRICE" VALUES ('0e1ba29d-65a4-48d4-b01c-7accf4fe4439', '92de2793-53bb-43c3-a787-728359e8a02e');
INSERT INTO public."UNIT_PRICE" VALUES ('0e1ba29d-65a4-48d4-b01c-7accf4fe4439', 'c05afa04-f322-46ac-9472-8be4a41fe10f');

INSERT INTO public."UNIT_SHOE" VALUES ('9692b006-9c10-41be-a982-73b8da28d4c7', 9);
INSERT INTO public."UNIT_SHOE" VALUES ('91821148-473f-4f4e-bfe2-cc3d147fccd0', 10);
INSERT INTO public."UNIT_SHOE" VALUES ('0e1ba29d-65a4-48d4-b01c-7accf4fe4439', 11);
