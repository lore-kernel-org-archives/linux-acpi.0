Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795424533;
	b=lLCXLBcsDWUbpN1rSLqE/vtK5MBR+R0qrGkC5M1AdBTpLV9qud4N4pMJSGJgdJkcJS8T
	 AiAFeirA/XNMkeo3uUs+LlbLrhWIpGiJUlDVo06gBFCRCAed42akfWAk87t5o2QbRQrvA
	 o8SQ4G8sPTOFex5vf2ScwPR6W1g53smNmTMjk9PSCgSzvUcfYRRtfMv17kjdzFftaKtZb
	 AMsyLG+ZbYiZEJmy5/PY3+MhVBl4RNMNuDsNNbsjOMF2El4iTiaI4NsmbKpIaiMKG3XCR
	 3SPoxMJ6cOPoPOVh/PavgZTP4EDZqfEE8pstIDa4zvXIKEpjcyaCSYlw5VipLMV5b3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424533;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bkGDFO70vWBKhUp1LATRTjL4dgwHVoXab95WIO6BG2Y=;
	b=X+DRPlaip0K1TX/xlRGa2mrDxeeJ85vWhvi6Sld13xExn9V0Q550BfwjVcrr48m3hV+9
	 VILR1N05BdNAfU4epYENQ7U2VAsZYMirj5D36yuftKNXR1uJhup1aa9ntk5TKQXk6gZIu
	 y4KcKb6v+hPNXHWkk9ugaq6dhl1TO3t089HezorwfBS2lu0frDqXiDCSdzFuujY06nsGD
	 l0nUJ6JkJJoipp4Celfr64Oioo7BRqnfVGaozca3tJDFtt5ND7n084nmXP6OZnbJncoHl
	 Szrm2VHZ05ZXsVQIlgwrUu65empxgeucXVgafjCdj1yK7hxzt3TeMUQV1VUY+nezu+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="EnuGc/iS";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.18
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839DD606A31A;
	Mon, 23 Nov 2026 09:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 839DD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EnuGc/iS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xd7Hfpp2m0aNMv+hYwVXTztiZ1vHqRwsdt5JnLjFnSGbLYcMnkCibiKtx/8fJv5em4RgJNbg5hf+L9w0+Dwtf1g3+4tURUwC/vPJ2Y5cHI4pKbXc3YFnR9Kqt3g9AiHvV+PFeFM/Hs8aDFib73u1bll7bjIW069txJMXxQwwNPlAGEHy7uLasnK86oaZ72bldFOE1PamVXlnadjFNI3uK5jEgdeFgj+FqEl/SPrsI8Axo7g2wlVxgjL3pDdk3zF87EikGOtfkYEa76tZ7FNV4EexaI/tfdOB53PXOv0Ygxl3o+AWNKi5/X60aeG6sq0YAghenSm1XMucNZjZ89DZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkGDFO70vWBKhUp1LATRTjL4dgwHVoXab95WIO6BG2Y=;
 b=OzAuDSpmwfsDOxBoS1Y80a8mn+JLSCvxpSl7Lh8Jvgm7ffrsn/DXjCK6GlKFIAJ5VlMowQV1h4F1iEGwcxub2D+pnnovSv7lpC8JweunM/+rmRgklKOGin4QxC3nwxL0qHJrtkqneQY9RWcsUFxth74SygNFBNSO+yHcoO0FjzOkRDT/xz/GP/pK7OEAnyYBPVtGEBapxqkLybKoBTTJ4d8mk83w1k8BnwysbSbexRg86p4IDGGHR1tAsvRCAGBJTEARIheaeb8XHY5lyINqOzvOTHRaf/PyqU48SZ7KBNlHG55xPR9RB5e0+w0LLsIptK6leDIkCgft0yoNBQBMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkGDFO70vWBKhUp1LATRTjL4dgwHVoXab95WIO6BG2Y=;
 b=EnuGc/iSMQRxfkdXByUxpLaViiQIjNBRblex5FSCGoIb8kk636YqgEYfBDaRVAm/75jt7wZe2wKODOFvJbx0PX9a15U23sOY6pua+Wz1N28dlRGSE07d/q1MIMFhvRwLM1phvh8A/r6DUvWrFwh2o834U9c0MVRxPFAsPSuSk4w=
