Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552951A681C;
	Wed, 11 Mar 2026 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231635; cv=fail; b=pTza1yMhwDGm72T7q52ZrzBJi9txT4QCvJblzvj9j2dVg8N9Z9O9LnramUv83bDVzs8zVkLqc6muhq1au88IUsxZLMVEOFO9GNHdFFKemRUHeme+x2tJBLdxTzIcPlGRyKvBV5fDHrg9vypuGYoaBcNJUcdbm/Nk/uV0RPMCSb4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231635; c=relaxed/simple;
	bh=SaTiqhqcCx5yXVWIqtxF3CIWou3l/1JuozF2TuMaFcw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Um2FbMg/78+PXgwVCHOGiIB39PYIsyPN+Gy7i24VCDcHwfHOAut4yp9FlFy1DdfbTqVud4UIOLx0R+St+h5HjXHc4pJhgtEi0X/4z/VRkvnqe60cxP7CexYxFZKCLPAf8IT4iyRbNv+WIQJ/zCuLgiYSWEpOUx+L+/YBzSja1Ys=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EgEDUjQS; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EgEDUjQS; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EgEDUjQS";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EgEDUjQS"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=eUAPkROw6PpJsEiBhKs1capUQMY/O10bazYyF3Rk8O/6iY94BEJfJdOeO6C4qGkWfX+HXADrOTX3B8HUutUVsbnZ0XW3yLb07p/MhgghfTQIc8MQ2uybduR1Qabva8Ea45RLxHPcPmu/u3vEoaWrK82XOKuaqjvaeqagC1/mOqbocRMERTXztRYiAh4ikQH5vOIpqvm1z+m3Ra9RDpbGIFZqvVnIv0/bge9RqNLeH7o6a9KyVhrRPSe+9+3M2Tq63nQ+kgXKmXgrATGf6EBxKe6Aaicu8j2sT9saOim6WAk08h64r9kaVhv1MR+xuGfZeJC29AA1RqA7fRglttBgLg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGhUIKQzUbGlx9S+2I9cGni1LgdFJ5GoQyn4IRTOL9g=;
 b=NQKPl6L5yZX5RvsMeLDqWcmKY0ZnLz7SOB+YKuT+rPYiWdP0PuOCOdWvO0Uf5HStFNB4o8e8ZCAVhTmVHxnsZNrwg3jNBI9dthTgcjgNQ0J4JirelyKJARoM/puxWBnCqfaf1E4o5B3v46QbB//0H0BMWk9cM05fATViXf/M92uQRmuuOBVKa0ef4+GRnubviQDqj9hKp7ap1l8hDdtYvtSTVq4N6bOCHjItiVhiDahv78QqGB4YkksGkAJUTK+w6F5dNx75iINXcdHKBWxb7VTAx21iF9EA/9sPLYh979I55gyLepKRrbSGVRmkiHKwspcvyt/720MYwhDTb/yyXA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGhUIKQzUbGlx9S+2I9cGni1LgdFJ5GoQyn4IRTOL9g=;
 b=EgEDUjQSU1qYZHIXfsFY6p38OYFI6TQXlhiKbhhbmkpZb3utaffBMBLpiW0iz+vPWhDjYqx9vE2fuU0en/PifWa4bkJgvOvBpGf9RzqoRUStcwMXuOhWwk5PuAA78EfeHJ+SgdOJ3W4gt9uXD7ftEwnKtV/vs7CnFhlrd9OXE28=
