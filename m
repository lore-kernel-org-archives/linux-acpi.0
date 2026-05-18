Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A35324B33;
	Mon, 18 May 2026 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100377; cv=fail; b=bL6GvbFKMkFUiijk0VEWbQ8Qxi2Zxrf7vbt6S44wTStBt1dlcSul5OKs0tj2NhPQ6Ww7B1s5XwTXK0wfTEajLULSghMmdE6H38zOYK0b6+aAxJa8mD6VcP8A+0AphR1zmiq0l74+0qhEq689i5yXh4Y+66yogiNhhpUuaJy3z3U=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100377; c=relaxed/simple;
	bh=F5sHjHj5qazIBiV8fQuJCVcf4fUGFU0Lu4i+IK0Cuew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRL91SVQd1ecqutrKRO4yhDLODIoSjaI7dSX5DNoc6W6fmxNFDCYHR3wB44LsqBA6S/Uknzuuw+VQfP9zUx3DCp+ProxvCdn+IarmLvoAwtSdM//p/t2tdBYtNqRW+/lGd0GJohn3+Gj2UQfZoANZM1dKmbG4PQTgaqR+qQZHBI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=e0uiZddm; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=e0uiZddm; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="e0uiZddm";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="e0uiZddm"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=aM6EHHAc8+4i4td4TKHrUvKwrjHOgW7mv11PYUofcuBeF/aKT/HBh2qlqvaTVwNY5uR+7AL62kLJ753s6s/a+Z5nF1J63uCnkSsVgCAkPfcXRiTs7385FeAxtAMXMdasGl9Muz/Nnx8b68KImkIMYFYnk9ob+YkaHbbmyMPh9hHRZ2aFgKFarDMZV1UphvyZGZxoRvHok/vXwdrkoESIboD+QmaLCjwxho/Z0YdAVj/zln4fjUWhmbw90fJbOqfFwjZicp1rovLXWKPjs699BX2alg8Kt3Sj7Nzhv7nXawdMEpSYWMvirE3+rnuj1QWvlGLMtzIk/zKABIt5AboBow==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoynlRt0j55faS/GMhoBYqJ6JYRgMBPRgbrk9bnYgtw=;
 b=XCn2Y27pGEu437k/tf46fArqAZcKWE0C7D+Hv2wUC6NddE6C9j/PaNuRUqpwykHLUg37pH0+M+uDju++ApRXglHHVm0chchB6tpzxO9Jzbm14fT/gPZMP61aRM3kY5Ojyuorl7be1eC5kb2ea3G6MFXJZyMjF2zd1E1vYja2P7rwriRsGTju8iOQ93+X/he9Ho1000/09OYlsnfC9W0b7xY9ZtqXJ6vuDnVGo4uiAZN3S8lNsPXMngfHdcEolsGj26gVvflVGUOEE+uh/+geYgMf6SxIRKZO6uUY4MIMngLX2VXNl/5RbPmfLv9nF8ER+i7y2rKV1kTTwVNDz6gktA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoynlRt0j55faS/GMhoBYqJ6JYRgMBPRgbrk9bnYgtw=;
 b=e0uiZddmoP4z7wIvr0ZYc6GbY7HafUuDtEPAyhaVIOXfZcAQm4id40Cyv1OY+GMZkh0p5CkmZtA3HWT+kR1OtiAHT8z4+cF+980U+I/dKA39VLPwReNfKXx1He5x0pzV7R0eUtOpm2fYINyvzrHUS+4SpyE+ZpU9Hgv8VJQQSpw=
