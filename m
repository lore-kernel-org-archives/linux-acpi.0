Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793366908;
	b=BaBobUh+C06lUdqhQGrccvrd5Ypp86B5x6W9vGpcff7GRsa7iYiy0yrlVfgdhen60EUe
	 E9bvmbOu0bzozlD3Njw5I+uaapvWITKwfYJ+GwJmQmyZoDsTG0uP6ZPQJl3SI1RM4yeSO
	 /JjdRCc3wFW1/QokQx4cPq04kamWee8St/1mQk+TIK32+zaYz62/l/eaqqqtC0LUzQPW4
	 o4Y3m9r2tWMu2y4BCvQ/aIwaMvUZ9um81KYG9aGlmXU5NREda9Igiii+8mwJjFnI71LmT
	 XnFzlApxux31kVSlolqqN120oqOtGBSQ+Uz86zAMH7bVE7hE4jV6cqdwVb8bmKreEqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793366908;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=zH5g64fjOLMbJ38z0p2aYus+q+wNYUqewdU9R66a5Aw=;
	b=fLq1YNHrMWIy4yOteSpXRcOw8p1a1boNFnp/UY21dLSL3OHJrtTOrD2HQ30cmKeA7OJQ
	 1IQig2wSxLt6fw5gs2BkSJI4ZUD1XdGa1T74NW0HIYo/jjj99twOPHFwi+Tpl4t7+SjAh
	 dxWxAGy9+dowki7lToAE696oS/0rxsWb3M7kFpXWMevK4JbzWm5yqu5S+JmdOZHB1e53f
	 u1zcb/la+b1R0NUYwU1P5q2WAujakwzZGt9En8WFem6UiyFx8zc23Y+kniGFLHxB837Gr
	 G2G6eLheJ60FqjJRHmDwCMVAawFMX/kZ/uKR/G3pnHm35CJyCUvBFuto3fTT1ucUS8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nTk4iojr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.4
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD21606A31C;
	Fri, 30 Oct 2026 13:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBD21606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nTk4iojr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH5QPEOZhXCUNbFAiicouXjVhT62QQLp/WkaQy79ajvsQcrxlkY3UHkJOEtp/Z+09XV1o7myhd07lgBfTmErUBBJ/WQ9Z6TMJ6e6nrSqA2LiKKI50dHl7gmH6td1/5M4I1tUW2PXbNIw5actY3povNfGHNmMOPKb03vPqZ1LYyHrok33ll/P1UANhDvng5TnLvHQkS++K5XKxpKv9M6WGZvQyUIm9vfV2PndQUUcSuUOoKdAJokHAsLZDrGtfjp3bgKaM5N4bXq+UuQCie7KbrXP068oLnr03DaPYj4hSVWIEtgMW8GlOuTpKRVesefMubobcQMXd0yvZWAMh1PIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zH5g64fjOLMbJ38z0p2aYus+q+wNYUqewdU9R66a5Aw=;
 b=mQP2SAiSrBq79aby7Q59WJ9nH7SWX0Sg/pkENaqZtZ7r9fZSeqN3xeBDGrxdcWj+lxmmA45NjMLRWNMksINBMlMMIknNDmOqD5zlYS9gk//CXTjsmLsuVZguCvqiq4VVyv7Rni3/bDDK5r25Lzjkr+Ls4IgmvBO3nm2Hmzzn/f7XrYdOQ3UP9x8KN/MQ2XYXE9cvAAf9Qu+rDr8MOjS6qE5vGlxFbwxt6D9D6xzJ9K9X0dJBj+CILcuTtN1fczfpbfyYKEJ5y+syu8+bCajpTuurJBuWLxqRlN7MAY9bp3RvMk0s3bO5sunZVsEhrILZPquaaqEKG+dMGZhX9Lwtmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH5g64fjOLMbJ38z0p2aYus+q+wNYUqewdU9R66a5Aw=;
 b=nTk4iojrUbdFp3G+nREy7f5/AEI7zAlVvzU2vmKjHmIVRSd9M/j0Ym0oIBfY6gZX9jNVsC/e7TweGgsd01rH3n9Vh5Ae0tBDIi9E3T3leFECbt6b8i+aXM/2UTFcaLbr1W28oaLN6qlMAMddJD0pzQXWY4AzxcE8ddUb1DwGO+E=
