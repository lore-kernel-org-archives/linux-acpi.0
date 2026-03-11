Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC82620DE;
	Wed, 11 Mar 2026 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233875; cv=fail; b=XBTPMZKCp5cPbTsyf7tqgQMiXd6icd3cpXxF7HrE+iO8xAT1/nGEMk2Y8HJ6bL9464cYnF9z2YlWKS6e5J5fVCm/cbt6Llmwv4Z3zDDSpKB3vocR0DVh4Hl6cmzP0av+d7ifBC3HqVsZBuCfVtIyPPROhsr9PMwOZSqUqa+QbPc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233875; c=relaxed/simple;
	bh=BBrabHLuraYgIRs7pwIzEiNa1TI93a5+uzLBgu3m+OI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fZtg5ctFYhR9oqSmLd9OuzdjGnUXf/toHukfNja57Y9+Lw4e7xhIeXLUQKFnGwBlrGvbp8v/PBV2zBh7YpJZD8av9/MNh6UPkAZUKkuFgBAwqOhCDN2bECyI458v3x05w9E6lTYwDnz8SKAG/zJcgsQKG/reh61yPLnfU0z27Xo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KJxcv0Cn; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KJxcv0Cn; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KJxcv0Cn";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KJxcv0Cn"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=te24K7wNmpkZh5yOaOG3I9SZ9qjG946gN1eJ16arriwAk9EBiVoO4ubmSsjN2loowrmv/XyrXELNeREFVrWnT4f89oQBrrTxvV36joIr3SO/Zgud0gO4QJBhQjgRULg6kGGwRNF/HvrJ06vY37oGcNBAjiiZhOpJn+9I1S1o48O9he2Tre3pppl3IrLbV0OkG6iHmPVfnDW6GeyATdw0s9nsp05hlDZEZNRsUHtC8J3In0kSqkt0IGwvvvwkzyjX7A4msaIPdRKI3OvABNi4M+wRtCEakinCzYn2qG2dk9ziDuvG6h8Hws6lP1euIqPk7C2SYTPe1dRxnIf5pdhRLA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCAA6JWmGuxW+ELD/ymApG2eCvlH2/Cf4nT6KNowou0=;
 b=RXnEX6G1/cxfUlUCAZA5YeDJvidfy++6XEHCARl1EYAAwseBtjvh/eRiUUnKpqxJl4g+GxAWHJPuy4baAgfdZZPMYlI9G7JZ1OvXpDhaVpXE/rF9MuXhBQJ+XKUdm55VRANwWcsFY36rrH0k2dG/LrkgTPDSX9rrCaqqDPsQdrIO/MpaXCjc0UiAV6HsJynS3Mo5Ahcgu/nmnIN4gQzpqy5AlfFocOvDycSat/2FWs6KfSPCQbY7B7halCzUv1ViSAyx9MiLsxKeW3JVWtYvv5A19RX/DHd7gW2VceIh/R+Zb7TWkUd2iqz6KL5cwgAY/xVzFz+H5Ng9k8iD6ZYjuw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCAA6JWmGuxW+ELD/ymApG2eCvlH2/Cf4nT6KNowou0=;
 b=KJxcv0CnzC9cuQGX4EvT3nB13HybXP+l/w73iOdOcg2t9nT1/zTQHH9r83T2Mf/SWeot7rcm0fkodNg2Pp46Ou8XpgsnismM5ePzNVwb8BbtpzE8G4A5Ma70R0TGX9KOMMqxzwEnPufDV7bftj36e6ruMAVkJgW5GYrjksQt/9s=