Received: from DU7PR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::16) by DU0PR08MB8977.eurprd08.prod.outlook.com
 (2603:10a6:10:465::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Mon, 18 May
 2026 10:32:35 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::4) by DU7PR01CA0035.outlook.office365.com
 (2603:10a6:10:50e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 10:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Mon, 18 May 2026 10:32:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZ3XlEKtiyDKHfLaDp4amUuJ0A8uRhPT1MexlUj7OKRnRxPwTGepium2cqB2/xw53CAK2OZaAGPmy4pKWCMzQUUnbVE313kjFJffdY3f+lsU1P/5m9WZwpPoRbFh/Uj+43K2bfEizmo0sFOReFi39mQOQCrvi6h+kequng0HtSXPlSSNGQ569Dqnw/qfdBGzBl6nGrJjyiYcy/QQeXc1iOUZ7L2MWSQJAKcpuASLsDFDXR0GlUHrxoY4bPjZb+95q67A+rrZD54nFDDDQhc+eXMg+kqYrg92KzL0nqLOhrYTXLvNt09TMernVU1Y3wJwkk3/EbhFb85BNaPNuY6jXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoynlRt0j55faS/GMhoBYqJ6JYRgMBPRgbrk9bnYgtw=;
 b=MPHDjGn0qXmvzWHuJppVSzLn0YvAei35yB2oV70sLXHld4iHpbK3sEPJlmfBs5Ke/l687uO5D6TH0Ga08yODvt3tGzGUx+uW+ysGuVSIziiSWAFOjul28cTg/r5DE3G0G5kbEMudMoPwnbDlyeYqkVHSUynSxTSdFsxNufHoFmkJrvsEMLCNSJZXlAkpWMwT3FYkdYMwVguUQYM4FfYJYu8vNw9q/xKjRf8pKtJ5mkVQ6a1OxiEdLNjNrIhoNpSInMqCc5OD18DvgQ6WsWdzy9KA8XgZXSVGKHWOHduv2t/9J26Elt8yxCnVfWsYlejM//TubDjF8rkaNPyfhdCSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoynlRt0j55faS/GMhoBYqJ6JYRgMBPRgbrk9bnYgtw=;
 b=e0uiZddmoP4z7wIvr0ZYc6GbY7HafUuDtEPAyhaVIOXfZcAQm4id40Cyv1OY+GMZkh0p5CkmZtA3HWT+kR1OtiAHT8z4+cF+980U+I/dKA39VLPwReNfKXx1He5x0pzV7R0eUtOpm2fYINyvzrHUS+4SpyE+ZpU9Hgv8VJQQSpw=
Received: from CWLP265CA0475.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18a::19)
 by DU0PR08MB9078.eurprd08.prod.outlook.com (2603:10a6:10:47a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Mon, 18 May
 2026 10:31:33 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:18a:cafe::bd) by CWLP265CA0475.outlook.office365.com
 (2603:10a6:400:18a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 10:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 10:31:33 +0000
Received: from AZ-NEU-EX04.Arm.com (10.240.25.138) by AZ-NEU-EX03.Arm.com
 (10.240.25.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 18 May
 2026 10:31:32 +0000
Received: from e132472.cambridge.arm.com (10.2.78.53) by mail.arm.com
 (10.240.25.138) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Mon, 18 May 2026 10:31:32 +0000
From: Niyas Sait <niyas.sait@arm.com>
To: <andre.przywara@arm.com>
CC: <ben.horgan@arm.com>, <catalin.marinas@arm.com>, <fenghuay@nvidia.com>,
	<guohanjun@huawei.com>, <james.morse@arm.com>, <jic23@kernel.org>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <rafael@kernel.org>, <reinette.chatre@intel.com>,
	<sudeep.holla@kernel.org>, <will@kernel.org>
Subject: Re: [PATCH 2/5] arm_mpam: Split the locking around the mon_sel registers
Date: Mon, 18 May 2026 11:31:32 +0100
Message-ID: <20260518103132.3265307-1-niyas.sait@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429141339.3171205-3-andre.przywara@arm.com>
References: <20260429141339.3171205-3-andre.przywara@arm.com>
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
	AM4PEPF00027A69:EE_|DU0PR08MB9078:EE_|DB3PEPF0000885D:EE_|DU0PR08MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd427b5-c1bd-4147-bf5f-08deb4c8c6c2
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|56012099003|22082099003|11063799003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 oZoMuuuCyfFylgQrtdoUFSOhNAPnvDLIjZaPho55Y7PU11tbGqHVx6VpACZb3j5r5B3OUNjKHBVfWjHULtrHIYeqos4elEb7sJ01ZkklK4NRTwLwyzq6HQf+A1hGNSpkCEbHA8WOLjoOs5rXo7VXuI5YRao8IoyF5F/ewXpkOsIoVPIzr6Yoo0BceEK1h8ct3ENo8N8oStD8Zz91t/l4aqLXxAfzUpkyhXQfqoLXgPYGMo9vqN3GwZw5XxBGKWeRaIYA9J7+Lr93bBmKIjoOt06sqmOpOwJab9PaVW1PzZy42XHqU4K8S3hZeEzbHZv9WG9scI+WwXfa90z9LFbeDBPysBeEkTD7xYsmyS383OJ7lx+82ev8qLiwFa9LKDmzDI7nsi/F/nC45p2kddZEVpqHfZbBQgtbktsYKjeI9n2drsDeKaOIwOY51Z9v3dPF3Jx4la1dUbbS7fwe7/bGOxe8p5nXNamSRQ40iJUcjV+qgMmA0LkniC9k2ebKHcfqBEidGuX5H0WvYouEXyncqEU/Cb0Si08oM72I9MP88TWmuXZA75bHXnpiJ4hpIh+3/v0o8ZE8Dok6g+V7kkGQLPh1oHeoBk25P/0oE4TIldiGkpUuY2XPgaQhWNP+HXeLamQsuJGuhY6H/iSab2vbKw3s3cAeCUERCxWkexpDcIK1PBEMm5HYMIvrEXROLdpPim6aJvWP99V+1zhN2FTxpZTOU/dEgryFfuqHINo40zo=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(56012099003)(22082099003)(11063799003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 wqSbBUEYcObonpYwXfOM4AEKenAkUnvb/RXtDh/mKVSFu4vfMOX7RmQQpALllNs8EIOHeGXLuwD3YaL2eVlBM0Uou3MNz2tz4NOjsRXJLXoEizaqTG1Q+Bmw83Q4M/HeQDKuvdfHoz5FrplAxoejOMGzdEURwi3CVygcCpxPMVwOVmmOnA6A9eWdTgfO5Az9iQHyGkTdXcwMySIoGtTbEYwa8lQV/4iqo/KZWrpPiPgd+ZONoFIfaCWlrZ16MClRnBQ/AnwNBqh915zNjn4oXjJ/xDhwgz742yFKzDFJiQMN3DPQWmoylUi5U5PVpbsN0Y9q4X7qVN4fzlJJIND3gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9078
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	93e91718-32b5-4aa4-6356-08deb4c8a1ac
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|7416014|376014|82310400026|1800799024|36860700016|22082099003|18002099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	igS1v8YDatTrGcIx+7EGsU2s+2XE3EPOgYdW/JZW2miIAfVSZ+sQRlUTbfSu4wrebcNv4LX+fRNpm2UUDGnW9tW8vrJ7MQ0EKeF7s7v1hcFSbs9exNsJgfN/g5o8jnYkn9/w/M2ZO5T8dxZomWqOm2KpCplAJY8kUJAeuik10wHWz1JW6CZruS0Pc54RjsMHGbGJdFBQUVETxCp1qZKK3EfCto7rHLPYnYl/Nw1feOow+IriNnwtzQTqsktOofzEupceRu5SItYRZGGRCb901J/MEcT80S74h8L54Y6jCOGeLQo06I6gF8+mvsNgOemlclXQ9YTTi0ReMGyJltcmw9wyMgnwOtTjMd4Mu0pffoH91WTi7XSJO1E+TEHpTRNXReqDscWpFij2F6eZuBjQh1vwUJbd0KbjoM6ohrJ4ShyeoG5hmlT3a+YBFumSoBsIZcigPLCz2oWhT8AY1+MlDkw+3qICnBb7tb8eHYui7jCIt6yr+Vt1BvujH/VessHKonWPCQUovYp8zZNHx8Aj6cuhzLC4oXei7EQ9IivlQfwRfgIz4UXNI+LEi/erqS1HP3X5T1ihDYUQ2oGAGHg8XOzQ2XiGS2H8gm+xXS/F0ZQoQDZyEa5j+F/TSD3XriFyuXg8RXG1aUiH4j1O1ZCCdwSYD0uPWaoTxpFasAsU1fiQZZLac57sIPJ/8y8nulnfTG3DYfe55TPtjca7X/wt5i5T35i3Hn/nmu3RT6QaJNE=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(7416014)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0lwqOvn3wRaxxjnOnXu4FYrSToF5sBFIyZ3x1CHoeABIQlSkODWYBuy0xN4jR4axbELzTFunxxSknY4OYydi0sY/N2JpEjeH3s19hz5IeHPJjXs+mL/GGiE73T1GhmnhdCoQVfUnSIMfFFr+X+48tPWv/w+/IrWJw1CkmWhzmi6hy77G+tApFvx1dHxD4weSb7Bq9r6IHxZfC1v5cIwkQRJfdGGOd5v9ccc41EDnx587HkSP9pHAS80sCDOpM9alI7jX+1BoFUWKbF/fYOhji7zVElxxfw4fLnCvfmGDUb/vmNJ2b6/DG5g51ZaGXoBMsJtycmpft+YI8HX+eJsR1iFCSjzJvlN8jlV8LuYr5Oc1UUEZTZQnmdJQUjO/JgvI5yeeyyiSaVEAGbPNHa2AsoZe0/xB1W1Lc0OUaiKC/dkGAQ7zXu/lCArIs58nnalw
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 10:32:35.3210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd427b5-c1bd-4147-bf5f-08deb4c8c6c2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8977

Hi Andre,

On Wed, Apr 29, 2026 at 04:13:36PM +0200, Andre Przywara wrote:

> @@ -1635,8 +1643,11 @@ static int mpam_restore_mbwu_state(void *_ris)
>  	u64 val;
>  	struct mon_read mwbu_arg;
>  	struct mpam_msc_ris *ris = _ris;
> +	struct mpam_msc *msc = ris->vmsc->msc;
>  	struct mpam_class *class = ris->vmsc->comp->class;
>  
> +	mpam_mon_sel_outer_lock(msc);
> +
>  	for (i = 0; i < ris->props.num_mbwu_mon; i++) {
>  		if (ris->mbwu_state[i].enabled) {
>  			mwbu_arg.ris = ris;
> @@ -1648,10 +1659,12 @@ static int mpam_restore_mbwu_state(void *_ris)
>  		}
>  	}
>  
> +	mpam_mon_sel_outer_unlock(msc);
> +
>  	return 0;
>  }

There looks to be a lock nesting issue here. mpam_reprogram_msc() already
holds outer_mon_sel_lock when it calls mpam_restore_mbwu_state(), and
mpam_restore_mbwu_state() then takes the same outer lock again.

Thanks,
Niyas
