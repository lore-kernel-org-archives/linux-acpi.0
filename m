Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF992ED846;
	Mon, 18 May 2026 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.23
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094434; cv=fail; b=HlVMBLE13H07aNZPrhLviW2DZcUykDC+x6FaZ529Sknt6nldki+14uihc8x66qC+4GtueQaXiEr6T/gwaCEzLU9Ms8l0QIYgCOxGNlMg2Bq5d0t3nZZ5IhoxcmmukhEQzlivYK/uPFX9RHMvqD6ALv1cpuzQBK7aBR+gsU5RPoU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094434; c=relaxed/simple;
	bh=phdTKgHOnkNkJXQVgtEGMt1Y+QCPmQCjatUvy57kNOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpl+Bp2Ksll2eJTNHIyW0OvoBPby484sltDVHAPZD6+mZZYUeHOr1VpzKFh0n48gw7LeNj/yKoLmPWvOl9hgil8PFojWzEkZAYjTnfCy42p9AWIZ9mE1Qs/BgD5iB5P+Zs0AYkMmteMWd+9/1Im0zBgEHGg+xkI3qnefgfp3I8k=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aJBOR2UO; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aJBOR2UO; arc=fail smtp.client-ip=52.101.84.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aJBOR2UO";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aJBOR2UO"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ft2XGcZxVVtKl718C7EHKMQZrkO61UGUB5pvVcO5tKQayH5n7iiWOn6lUhtnEdTbnkrfohzZKEYcRv52B3+RbpgK/7PeNAzWmo3ov1IKa+35h/6HgH5JbbiPnO4Qf7XdoEbsDk6U5uwx9NJ0D4CbV+cC6B8tjs6f2UiuoQKukBFk35GlXgWAHIrp+iqWtsRUWZJtaxJgxHcpFVtKc4MtzySxhSv1hXV+p7gEICttlezMwTN/UYXujf5MO5IxMr5bwfll7PT2/QMldleX2CTKax2BfbM6K1jZaCZ53ayaCBfKjc+4rBiObkM8JLoo0ULGTM4yFqgOG5UvajJWeqsoMA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHcfHl/wIureKjj0xsfWQODZO3Jyb9Roym9vA6p1kY4=;
 b=fwPRhFFnpjIA9OoILSodVw281Vtfowlnr8+YdxfNrKT+hSVQRL4hJyydZOXB8ieO83Mi+VWbSjDMnjZiBz15TOAVGlmnZQ2eJ5TPAsEY35mi0EfVwzLTP5bR7rD9HINKD0s0dj+bieuOScGw5yOFTXoFouM0S6Dka8b7qtD4bPQVFH5K51JuoYr5U4hNLNRNHSt4Wz+1NYhtIS7wcSBxc/wE3yfisSUDxFujp/8P8rLSqrXw9ULBCWnQCNVGLqi0h0iWECJI28/i6Lzf1KINzwN8ARjQS3oLohyNJZJmcTpyi9KYgrTUqO2JhmLeE3J+kpJ5COZDonhUpEnFuH6BCQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHcfHl/wIureKjj0xsfWQODZO3Jyb9Roym9vA6p1kY4=;
 b=aJBOR2UOKVjgS66pLKaSO9X5X0b17M9019lW247BOj+9S2SKpeUp1o8vI0miSLVAZQqqDhPyX49HImz2kdlwi6eqA7aKC/zoRCn55UI20QgYfMuJbT9/gtIm78n9xGRkw+TieSowmGDRbtixRhpYGs9mK6zNfqL1T8r3zFxdrYE=
