Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010040.outbound.protection.outlook.com [52.101.69.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725249B5CC;
	Wed,  7 Oct 2026 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.40
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380165; cv=fail; b=Ma+UM6TARRQem+Dk+3MmX00H1JbhqGVQXhv5ZO60DZg+LUn1PYulMgkYeDrObm5piqIo2l5uHHsqkjmiZqbWK71DZi3n/N281DoKuO/e6KdbStnKcu/u4nvRzJ/01rWkvxaCPfcWsPBL4aE+yjLCPJUAiBGSILwbLicdLLeIUzs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380165; c=relaxed/simple;
	bh=8iNzqiURZc5XOaYbIrOkUArnGkqAEQBoBeT1HPOrRVM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MXzHx7HqmpcBGS3Id0TM8gFEZQ6GQdpco6jQcYIO4aq5oX0FV8bf93GbgetFotDUbFjYYvEytFypOZqUC0C0y8rcqR7LSTVJngYowu7qeRvyxXv/77dIgk3thD7WhN54Ikx1Ge1XtFrUtRW9dnRcAwjUp/tyF3HCPK1tqw4pVa0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Kmmo2Iwn; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Kmmo2Iwn; arc=fail smtp.client-ip=52.101.69.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Kmmo2Iwn";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Kmmo2Iwn"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=wkKxFRtTknSQ3eolpuD6C1Ec9d/1jN8QTwb7Q/7M4b6xeHF39RZ0e+St41z80sF/z4fFyfjIV/iJX/Fb3IzVeZOp3yP+lG8XChMoKU6QGCz4OY60azRNnJRdJ0s4A3KZFB6zuIzgG/uRQ85LBD71CCInItZgDyR7oHx8VtY60YdFtcLVrLrcHzoPyydVqrMQ45GAs3eTL7qX6f3oUXL6JeDyf0SWdptPIe1k5HmBDIZaKSd62gOGjZRbukuBpdealuLi9KZn6RnbuCTmsKFnaTTNmmeG/cHsoQ1kG5+HR0mIPL69VbNCKdiZxvDnSnbxwbm9G/IW/OQJ5ktQvND2VA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uh34us1QU8r4fMDzpILjSso6N7IdWvwgWwkwWE/iY/8=;
 b=G54RiQ16+kKYAdZj3zVVr0dGh1spX1GCZwvEYE2gwYXEN6dxHLASFYShK5RrL1wJdK9ma2NLNUqF/BUmLBuPuWaBGsbzEeywj2hxWGj2WKrpQ3eZ486OCbRfrW3hoQi4qjs+HTo7KJwJ4kbHyhwNXrlEzTdKLnK156GWZTZ4tZ4rmrbWRp8mcEIKt+KHncauM5RHfXpg5TUz0KJkRAZjM2/0BLJLeTI/UiYVUbsrYWRwjhzj1xpleB9J8861kYqSvoXNqlQt9v+kULoRItXwnPzuOiMjk8t1rCRu2WSbYLeOCcoCCOjtG7XGpYEu7tyID/4ZkN4W07bw0bAtVopGEA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uh34us1QU8r4fMDzpILjSso6N7IdWvwgWwkwWE/iY/8=;
 b=Kmmo2IwnMLdZzhWmyZD4WuWz1RIQgJj77CB8n6UlbDMjWi8a57X2JW74HdZSvVxRD0biO8w5tby353RLqT2S/Ta974nb81x6GSK7NazfU0/Vln1hYStKsX15pSjzjfWiSFzkW607V/nYWGwAEbeZKCATdA/9GOj4E0OT8oI0RCY=
Received: from PR3P193CA0035.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:51::10)
 by MI9PR08MB025303.eurprd08.prod.outlook.com (2603:10a6:290:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:35:49 +0000
Received: from ZR1PEPF0000E45F.eurprd04.prod.outlook.com
 (2603:10a6:102:51:cafe::7b) by PR3P193CA0035.outlook.office365.com
 (2603:10a6:102:51::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:35:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E45F.mail.protection.outlook.com (10.167.241.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.14
 via Frontend Transport; Wed, 7 Oct 2026 13:35:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/ZCOUmsl7Ef3BA91RhSZ5/HbHxiYIzmvHK2kmfKkdW5tilmb4j6KTLYR7yVy9kb8HU0UKGCoGACqmj7u9ic/cbjNRSKaTDuJKQinYiReSIWcNXjhzNqoA42kR5QeduIV0wHVo4fw54CCUB5qwyKyNZ7KLxuSKG8k5IMpwghLmw5b3RBWWN6G52NTgdX9oJFHAHY1eN+TLo7KPlzX5c5uCsUXlhcixuTPocx7fm97Lwx2ho2nlB7lD3FKMI4mcmNi43cyh1q8ER5kB+hjwqQGTVBGSjMBSW+B2JRIr55nHjHC38gJoCULHxW/BEBx9EPoL972awIwAxG7H1zl4olgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uh34us1QU8r4fMDzpILjSso6N7IdWvwgWwkwWE/iY/8=;
 b=nAL93+MbMqBINrVjTCjKAGI36d5QjFpwyungp4iAmD6Mg/U4CQVqbbFT0P6b0Tr2jVs/P4cIVyTsUil/nf5lPTWkiOBW8KJ1ZZHcmdLw1NIyQg6weao0FzA8iDY0v9cmkgcxWoY7oQy7JHbmaxKItiL80wUIbZPgdmN18DRnwwY+hKYUMenNUn/JKgen3oN9bY8i83+gKzUh0DdYyqWn0tuIx7hUjz5DNfA+60/XdByzFSjTxfFXKlg5Pp9WglGcBlbYvN+hB0DFQwQazJIEa3AwK0tyloyKrmdHhQK2PFm4ZQNPHolzPBrMm+03XejFv912HllqtY0qUWQN8YvAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uh34us1QU8r4fMDzpILjSso6N7IdWvwgWwkwWE/iY/8=;
 b=Kmmo2IwnMLdZzhWmyZD4WuWz1RIQgJj77CB8n6UlbDMjWi8a57X2JW74HdZSvVxRD0biO8w5tby353RLqT2S/Ta974nb81x6GSK7NazfU0/Vln1hYStKsX15pSjzjfWiSFzkW607V/nYWGwAEbeZKCATdA/9GOj4E0OT8oI0RCY=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PAVPR08MB9089.eurprd08.prod.outlook.com (2603:10a6:102:322::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Wed, 7 Oct
 2026 13:35:11 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.21.0522.002; Wed, 7 Oct 2026
 13:35:11 +0000
Message-ID: <94bf3539-6a94-4efb-a57e-c0e1ecf243fd@arm.com>
Date: Wed, 7 Oct 2026 15:35:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] CPER: Add Memory Error Section 2 support
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
 Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Radu Rendec <radu@rendec.net>,
 Avadhut Naik <avadhut.naik@amd.com>, Kees Cook <kees@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
 Dan Williams <djbw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
References: <20260929074659.2587216-1-pierre.gondois@arm.com>
 <20260929093516.00003781@oss.qualcomm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20260929093516.00003781@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0219.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::13) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PAVPR08MB9089:EE_|ZR1PEPF0000E45F:EE_|MI9PR08MB025303:EE_
X-MS-Office365-Filtering-Correlation-Id: 5567bc22-b8a7-4be2-562b-08df2477e653
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|18002099003|22082099003|56012099006|3023799007|6133799003|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info-Original:
 IYgBhtNmF4MgeTKJPshmsPG3/6irA5KWB4eHVab48A0Ey6USEgT1oXykSKz47aLc2WlioNnJwbH8ebwdUvPjZoKYa6YidT1rNkDywhUnHHfBhuvIZXpIWqsXgeyVXQWhV3/wMDHdS4CJlePCTDxfl8gm3vkhyCI3JpM14RQ9i0sS8cA6ee/8tdxEAFzfw4njAC7w/ZTe8JeeMteczNOaXFuuJGr95whO4eAOJosH6lk2RqeUXWis8ldNREC6GhOlICYABfjI3Vkqe2CRQ+ZHK8ajwcG8p9utwrmdmirHrAvR8R4xYSVeSFkl6GyvfAvQZfNy3JGC2AkQIkMM9s/JJ5LlPICZId6GOFbNZR/uwMXGTEFzDmNZUOvP1MI6U84mIEGfJAIA6n/cpjwE8OzRvkTviHe7BEryMMdIHNNr2doC3ipll/QuVy6YLPrd8HVZcY/8XK3i5+U00bjTukpRGG6rrHdymud9pX5mn1DAUUax1s+sX9x1MUbDHeUBzYWRs8VyKO+CX2XAhwxjNrXVhVQUmYa6cyLh2nFlZbRpBWz91K7PenidEOYuzUzOEsWYH5LoQcytJSqR+gd/uWceBzuqr03HfERGV8MQsrLVj6q/iMmF3c8EVA9knHL4M3DjkXoJ8oYiWQs8J+7hey76yKeLrKRSpU2CPUKs4ygTvcs=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 uLRR4pHDzYC96GZPxAkeCN93ZJ924mqlSfHJpJx69SbXbMLqDfjzHOF7/wnxutbiKWRhNr6+q/01gUE/rGdZmPmbRgOQ6Tu1nSKHVYZC9fRfiv5EokqABL/GCHYiR+izktlOh2M2zPnFM/MPffZrNGSCfUE5WkEe+MHaRPbNQ8zRwzMODkrIb0X9y0TqkSYw+EWtaAzPOCVvJS04aHJf3Lu8Y7lMjGfrKTpMV4JmPepIsF0piAI/UMF9LMtI1+zznRdjgKr7NX5zWN2fhN9bSGBqY3Vw9on9UsHiKryxeqy0WQD0HYBeO1Yxqj14Qsy2HRoct5Fcjz8iwBF3rJnYCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9089
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 ZR1PEPF0000E45F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	01692dcd-3002-4df6-b457-08df2477cf62
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|7416014|376014|36860700016|82310400026|1800799024|23010399003|14060799003|18002099003|22082099003|4143699003|6133799003|3023799007|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	jnZNaD2sCh6WjRxSY2dqmGuU97DSNKyfZT2yIGHOvVQDRujTF0wbQZAY9ceb3aUB5x853zYaNdRtQ/TGMF81VN6X4rzu7g67rn3SRB4jDNKwHNO+fpyfGOel6H83sCyJxIomSXBjXupLR1103+5EPR2guxQvBpBuD0E43qVBkhJR1N22NqNaSXBQVIGYevtbqJX9bKE8/eq1cCd8vk8zvq6Ccw77mhu0IxJAfW9+pWkTVdKLjVnHzzVwcyd2gmU2NXY8qfaLN/6LN/bg0eOV2MfCfL1qJXj30sNGK9QdP0CBS05xeMD6Yoc9FvMgfZEmXIH2BEZQQvrHZBV8m/Lr8yIYcuEdV0JJjkqxAlXlxH+e9uH1kWBQsE03beI1bDEizjRbvPSUuq4MCcTF5URLeVrVnm38J+oeRuR1qLVCQkeqxXJLdO1r7gZ04hZPzDYuW4Yags6lYKl8BGpvsEP9JkI4x7Rn6TxfqPQo2buWYWhlPT0ua/eoW/cOji8YPe2p/fkufHyr0NFqg9s5hUxCk+tYwC9o2bRvxlelQ5Chi5TyRwipaZhhDPaOcEAhCGrAZ+Hd1jMt4lA4CTap50HziQ2loHXhfVYuqA48NXYsL67ReYzx0UBLXoncDnkPicGxhX/SMjmxkC/ISpOe+HAD/fPCUhVhrH5Ox4x8YQuHBJMt+2N8czDHptr5szIgvHtZiD8HtS/yefi1LMDpoRCb4A==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(7416014)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(14060799003)(18002099003)(22082099003)(4143699003)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gtp2a+BGMoOvZm9MApMTCSaUGHEEXA7/3St/dUggfk536G74EI3wi0R9OfcvG1CvaoqwtPc8iAQKOjTi3+aiTMjnAsd2hiVwZxEpvS2fWWhTgeiiY8sTjgL2NS2Z4upGENNbqPu9Dk1lenJ147zM4j8lWccV92EWeRaFVt14y8Nfot5Prkd1kBNOBrGiiOM2mvgt8dSSZpAGZa9s0rRPULldSd6TwCfCvG5vs//dDAKrMF8BqLn+u/6uJPDAiygtP9aMR+OHvr2waQT8gQR+xLF69Q111/Wq1chgjcB7ax6Qmb6f5gCemzXaf1DGEjFXJSbnaBVgIjSvwFx8k9rZPdnknIM/fdpN4OZWpfVwwE2vBlhE02DDz+QsiyAM9AXduw0BCu298IAUCk4ffPY/np0b1JlKlu3Mtm516HYi1KRvLGC2HFYkXPCz/LTDVO9w
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:35:49.2278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5567bc22-b8a7-4be2-562b-08df2477e653
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E45F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB025303


On 9/29/26 18:35, Jonathan Cameron wrote:
> On Tue, 29 Sep 2026 09:45:59 +0200
> Pierre Gondois <pierre.gondois@arm.com> wrote:
>
>> Add support for Memory Error Section 2 records.
>>
>> Extend cper_mem_err_compact to hold both legacy and section-2 records.
>> Add a common parser and convert the CPER, GHES, EDAC, extlog and x86 APEI
>> paths to use it.
>>
>> The extlog_mem_event payload layout changes with this series.
>> Compatibility with existing userspace decoders still needs to be
>> addressed. More specifically, the rasdaemon relies on the current
>> struct cper_mem_err_compact definition.
>> Either:
>> A-
>> this patchset should not modify struct cper_mem_err_compact and
>> create a new structure to handle Memory Error Section 2 events,
>> but this would ignore the similarities of Memory Error Section (1)/2
>> B-
>> userspace should not rely on the struct cper_mem_err_compact
>> layout. extlog_mem_event trace events should instead emit data
>> that relies on the actual layout of the CPER records, as defined
>> in the ACPI spec.
>>
>> I am looking for guidance on how to handle the above question.
>> Current implementation lean toward B, but emits data in the trace
>> event that maps the new/updated struct cper_mem_err_compact.
> My initial thought is a no to modifying the usespace ABI.
>
> It isn't particularly painful to just have separate handling code
> for the new record.  Unfortunately the ext_log tracepoints don't
> split out the fields in a fashion that would let you change
> the structure.  Other RAS tracepoints do it field by field which
> would have been possible to augment - even then it would have
> required care to deal with field size changes.
>
> It may be worth considering a much more 'expanded' tracepoint for
> memory error section 2 to reduce similar future extension problems.
> That is express ever field and don't use a compact structure at all.
>
> Mauro, perhaps you can give input on what works better over the
> long term?
>
Just to be sure I understand correclty, this means that you would prefer
to add a 'struct cper_mem_err2_compact'. All the functions currently using
'struct cper_mem_err_compact' or 'struct cper_sec_mem_err' as input/output
parameter would have to be duplicated right ?
E.g. arch_apei_report_mem_error(), cper_dimm_err_location(), ...

Regards,

Pierre