Received: from SJ2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:a03:505::27)
 by SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:02:07 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::af) by SJ2PR07CA0010.outlook.office365.com
 (2603:10b6:a03:505::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 09:02:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 09:02:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 03:02:06 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 03:02:06 -0600
Received: from localhost.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 23 Nov 2026 03:02:04 -0600
From: Baorui.Liu <baorliu@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linuxfoundation.org>, kernel test robot <lkp@intel.com>,
	"Baorui . Liu" <baorliu@amd.com>
Subject: Re: [PATCH v8] ACPI: button: Report wakeup key only for power button wakeups
Date: Mon, 23 Nov 2026 17:02:03 +0800
Message-ID: <20261123090203.573-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJZ5v0gxGtEENP9kBmwFvcrSxPMyguYsYoYKpa6oa7hhvAvN=A@mail.gmail.com>
References: <CAJZ5v0gxGtEENP9kBmwFvcrSxPMyguYsYoYKpa6oa7hhvAvN=A@mail.gmail.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SN7PR12MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f52c03-d57f-46cc-378d-08df49407345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261028144727099003|261022105027099003|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	n7Z4vpLudtUpgXGHObI4QF6/8ABnKhyB3CF/TnfMsa/PRzdQGTs2UjanJMNAGa9yhu8JP4nN4i+t/RQPWqssWrGJzGfjn1BPvQTgL/GccNii9xD/hWol59DqnsSHHn/nZaEOQ1CwRpFvpAlNZ2ICtRLWRg7NWlT2m7WphsU3bFcOaTxrGDPT6BPJFLbv1UIBtHTegbGurqoHI58CKPratfJhLWuVRb/byuPZMgWqoqu70mwO4bKFDt7juu2BhNuCqlmz6S+v5kfXYLf3Bwc9vqOUzAzmbt8XUIijRfH2P4HtAdmf7MlMTSH1FEVmY4J3yLb5EF3+9vf41OX0/EY1g9qfC62SUqvIn/Qg9rV+cBwpSaMhrizAniZPrJ2gdqXxZT7ifPs1LerRm8m+LX49bA5sTVxfiDnXWuB9+ek1PtucU2qpQcQOzru4yni1TzMDQ6x7+IMvtacDxjYp/7A1ajymtrjlaBn7qB6ig3U6nGoGLjBLp0zkcKOrTzOqf9TFl29A0pd5aKX31sA8eE/xnj8kJJftfmCMxZ2y8SANHkT9GVUyDZBeLMMnMsRrlGe2DPPTVK5OHB0GCRiYvLnFj6B/za/DiaF5Svxx6YnT938jJmfEZbhXzr2q0Y2DKGA1utz0B9CpJmPeh5zwH4axQQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261028144727099003)(261022105027099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LGOuj9t+FblZsk+tfHp2FmI2nmpvEPdkh9JBPHfGnp5oFfeVfez15bn35u3vRV7KWZHhW2K3PTQYwsmP7vrb7tc50IUVbnfzUyxeMF/UZ2h1XvhC8USKxPWRXhZvFBfugg9LyBNEcQsBuowFNUopyS6ZPzbU1wEVuG3n07ikzMirF1h237br/zAyL2m07eNEy1HtSeu3lMD1CNGfR61EmZiF4OUD6VgAGPTmur/csYS3/mnzaVRgpqh+CM9T1enfStNPACIP1R5yTbe5R944TYWlodoFzvXofETDEOfIFTH0gNGJuzKRtU1xodj36rHQeeRMiVpiBTsATTfLpC8bsqy88iMIQsX71muS70Lu9Dql/GzLrrYqVaSK3SkcQfuW1Ziez/ZtVFjs9DWlBiIn3cEgp1SwU40sAhgh9KuG0aVaa077brKDj5UxZUiY4Aod
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:02:06.9816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f52c03-d57f-46cc-378d-08df49407345
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155

On Fri, Nov 20, 2026 at 2:56 PM Rafael J. Wysocki (Intel) wrote:
> Please let me know what you think about it.
> Also, if you decide to send a new version, please do so in a new thread.

I agree with the three comments Sashiko kept, and v9 is sent as a new
thread:

https://lore.kernel.org/linux-acpi/20261123085607.476-1-baorliu@amd.com/

1. The fixed-button flag is consumed before it is combined with
   wakeup_pending, and only by ACPI_BUS_TYPE_POWER_BUTTON, so a
   short-circuit cannot leave it set.

2. suspended and wakeup_pending now use SMP barriers, and resume checks
   wakeup_pending again after clearing suspended.

3. The commit message has

   Fixes: 16f70feaabe9 ("ACPI: button: trigger wakeup key events")

   and the version changelog is below '---'.

I am not changing the three dismissed items: the Signed-off-by name,
the CONFIG_ACPI_SLEEP guard already in v8, and
acpi_os_wait_events_complete() in button resume.

Thanks,
Baorui