Received: from DB9PR05CA0009.eurprd05.prod.outlook.com (2603:10a6:10:1da::14)
 by VI0PR08MB10972.eurprd08.prod.outlook.com (2603:10a6:800:251::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 12:20:27 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::77) by DB9PR05CA0009.outlook.office365.com
 (2603:10a6:10:1da::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 12:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 12:20:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smps45CHRM3cdHraZpfkTiyq8yEHTRMu8YlgP/DpNn+DFnpDHXWpO6Z/SO/Cv84c9DaaAKvbWUDOz1RAX8LDsiu36T+AQluwwHsNOasP3wQROHs0PdI5aVKuoaI6ReofbYsdx9552lehNyCWkFIIFr+tTXwbczy1kEtUSpZpBPrrNLGQz/10EOSONxunJz2fO24asJ3OlO70PrVWtz8fDwtyhq6msABQzrPNUeGwaVxMkHgKfMxG8NSUOw2w3kXt9kJ5YEbB05LOijgCJjH00VTZn4wz47z7ABK+8KfCNVWmc9OHyI8fMRK/t8jhe8fG+Ar8a6zhrMxCaNeuIpnYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGhUIKQzUbGlx9S+2I9cGni1LgdFJ5GoQyn4IRTOL9g=;
 b=n8hoYdyr95hbXkSwRj6fcnrvMeJOd+2uO08NLr0NTPW1F1Y6ilxznaLOEIvVl1LaqQASGZKCwwrpEbmACvt1SuFV5aBDRyDvneLwIRHdggefWa3VboqtUmuYyiuFAQBR6n250VVNvc6wih48uzPpipx8jhHXVkSlb/rZT7QTl5mcrX8j5bVPjPTYCJqxtHOXTo8wzQ4zNwNeywp69+XnSX6QNblrtFxTxIt2u6/hvWtjg1KtweAjkn8t3yTXR2EO3FyISXISCDItgYble2KRh+Ecv5YJG8ZI6Ht6G8vwdKvosTL3JOG3WFwqJZ0C8eFcvurELb6lxnFsYmoZ+UCq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGhUIKQzUbGlx9S+2I9cGni1LgdFJ5GoQyn4IRTOL9g=;
 b=EgEDUjQSU1qYZHIXfsFY6p38OYFI6TQXlhiKbhhbmkpZb3utaffBMBLpiW0iz+vPWhDjYqx9vE2fuU0en/PifWa4bkJgvOvBpGf9RzqoRUStcwMXuOhWwk5PuAA78EfeHJ+SgdOJ3W4gt9uXD7ftEwnKtV/vs7CnFhlrd9OXE28=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by AS4PR08MB7808.eurprd08.prod.outlook.com (2603:10a6:20b:51b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 12:19:24 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:19:24 +0000
Message-ID: <8ced1e63-d8d7-42f0-bc45-88e7cc17ef59@arm.com>
Date: Wed, 11 Mar 2026 12:19:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] ACPI: APEI: GHES: add ghes_cper.o stub
Content-Language: en-GB
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 Dmitry.Lamerov@arm.com, catalin.marinas@arm.com, bp@alien8.de,
 robh@kernel.org, rafael@kernel.org, will@kernel.org, conor@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 krzk+dt@kernel.org, Michael.Zhao2@arm.com, tony.luck@intel.com
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
 <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-2-347fa2d7351b@arm.com>
 <20260224152534.000040b6@huawei.com>
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <20260224152534.000040b6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0460.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398::24) To VI0PR08MB11823.eurprd08.prod.outlook.com
 (2603:10a6:800:324::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11823:EE_|AS4PR08MB7808:EE_|DB3PEPF0000885A:EE_|VI0PR08MB10972:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bff998f-408d-4049-c870-08de7f689400
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 KIJk8fMNqsD9PUjpwm1F4Sr+Rxoi7r5WJw26FsFE1EW+cSNEdf0avqE5Iqe66Dy9aYejlIjrL3sZZXmtw3zruoreUHFagWTHFNLFiOYoK361VyI3a127Wvo+5E0MnCIwQ9ammGV6R9iitqp0dTnE7woGta4gxVJ7y5mEO92x5TU5HiHApbFHWWVZNOWULMnMwUgvEDoQHltzZ79OgCtLgzjGfoUsYwvZHAKdY07Y6+HvPSrCmf6u5/0vxT8sOm/GRs7VbcmNOrynfgA8tnTAciZUD5GlhxRC9MUxcfbN6pCdfIjAoUSgyMyuVBbG/Fr+L3EeLCFsTFjDCyxhE6FniU5jrn9+3LQVaIDpTXDp+9jHh9sEQCKPUusEP5huC1EXV5C5NH+CZ2R+j7drAm3XuCGLSi/gjgLdUkRp2nS9nUIEG1pKy9cQHV15ugoStZKC/XTwbOMeDKexiPNEip6WUlrKM7g6QWF1N4F7PMB+zz90G11T2eXg4jpgoFC78yvIIEijv2NFihsavj7b854jWS/2w1m7foj0XzARnkdp/+D+5CaeBFkkM7XIizrG42gnivMPSezeZtCwdTlxEyUqCu7vI3l9/zvszZ0G5v+LH/Oufk/zSlOuyJ/4ijjFt7vsljP9VR3AbXxD1DzGEuGY6zl7PmxTvVbu5vcrTbnMd+OL5hjY871ewPv7pzPK5L84BNOp45DrHqn6pMNkSBRa1DO6nFl8IWp3GKjWB4qFO28=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 JmdeCJq8IXtRR7MjZG3T0u3AYIHc+aiTtCUJlnN0QiIACSiv/imuc8oGWq+sY5g/r3RrmJqgntnQ+nzawNvaQPkUnWbWcBhzWYVbFlatv18bfwgNXKbe6yA8MYHPQK6LgZSL9ImxqVOxOXB27xa2lYPlCYSjodHf7OgQzdX6ryi2h1+YdjcNaLH60d/y9p3Nko5r0qWjFUpXdrq7qO1Gs1K0C6dIIhYR7f2scpDP3UoPcgARr+dJKP+0ApvG2BcKn0Mex0kPDeAxc4dcKd9iNDzW5bip8+mH5SIZQV2wAgBRxTDriwEHsh8CzV4m2IEIAKTxjFJt/zyLvDOJ3GunwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7808
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	35482b8f-3f61-408c-2bf9-08de7f686e57
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|14060799003|35042699022|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xBQWqWbaseTfocvLiS33NdvIHjFRCDev0zTyToEQh1z/HkyvRFRdJEzJSHuiLwvh9BN7e4bsap4ks2Nld/RPnUVApRM6dktFp9CNxraiLfD1jELNIgb53ByXoWerL5TsuY085++/0JgOYNoqb8iIED/RibLOb/XKE0q3/MFCxNx/VpO2INbmNnDFwfUoPXC/vXQfzX747kDp7B+e8M2UQD6wg5i7CGEaSrYFYupw7uLJW/tqG44IGOdKD6gqCQ8yRDEoaGa/K3N4ypvtKRcHpjMGRpw00EFeGrjTy5q6m4vYxed89opajvwrGdxbhacs2XkfN1ZCWN4836BDXT12Bn/21t2P0y43s5BxfEA4H/sCMluQjyoeU4QxRxYtiEdmdEUaLyuupxvuw+0qlKE2YAu+CmPChcvmZJp4E87f7Z16WzGPKGrqJmJ/FHZreTJfjX4HzJZ7uoTKO5AhwWzyvAP/bkbRCYK1Cy1T83KFjqpMc0bKcGxJuOU1ektpWaANgbdpuoz2xjXjUTOhhq9SmuF75PHZhSAifZklq3jjQdSWoRgU3s5B1gT64cEqvGqf+duRAg7AbM25EF2H/E38ApdRSuT7y1TG91siaXYncLMhwmQDsNsEAZ8woJhf5bb63rxk4diP3IGCX0qjImpPi65434mP7hH3DErOeoWInkW6HL+67FXrEepuibCHfngG+YP5SXZKh2olbJEsvKBuAWU5Pw1w40WNUib/6BiAwzVpcYvccY983GpKcmkGo/+r5kALaj7MOQARfrBHI2Txdw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(14060799003)(35042699022)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xFSxN39MDyfDfRjpx8pWkqXZm+XOqNOV+etuFkCbaNU5q3f/BybsZs9VRvIUS4PUYR10fO+F4LhZhc+m3KP50WvLyWG0y8y3znkKupyLX8q/y7fkAXBD7YGo8TcX9myCiojKv+ATlH+4DZN9x9eY8iY36Ez4PbzvwRKVSn2bodUhdO/wH+5W/cqvkooDucIYU+HUaWnyHiJmY33Pl8kcu5iOKIxZxQA8BfTDYSDQHK7ZN1OmWP2QH4JsViVt7/lpHzFPh5GiVK3xOgLnW36hEPLxSH09LsXHTj/svLUaPVQ+lgRsfASV3DqM0vA8dWmoe+hgy6+83NtbbWr4F3xb4Dpc2qV1W0gkeBrkCaw4H+FGZDLY/TYSQLlBNQ1fsSxo5ix98G01mF7j9f1peMgTcjavqhTz5gDhncDZqF/ZO/8UOOJxHxs5GZFPLEOCjhRv
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:20:26.8595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bff998f-408d-4049-c870-08de7f689400
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10972

On 24/02/2026 15:25, Jonathan Cameron wrote:
> On Fri, 20 Feb 2026 13:42:20 +0000
> Ahmed Tiba <ahmed.tiba@arm.com> wrote:
> 
>> Introduce a dedicated ghes_cper translation unit so that follow-on commits
>> can move helpers out of ghes.c without touching the build logic twice.
>> This keeps the object in the tree while remaining functionally identical.
> 
> I'd probably do this with the first move patch not as a separate patch.
> That would resolve the question of headers etc below.

I kept the stub as a separate patch intentionally. It isolates the build
system change and the new translation unit so all subsequent patches are
pure mechanical moves, which makes review and bisection straightforward.
If I fold the stub into the first move, the first functional patch
ends up mixing build plumbing and code movement, which is exactly what 
I’m trying to avoid.

>>
>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
>> ---
>>   drivers/acpi/apei/Makefile    |  2 +-
>>   drivers/acpi/apei/ghes_cper.c | 26 ++++++++++++++++++++++++++
>>   2 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
>> index 1a0b85923cd4..b3774af70883 100644
>> --- a/drivers/acpi/apei/Makefile
>> +++ b/drivers/acpi/apei/Makefile
>> @@ -1,6 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   obj-$(CONFIG_ACPI_APEI)		+= apei.o
>> -obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
>> +obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o ghes_cper.o
>>   # clang versions prior to 18 may blow out the stack with KASAN
>>   ifeq ($(CONFIG_COMPILE_TEST)_$(CONFIG_CC_IS_CLANG)_$(call clang-min-version, 180000),y_y_)
>>   KASAN_SANITIZE_ghes.o := n
>> diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
>> new file mode 100644
>> index 000000000000..63047322a3d9
>> --- /dev/null
>> +++ b/drivers/acpi/apei/ghes_cper.c
>> @@ -0,0 +1,26 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *
> 
> As below.
> 
>> + * APEI GHES CPER helper translation unit - staging file for helper moves
>> + *
>> + * Copyright (C) 2026 ARM Ltd.
> 
> As before. If there isn't significant new content copyright doesn't make sense yet.

I can defer the copyright line until there’s more new content.

>> + * Author: Ahmed Tiba <ahmed.tiba@arm.com>
>> + * Based on ACPI APEI GHES driver.
>> + *
> 
> No obvious benefit in this blank line so I'd drop it.

I'll drop it.

>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mm.h>
>> +#include <linux/ratelimit.h>
>> +#include <linux/slab.h>
> Build includes up as they become relevant. That way we can see whether
> they are needed or not.  Right now none of them are..

I’m front‑loading the includes that the subsequent mechanical moves
will need so those patches remain strict cut‑and‑paste with no extra 
edit noise. That keeps the movement obvious and reviewable.

>> +
>> +#include <acpi/apei.h>
>> +
>> +#include <asm/fixmap.h>
>> +#include <asm/tlbflush.h>
>> +
>> +#include "apei-internal.h"
>> +
>> +/* Helper bodies will be moved here in follow-up commits. */
>>
> 

