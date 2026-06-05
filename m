Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69E73BBFCF;
	Fri,  5 Jun 2026 04:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632188; cv=fail; b=eIUsfCLGnpJ2s7zy//tuQz5eO9qkZefUvSeGGfk2GzZC8LgILbh2FcAeRp8ET68uSFlGJsU+Femgn/SK4rVk6ECsV/FjfEKyeg8vUEzgl+SJBtUnY8w+R/sqGR2izD+EcUojno1vzCBfdcZa+LHKE0KrsOG/IZwR7sMOlwAkl8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632188; c=relaxed/simple;
	bh=wGN96wg/4EaCO8jvqIyK4ykGN0uvUg6xh8sU7BE1GL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kenfd+WDPn5VTLF+GQSOYuyEeuVqnaDX3x2KfuMgmWnU0DMz8dY1UBsj/9Qt/xmU35QsQb8kmFOp5GOZth7LaJHzWRr83ne4W/GtKs3pa6Vex9fYKGVHjYrkIH1Li6+mZGkOPWu/60BBJ8Y/FArCAwUV3TqcrlmUMIW3+tBYGA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ruS3O2KO; arc=fail smtp.client-ip=52.101.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ruS3O2KO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SntU0NLp4hLCL0KcZMSK5reAlKOfnz2WlZ9YNl7I6OyDUtNU7f5DEsf21T2SYTi9GBIz8e4xwyOY9mexKaOwdh1H3NtimSTcVGZlFVoaWnA8y9fH7s3KndvgAkimKTvWc+uXFVNPnhjEr4wbEzA6hCqHCwq9lMAui4muOnSef83z3T3NMMGLWDyLe9jFXTU76kUZkKnWO74FDGYeWVUc2CUMiPBKpRT86cLXyTGpP/5TqNEJ6xnAjAcxIm8MTESX0eWCWuFojD9axp/mF+OMb0sfYTDe6q/OmtzeXNjvVnbcJTicknVWI+nOqp95zE2Ebfm0saODVGe3IskAMW9wKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7J8kafN3KW4d88VWPQHfBwo3zYoOp/e0FBQA/oXEtY=;
 b=SOtzhEWpiFXUVb7VJxbMkMdo7N+6yfrJG679tAvXVBR0wJKAFBuot0vcXmotEkBtno+hNs0v1n6q+VSbOBx1eA7t/mvztEfdAw5BiYRWYTg83qJySmUfji4PIG5Z8YF4J/GwYkimlwAHmdadMmz7BDN2OYQkkKNZJnA4F8UEms/+qBa+GIMaa/SPsC3p46Vf4aNSAqOZqrVWLALdKsziQ7s5/58prIktViGcd3UhHUcnjiBaHrF50Db+OfRFoOoS0lgwel5K0072UaGcj7JC/Xn+D7+VKl5l3WwPSD/eUPLO1Bt+7pthq+e1UvIE1pSVLayfX2DgIq1tAY3faEYedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rong.moe smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7J8kafN3KW4d88VWPQHfBwo3zYoOp/e0FBQA/oXEtY=;
 b=ruS3O2KOnRKAGpJOpa18njq7q2ITK+CnhE891m2g0Pk3Rryz7eClFR74C6Z72JejuvQO4/hbJ0SQ9V2UDT2yY1tzkN2cmVMFPgkjY6xByClrchqgapy1MMfcVUJb0f5GeEMNuHTHYIOHeevI4ptFka3SAIXER8OYAI1CX3gpEbs=
Received: from SJ0PR03CA0341.namprd03.prod.outlook.com (2603:10b6:a03:39c::16)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 04:03:01 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::f) by SJ0PR03CA0341.outlook.office365.com
 (2603:10b6:a03:39c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 04:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 04:03:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 23:03:00 -0500
Received: from [10.136.33.4] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 4 Jun 2026 23:02:56 -0500
Message-ID: <b9079f36-7d9d-4c5b-82ad-83551163a3b5@amd.com>
Date: Fri, 5 Jun 2026 09:32:55 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] ACPI, x86/cpu/amd: Parse S5_REST_STATUS from ACPI
 PHAT on supported AMD platforms
To: Rong Zhang <i@rong.moe>, "Rafael J. Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, Mario Limonciello
	<mario.limonciello@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: Vilas Sridharan <Vilas.Sridharan@amd.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Mikhail Paulyshka
	<me@mixaill.net>, Kai Huang <kai.huang@intel.com>
