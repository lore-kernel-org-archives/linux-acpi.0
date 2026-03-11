Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AFF37188E;
	Wed, 11 Mar 2026 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229262; cv=fail; b=UE2t8HWinf/Vvq5bLUyV0osvVHs4kp6lGrC4IWW5WMoy6cvOv+duguEdQ8hlRrpTQDExRlijpiW9wdUq/Oti/vPVz3UcEW1IXTdWwBtIN93Xk81sQ0oAqidITPc5q/Kr9dCafw5TEpa5ym1LqWiSs+DJvqI+2FnLRlIerbS35zM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229262; c=relaxed/simple;
	bh=vkrKRUs3I3VUtj3w4LBcSR+zdgHIrJuMwBJLl9MhaMQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CpcfgCkysVLWSUzCOLs36cbQukol5jRaXozoKXP3ZqPqNfbTkxwsE0baNHjp54HU7p0tOeTNrE7aCZpFqBx7LqN4aRJhVnFYkXRXMoukGTl4F4u/BI6IIDStfYI17U2An+MG8iAt2E6pTQDoMCdWdeMTil/KeUYZuKLfgyuGeLA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GOBLaAhy; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GOBLaAhy; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GOBLaAhy";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GOBLaAhy"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cYzuMNJBPG80t0DBkjdAV0GUFVyCKYwPJjB+HkFTqGGvMu+Yd1aNSjuQ+jqhrPUiam7JPkyHlS18lDZfezGDAxMMwvMtJ8GgftUFF4pYH92VNybMfOd4yEtTEgYanEiytOHbKulKy9dhOk2h8UaDLZnZ+vaU6z0SxVvd4hYxWkDD1ALxBxLGeANIZN/w6tpHywhGYgpLDQ/YGZrJJPdv6u2D0bEOlAwOE0OMcXCIZiYulklTsp1XPtVREp0s39Hunv1GzC7mqBLoDbq95v8XayUL6KQ9vv7Pmjco8p+jSOKDaWIqw+pft5tQJbNNEUM71t/7CWVJHjAwWUvCssiGKw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa/RisfZLNSuF95ipY/GAhv5+je8swhEyaMGsJQ/NL8=;
 b=q/GhUuuDCDZE4Np1JF/3dEi0Sv46Jr2QLUjEGKCYht+idiKQ00L+NE5jQcBB/hafCVXGj3lI5++JabcXFXu5jLB9DyjOiPem9Jx4Nzi8eJZsxQ6lt3wcLU/0gv92bJJgWN5otxqj8vdViBp90sa7pq+0fLIAqQqu5dHkOmZfLzWsvfYGK2ugspDgEV0vbEfAL5BYRolLGIbljQ01RUdGFmhhoob88lirake3EpxuDAyYgSoC3xGRpcIsiKC7cKRP1tl7DgrJcEzmoYSfqu1v1in/nU5HfVpDWLwK8EMF1mujlcNkSL9jB1QK38oevqwofFlqtn3QTsTIgPe2mLLWtQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa/RisfZLNSuF95ipY/GAhv5+je8swhEyaMGsJQ/NL8=;
 b=GOBLaAhyzpw/8Dc+B/D56sn0Pwmt53/0ciE9GwsjBXSey/uKdm/zALH0cNA8iutfi9eKEOCTydjeVtwoOWENSU9tI30yO+vpsf4K8dxHoJ4Eq6QLnN/ekk2Zso0oZl0SIMdIv8X+5gI1UdTripqUT/JeA22ehwmJ9iLq25IXaLE=
