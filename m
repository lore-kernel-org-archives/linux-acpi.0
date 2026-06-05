Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ABF242D65;
	Fri,  5 Jun 2026 04:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632406; cv=fail; b=m0ApjH8Wl8RxOfQnuJMISdEhjkoZo+t9t4mREyd8wgrAz1H0rdYmMFD6xqB6SUCLCdtQhq4kKxCTSvEhjpY9mGtJXw34IiIRCxq8YFC8IyzR3OuyCsdUvP5fY7pdOUBahfYjwmWpYW9fZ1vWk/9wQgPLvGv8J6VjWyGs3v6iy+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632406; c=relaxed/simple;
	bh=hQPXVTPD2r649PH06QiIXcUP03/YSfu6vmye1fnA0Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JvfJTXYgVYGK6B0eqOLjpqV11fyYVQhcHIyKSQl1V6bgfLB7F7ikTwiyfrjvpoyLtFJdB+mvo0pqwMaU4TgueVd+1IbfdRAz+j5y/xfSrpIn7GCBprQmTZQ0eV5ruC2rwkEvC4zz9qWTe/dQffRajNGO3PLlGRhU7GW0A3s7E54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GL21vuKF; arc=fail smtp.client-ip=52.101.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GL21vuKF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IB5uam+sAwNWn4F9Qwci7DK8Ai/EWFBEVkeoOeapvJmvdf90NtKolj6IHvyTYPkcZHJvj0oRAr/ekjP0xGUmfAcik4jXg0psijn3VO0yzCuZ/6icVKeIoZdmtBLDJkK2G1bgr4XysfF+b6LGpLVPfGze4H9Zn5V8eX+rrh6Ch/mf0NMxwXecTg10IV1zh7EAKrND6BtVDy8yy9MDbyGYVnmORznZ3C5cCsHWdiItIGvyxzut34VrA5uSH9KGfBD03MzUbGip99SfP7eWPcPXujTv9ufgS3ht0tfoBlbTJqEa1ej0YtODkBz06Riq7ASunYltdreOR0+tcNMpKo/qDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oWOLTjQRrY40KIxGWWn3OgFPFOyj1+EGpQgiqsecow=;
 b=R2e6wdaAJAIhGRE6iOhFJbmcTUz796Uf1QAP3bwcvGA2WQCkToTtbZfAZZtQENwmlIhxSwOR6rZRb3m55koA7E4E96CCPazXAf2hb+BXlB/yXw+zHzxF6215SKJHD7S6EHcSaa3tdLb5DgVGttSyN1CGRJdcWkhTO4IIWlVSbORiyDoHZYoUV1nHfEx2Xx9IljwLQbgHAQDbA9MEO/LYbaBJy99DlMK8xzBIGgbFXiUoBcuiKlzUE9wX9cAGdb+kOp4erY3h7RR3p2EJSd+xByGky/O9Z9GSXqaI/5TqrQFkasptVNmrTu3IyXWrV71AUC5aHx0efaQ+o2c07g5cZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oWOLTjQRrY40KIxGWWn3OgFPFOyj1+EGpQgiqsecow=;
 b=GL21vuKFamP0nw47Lpni3ET1F+m0PdcSWA8Ebp97Sx5fMpBP/lbOmve+IvtnLVU09lfH3yKG+Z69nIdr1UPLPha0Xee5PFOFv3nV1ONUlJXD+mlxjt8u4JHbBEGBN4NRJnrUU+azv1Vg/EdQYdNrFkbPXcJjLRJhUq/zctlDCnw=
Received: from SJ0PR03CA0178.namprd03.prod.outlook.com (2603:10b6:a03:338::33)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 04:06:39 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::6f) by SJ0PR03CA0178.outlook.office365.com
 (2603:10b6:a03:338::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 04:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 04:06:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 23:06:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 21:06:38 -0700
Received: from [10.136.33.4] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 4 Jun 2026 23:06:36 -0500
Message-ID: <f554ac86-01bb-400e-a206-b40c41da8ce7@amd.com>
Date: Fri, 5 Jun 2026 09:36:35 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] ACPI: PHAT: Add generic helper to parse PHAT
 records
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Borislav Petkov
	<bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
