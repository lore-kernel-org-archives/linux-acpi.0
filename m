Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A0433E367;
	Fri,  5 Jun 2026 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632626; cv=fail; b=qwyvxZCNx0TnM89n1Iw033HA2KPJUFToJgP/htQugmZ4OsnJwVdX/0y/Iu5xltYnq7QP8iNUu5Czsq3I2/hQgRL9RprKAdNoWJadQOoHl+bmPGPA1BLnnfSTEH1ELNOildmx9e95w52BTv4GuPKpi1YwpMJ66RWtYuJCTZLgHB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632626; c=relaxed/simple;
	bh=VA+l24e7JVm0uJf9ff2aCVcRAAO636Iwx7Jvfk8j+9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CjSKyyvJ1w1RwKKgCpthVLpbmrE3LHnRqcO2CfDpGP3xfsHDOSDmxFBy3+kiGTjqBmAkA4f7fAruK9YGaCFWqZTpnoE+CEC41Rb2zAP0SSp0wRylQNRMMzRqE5wrXYCHMldV9BenavTkGo2DRaqpCaPY4cUZeZ6abRY7+bN6WcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3rmhMfN+; arc=fail smtp.client-ip=40.93.198.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3rmhMfN+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWIu9wAuwzxGFoDYkOj1JFCjRS9uEM3eIXFzy1FNgRP6pRZwCBxi/toH64L7nQFZzudl+MJwiOnyH4R/p8rn5GOaOTz1MxXnRouxM2NVWlWeO0DmNWeWn1rggGDLYmWcvq1W0gYT13SLoFMn9ivf5pNptu7W93zXIB60Z5W/JwT0YwmRbcD30jcDTiJgZm3lTLOmGSggq7fl8/9gaEialCjAVH1OVH3/BcmY3rf8EOvWqSzmLSUXmWAlF820h7pcLCfapIscMpCTNDdBPCoD4oR9vSWal92vgXGcWhdUdxhaU7EecivMOInGNs9A3OvYfqGJAyAr9RkEnehC7xfd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOlkO7LuhSZwyArTOzfkGw6mvgV/74hMuZtXKzu/APo=;
 b=MGoFxQeFWJPwOtf8HyCZr8tBTdF1hJnxLrBekBYbTfn4aODNQvE9fBhyLZ56dtLo+NnQi723DpsP2hda2epOP6+TXeIJif2k+s8lBmoPIQjSf75FlqPutkt4VxQ5ZnpZa2KRb1N4bAhR5KB5hXw9aoDhyMb54L0MMIcee/ga2BSIJGrBk5fUIyTv/k+LyXhad+snJlKUrjpAsVAXi5OmYyOFnQLWpX/U83TCYkjrJ6DqSjUrlQtBv8IMRIZHNDyFyr6QnXEIHgDpLSzSdysHA9SyVtr1IKONQezqJNKfmSIWv3rBEIwKITwhyHMzhDLMlhXsEAACtwnuQFIBgz66IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOlkO7LuhSZwyArTOzfkGw6mvgV/74hMuZtXKzu/APo=;
 b=3rmhMfN+QxKXbQg9PtR43hKlvIGBUbOtT9Y1sDk9Yx4+dkDgK3FDvSvsGjnppPtC/7AWnN3mCUkg7lVDoEtyLnleonxPNeOZ5gEWsp7/T2RmyVzg70opgeayM1wTRzMbonZgq8zH3U2hCyaxy/+kdhrvgp5HKP/sN9dLQdCcMtM=
Received: from BL1PR13CA0352.namprd13.prod.outlook.com (2603:10b6:208:2c6::27)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 04:10:20 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::a0) by BL1PR13CA0352.outlook.office365.com
 (2603:10b6:208:2c6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Fri, 5
 Jun 2026 04:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 04:10:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 23:10:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 23:10:20 -0500
Received: from [10.136.33.4] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 4 Jun 2026 23:10:15 -0500
Message-ID: <d258b3dd-633d-4733-9eb3-4b65013e81e7@amd.com>
Date: Fri, 5 Jun 2026 09:40:14 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] x86/cpu/amd: Fetch S5_RESET_STATUS from PHAT when
 supported
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Borislav Petkov
	<bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: Vilas Sridharan <Vilas.Sridharan@amd.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Mikhail Paulyshka
	<me@mixaill.net>, Kai Huang <kai.huang@intel.com>, Rong Zhang <i@rong.moe>
