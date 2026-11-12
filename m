Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794501082;
	b=yabIQxchDjziAeuHnvXrOdAJYei1QrIlblngzk3PIINNsM2z5Wuw7K9AHqehNxny8rly
	 hhSBjDLbOdWdpZMYrGzaYfh7gErNhAhbCGkcFu/w2vEHhvvdWFSF+rK5Ko9Uc2l/mjC0p
	 k5B7zMj9hR7y2+HGm9L9sg4k8DkK/01rEYFSer78wpR6dxmXx3HYFRN1EOuHf4fuzhdXl
	 fSSmc1aveJcX8iP0P6YxtSv/U5y9o2U2yDrOFJ945dM96mmx7lLkYqPEwhe4R0ZEZp77Y
	 NG7kyBVYPBbHi1+xM8p47RJQsIgREFhbDX4+L/xr/dAIkANKp9Ei2CkAmx70hUn+iXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501082;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=v6np08FptyurW/megBjlbM8MYiZL+rC2ypAnZD842Wo=;
	b=vZ/YGfGPQKRopTrLj+EbZQ8NYylQRS2OmJWpc5N0kuSOTvWiTUUhSLGnx6CEYr+rbVjQ
	 pqns/+lILpVYYMLXcFcnSbjWV23Pxvkn8ICtv6AgY3dTNjEA/mEPw3fMgqDaDkouP2dSa
	 yYQ4sknMf/nppLU8BI2YQkOQ7QI5NY3nH4Itc5u4zzQBOGD5lja8vZAHhZKXsjIIDbYiw
	 nWlNJpaixXjnmdlj7hcItl4klBHWv1MnIDCNpI15Mn2grVkcn/Dkp2XDK/lIWd+J2i5k3
	 9pcydmysJFR2QVfm3ljoFRqpOIPZwaJxlfNmfhv0d7lfyfkZoeBJ0VRyD5WtoPSsJWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YocVrJGg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.36
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41689606A881
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 16:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41689606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YocVrJGg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJ2mT3Ia+PycOQUPSgmv5x4fVlMNmj5++70yBd0l/mmEfk7T94LtYB/kKn8AywsBf9aUt/4/MI8ppLeo6IvSWq4+PARZCWzklnUZ9JSJu3Av/0SZ/amwgqlU3yS4EBDA/XKuscJhln+e4Ojheu0/TzSmARANf30wdOoZ5SthGP/3xKN3aeZbh3bYYAXgIwBnNZofmKni8/A4JZYnIQ9eTguCntLhM77K+0P8MAskCmKAg91F53XusEgel5ooEYEi5iM+EnnYw8977TT9eDN6IdTHT1I5XTGEeG4gMN50UsKT+B9uxh4MBnmxo1t6S3WC5fBYShSkhkSMVI4ReSP4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6np08FptyurW/megBjlbM8MYiZL+rC2ypAnZD842Wo=;
 b=gsKL7Rtbv87VIhhexwf/EAmsxuqvdk84WGwrVqj58zIoJexebf5xIOB61ob0yri4Bhig2vJnwWd7IfZ7IBRhu7TUayc9ROeg1V5d3mYD2GTC5yh+Sm1IZDrKMEzTjmEv0ynSGBr0khXxnafMLUEb01KdCWjEqxHFNLBLzfn+IvUWTl9hDfpSflh74cYMpDtZ0cnHt76QCE/rkD6vvBEezehl5DmRE7lUkbEMMTIbSRSIOhKAa3qF9Ts5uc8lBrYLfujL3Zv7Y6iu6xz/jG7mbAm+20nLwTH6M7IjMaZxJkShb0/boQvtqXksoBr2lg55eQgy0g7U8dXgdwIXDA5ouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6np08FptyurW/megBjlbM8MYiZL+rC2ypAnZD842Wo=;
 b=YocVrJGgDeEj8VnDOkIB3yX4hpG4jJqtXaU4iS9pZvM+4QqeVAgGbHt6i5zkqxB/DjUzb+4zQpFUY/Vs3rRaAQIt3Fjks1ppunsYSpS8hOT311f336UCLRU9XAHYIwEMHHgipCfmVZqLYgRyjARaQwQ3zK3qMvWjp+sCIoTegYEfeqPzLp4Fpsg3JnBdIXlZ8unKXppE5oig58cK9Ts4QoPWiV3CwiXghEb3MgTIP8lCct4NUWFz4A9i7wiKVPPzAjJOosq14E2cxDMdp5rxpDOzEfIYHQK/JDESWozeYQyDxJBtrPWejIXX+3P4V6vF9h5tncLG5NiuB9ABxDwE/A==
