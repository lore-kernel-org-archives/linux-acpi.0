Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EEC4B0CA3;
	Mon, 21 Sep 2026 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013006; cv=fail; b=ea+Hjh7TBjUH9684mtkkKB0cIJxJvQmLgYw7800HmnGn0ahROt8+/Df9tiGohc4S9i8J/moRIgnbgupdMGbAFDrDVrgJt59ISzAql0hi5ZynCxjjKpSzQR4ARkO30O6YeBz2JPb1ATlEIHgtvZ31QrTw8M/kGYxFBfQyFSl0lZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013006; c=relaxed/simple;
	bh=nq1BA0mIbs3VbaO0uX99y0RXvgFsfMfBlqZ2Vbq7c4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i49vI6n5tLn77W/ICa6UdIEkk1SYOcRPbZv30UIJYqrng1GN//3Z8sf2YiAPUr07O2u2H3xLfe7FPYjDgfdrDMr+cLXBXWr9gzfgcpGGA4mJQesLQaVRjqAQpFD4VOTYKVNS6Rh1mX3CCq64MbEXsUCi2L+Wy2dEQ6MuMqDPiGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ulHQliaq; arc=fail smtp.client-ip=40.93.196.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ulHQliaq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwFLKAjz5eGUF8d6vQHjq8tZZsahcDGQUeUwe7e2G7hefqMf7V5yfC1RAagVl5TIUFAOI4L8inUgBzNpZK75vE00cg+ggeIoLUut+bF8n0iLJAHVZBY3z8ZtYrjqKH10z5ZIMy0yCg7QjkQdG4XpI/H7D7CaiE3d1DszV5VbPJ0THSSQAdrBuKWD54QAd35YCqs9c2K4A6dnXJVVInlwTEVZ6a/f2R34nzCbEMxTj8f4x3HFjA+uttEdexmcyQTU3HDFagxGYvDfbeBI3GinmgekSyMSYLh74UYBrGGgM753k+XUar6Go3tejghIE0smQVBX066hk38zs6N/TVenng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZBDS/fjV8mTU4sbd8xKsPOs2kwUo6QT2nm+gOvROos=;
 b=E66U9oUmjlfSrucRRLHg3Hj1ilvmeto2lFVQk60lkQv227yeQgzbwbgbtDC2n7xbG8kImYJffpcXCuvkL236lI1zeD2/CWk9j3/og6u32qD5NyUAmEOQuMX79TmaH7HzIMEFHnH3aNnt4ACRJTjFKMsdIadKCQrj526xYl14VF19hQ+zUHdZ+A1gcg08hmNaFXTOeIz2dxP28tkDcDGF5T5aC8nObLXYPXs9WT/9s4ti7vcbVVq1TkpLMiR7MBWDSh62PLFT2jxq9oJ/WLU9hhhKbnRCj9tcUwspmc/kWdID2wmeknJny4P0V2L/gLvs38yWuzm/tWJshyT4zWRkZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZBDS/fjV8mTU4sbd8xKsPOs2kwUo6QT2nm+gOvROos=;
 b=ulHQliaqROhRVxhrylCScxNaaNmQBYgCp756ufEUwew+z5eQerR9SwgTMPAvA8m9dGY9lBdZsmxCLT9/MCHVpsi9rt6CqrO65HNI3xL0u+loi02mIZEUwuM+QzSS22ebAMzfTJRUEKhNiwZxGlXmyqWWXgYGqudWmjaX9QI632Qiu1AShl8DuxKTK+j+RN5NIeHKR6bymaW/7vzmSM9B85dJtLvXizGhcsKcNpgGMv5BpI2j6/7VJ5odl+SBOu7qmeLFljTPt6kGA7AHx0O10fjZFdms7nIXLW/VA7s95UwD8XNxTJC8gjwtINqh0qBXnVwn+MQm0smXEvhgATTK1g==
Received: from CH0PR03CA0298.namprd03.prod.outlook.com (2603:10b6:610:e6::33)
 by DS3PR12MB086197.namprd12.prod.outlook.com (2603:10b6:8:60a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 17:50:00 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::47) by CH0PR03CA0298.outlook.office365.com
 (2603:10b6:610:e6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 17:50:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 17:49:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 10:49:42 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 10:49:42 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 10:49:41 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: Hanjun Guo <guohanjun@huawei.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Dat Mach <dmach@nvidia.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] firmware: arm_ffa: Split the response out of ffa_msg_send_direct_req2()