Received: from DUZP191CA0059.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::13)
 by VI0PR08MB10654.eurprd08.prod.outlook.com (2603:10a6:800:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 08:53:45 +0000
Received: from DU2PEPF0001E9C2.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::b4) by DUZP191CA0059.outlook.office365.com
 (2603:10a6:10:4fa::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 08:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C2.mail.protection.outlook.com (10.167.8.71) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11 via
 Frontend Transport; Mon, 18 May 2026 08:53:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSSVZ6F5aZYzsx0m7Lezg2eP7oTxeuUieGfZ/mHqxHflAfYzDIWKaUe3ubOisc9cov/ld7lbvPLcAdJi8OaTQxL7r+777A/o5mqFdnYFLhTd8EkhKPgMEaFeINS1JMXhcnkZl9i7bjOP+NwWbLiuZgV/ekCtfhsB4gG/y9/OSACLZftm3/rZfMlLkqIOa+3QKrIAIu0hTWYwBz4bGLWkMJrPTw5BxpkVC4oDq/6MvFrMenoDcYlTjVuLbbPA1S2HUEhmRGomuJStsanDTkAm/dhu4Xdj7o/FUf+HcFXiHkRjc3jZpYdLpI5JtBYo1VK+IRk80OLWjux7PZIg3Fctzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHcfHl/wIureKjj0xsfWQODZO3Jyb9Roym9vA6p1kY4=;
 b=eKA3uD/0wAX3XN2tMTnrb0WoXaR1Lal6YevQ6vFsuXKPky0lGVOKEomdxxbI5QoGeQyKwTCGwuh6OPfy90GFbOVj/qOFs92W8WVEcvpxO22SsS2QtQT9SGV3EZlIdwqXPGXA5A6TGvPSwIZr8gQNO37TrTGZdGiMJ2pcR9M5vX46IwkcGEXTMbN1bU5/z2b6FxiIDfATzVHeh6mY26K1AM7pDsaeEqdlEFQeTLU4M1xrrOiLUJwdpm4wjI5wACNVb2B4Yy83phLXplSSa6kSL4LlvJjjKC5mRET3ZiIp+eUDunmRLQVwsClwJ+/s25jC1hWVJZtMdhu3pHJgkZ0eiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHcfHl/wIureKjj0xsfWQODZO3Jyb9Roym9vA6p1kY4=;
 b=aJBOR2UOKVjgS66pLKaSO9X5X0b17M9019lW247BOj+9S2SKpeUp1o8vI0miSLVAZQqqDhPyX49HImz2kdlwi6eqA7aKC/zoRCn55UI20QgYfMuJbT9/gtIm78n9xGRkw+TieSowmGDRbtixRhpYGs9mK6zNfqL1T8r3zFxdrYE=
Received: from AS4P189CA0011.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::12)
 by DU4PR08MB11149.eurprd08.prod.outlook.com (2603:10a6:10:576::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 08:52:39 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::8a) by AS4P189CA0011.outlook.office365.com
 (2603:10a6:20b:5d7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 08:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 08:52:39 +0000
Received: from AZ-NEU-EXJ02.Arm.com (10.240.25.139) by AZ-NEU-EX04.Arm.com
 (10.240.25.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 18 May
 2026 08:52:38 +0000
Received: from AZ-NEU-EX04.Arm.com (10.240.25.138) by AZ-NEU-EXJ02.Arm.com
 (10.240.25.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 18 May
 2026 08:52:37 +0000
Received: from e132472.cambridge.arm.com (10.2.78.53) by mail.arm.com
 (10.240.25.138) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Mon, 18 May 2026 08:52:37 +0000
From: Niyas Sait <niyas.sait@arm.com>
To: <andre.przywara@arm.com>
CC: <ben.horgan@arm.com>, <catalin.marinas@arm.com>, <fenghuay@nvidia.com>,
	<guohanjun@huawei.com>, <james.morse@arm.com>, <jic23@kernel.org>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <rafael@kernel.org>, <reinette.chatre@intel.com>,
	<sudeep.holla@kernel.org>, <will@kernel.org>
Subject: Re: [PATCH 3/5] arm_mpam: add MPAM-Fb MSC firmware access support
Date: Mon, 18 May 2026 09:52:37 +0100
Message-ID: <20260518085237.3259344-1-niyas.sait@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429141339.3171205-4-andre.przywara@arm.com>
References: <20260429141339.3171205-4-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AM1PEPF000252DA:EE_|DU4PR08MB11149:EE_|DU2PEPF0001E9C2:EE_|VI0PR08MB10654:EE_
X-MS-Office365-Filtering-Correlation-Id: f76ebb66-7f75-4b24-3c55-08deb4baf801
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 BS4aDGvAnVM7Mx27FU3zSC6LWd5/cjis0RsmT83EonuQcTifwzrpqjthsQFQSZcL8sAL7Cd8QxjYdEGAMTis1DHLqLQTkeSOi6VTNS0zD5d5RznO+xzUatAKRb3nQtT9jvFbRUt3pI/aaT7eJK8tI2v2oIcHoG6Mxg8ur+CJjpq1YEFjb8AXr81WeztosaNz3kOxKCS9ejEBuzAcWdlLZAHKzbTBvl9xfi1Bjs7UOuVUzYhMJPkK5QSdbP1rfyllAD4gwjk2YVAkeCluafIvYPJHbRbLWFKDzezrEM45piOcC+xggY6j/qNttHELBj4ggnsqfI6kaW2PeSqInsAeFVK4L4vJDIRVCN2KgQVkbe19TuXAElkzsRd1iowa/SGEaAHvYtJosbwDDQOxRkVCUeswGNS5AaWO8qsoKyPWecyZWH/AhoIn5hJgXn4qzc44kX0dJTyvDU5JeQ0kjAqpM7guKxq1SEsdyr08Fl0f1PWOgx3UoyY7M0KJS+rsPB5y9YFrCM+nub/Altr1qbZyO59bF3ASua/ZSBwxnnvAGha6ZuJh27dklwOjAm4cN8q1hTL+yMXpfZyOyggqaIGioW33kOtubk7JSw2jTlE8EUpD0HY3Lh44H34KXf00ojbcaRfQuQSZEirS7i5kVnMXdziEdOL4v7tGjdW8LrMlbQSmF5FewB+C8FUz3IfEIwhq2ob7KCIDE0+qejN+7Wxu06mqrMhtX/kdHbNZe/kbHX0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Osm4bGXlcXtDU5LADBaAX2pXI9Htb2T+2YPYu/Nsseno92BjIrMoT9+6Atz+BagKRcH1RZLq20HTSzPO1T6TS+X6WeGaY5BKjo4sbw8gI+J5qnaNnwuZWKe7lNcHgnCu8DJ0YfcBOYFbxV7iROWmFotlrV3Dum/o1AXzz28zrR19mVznJnHSigTixRT6a7OLtdZa9bvNai+05EMyhJttTFDGAY+M/78C7J/Adp9WylxWzaB8JfdV9lxZNdEu9ryuEvuJZz4g777yKOpAUOVlFeQyq7q+akrPT0ZX+kLjVOlekXn0JKhh4lu7X8agfWDVP/Mq2ewnX0Tq9N2WyO1r4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11149
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b87c3933-a02c-4a2d-b42d-08deb4bad116
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|35042699022|82310400026|36860700016|376014|7416014|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	YB2UbuQoQuhCUg9p6I9Omti+wXr4vOCCVHUQk4DeB6aRAmdG4bmR8kmolkiJJAEtjnHbqZ6jKIHS5vGyKq2+v4VMWNU+YsL+9i4B1TBAo7QoHg8a6I40Szc3kCTcfBbQ6kPDUxbeMhqJE0peRVO5kt7i76mQs2OarU+pkuco9OHZxwMMPBMznIs1F3uo0yHwFZCq7zffspTHqwpGqI6XvHkH/R9YHJvg1arKXaolXgMGKuMm266O2Vrh8V2hd3j8icDCn3PUkO2k+7pYWs8ALvqChvhqGbgqgjxUbkJ6rFWK6zd7jjI5+zpMd/+4ol0d8Lu6oiEnDtOyIgNfFQFpxp3xn27kv5lMwDxyf1bCXFCe62ots/1N4w6CV6DB1VXnFPx59znK4Imob6WHw/uhop19oVCT5dcKFjLdUthrkLmDzr/mnIdIreZ9y77pSl0d+vWBCLpgXWdi1ZQgtjmS7A1FEtFnEieeWPuaRTCLWspE7cQ/UQxrT2nyAu1jhXU5znEyqBy1/BIdbcIOl939hXwacEZY8nIbQWDVI/g/8fuM4yLLkmxeDL4LUnRH607dqHDyF87720gxINdQok+8k0M7aB0hYO7eypZrXyvJsm70fAaW9Nyp7+8DvTW/l4olqCFOOqPEvRENQj2nnb6x81A0oeDoKRWgWTvICAfERsLyx4VmMQSUC2SlGM/bPipQ+qvF0U28BkTb4oZtA5VCoLaLiEcWY49mFckObyqQPtY=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(35042699022)(82310400026)(36860700016)(376014)(7416014)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QsQGvmWU9g0NdYZA2Rr+Z5Fn7CkN/+xLYHOZrRih5ev6Gs1/DAc6+inSC8j3ntfnd2gyViKbdt0x3g/M+k/oCl8zmFyRuiHP3x00yCJVnetXLqJOajQRJQwUpwPQV/tjwyXSL6oobjaJvllRosYZSMZBA5UJOadT9AqVCX74xJVxnyk+xu6INkdFBSMt4Z2qg0kXok+5Qg4XZq/OsYH81hCtcI5zDqsuovTfL8Mo2Buk96LDxs7TmTDmT2pmdyVS4MUO9io+wK0ImAZhwMjSJUuZ20qmuVtyNIytFvnsRvgmvXZIC+zwnam5MGl0HEJCpsa7iY82waSNNpSUB0ecHRFmUPWfhlNK/vSgmx0nXkhd2E1t0JEijAElK2XHD7T+XMPAlIEARPvFO+aAQK9copBp/Q1gxBwqqnwsMtJY0vvghjFejnlgX/TJ6dMqGy6+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:53:44.9917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f76ebb66-7f75-4b24-3c55-08deb4baf801
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10654

Hi Andre,

On Wed, Apr 29, 2026 at 04:13:37PM +0200, Andre Przywara wrote:

> +#define SCMI_CHAN_FLAGS_OFS	0x10
> +#define SCMI_CHAN_FLAGS_IRQ		BIT(0)
> +#define SCMI_MSG_LENGTH_OFS	0x14
> +#define SCMI_MSG_HEADER_OFS	0x18
> +#define SCMI_MSG_PAYLOAD_OFS	0x1c

I think this will not work for the ACPI PCC Type 3 MPAM Fb path.

SCMI shared memory transport layout and ACPI Extended PCC subspace
shared memory layout use different offsets for the flags, length, command,
and payload fields.

For Extended PCC subspace, the layout is:

Flags   @ 0x04
Length  @ 0x08
Command @ 0x0c
Payload @ 0x10

SCMI shared memory layout uses:

Flags   @ 0x10
Length  @ 0x14
Command @ 0x18
Payload @ 0x1c

You will need to use the extended PCC subspace layout for the ACPI path.

> +static int mpam_fb_wait_for_channel(struct pcc_mbox_chan *chan,
> +				    bool free)
> +{
> +	u32 status = free ? SCMI_CHAN_STATUS_FREE_BIT : 0;
> +	u32 val;
> +
> +	/*
> +	 * The channel should really be free always at this point, as we take
> +	 * a lock for every read or write request. Check the free bit anyway,
> +	 * for good measure and to catch corner cases.
> +	 */
> +	return readl_poll_timeout(chan->shmem + SCMI_CHAN_STATUS_OFS, val,
> +				  (val & SCMI_CHAN_STATUS_FREE_BIT) == status,
> +				  1, 10000);
> +}

This also assumes SCMI channel status completion semantics in shared memory.
For PCC Type 3 transport, completion should follow PCC Type 3 completion mechanisms.

Thanks,
Niyas