Received: from CY5PR19CA0031.namprd19.prod.outlook.com (2603:10b6:930:1a::23)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 16:31:15 +0000
Received: from DS1PEPF0005344F.namprd04.prod.outlook.com
 (2603:10b6:930:1a:cafe::9e) by CY5PR19CA0031.outlook.office365.com
 (2603:10b6:930:1a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 16:31:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0005344F.mail.protection.outlook.com (10.167.23.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 16:31:15 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 08:30:48 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 08:30:48 -0800
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Thu, 12 Nov 2026 08:30:48 -0800
From: Jamie Nguyen <jamien@nvidia.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
CC: Jamie Nguyen <jamien@nvidia.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dat Mach
	<dmach@nvidia.com>
Subject: Re: [PATCH v2 3/3] firmware: arm_ffa: Share FF-A version negotiation
Date: Thu, 12 Nov 2026 08:30:47 -0800
Message-ID: <20261112163047.575186-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112-acpi_ffh_ffa-v2-3-575a9dbed22b@kernel.org>
References: <20261112-acpi_ffh_ffa-v2-0-575a9dbed22b@kernel.org> <20261112-acpi_ffh_ffa-v2-3-575a9dbed22b@kernel.org>
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
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0005344F:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: eed84d51-f8e5-4597-0a0b-08df40da5f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|4143699003|10067099003|5023799004|11063799006|56012099006|261026121527099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Xl1kIfU9JsQdjTPowT2jTuvXeNzIkdAo4hVJ211GrzsLY1W/IcreCigfJ+WhDFGKJEvvtjwFMJLKtU8O4oCQ6mWWrpMVyxBpmtfOv4+fD9tAJFpKVR05vV1ofP7f2WqFvnDgprUQJdtuA1hh/S8OrfP+eVqPVFUuBuLz+GE9kX5rPdb4nHXmtScd8WMVTf30eiIqelkcShJsfkxSse2TS492nkJynigGuUXSEUwx65ZUsynw285tOuMFkK92LlLAMz3WKhMlz4P4eYUa0ydBvs5EGPHzSrhsPJNne+vlCy/RSdfMCNoLGDxDB+4IKSpgMS37AtFuTZ9Cno1rfymS8d+BsdnrQ2NP7oCpoQl2vLciMSRZ/WfmUcgMTcn5BDn3tOtOVPS7EN3786vVESicCJ0ohAK2d09auIRa5kMbHWw+vCC5GdxgOwuZICPv7WvfbfEWEqMPLMGJY5me1o19jaj1W9D7m+UatKKwS0Bbx0ZN4IJvBUIdJ9xR5I5SoeId7w9i9N0upWA8zXEgTfEgdGz8Y9i0otMWYA/pve8qdhiXIVLgkIV+7EVoMK5m3GSlHicGVa5hYt2dy5SYISIVj6fY+OATYaZL99AK/vTvLPq4du7ZjtLl6TxjyJfiZEKK2x6lvInNEszX+bqC6FxuTtxbyLVFS47o5LTo4NZgyWqBeGKCnzmfA1A1VSbJve9Twm2PBrFQYqQcnlc4a6qxLw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(4143699003)(10067099003)(5023799004)(11063799006)(56012099006)(261026121527099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w5NlOL5coEJdNi4VzDRe78zkkeX6PtgRyPD99TxnZKc3yAgAM1w9S8zFyL/rLjajPncgE0QZHmtzA2pnXZmOoLnYddnp/AVM9iiGkMX1ps5FXCDl0ZBOaQyHcjbJ46UwNB0tfGc1f8jrRbVldWXRWnKgW3h2twW9j91wxHUaYyd3yutnYPw13uK+D6gZQ2rBRJ9zbuWvZOtiyRLJHerihDvAnha6NstiYk9bUhN6eWE2uFXNC6BnQ43lBn9Y2kFI6yFsz5maFJAs8opQEaaJTWDT3Xe9JDvPMdNpsVkYn1e+9jH12Nsj5W4of5c+bHXoQS1T0aOGoy44D1Ryy0mN+p25jeyL0P4x+/DV5lznesaGHP/wPTJ9xeuZSg97MBxy5PByJnml72XUNS+wqpd/UgEmzD1PDdXn9ylSiNB+t6bzi2MHzLj9ctzf1UZ3LBYZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:31:15.3796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eed84d51-f8e5-4597-0a0b-08df40da5f41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0005344F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450

On Thu, Nov 12, 2026 at 11:14:08AM +0000, Sudeep Holla wrote:
[...]
> +	guard(mutex)(&ffa_version_lock);
> +	if (!ffa_version) {
> +		invoke(&args, &res);

Can this scenario happen?

1) pKVM is enabled but not yet initialised, and offset-2 AML runs
   (e.g. during the initial ACPI scan), so ffh.c gets here first and
   negotiates directly with EL3.
2) The result is cached.
3) Once pKVM is up, ffa_version_check() gets the cached version and
   never sends FFA_VERSION through the proxy.

If so, then I think kvm_host_ffa_handler() would reject the transport's
calls, since has_version_negotiated is never set.

Should we decline here instead, without caching, while
is_protected_kvm_enabled() && !is_pkvm_initialized(), like ffa_probe()
already does?