References: <20260603063317.13665-1-kprateek.nayak@amd.com>
 <db42e87bb1404578f33b2c921bc69af73a33c9a8.camel@rong.moe>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <db42e87bb1404578f33b2c921bc69af73a33c9a8.camel@rong.moe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: c742acfd-d442-4ee8-3821-08dec2b755d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|13003099007|921020|22082099003|4143699003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	J35p+ujezqw4bQdJsh+ghadjqHPGLAXpj2Wsb6V/somtiRMYjxKIvHAjCsTbCKorX+zW2hrzo6u5L5MLh12qhYi2nuoXeW14HJF1FvlQIFozEGacFtqu5ZRNZLxiBW5PQFTdOl4dGQ7Z23fAcb3v/nuv+pyR+Cd/sU8E/4/XTSC3Rgc+bOAZgCiwq8/TIGbxFU2Qzqb8wUOEWQP0DKYL2IRK3iDj+Wh8ZOj90riX5mTAWUqUJeh93eggd6A3vlIwtCDdPDMYlf8jLX+wxfF4TEvPIjH+jVdQMP0EopqiA7dGC6YPee5abS9wPWUhuDE+ZN4nQTY+8lt75RzA3qfcxvMc7lQxmHYciz+swkrlJs+6V46KvIf/Lh4pmoD+3UTOXjyk2uRt1pII0j2pe162uj6nI1mVqnlAO37rjHSreDC1M/z7+kDBssSWQ3rdMEKTclkaWNJ/RAUgdMrcc8k5DZCbtNkTIGutBxeRIbBqPcHcvcJLiOckcx87/SsGEcUK2vjDhGeKVKzyLix457/db3AngYyow/2xctjZe1n77+csct3tGO80jXAmwDz+lAYjg/LOgNoewQns7IpyQw1TnSDdU7vhIOdbFzWTsS/OgquSmKBifSOP9t50ATJSbhUktqQeSd4I0Q3g1dqkUY34LvB+jgAkdIpAEOpVSSJf6XiiWQnhSt9WT2LhtL67w7GjuIwY81j6ol8+a4Xs9p5lDSbtXs9qzVE6zXTjih4oUJNar/0F7WuhWeLlka3c+CxNpuYJwn/yhrVba6r+xjjpI8SRfYFQI4oeNVCHOYtT7Dw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(13003099007)(921020)(22082099003)(4143699003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iKiz8Co0VMswrubA9dEYYVB735eg2BlzVe6IDiGY1tik8J2fhcV9Syb4YzEkNrGtRmuwb/i1ZEQaL4L0XN/g99gtuKHglvoTWR9cJGG3H6OYGQmvJ75JxF6/JA/at8zI+KPsrC7KoasCJL8qF2LK8OLGyJD+sxv8VyvtmXG+XbXrRhtGBWJgJNsTdD94vSo9dFHCRVD1728BsR/KlaLminy+B/MVwRGEU2M70lFHi11dHFAfDBWr+yNYlW6VFm6ZB6QZ6N/EI25KZFJmIpvirLJXUaEr1hgDNmA0Q0oq+5c8cvHW9UC5Jb2ODPIC05QcfxE6vYDuq5C2YnjCKM8OqeSzHQ3bHUqRs9bKaYD7hXe29Q2sF4GjcS//lRJUKbfmCwKkvPYGxXCgpP4p+CaQbN1mb1vE/TZOlTnKdMh8IAuJdFS3yhMvwt1lcahBZ+mA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 04:03:00.7000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c742acfd-d442-4ee8-3821-08dec2b755d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461

Hello Rong,

On 6/3/2026 8:07 PM, Rong Zhang wrote:
>> Since these records are read-only, the status cannot be cleared once
>> consumed and the last reset reason will persist across kxec until next
>> reset which reintroduces the case prevented by commit e6416c2dfe23c
>> ("x86/CPU/AMD: Prevent reset reasons from being retained across reboot")
>> by clearing the FCH register once consumed.
> 
> It's not only about kexec.
> 
> The last reset reason register could remain unchanged when the reset is
> caused by a voltage drop on a power rail, probably due to a broken power
> supply or VRM. This wasted me a lot of frustrating time debugging
> irrelevant reset reasons.
> 
> Eventually, I RMA'd the broken device and submitted the patch to save
> other's time.
> 
> Also, some bits are not cleared by hardware as per [1]. If the firmware
> doesn't clear them either they will persist anyway.
> 
> So I'd prefer clearing the register in any cases.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=206537#attach_303991

Thanks a ton for the additional context. I'm checking with the BIOS
folks if this PHAT record behaves any differently or if it just mirrors
the FCH::PM::S5_RESET_STATUS at the time the firmware loads.

If it is the latter, yes, I agree with you that we need to clear the
FCH register regardless. I'll adjust the v2 accordingly based on what
the BIOS folks come back with.

-- 
Thanks and Regards,
Prateek