Date: Mon, 21 Sep 2026 10:49:40 -0700
Message-ID: <20260921174941.2406319-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <348dfed7-6aa2-77a2-a0a9-3aeed22f46b8@huawei.com>
References: <20260901192906.133670-1-jamien@nvidia.com> <20260901192906.133670-2-jamien@nvidia.com> <348dfed7-6aa2-77a2-a0a9-3aeed22f46b8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|DS3PR12MB086197:EE_
X-MS-Office365-Filtering-Correlation-Id: 49609326-cbb2-4ba9-bf30-08df1808c177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4ZpiIJ1T0mI4291frd7kXARohmO+1x3OUq/T0ZjkyJOvaNCgzfFdBIgBRBCmxRzx+Ie2n+hmM+rXbwqKR56lc+Ld+XFPZrbm7Y+nTkTjhikYNZ4f1GGUzt7ycQvh6Gw7D9YDcyyGjuBmCSIFFq2VbR73T4rO/JaiXPiDmIvhBXdHEVbbKE+ehPbhW4tDGcpgeBdnQrfl4LCbPlZyzUS3AifD5i1EWN4aol70eUGQvzF7L9wLOnj4aUmPTmYBCW8oa8LbRNkTRnDUYM2raCBKZE0gAqagsct+tt+3IL9tV/fUXPWBRANKm8qMqzJlxx1DcDw9k42aIXFO8AJv6hbFL8av3lUOdjzmrBme2jbGi2y9uO/PEEkfS8Qsgcu6sT7qVOj819b7X58+d3tD5PyZpzTzNRDUiMXx5stQg+RXB5Qbs2OCga2V9CVxPV1ml/biXWfD9vNFy/TcpnYV3SwseztUpVbfM8myImLtWycXcLmYSoK6Rhu3Mbb9GJe6Bw+CpzWBsUrH1A6ya4xfNfihDXgwFwYwVRU+XDWncS3S6bzEmjBh5u+9yzFVUNzkQ7d3Ij4cBYgZKhMriHEUR7qN4xDvFLL4q8fmuV7c6lSA7lBAn1ad5fA0lSjEf5MCQ1MSaPdY8iBNoxE6Gi3/K580HpFysld6qwa//9OaWbEmdnn/VPRAgCJHxkTBC+2vI0eZ8he/GjktrJ+/1wOcdjmFQw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zdmKmly1dVyjIQ4lG8/hCiza1/DOMUybpRxyUM4Z8cN91vFlJ86PYlL3ZksA2O7UWYpjaVgwVl4nhF0b8YOtVOZRLT9OSuKFgNqVls34xnypI/KPXhyloTMg4fGZgJHid4D6Axd4Ykpaw4e++MoD6XXRQMI7jQJ/DIFx5wviYRVr30HqqYJsK8TWBSv66xufUYgo62HxZp268FQF1HcVJ0DAaW8wrBF1njyT0CXhAn0lE5pf4g27YmqMWPE3T2GBf27nPejGK3bXxLu1+DSU4LNuHEUShN1n7Px8ESzmQCYTsIvF6usjbWEMFlp+J2T/p6FqQMVOZUvC1owpiiygJnuNC3I2l5mf8AbUz4Cd2nVB2tl6CLpYUpws/Xzx3lYldMGw7BzdSx1J1VYyqzzpY19cbwWLY4tVRvGAK0Ev7nK6REyIuJ+wPuS4OjY9Qs5U
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 17:49:59.2679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49609326-cbb2-4ba9-bf30-08df1808c177
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB086197

> The kernel document was updated for this, please update the
> rest of two patches as well.

I'll update all three patches to use:

    Assisted-by: LLM

> As you noted in the cover letter, the AML thread will stall here if no
> response, block the ACPI interpreter and the ACPI global lock when
> the field is Lock-flagged, so do we have some warnings if that happened?

There's no warning today. Would a rate-limited warning after a prolonged
wait be useful here? I'm hesitant because that would also affect non-ACPI
callers of this helper, and I don't believe FF-A defines a threshold after
which the wait is abnormal.

> resp_regs[1] is confusing, comment here it links to X1 register
> is better.

I'll clarify that resp_regs[1] is X2; resp_regs[0] is X1.

I'll address these in v3.  Thanks!