Received: from DUZPR01CA0339.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::17) by AS8PR08MB9386.eurprd08.prod.outlook.com
 (2603:10a6:20b:5a9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 11:40:46 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::19) by DUZPR01CA0339.outlook.office365.com
 (2603:10a6:10:4b8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 11:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 11:40:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlV2o9FtihgOFU9oCeZpW7tKiQXy95cUi99yNSkBnjSGlB14APGtmdnSLGjJlu2XEata1NQCF+2WIag8vZOW8LFjI5EYMRs7kUPxdXRYIDCRoUPGdptn8dG3SxmXusCuDW0g51B42v2RHs5afea+l+S7dvPycQmaV/SmfVzoaMRKaZgQadDDIhN1jMJRNwcH4PXf1nSN5WGE3gJ8tiibW9vs2VCrOb3f4Ok7NnIYevukSP5yK+uIUe1WOQ7MVmZgvo8070Gz4/hhF8f8DyDgO3c5hEdeq+/qD8FmDxRg8zaXlS0n6SI3iEg2l49AEbSaQFskA8oM2NKqSVydI+MabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa/RisfZLNSuF95ipY/GAhv5+je8swhEyaMGsJQ/NL8=;
 b=CFOix3V8S6uUK3kUvADB52ySXMUNVLXc0NaMafC5B2ggKUUudqvH4XpzY74BRK2um0ljV17EEYslexAUI0MOhlmoAxw93ixplP9IyWi9H/2+O6g1YxQL0VDRi4p26RVwGHITxKpkNHHZWgUHMbgh2MWIWOtIqR7U+Is7hxX6r4WGsBpJ+OhyflTj47CHlIWI4AVQTl99MsuLfkp5lfgSmax2vb1GIjDTZujo35tqQx6mCX1oNh46GNsthvYvyDCMF6SktLU9+t2VgC+U7814Yj9B6zXeCYM80LLZatJkFwryC5OkWKLpWPvGJDGgTBnekwtnKWctfB9yE1UvhiLg7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa/RisfZLNSuF95ipY/GAhv5+je8swhEyaMGsJQ/NL8=;
 b=GOBLaAhyzpw/8Dc+B/D56sn0Pwmt53/0ciE9GwsjBXSey/uKdm/zALH0cNA8iutfi9eKEOCTydjeVtwoOWENSU9tI30yO+vpsf4K8dxHoJ4Eq6QLnN/ekk2Zso0oZl0SIMdIv8X+5gI1UdTripqUT/JeA22ehwmJ9iLq25IXaLE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by AS4PR08MB8000.eurprd08.prod.outlook.com (2603:10a6:20b:583::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 11:39:42 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 11:39:42 +0000
Message-ID: <d0911510-9f87-49ed-b896-fa00e5d2a98b@arm.com>
Date: Wed, 11 Mar 2026 11:39:38 +0000
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
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <20260224152230.00000531@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0064.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2de::9) To VI0PR08MB11823.eurprd08.prod.outlook.com
 (2603:10a6:800:324::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11823:EE_|AS4PR08MB8000:EE_|DB3PEPF0000885B:EE_|AS8PR08MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: c49633bf-ed7b-4b9a-c77e-08de7f6308dd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 K5FBnEzAKyK1RB6HszHEuKCHMonZJ2Fs2az1jppQBH3pBEbUA9OdgPJjpNyPfYUDmOYo6l2KWtbY1NS7ctm53faWszUlkfLDLqs7Bn1RBNW/QKasrTzGuVShdRwZAyeWk5UHbQ88ckHuSjlVmaDKT3lmsKd9TSkQ2KNjrxX1Bb/5xnQSmdA6cGKRk2GP16ecuKydLUDJ2itTp+qAhfAJynl+hjICBq3pVrpHfTJi2q0FNsNR2AbOTCOUYUrovbxQztaH4sNQHgFzjN3JZ6V2mu6r6mrPmD3Gw9ygcviDM1tRmsJduo/5Px4cVjrrBByjrJWYrmbWrfHpXte/qvZNpW0gpZJsaTmWOak7POxr3+6ML0/2Is/bCvCYYfgRp8vZ72SxRnX+6L72gvZVBhxy9+T3LnaBK8xKZxtPBzGMKzoKaVA7hH2B0sXJyuiyBV0SgZpGWwhQs9LDQN57vXTACULgqDrsNh4p1FUI5Dkp/jwhdfmX5vrcs4o8SK1X/K7XRQyQScnvNRDB52aMl5JC9ldeO3L6EE8uwFjmwJcW9Efl+ySUcQ2mun/Xir/NWiyBxRCVXaDpCgEH0qKL3aK6r4PLo9Kvxu87jHL4fpMvGUQ3m8qJbYZcVG5FJSzxyAXkGMFcxPy6ewWVya3S8f1oF7lMGJ+yQHqzPL6S5OTHJ4rYrWcl7NtDEVtHVsScfBYDrqB3GFft5eHGwRwsxaFHa38HD5rJtbpIrfgDrdy0vM8=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 P5Ywbn9v2MjIpN7cpqjJq8feyyjA6IrLaWazv5Yqu0fDp3tIl++rFGhoRBaT01ur+yOu2x5+/jpTGUprCaqwI3sff130SnzX+7t0NLI0BUvpR0FBBt0WahH3HTf3RBgngzl+WyWVn5QAcdaEBrDKWqxSYxIQ/tZixTrJkJVu0mB9ekCbrtvdThhJIDRfyl/BZOXxeIzI/ZYII36BmiRGbVohhGHdk7R4ZrM9hevoL9pK8KOoUJA0kr46bW2BS5otv+MS3Sp4SfJgodXwO4rz0zDVb3Yh5BF6SpoRC9bjDgQpkcZHthv8hKDYi6x7VQubZk6sjwFXmfWpDE8WjUtdVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8000
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2a32df4a-78ab-4c58-d5bb-08de7f62e2a9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|14060799003|7416014|376014|35042699022|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	n53AIgEZnktT4Z6QR2txaOaZwFKo55w2Z46gHJ9InKmSPyqJtL5+LkGnQ/VdF3HtWYVpfas6/NNhzp/XSc5B5tmhV7ssB/rZ11yfgVEfyIxtcny2njLltW4kUc+00NQ1Hl2zdT220xpEY4sp8U01+4PR1mCnf8d7vR07OTSP8lR1R+Vj4BGcVXxEm2wsfVM7+pORZb99QWGDh7WFFZDYJ39PJsRMwq7DwvHzLm2VqDe5UryT8jiuRsT44T9Om0mRGEkd8/+cVJBUKICC2VbtXF3UX9kQK/rMzYyZt28MKu2lu59i+9UqhlGWOX1zgu2NumBHUwhhsAaMcX7PYuf0aYdefuv4Ha6Bj5EwX0WY0J3zuMyuxFuRON1S1UFnoSKpTHztrT6vYBF6Bnapuq447zCZVmYSz6UVXliHf0xKuHj8dliJBLLhvU8+Rw3186BcUdVpgDM1t3LtWeCF2n26EAiuVNh8o8TG+pTU6f048gltcGGg+LYI/2CN2GcgIfAKfQT5doumEpESEVotjs5kcCQ4gneNs9bb3bwiGIlHpiNwpOOQrozRyepOKVj4HGwu33RD29yVh+lu5M2R9ART+7CtJ3ikqBIrK5z+GAFMUvXD2wscSHN9V5MsX442I6x/6HED6IgcaYQ/PmxP+QVYXrT3Td7mO60O1FaLP6YI9KFrL9oDN1d/2IP+DEateBao/4g6M6d4jgkKbnCeQIlhZFDUpWw0UEFzFJKxCaVJEbaYxP3nTdvKbHx+GY1kvFfOgGyDCBwRtcm2D/4faXZXSw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(14060799003)(7416014)(376014)(35042699022)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7EQkZQlmC0tVXJlOqWrqgDXJXJ9OP7Rl2IiEmkXwoyVZtovSGeWqYPEaeMG6Xy4/gVQAeKrKnFH5EHAr8AY4wX1+3F0zUZgf97YM/S9ZjPD1HL2U+l9VO+IgQUrvBqZtBmF+mgLNOwmaA3hbdfkFd7lZQUpxju6EyQZH+UMPM/1mZ6A7apLhBoyaemI/4nL3HYrekbogfGYu6lmW8DS6EZn0T3QHUbQZSoHAWgwpHoSAGUVMRVIT/2OiSBhtwsVLrVnAYistrYnjKGJacvsflL2QgdYN6y2g7UNN6XZMXFR8KEI0QIi7lKkyp3hZ79U+R351XnH+ydU0NCd1+HDwzSxaH5AcfAh+L1tyi+O/teNoCsjTOvNyTtZso/NbMM92YbwOj5UZ81eFV56TTtK3yDRp572IYyY2xtym6yAyj9qUqbKfH4Uio2oBguJ+o4SO
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 11:40:45.9238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c49633bf-ed7b-4b9a-c77e-08de7f6308dd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9386

On 24/02/2026 15:22, Jonathan Cameron wrote:
> On Fri, 20 Feb 2026 13:42:19 +0000
> Ahmed Tiba <ahmed.tiba@arm.com> wrote:
> 
>> Carve the CPER helper macros out of ghes.c and place them in a private
>> header so they can be shared with upcoming helper files. This is a
>> mechanical include change with no functional differences.
>>
>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> +CC Mauro as he's been doing a lot of work on error injection recently so
> can probably review the use of the various structures much more easily
> than I can!
> 
> My main comment is on the naming of the new header.
> 
> Jonathan

The content is intentionally GHES‑specific CPER handling,
not generic UEFI CPER. It's the GHES view of CPER parsing/handling
and is used by the shared GHES/DT path, so keeping it in ghes_cper.h 
documents that boundary better than moving it to ghes.h (which also 
contains non‑CPER GHES logic). The helpers moved there are the ones 
needed by the shared CPER handling path.

>> ---
>>   drivers/acpi/apei/ghes.c | 60 +-----------------------------
>>   include/acpi/ghes_cper.h | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 96 insertions(+), 59 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index f96aede5d9a3..07b70bcb8342 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
> 
>>   
>>   static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
>> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
>> new file mode 100644
>> index 000000000000..2597fbadc4f3
>> --- /dev/null
>> +++ b/include/acpi/ghes_cper.h
>> @@ -0,0 +1,95 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * APEI Generic Hardware Error Source: CPER Helper
> 
> There is other stuff in her usch as the GHES acks etc
> in ghes_clear_estatus(). So I think this intro text
> needs a bit more thought.  The boundary is already rather
> blurred though as for example cper_estatus_len() is only
> tangentially connected to cper.
> 
>> + *
>> + * Copyright (C) 2026 ARM Ltd.
> 
> Doesn't make sense to ad this copyright in this patch as so far
> it's cut and paste of code from a file that you didn't write (at least
> not in 2026!)
> 
> Might make sense after a few patches, in which case add the copyright
> when it does.

The file is new and maintained by Arm as part of this refactor,
so I kept the header consistent with other newly introduced files.

>> + * Author: Ahmed Tiba <ahmed.tiba@arm.com>
>> + * Based on ACPI APEI GHES driver.
>> + *
>> + */
>> +
>> +#ifndef ACPI_APEI_GHES_CPER_H
>> +#define ACPI_APEI_GHES_CPER_H
>> +
>> +#include <linux/workqueue.h>
>> +
>> +#include <acpi/ghes.h>
>> +
>> +#define GHES_PFX	"GHES: "
>> +
>> +#define GHES_ESTATUS_MAX_SIZE		65536
>> +#define GHES_ESOURCE_PREALLOC_MAX_SIZE	65536
>> +
>> +#define GHES_ESTATUS_POOL_MIN_ALLOC_ORDER 3
>> +
>> +/* This is just an estimation for memory pool allocation */
>> +#define GHES_ESTATUS_CACHE_AVG_SIZE	512
>> +
>> +#define GHES_ESTATUS_CACHES_SIZE	4
>> +
>> +#define GHES_ESTATUS_IN_CACHE_MAX_NSEC	10000000000ULL
>> +/* Prevent too many caches are allocated because of RCU */
>> +#define GHES_ESTATUS_CACHE_ALLOCED_MAX	(GHES_ESTATUS_CACHES_SIZE * 3 / 2)
>> +
>> +#define GHES_ESTATUS_CACHE_LEN(estatus_len)			\
>> +	(sizeof(struct ghes_estatus_cache) + (estatus_len))
>> +#define GHES_ESTATUS_FROM_CACHE(estatus_cache)			\
>> +	((struct acpi_hest_generic_status *)				\
>> +	 ((struct ghes_estatus_cache *)(estatus_cache) + 1))
>> +
>> +#define GHES_ESTATUS_NODE_LEN(estatus_len)			\
>> +	(sizeof(struct ghes_estatus_node) + (estatus_len))
>> +#define GHES_ESTATUS_FROM_NODE(estatus_node)			\
>> +	((struct acpi_hest_generic_status *)				\
>> +	 ((struct ghes_estatus_node *)(estatus_node) + 1))
>> +
>> +#define GHES_VENDOR_ENTRY_LEN(gdata_len)                               \
>> +	(sizeof(struct ghes_vendor_record_entry) + (gdata_len))
>> +#define GHES_GDATA_FROM_VENDOR_ENTRY(vendor_entry)                     \
>> +	((struct acpi_hest_generic_data *)                              \
>> +	((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
>> +
>> +static inline bool is_hest_type_generic_v2(struct ghes *ghes)
>> +{
>> +	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
>> +}
>> +
>> +/*
>> + * A platform may describe one error source for the handling of synchronous
>> + * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
>> + * or External Interrupt). On x86, the HEST notifications are always
>> + * asynchronous, so only SEA on ARM is delivered as a synchronous
>> + * notification.
>> + */
>> +static inline bool is_hest_sync_notify(struct ghes *ghes)
>> +{
>> +	u8 notify_type = ghes->generic->notify.type;
>> +
>> +	return notify_type == ACPI_HEST_NOTIFY_SEA;
>> +}
>> +
>> +struct ghes_vendor_record_entry {
>> +	struct work_struct work;
>> +	int error_severity;
>> +	char vendor_record[];
>> +};
>> +
>> +static struct ghes *ghes_new(struct acpi_hest_generic *generic);
>> +static void ghes_fini(struct ghes *ghes);
>> +
>> +static int ghes_read_estatus(struct ghes *ghes,
>> +		      struct acpi_hest_generic_status *estatus,
>> +		      u64 *buf_paddr, enum fixed_addresses fixmap_idx);
>> +static void ghes_clear_estatus(struct ghes *ghes,
>> +			struct acpi_hest_generic_status *estatus,
>> +			u64 buf_paddr, enum fixed_addresses fixmap_idx);
> 
> I'm not sure some of this makes sense in a file named ghes_cper.h
> Maybe we just need a different intro comment though.
> 
>> +static int __ghes_peek_estatus(struct ghes *ghes,
>> +			struct acpi_hest_generic_status *estatus,
>> +			u64 *buf_paddr, enum fixed_addresses fixmap_idx);
>> +static int __ghes_check_estatus(struct ghes *ghes,
>> +			 struct acpi_hest_generic_status *estatus);
>> +static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
>> +			u64 buf_paddr, enum fixed_addresses fixmap_idx,
>> +			size_t buf_len);
>> +
>> +#endif /* ACPI_APEI_GHES_CPER_H */
>>
> 

