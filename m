Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011040.outbound.protection.outlook.com [40.107.130.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFA42D94A0;
	Wed, 11 Mar 2026 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.40
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232819; cv=fail; b=D6BApSaYHPkZOFCybNrq1IfS9ibBE9qhMKhSNhvhIMehpKhw6UqxkigrwtAskHuMfFeLz7KumtAnjNDbQqcVX+E2+y0dBKRJZlXwXfuejVMqXW2TeKCr+lSN/T/3BnOaS8Co4t/NVEica9bjz6KbA4RkO8Z877QLky6WLcDfEls=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232819; c=relaxed/simple;
	bh=jbGRl4PryE4tDt93b9Ia/mxFB4KB2GD+qrD2gjuWvQY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pI7fKFbjpShP5D7ittGg2d1CefqVKaiYVkDdC+rL97nVQcKiY+b1ncPTNWzV1Hs7wxvi/TVeI1DB4jsuRKd3JUKGnMnX+T1yob3bGz23GqRnQMqmkXD0UiOMF7vk89NP4Ts0e4yef+srI58S711CzmNCf3u22rId33J3pQpqRkU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cNPSpKLj; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cNPSpKLj; arc=fail smtp.client-ip=40.107.130.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cNPSpKLj";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cNPSpKLj"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=o/jCm6twYoKmENuWrbsre4SvNfUj/NokgrbzJO/Vz4zbVAuCMDZjR+80ieJLkiWxarM0bNj+GSQC2UKsDYMkR47iej4Woh3LCyvMP7FXgjeSVtONRUFoloOY8szr3e0yd7p8pIXygK9DrBYoHVsz2bR0jffK6DFDt+rimMd9ElOzNuu3RNhtyt5+zpRPHGxG4/nvwoVtcSygkT3758Y4OsuKkQUUXVMNz9jkLkbMMCFAny0TOIHeItYFSEUse8b9P/Hr3OSNSLXVL353i9Ap9UQWJXDYAEj6G/kgIna2yLrl5NAwQHzflpJIjTCixIIQPx26BdO6C3awq0eXdu+iyw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RbuDHtEJH1UAr9Gl8WOZMMDce5+dp+w4DDehgWOVBU=;
 b=v8i5HlOFu+AblzPda1mo1NPQx1oWGcgny9olaqmqyWOiz6g2WwrsmqbcI8dVfKvlUm8+o9tAaTyKufzrYPo/q6dcydZ959YJ4bQ+8hQJEVV34tG91N36WViImpJGQWNu1YGPty8E6tj3xvhU2CB7AFpgqAVXNKLqIZN53jIQ5KH3iwZU8SETaHhv9B1ZwOC1piLtHh2ueLcQ4NxvfgMboAVOtEv8/xFrPiRZdnPoh+oELWM+Uoi1sRC6zSXoV6pVs0bmJtB2D5KtID3S3SX8Hsji7DBp8uvHQJ/NS0+9bYQ19yDXbLOIvVzBwGyPka+J9gbZmNzSKEBfeI16jRt50A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RbuDHtEJH1UAr9Gl8WOZMMDce5+dp+w4DDehgWOVBU=;
 b=cNPSpKLj/86Id+ruqV8QWrSJsPufxNf2PqNKBk84s1ejXwneJaKhV8YcvS9NNdLgxkGGZTtpW6/Pf23TKLvYNBjoRUqbNl1Pzuw1jZXjLM0t7LYLMxs3JxAKVzxMb1at4Ni1yDpjVgS0AjEQSPQVhbbzFUWDW0au8cEYRrsmiec=
Received: from DU6P191CA0024.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::14)
 by AS8PR08MB6566.eurprd08.prod.outlook.com (2603:10a6:20b:33a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 12:40:10 +0000
Received: from DB1PEPF00039234.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::4e) by DU6P191CA0024.outlook.office365.com
 (2603:10a6:10:540::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 12:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00039234.mail.protection.outlook.com (10.167.8.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16
 via Frontend Transport; Wed, 11 Mar 2026 12:40:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Za/sjSJgd07bhVyf4ZvVaTXpadXbxswRYWkGUTaMPubKPt3hclMcQ9LI4h/vH9M7AvkK0oZ9Zb9la7O9IoixMXQZ6MmkdsUlxe9HyEvw2xSlTyTonIvsE14EdUcOA6c9SIPtbthOLnbuzlOur0yucGwsQFyclsGYPewfV8x9U4z+Tmpox1Fjj7nxZXx84uONibd1daqu5JoonKQIYLVGqyazxLHBrM5wAy+iYaYj/GPFZarQRH+rTQFZxLd1gGsJYkAkQ8J5mKUd7JjIg3XzLX/XilI5cE1if99h/WOfjk7FjkIwkWFyIOd786L51lmGCWaP4lmDu5wenJ5FDlYCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RbuDHtEJH1UAr9Gl8WOZMMDce5+dp+w4DDehgWOVBU=;
 b=gHhVduWcnDWR3Ec3KhZwSHlW1/u4BqrMZgXx8KLVO7Ilb4XGSahfv4Ox7CXWx10AAsQC8fIDQFm6dAdvR16uUA0UzDERXdYsAqwLEtnP8RPdGBc1kB2N3VOQsYqeB3xOnkFsdRaQ857L5+W0tOqGhJn05bFmLI7rqGMY70s3FnPpJm3tA3qjxIDxh92jy5JvLxiyvhWQ6xHpm+6fUI74JO4xcg0LwEiC5oO4ozZqZJYG3Up5gXAOc6dzqap2CLWRRnT1ZDF2OgwgIuNA6WIU6aaI5sLXns0hgBfnaVmdfYAipAdxTLM/xdCbaNH+12IpMbzagayEu8KHsuBdLmvCkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RbuDHtEJH1UAr9Gl8WOZMMDce5+dp+w4DDehgWOVBU=;
 b=cNPSpKLj/86Id+ruqV8QWrSJsPufxNf2PqNKBk84s1ejXwneJaKhV8YcvS9NNdLgxkGGZTtpW6/Pf23TKLvYNBjoRUqbNl1Pzuw1jZXjLM0t7LYLMxs3JxAKVzxMb1at4Ni1yDpjVgS0AjEQSPQVhbbzFUWDW0au8cEYRrsmiec=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by PAWPR08MB9639.eurprd08.prod.outlook.com (2603:10a6:102:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 12:39:02 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:39:02 +0000
Message-ID: <b7c95e33-c427-42be-9ea9-99b6556f266e@arm.com>
Date: Wed, 11 Mar 2026 12:38:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] ACPI: APEI: GHES: move CPER read helpers
Content-Language: en-GB
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 Dmitry.Lamerov@arm.com, catalin.marinas@arm.com, bp@alien8.de,
 robh@kernel.org, rafael@kernel.org, will@kernel.org, conor@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 krzk+dt@kernel.org, Michael.Zhao2@arm.com, tony.luck@intel.com
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
 <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-3-347fa2d7351b@arm.com>
 <20260224153221.00000420@huawei.com>
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <20260224153221.00000420@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0294.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::18) To VI0PR08MB11823.eurprd08.prod.outlook.com
 (2603:10a6:800:324::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11823:EE_|PAWPR08MB9639:EE_|DB1PEPF00039234:EE_|AS8PR08MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a343f1f-a932-4589-b072-08de7f6b5560
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 WMmp8ZjQFuP3WbTrliQfjuYsWezRto1UH1CV3RY1XCxurDqkcYCHTt48WAKuGTT3PxgCThKbjsuse4MFNpORQRR3w544q30ruX18eni2mCBGYCVaJwEwRyvzaMcN2Eu4Gx9PO/sAIgBsLvYcCZa+FOuq2BW2IWC6Ovbq5ddEvrOFWM04zCy97Kwi50+103J57ENmBI34pv80dZ5Y3mik2E55KpvpJ40UoqzqyUINgxCjXIb0OmZcOyVZNZmr6nTHM1NDDJzWX8U5Ns5KrfoQ3G/vKUt667Sj5KZdvGmBdog5bkr3oTzbhHif7GiwdFSkC9huZBUNPYRTQ6skYdqnlDIML6gnta28F2CUbMGKQlc2wXnFbTewCe4G6z6u7RHUKZWQxiMOg9qRkq7aCpF4Zby69xNR/PBDMFu8h/cWPCq+W4zKD6fJHjo1lo/42sGAhmmhHqgD21ljm0Gyf3G1dEvZzfW9Eq/evEh3daaSX1wiXCJHOxl1RpztEgKGO4Vt5ox9Dex6bAq1IGmSarHIgFrU/5UfYAu9gk3Eyc0MN4rCOT9cP2qqYsp2gJsdEPdmgZBRphD1DefwB1e8GKyDDLPxYSZO3j0hp9ja02DWAZ/bpaBCh3CkPy7Gu7DA0ZcravJzPo0KM/fv1VzrWbtWO/5eOn1pTo/zC/XyMHivOeL8ZCHA3ULS2iueMCy3xJVUAGcQOTBgxARWojut7KWfiNFkvsArEvdhIeeZ7mTy1SM=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 n+s2KMXdU0dUk7fbj1AGpB2RWMouFRJCA47L8RFEA9Hsaj0Q9cHDIaCFHIa3AtNIWRI3h4K4KGwTu0BRqnGPOiTauIOCbxdFLOGKCfLEwxNye6wp4sCkbh5KJBiXEvy6Izwdx+32cLUWvxNTw+AR77Un7FBtbS2sMKSmg34zoj1D8i45M7y6+G3AwqBfxKGCaMKMgSPpH6dYEvtClbhJ61lsI0KefACyyI2nKcJLw0FtV7xSbRF20B7YpAAl8E8nOR0MG0mxjGQr3iCykP99S35Xe9xGB01UP5PdOen5D8gcmt2GAp28kxJgSsHMIe2OkKyOIuIBttQJkH9K2pDl5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9639
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6eb1a4a2-3580-4b05-76fc-08de7f6b2cf7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|14060799003|36860700016|35042699022|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	s4gYjuHI9juKtQCxt0ipnI8PntrCA7iGoo8WwhTEi2rcs2Ty1MOVSqbElTQX9NR/6qOVeldqpueUdir6TyVlomt6gAasCMe+b6L6ivUazrwwCCs0MtWPrSbql/4hpTr0W+2F0d58pZ8zB73wPNh7wWZuOXqiI25pRTiEgU2anJpo/wf0geKIzu4VrXYamlteCXF6FSrDmnLlm4VqUOivBUnMiuqlJPuzxt+rs0HzbUzlCV/lLvVYnKgM2n4RDT6NYa1aHLwaQjEGot71UJzzGpub88SjNgXeyJ27uP7MmKr/yI025jy+mu5tbJPmg4xm2YaOJkMXBMlVqILjXkC5dUjAz8G4RtdaoKTMeIx5NLUFeU2LNA/KfB3TgCfOlQj6qcsOivoqGLJDvIfxt4/uLv/2G406uMrDQN7PPKCl9zOGOcZolgF6lr34FWZFthtqlfTzWBIEPp/0/+5MpFGHykial73AHQg0X82/hQU2cGvw6V2f79z0sYeCIMJPsdTi6ymFw3zFEZ4rdT0m97klo/MrTplUzt80xR5kuKH4XVHdTlOC+x5u0UdGt5VnnT2NbTl/Yid2MhJil827GALq3EpoyqXLudWH2zhgIyFBJEPRnIiawfoABj67tdsyFRzreRJ6UUnZe68FYNC9sOYrdZATSQuC0QkxBnw8Y2H6Kvcxp1kptQ9u4b9kaxVwj9q/htzhCXt9H4e+RXcp96CZVAe/uCvYyfWxsu218cHjYUFABfoLIiNs9bO26y89rpGFIqeCb1iWmQ3VpYV3BbLxtQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(14060799003)(36860700016)(35042699022)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Dlq+89TJZY6wwzOD4WGqNC7lLaDSP+p2KV3ExUL+l+HfOxJfyZzBTbTNU7ZdTsZ0udOugJbIii84jS3cbPk3NJIUtoUGaiWsEdLxuc0wlu3f1AjgaxEyhg3Gfzbg3m5pPTmhfuPNMgZNdX148dufLcKUrZ3a1tYHDCDcBKOmqei7TrtB/CWoOMDMZxBuMgnAkXPzbp0pz8qnSM2jj33x8R1ZR4S6/A6TMjcjnl7nM49aprLuBYa1lPOhOP21Au+sZBTnzU86cwey+llnSiaKayn+GaRybAiGsy9oCxVu0EpBGLR6dJRdY6XBGaJT7QOuaF9fy3Nx11Cgn7qMcoGB3upmEMl3R/onJLNIyWhkeMCjQe6UTq9Amy6jWezQP2e4wxvRVm2WcLZuB7pw70MVcqCuCOkP3LT8m+hbOp5QRiUNGKBxy5x8tzb4RaopovCs
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:40:10.2560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a343f1f-a932-4589-b072-08de7f6b5560
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039234.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6566

On 24/02/2026 15:32, Jonathan Cameron wrote:
> On Fri, 20 Feb 2026 13:42:21 +0000
> Ahmed Tiba <ahmed.tiba@arm.com> wrote:
> 
>> Relocate the CPER buffer mapping, peek, and clear helpers from ghes.c into
>> ghes_cper.c so they can be shared with other firmware-first providers.
>> This commit only shuffles code; behavior stays the same.
>>
>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> Hi Ahmed,
> 
> Most of the comments in here are about changing the patch break up.
> Basic suggest approach is move stuff as it is needed, not in advance of
> that need.  So when you move the function to the c file, only then add what
> it needs to the includes / header.
> 
> Jonathan

Thanks Jonathan.

I’m keeping each patch as a strict mechanical relocation so reviewers 
can diff‑verify the move. That’s why includes and header prototypes are 
introduced alongside the moved helpers, not later.

>> diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
>> index 63047322a3d9..7e0015e960c1 100644
>> --- a/drivers/acpi/apei/ghes_cper.c
>> +++ b/drivers/acpi/apei/ghes_cper.c
>> @@ -1,7 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>>    *
>> - * APEI GHES CPER helper translation unit - staging file for helper moves
>> + * APEI GHES CPER helper translation unit - code mechanically moved from ghes.c
> 
> In the long run, no interest in where it came from. People can
> look at the git history for that.
>

I'll drop it.

>>    *
>>    * Copyright (C) 2026 ARM Ltd.
>>    * Author: Ahmed Tiba <ahmed.tiba@arm.com>
>> @@ -17,10 +17,176 @@
>>   #include <linux/slab.h>
>>   
>>   #include <acpi/apei.h>
>> +#include <acpi/ghes_cper.h>
>>   
>>   #include <asm/fixmap.h>
>>   #include <asm/tlbflush.h>
>>   
>>   #include "apei-internal.h"
>>   
>> -/* Helper bodies will be moved here in follow-up commits. */
> 
> If you just do the file creation with this first move, then we don't get churn of
> comments like this one.

As above to avoid churny commentary.

>> +/* Read the CPER block, returning its address, and header in estatus. */
>> +int __ghes_peek_estatus(struct ghes *ghes,
>> +			       struct acpi_hest_generic_status *estatus,
>> +			       u64 *buf_paddr, enum fixed_addresses fixmap_idx)
>> +{
>> +	struct acpi_hest_generic *g = ghes->generic;
>> +	int rc;
>> +
>> +	rc = apei_read(buf_paddr, &g->error_status_address);
>> +	if (rc) {
>> +		*buf_paddr = 0;
>> +		pr_warn_ratelimited(FW_WARN GHES_PFX
>> +"Failed to read error status block address for hardware error source: %d.\n",
> 
> Unusual indenting.  I'd just fix that whilst you are here. Don't worry about long line.

I'll fix the odd indentation

>> +				   g->header.source_id);
>> +		return -EIO;
> 
>> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
>> index 2597fbadc4f3..2e3919f0c3e7 100644
>> --- a/include/acpi/ghes_cper.h
>> +++ b/include/acpi/ghes_cper.h
>> @@ -74,21 +74,21 @@ struct ghes_vendor_record_entry {
>>   	char vendor_record[];
>>   };
>>   
>> -static struct ghes *ghes_new(struct acpi_hest_generic *generic);
> Huh. Static forward declarations in a header?  That never made sense. Fix it in the
> earlier patch and remove the statics from the declarations.
> 
> Actually no, just bring them into the header only when you need to. So as part
> of the patch that moves the caller or the function.

I’m keeping the GHES‑CPER interface explicit in one place.
Moving those declarations later would scatter that interface
and make the mechanical diffs harder to review.

>> -static void ghes_fini(struct ghes *ghes);
>> +struct ghes *ghes_new(struct acpi_hest_generic *generic);
>> +void ghes_fini(struct ghes *ghes);
>>   
>> -static int ghes_read_estatus(struct ghes *ghes,
>> +int ghes_read_estatus(struct ghes *ghes,
>>   		      struct acpi_hest_generic_status *estatus,
>>   		      u64 *buf_paddr, enum fixed_addresses fixmap_idx);
>> -static void ghes_clear_estatus(struct ghes *ghes,
>> +void ghes_clear_estatus(struct ghes *ghes,
>>   			struct acpi_hest_generic_status *estatus,
>>   			u64 buf_paddr, enum fixed_addresses fixmap_idx);
>> -static int __ghes_peek_estatus(struct ghes *ghes,
>> +int __ghes_peek_estatus(struct ghes *ghes,
>>   			struct acpi_hest_generic_status *estatus,
>>   			u64 *buf_paddr, enum fixed_addresses fixmap_idx);
>> -static int __ghes_check_estatus(struct ghes *ghes,
>> +int __ghes_check_estatus(struct ghes *ghes,
>>   			 struct acpi_hest_generic_status *estatus);
>> -static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
>> +int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
>>   			u64 buf_paddr, enum fixed_addresses fixmap_idx,
>>   			size_t buf_len);
>>   
>>
> 