Received: from DB9PR06CA0016.eurprd06.prod.outlook.com (2603:10a6:10:1db::21)
 by FRZPR08MB11138.eurprd08.prod.outlook.com (2603:10a6:d10:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 12:57:48 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::df) by DB9PR06CA0016.outlook.office365.com
 (2603:10a6:10:1db::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 12:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16
 via Frontend Transport; Wed, 11 Mar 2026 12:57:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCfyGxFPSs8iPLs1EX5GQMXzuGo/TiNr8OLY8vvFigeHaLi7ZHL3AOCKPFpk2v9vkCtAqkVI/4u2tmLlB6uhg7EQdvsYW3vWANBRimSQOCGaXBVHvB9BifvsePWnxngdw74YZKVsEKy2nbIJ1CNuT4EuEE7aBSmAQxH1e5i9FhOqXBFw9ue5svz9XcR4/zBerc0eTEoJowzKhQA0pvTGGuJ0z4L0gKXdvoT4hImgvG0NHqAp5BVZzr0aFNHFEbY+XJ0Zb8SaF/T0Baj2kBSr8gx3/xCLubRuTtq+n/1Pr4zR/n3JtObFJTB5E6xALdN8DVWmv7BzFY8Jjesfy3EEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCAA6JWmGuxW+ELD/ymApG2eCvlH2/Cf4nT6KNowou0=;
 b=R/T4DiiLk6WCa9aBTyLULTYrX9EH0UXKlAGR1bqAshhP4LYqUWb1YVcx0dMWJKw2D4eOSNtFgq0d9vBFlNUUHC/980hU3Rfwlo0t3wQeR2UxIb8+sZejdRk+I0d+je1JAyyRCCqlcWs1j3fa03VnXx+t49G3Ioi+Jvr9XxWdCTvtbMOftwscxcvFVtxQuOpbhNU18WvplAnm9PoQSqSlMB5o9sxMHg29tlWg34P4wW8y/iODyn0SLO5hB7qccndmwPCTKWcxcPcnjrcmRkNa9Dy2okFElgWqOxx563wotJoMfyQ7/yaSkC4iwYiPaPsHGUmzjTCqberrxA38xZZAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCAA6JWmGuxW+ELD/ymApG2eCvlH2/Cf4nT6KNowou0=;
 b=KJxcv0CnzC9cuQGX4EvT3nB13HybXP+l/w73iOdOcg2t9nT1/zTQHH9r83T2Mf/SWeot7rcm0fkodNg2Pp46Ou8XpgsnismM5ePzNVwb8BbtpzE8G4A5Ma70R0TGX9KOMMqxzwEnPufDV7bftj36e6ruMAVkJgW5GYrjksQt/9s=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by GV2PR08MB11539.eurprd08.prod.outlook.com (2603:10a6:150:2b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 12:56:45 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:56:44 +0000
Message-ID: <255a576f-2d5f-44a0-af67-b6ff47be5a61@arm.com>
Date: Wed, 11 Mar 2026 12:56:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] ACPI: APEI: GHES: share macros via a private
 header
Content-Language: en-GB
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 Dmitry.Lamerov@arm.com, catalin.marinas@arm.com, bp@alien8.de,
 robh@kernel.org, rafael@kernel.org, will@kernel.org, conor@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 krzk+dt@kernel.org, Michael.Zhao2@arm.com, tony.luck@intel.com,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
 <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-1-347fa2d7351b@arm.com>
 <20260224152230.00000531@huawei.com>
 <d0911510-9f87-49ed-b896-fa00e5d2a98b@arm.com>
 <20260311123947.00000be3@huawei.com>
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <20260311123947.00000be3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0498.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::17) To VI0PR08MB11823.eurprd08.prod.outlook.com
 (2603:10a6:800:324::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11823:EE_|GV2PR08MB11539:EE_|DB1PEPF000509FC:EE_|FRZPR08MB11138:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e962a96-87eb-4ded-e4f5-08de7f6dcc38
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 FR4nJS8PM8ZlU7vpi0XrNlwGelem/QTvKkJilrZYs2uLCD3co8ulA8DtKmXIY1jSACgXCcM7CtCQt12juWq9VURAm4mdCQp5ZRdDdEFtRI8OYUDWDE6yNCMW/j5Mg8TuYkwzLvAcZdkZvIkc/y4paLJm5Woq1aPq+ozYwOmXafvT3NyLE2XM4mtmc+larNrIdM/oIEH9njkYoS2wSYIaPlSAZugTBZ/gMXX11nX/wGkAA80aETdk/uPlZxusGHkH8dIZ3dSIRiwK3Imt1otHcEkMPkUDroYbTJs2mlgVRRtR1RoTpxcH3WVinYzMQPlOXrcZSPt2tv8aCfngbqw3shjBvxB3lly0C/FPsprFRJD4zbjqqOxPhhXZNpD5LvaSJy1omaGFA/SvfnKbalXRB23oRjZRN8oSRHboN1pB3+EVM6IVBfVa7M4Bz787JdTDRMzfX27ZHXQPPJ+leU/g3jojdHMJ36IDuqGzZAvEN1mQDPrNzrPx/iNNKrFViqzbRrL/5JCBhQRa43s7uOf+1Rhl4o/SyHj7tqn11NUEZM0xwBHg/XE9ergxtab0uBJNPa1K6/9QX3HuNMMroTffcZfo0BCztbC0Fraj/ep/D7suGImYPFtdNurMeoK9NxgdSHNleeF8m8KCAz5AG9RAGR20DnN+5iqFoK6Uk+04fEU2v6fs2u0CVm7cz/JhjN5WlOTg5d43+d2GDYeclxMrcG+sg8GBk/+w069Qr3NTFZw=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 jWemaplT6r2Zcakvrq5oyWtiiHAJEOGY3XAMHEqcmdRtoYL9pge6VeKj7Xt2wUjAw1S3h9jEE0vfH0DPsw2I4i+JNTSrsnI6tPVZVDhFOtSRjv+2Nnhxsjl15/59BdX6b1V+P+/L/NXSTeV99Pl10huGibIA5EQRLQvCk+3llybv5GMCNQP3VJrMqjoBIeO0+yve1hwBLYJlHvL6IHvqKCXhlRL9pv+hc9j7usDGaV7vn54qxtS3Dv80ZnizkQ4nD+cVR5SOCcMHZGi8lvZ+L6p22M0JnjMoFZc+LYyDXkBnpD3iHuYFfE1ZGK9xtQIxDf/SlZymk6OdI79+DRZthA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11539
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d70f347b-1df3-48d2-82aa-08de7f6da5fc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|376014|7416014|1800799024|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3kHQbqGse+Jlz56d22VWC9vCvJ9c0MtNa8Q3yD7KYhnHeW0pxmPasounXIRNtW6HBR3WCX2OFl/Z79kXxIei0KGMmuV+J+1gsmIw+8u9RSeB9DaamFSj5TNJtyhf+fOBpnsGWNc7RE/mzBTtUIgFT6rF9HsnWTRw2dwKsm5p5+mblldDgpWZ6LymOk/v7nzPjKHIoiMhPyFghQwGZdfyQFYXF6TcvgtiAyj0N+AOB8K1ESPLKck+TROCQtlWs7LvnGsVMm/LV7AIHG2QbJBYLxHX3HOdi+/TcqNW16UrUNhV8vx445PLplUAlnrkMs9tkDr7IONHEVXIJtt4ug5VX/yGcrvxNEQuA3SNu4Wpw5xiN13ZyqnQerR/jylS/ofQeQqLlmYkdgmeszA4Tx0ZV+/SQ2fFiCtq1qWKwHVyJ8Zv2G54y1c4ujkZumQqqDLn+ezTTnxOHySbg0hEeS8NW9UjNRai1cD/AnZcnbjcWOJ8rNC9VmAlPJY0W2TvksaLA+jSI99zbYc76jLeescy8cyLtGWpCXGPHBLwk38SrRr9Z0paj7nrx4KAZF+i32siTU0Z8Sg69X0k7vdJIhtr3PNUCj5UbC6jJPscCH58jwJj3Tc+SpaoOlz4O3WpKIJIuVI+ooyQPOEMZXxQRzPE5XaKIFyo+CqgtUmJtZhm5xUKspnaU8iQM/34TQBlM2WnzDCecHipX20QfONqFS0ob7n8ElLjTve5NBY9XYj7CzX0qzuFpZKVC+aexoCld8febwVAq4fkqt8vuIV+WvPRxw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(376014)(7416014)(1800799024)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bLL6cN0KipZIMbB85kFCnqi5DZTMGca5iqTb+zr6JrxqsiSMkoHNYsYAS8TZi25J65SDBHw6LMAdO4WPz+OHAzd8cT3KbZyhbmBLVp+i5aYwJfQsCrEYHWdAU3lhsO/mhHmVsudDfHANFrgK8RQXJ/gQuok2gKtVCUu8NmEvBew/APxkyA7DeslOeLztZ5m+xeHy9ruiHmFUEPqCgB4v6VRGOwKaYSOMOwsGopKwedkds5bulyjWR2+amYz8c+rdr2K0muNHeHIR9BevtTQUN19QtsSJFaqOGUVRrwW86202aCdM7DsyVzoIPrqAGIXahxLBJPLJcD0aYL6JT3R9E0iEjOsyiB/AOGpG7dqGUsnnbEIraeeLsPM3C5Ykgep0+z60o3oRfbDn6A1eALh5uqeO+cJJMgPCZDrzmAJ1BLP/d0PfXxcn0IwHfRURzFqg
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:57:48.6641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e962a96-87eb-4ded-e4f5-08de7f6dcc38
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11138

On 11/03/2026 12:39, Jonathan Cameron wrote:
> On Wed, 11 Mar 2026 11:39:38 +0000
> Ahmed Tiba <ahmed.tiba@arm.com> wrote:
> 
>> On 24/02/2026 15:22, Jonathan Cameron wrote:
>>> On Fri, 20 Feb 2026 13:42:19 +0000
>>> Ahmed Tiba <ahmed.tiba@arm.com> wrote:
>>>    
>>>> Carve the CPER helper macros out of ghes.c and place them in a private
>>>> header so they can be shared with upcoming helper files. This is a
>>>> mechanical include change with no functional differences.
>>>>
>>>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
>>> +CC Mauro as he's been doing a lot of work on error injection recently so
>>> can probably review the use of the various structures much more easily
>>> than I can!
>>>
>>> My main comment is on the naming of the new header.
>>>
>>> Jonathan
>>
>> The content is intentionally GHES‑specific CPER handling,
>> not generic UEFI CPER. It's the GHES view of CPER parsing/handling
>> and is used by the shared GHES/DT path, so keeping it in ghes_cper.h
>> documents that boundary better than moving it to ghes.h (which also
>> contains non‑CPER GHES logic). The helpers moved there are the ones
>> needed by the shared CPER handling path.
> 
> Ok. So the intended meaning here is GHES and CPER, not stuff specific
> to the CPER aspects of GHES.  Maybe, though I'm not sure why you
> don't just name ghes.h in that case as GHES always incorporates CPER.
> I guess because that file already exists and covers some ACPI specific parts
> and HEST bits that aren't of use to you.
> 
> Ah well, one for the ACPI maintainers to perhaps suggest what makes
> most sense to them.

Ok. I'll keep it GHES-scoped for now to avoid implying a generic UEFI
CPER API, but I'll defer to the ACPI maintainers if they prefer ghes.h
or another location.

>>
>>>> ---
>>>>    drivers/acpi/apei/ghes.c | 60 +-----------------------------
>>>>    include/acpi/ghes_cper.h | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 96 insertions(+), 59 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>>> index f96aede5d9a3..07b70bcb8342 100644
>>>> --- a/drivers/acpi/apei/ghes.c
>>>> +++ b/drivers/acpi/apei/ghes.c
>>>    
>>>>    
>>>>    static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
>>>> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
>>>> new file mode 100644
>>>> index 000000000000..2597fbadc4f3
>>>> --- /dev/null
>>>> +++ b/include/acpi/ghes_cper.h
>>>> @@ -0,0 +1,95 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/*
>>>> + * APEI Generic Hardware Error Source: CPER Helper
>>>
>>> There is other stuff in her usch as the GHES acks etc
>>> in ghes_clear_estatus(). So I think this intro text
>>> needs a bit more thought.  The boundary is already rather
>>> blurred though as for example cper_estatus_len() is only
>>> tangentially connected to cper.
>>>    
>>>> + *
>>>> + * Copyright (C) 2026 ARM Ltd.
>>>
>>> Doesn't make sense to ad this copyright in this patch as so far
>>> it's cut and paste of code from a file that you didn't write (at least
>>> not in 2026!)
>>>
>>> Might make sense after a few patches, in which case add the copyright
>>> when it does.
>>
>> The file is new and maintained by Arm as part of this refactor,
>> so I kept the header consistent with other newly introduced files.
> 
> It's code moved from elsewhere, so you need to at least also list
> the copyright of the original file alongside the new Arm one.
> Just moving it and dropping that copyright is inconsistent with
> the license.

Agreed. This is moved from ghes.c, so I'll carry over the original
ghes.c copyright into the new header and won't add a new Arm copyright
for a pure move.


>>
>>>> + * Author: Ahmed Tiba <ahmed.tiba@arm.com>
>>>> + * Based on ACPI APEI GHES driver.
>>>> + *
>>>> + */
>>>> +
>>>> +#ifndef ACPI_APEI_GHES_CPER_H
>>>> +#define ACPI_APEI_GHES_CPER_H
> 