CC: Vilas Sridharan <Vilas.Sridharan@amd.com>
References: <20260603063317.13665-1-kprateek.nayak@amd.com>
 <20260603063317.13665-3-kprateek.nayak@amd.com>
 <308d71e0-2f63-49a6-8a2b-d6a6401b8018@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <308d71e0-2f63-49a6-8a2b-d6a6401b8018@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: a89f86c9-644a-422d-2a0b-08dec2b7d7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|4143699003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	g5jydzTMBzSNj8r5BKC1NuYo3cAyXG8+FduvpUtMtLNXZ6Hd1ALNZeZqKQ0ztw5v1GVg9WgMMwaEOgQlCLTwKr09qVPSMdL6g3y3o2S7Ck+2oU/xBx791+0psGVIRPkqGAv9xwnotaymiqvZLfCQgPEiZyOmCxmY1pF4jGLv6mIdwo7YiXy/0bfddmF3sHPibmm64N+7Cc7mF/87diMX6ndIeRz8oQOmU8/jm/M6zzxm6iII6k+I7gFBD+GyzAnjjksSiHi9SujWtVJawu/FzfWki3f9h9nDOeEAahYAv5gytBN1b/kipsCnyhX/rQGhaLTza7JxhM8sZiJTPEhqwrv82c4VWuduavDB/+HZM1ZyY1SIqdfEUTr3wbl0UbJHNUEJaCuJ/INDCs2jENS3u9iUW8hb4NMfp53kBUOxhSWORuDQjd/qw6UlOnSZVU3NiLOgUsDzGtSeT5fDfcrJgpu98jYwrroDrNKj1CCHPXmFgeNDBnzaYfP2mz1eioM1QguYtG3LtQQn6kGTxG9z9bt3k2J/VfHeg6fryOZp2OYbqccaJnxvkpRxqK4bJ6faoatVZ+CC6ttxYMdewgasHn5zbYR9pvc/OUYxtBrROJL6zJ//XtRv+GwC5j3yCZkPh07sVsxGOJMjjppaTwYwrmE1xVOVxqFUsHNqYHnQLTq7/smh4zC2ktZJzSnK6KMUuNS42g0Id5yTQV65e/tm60/ebHFuFA7XLdukL4NNB4o=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(4143699003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	19TPAok8zgpWxw1hUUDEWg3j+FidomHHMgkSX45at9KE7R4noF37SRD9ifpJuZgP6YhXl9MdrMWDTeMmq4JIXCm0UA0yay5pYIDCMjATAmEKTRBhmeNvVfqu717xkRLSKw+tz/INF5XnDsoExL4Cpa57ghCxnDT3zPDSTNfCxu4FSVrt4PVz3r0oIul9JCx49nefvAOSOqFS4kDSKGVpMjn7M83lcVgJZ2hGN+KxsHCwG5gGPMqTNZ8W/LIS3GsQZCGsO3/NUZlwFcgdOOz+AD8/TSruqV0kDtrWVIiREmal7hincibpMBmbE87eAfOd8m2qdFk9m0rqt2wEihiqaDRhsXCFEJ6aNE4bI1mvzdB0s3y4uw+twqsnoK/qlCtDJFspJWTs+Q0iEoGFpnXBp//UGcFf4s3319XV4MmuZiWMNskLnOnXirajvzVSoCoE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 04:06:39.0491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a89f86c9-644a-422d-2a0b-08dec2b7d7f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141

Hello Mario,

On 6/3/2026 7:55 PM, Mario Limonciello wrote:
>> +/**
>> + * acpi_phat_get_vendor_reset_reason - Find a "Vendor Specific Reset Reason
>> + * Entry" with the matching @guid from the "Firmware Health Data Record". If
>> + * successfully located, the function will allocate an object of the size
>> + * "acpi_phat_vendor_element.length" and return a pointer populated with the
>> + * content of the record.
>> + *
>> + * @guid: The "Vendor Data ID" of the reset reason record.
>> + *
>> + * Return: A valid pointer to an allocated "acpi_phat_vendor_element" populated
>> + * with the data from the record with matching @guid; an ERR_PTR() otherwise if
>> + * no matching records were found, or if the element could not be allocated.
>> + * If a valid pointer was returned, the user must call
>> + * acpi_phat_put_vendor_reset_reason() for the object once done to reclaim the
>> + * allocated memory.
>> + */
>> +struct acpi_phat_vendor_element *acpi_phat_get_vendor_reset_reason(guid_t *guid)
>> +{
>> +    struct acpi_table_header *phat_tbl __free(acpi_put_table) = NULL;
>> +    struct acpi_phat_health_data *fw_health_data;
>> +    struct acpi_phat_device_data *dev_data;
>> +    acpi_status status;
>> +    void *data;
>> +    int i;
>> +
>> +    status = acpi_get_table(ACPI_SIG_PHAT, 0, &phat_tbl);
>> +    if (ACPI_FAILURE(status))
>> +        return ERR_PTR(-ENODEV);
> 
> For some further sanity checking, should you look at the PHAT revision
>  here matches 2 as well?  Table 55 in the linked spec.

Good catch! I'll add in that check in the next version.

-- 
Thanks and Regards,
Prateek