References: <20260603063317.13665-1-kprateek.nayak@amd.com>
 <20260603063317.13665-4-kprateek.nayak@amd.com>
 <d45e3051-ced5-45d8-b3ff-c50f4e41cd1f@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <d45e3051-ced5-45d8-b3ff-c50f4e41cd1f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b1bdb8-95ff-40e7-a88c-08dec2b85be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|22082099003|18002099003|921020|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	ua1iDmHjYp/0OEUhEKuznGd1ocKfDTeRtvevszG1/Yka4nvZwRnNs2jBKhXWoTLiw78R6+0XQdHd8XPklYrhJC8BWOhmrGSK/KWer9K5j0OeuC8zMivxAiUI38u4CBbqSp7wOPb2tvMGJa9cAyZf+JU2+JTIs5ZPwHvCtvTBYakQJqN0EEqKgu0tYYed6tR3G7w1VxWZLvy7r6UNBYCvaTs1KkJiCK8c3QNaoJYkzuootOFdXqx2cFIxcrzVRIsF7W2rg+/6kcND2mt+ZXEC0SUVqoPB+q6PAHCe0IjZZmDfLn4gCOIiRUT6EvFrmqMTtWswwPZL2rv5kKj5fFanvGLvHso2lxupxO+i7sbKDJoFS7XAviYFi+T4dXW+fC5SLY8F13USeneZtwCvrmWgvRjLpxusLKqkGlb1CtTnTwWdmYK6BmauUg+/CrZZoTWpKvQwWP5O6PhPQauosc6i+wOwWCzA9JmBXSWIDikiDouaQ+X6+4YsYIvWbdiP4se8YZoqO/KAzt4A1LG/bOgdI+9peiarOi7MGfXn7mYEka1UKNDSf92iTjTRVXjgs93TicoZZRx78LWQT4jWvxE/JKWnPkM5xPNcVq/HZKS8i8ZRPXl3powcuaVAv/dxh4idMNnTedsmkXW5LIJWtC4znpvTGRGHwsIAUeohlP5P+S2VwFdV3F9EAYxCN7rMhUKriimmGl7Jb7w/zEht7cyuTrGUmjVWZ9T+k+x8d/8/9toNKKIHqPPu3rdUpVJR/sOC+yoMQ7xFDov00Hcqng0Q1w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(921020)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rll1xbzIchbv21JIspP+73gXTDRtpDXs1NBowKB/W4qseZ7w9bbq8QvfEa0o3jhpvjX2Urqy8orSdpjGscmxY9hb8CkiL1fRxadhQpJNajvqRrxiU8IIBfwpYiqMItjfO/Buk/qgQgPtj3jhfUk4Y2xUt8yqJEkYjjinChomHrZZ8Nj67UhHAG513NHppHPJEBf+C2ONlzx0kCapwFCxswEOybv7ugvONugwQdxT924xkUI1HmRAHzCLGorullE99rWOjRkGMrct44hTIG56GDogTFfWT13x+kusvgM3pBWVQFYNITS63P4Ed4zO8ttqrBdlb+4Tlqc2PGsIkaOIu8/K2ut3M1RP9mGB+sYd2XR9EU412Fit2c3P9NKL/mR+5535/gBiDjun/HzWoe6rkyPxaHTz9knfxxFb+D1qJ3wmvh9QLcDI2DWiye5QhW20
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 04:10:20.4269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b1bdb8-95ff-40e7-a88c-08dec2b85be4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190

Hello Mario,

On 6/3/2026 7:56 PM, Mario Limonciello wrote:
>> +    record = (void *)acpi_phat_get_vendor_reset_reason(&guid);
>> +    if (!IS_ERR(record)) {
>> +        bool record_valid = false;
>> +
>> +        /* Sanity check before using the parsed record. */
>> +        if (record->header.length == sizeof(*record)) {
> 
> Why not do this sanity check in acpi_phat_get_vendor_reset_reason()
> directly?  Then we can always assume if something is returned it's
> valid and it's simpler here (and any other potential callers in future).

My intention here was to catch any changes to the PHAT record format
for this GUID. If we can reasonably assume that isn't going to happen,
we can skip this check entirely.

-- 
Thanks and Regards,
Prateek