Received: from MW4PR03CA0086.namprd03.prod.outlook.com (2603:10b6:303:b6::31)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.10; Fri, 30 Oct 2026 13:28:24 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::57) by MW4PR03CA0086.outlook.office365.com
 (2603:10b6:303:b6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 13:28:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 13:28:24 +0000
Received: from localhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 08:28:21 -0500
From: Baorui.Liu <baorliu@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linuxfoundation.org>, kernel test robot <lkp@intel.com>,
	"Baorui . Liu" <baorliu@amd.com>
Subject: Re: [PATCH v5] ACPI: button: Report wakeup key only for power button wakeups
Date: Fri, 30 Oct 2026 21:27:40 +0800
Message-ID: <20261030132740.459-1-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJZ5v0h_136ACZzxQ=MdvRx_7iYRu3L3z1tY01ONfkSz5JEXzw@mail.gmail.com>
References: <20261012060847.486-1-baorliu@amd.com> <CAJZ5v0h_136ACZzxQ=MdvRx_7iYRu3L3z1tY01ONfkSz5JEXzw@mail.gmail.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: e969f6ea-575e-4c51-54a1-08df3689ac7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|261028144727099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|10067099003|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	XxTu+hKj/E87htWG2tpAsF11qoI7jDzrurSYhJ3XRcdoV/F2T6bH3hBoyFPqkPF9euBeZIwH+bSQQFjTI42EupGmXCiJ4CkIKZFW9BcVP7ps9N/qDy1neR/3NGwFzMN4jgkrN2fsww0wJ3bcZtVYaEQY3T/hAPhwRkNkiXkTflUq8fJc4564Mg3Z8wk+9QRCe1m0/SO0sZ+ZX6oLnV1D5mfZXOEJ4hgylCvm06t5ZvDGUx5XJYQE9bUs3JcFp41nbDeQltiAHXvEkNIvkKU2K4G1+Ue5V4jCAM9wnpxPrLhhUIZteDHe1HS78tz3dW3o3duxlzZtAXG3lnIqlHpG71Yft794ZXuchjMRnklxK7fvNlC9nNnDNXT3vA5A+oFr161KWLvHc6nGr74Qn6aMJDOZGnc6CUj0C5t1UFVlkoTq1F12F6PivastEIPDqCcpTOJ4lrnZhXYbx9J8V3DUxvueUmj1GIdccpSOrQV9wO64+WyOpISFjPcbuOzfdTCRXUZ3J0ttE04d4mwa6iPm8nejVnw0bhs8F7VYztLC6Xu/LjJXzefGHX9zr23yW4Uz41DMKpIsRR2lwZ8sD+BjHntaenGg9hpnmw97vfHjzQtWJbhuJ72pYPoN7eyQE+hEhgdW2IkWCqEaJMTX96kmrUiy10BlwzEPv96cmP39CJCw3c+EHRDt3HvL9XEpCcy0Nx0gU/YzwlsDjys6EEdiUw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(261028144727099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZlRMSZRgO3Wwuvi3dyZIrbmycTaIg+ePPhXuZRpbRlQmRVKp7Eav+yQKMvFGdauGCVKZnJ+g7E7h/OQL2whw77Ao317W6WiM7BH5+IbUXQWSRX7dKGtKw28XMD7EVdg/2g3PpAsrVX+O5WVmHiyOmUltzJzkLTKUMPG864h3X578oCEVdbLbzjX4NaTi0B6xPDJJf0RPZNh2dhq9AHlyEGk0J/ycnfKj83jmpg11iQDEPAlMAyYyuzAUbuKC/qPEqC0xqkPL3yKkA0EBWYfU3nr6M8iEIocl2sA/qGTdET9Q12EY/9PVG5k6JoCNWTlVyQyzrwVZ/06P57rVdSo0WU1xR4xpf9klU/XhhnmtLVd3JPkSMVYbf+ilp+Pqkt+YHdJH+cAH3/5ad2g+YpLoOmKbqPsy4j17er2rajUHLHdWVJ453BcKedHf1dqrqxmQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 13:28:24.0728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e969f6ea-575e-4c51-54a1-08df3689ac7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886

Hi Rafael,

Thank you for pointing me at the Sashiko review. I went through the four
findings and agree with all of them. I have prepared a v6 on current
linux-pm/linux-next that addresses them as follows.

1) High: sleep-in-atomic in acpi_suspend_enter()
I agree. acpi_button_power_wakeup_pending() reached
acpi_get_first_physical_node(), which takes a mutex, while
acpi_suspend_enter() runs with IRQs disabled.

In v6, that early path no longer calls into the button driver. It only
sets plain flags in sleep.c: the existing pwr_btn_event_pending for
acpi_pm_finish()'s pm_wakeup_event(), plus pwr_btn_wakeup_pending for
KEY_WAKEUP. The button driver consumes the latter from resume via
acpi_sleep_pwr_btn_wakeup_pending().

2) Medium: IS_REACHABLE stub drops KEY_WAKEUP when CONFIG_ACPI_BUTTON=m
I agree this was a real functional hole. The v5 IS_REACHABLE() stub fixed
the LKP link error, but with a modular button driver the built-in call
site became a no-op after clearing the fixed power-button status bit.

Keeping the flag in built-in sleep.c and exporting a consumer for
button.ko fixes both the link issue and the modular KEY_WAKEUP loss. The
IS_REACHABLE stub is removed. The sleep.c flag uses WRITE_ONCE/READ_ONCE.

3) Medium: missing compiler barrier between the two stores in suspend
I agree. v6 uses WRITE_ONCE()/barrier()/READ_ONCE() around
wakeup_pending and suspended in acpi_button_suspend(). The same store
ordering is used when clearing them in resume: suspended is cleared
before wakeup_pending, with a barrier() between the two WRITE_ONCE()s.

4) Medium: race between clearing suspended and a late ACPI notify
I agree. v6 calls acpi_os_wait_events_complete() first so queued notifies
still observe suspended == true. It then samples the pending state and
reports KEY_WAKEUP before clearing suspended, so a notify that arrives
after sampling cannot set wakeup_pending only to have it dropped with
neither KEY_WAKEUP nor KEY_POWER. After KEY_WAKEUP, suspended is cleared
before wakeup_pending (with barrier()) so a new SCI takes the normal
KEY_POWER path.

I will send v6 shortly unless you prefer a different approach on any of
these points.

Thanks,
Baorui
