Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0EA5328A9;
	Tue, 29 Sep 2026 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692290; cv=fail; b=aBwp5/P873l0FFIux64n5LIL0xjTa4Ws14WsF8DveAIrJcUSF3nQj9LXc/IPLhDuYJ5sIMKloWHMN0NGA0EodE7vp/BTLEmACOCzAiJyPDRHTt2zHPOwJP4FAvFfNARIuswrMzi6j73NUpSocIje2LNIARU9r49aO/zGbbqHLhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692290; c=relaxed/simple;
	bh=Zoq4YlGaGFax50uipab7CuYdGDntIExZ3z/3IuCWi1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bt3F7MWRrzryAh4NXt0gkFrSpL+11VOPwnhql3RIVrZEVujmd8XahEl2nBv+mURyNP5l0vkC1C8w3z9DFbOk3zFfvGo1mkrsLT1nwYpC7v+cyKluKFbBk5S/JVEcBqKcXneV4MCbuht828x9DlL7717nkqsQFi79h13DFErrELs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GCPoaZwz; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=xqqN1VJv; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GCPoaZwz";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="xqqN1VJv"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TEDZ583443158;
	Tue, 29 Sep 2026 09:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=kjECZh+XuKhw5ux+2I2w2UZ6SZEaQKbPqbbynDCpW/8=; b=
	GCPoaZwzccBA5yPsTmbtHuBvm+90AsF7gYTXk93uqFt5pHuKlRbJbyUtXrrmYnrq
	XvAdr+0t5xydNtVMnrPvrw3qRQ4u/24WRWdmi4GUCk3v/C3RnED3QsUHaBOYJtho
	dW9oCqcdtIw8T2WB1FzhNYpEe7ZDmJu7EBnxWNDT0Lty+JDTBaKas4xqzscpLfca
	3aaV4NpbqpzX0u8KhOWhjT6Gwd641+BXY7FA5SWCkAi1reZrzB1kzQf2XEjpZAeJ
	nCD/H4ioZvJIGqaRof96npCrEYmFLYssMshp/N3nfmgoATF+y7WFFOUEMAHawOCH
	AS6Ur5B3YVD3A+SsOptuRA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020129.outbound.protection.outlook.com [52.101.85.129])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4gxbf0kwxf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 09:30:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLFhTExxCPnM/qKXwK75xHQxL2xx/D8CRjFaMx89SaMoRRPX+vOA7niy3cqiqVCerIJWYfC2DVDGEc+diSD4wmc2TyZJVSz+HM8XSPs0kehxWOLL282adCGmKh1oiB+J6+nafgSOc7WLF8Oomvu6R1dqzIasxHbU3PnfuK58Z70SXFnzCScb7bT5xPE1uvzci21xEaBzuDPRhSqKZxsowD6BbHcaw1w2btsOTlMQXG/6eM36uPC1azbTXh89Parfuy2DJKB6axOx2qnYKEV5SCl39S+KaCiqDi3ZcxMcdfykQOxZcI0i1/pX5cVofnq81QCU73/M4ZNDarAjAw40Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjECZh+XuKhw5ux+2I2w2UZ6SZEaQKbPqbbynDCpW/8=;
 b=J8zFUdydCq9fPZ6FtOaDMmGcJ1PWfzR24hDAzCGosmrPiU9/sAJLYRKCMhMoFMOEnRXgROQfvCAv595RggA/oAN7YvWRt6vgfmuFi6oAxPuHvyf4Fujei/UGmZsBGNResiYzSWNQK6pVAAd62tvpxGET0xNsM6hetKaGaZwO62hI5r5BkM4nlER2P8sRUC/7WnTRKX333qw1e2MwPQlwJ/0FOcwqfNldNMGz8DgApqy51XGL4bkVeUedyrNE8Ubyb3l70g9MQ6+EJV3OQPJPpS9d4TKu9lkefWEQZhqkvi7FJxEePWFoz11zReiwMVWsKNRJJxwl32mIOIcZBt/z9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjECZh+XuKhw5ux+2I2w2UZ6SZEaQKbPqbbynDCpW/8=;
 b=xqqN1VJv/4epPzvJwg0nmV6x6qnQAqfA3nvyV1lkd0HOXKA7MknUAun9nD/G3K/yGujArxt2cdIg2sFy8nExXY7o8k38gf6yIKAHI+KptB0yTdsfpf8oinXkp8juvACivOcqKfXE6k4487vWysuNnxoZValbwCgJ46wzM0/G3Z8=
Received: from BN0PR04CA0066.namprd04.prod.outlook.com (2603:10b6:408:ea::11)
 by PH7PR19MB6529.namprd19.prod.outlook.com (2603:10b6:510:1f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 14:30:44 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::21) by BN0PR04CA0066.outlook.office365.com
 (2603:10b6:408:ea::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 14:30:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Tue, 29 Sep 2026 14:30:43 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E53A640654B;
	Tue, 29 Sep 2026 14:30:42 +0000 (UTC)
Received: from [198.61.68.159] (LONNCK4V044.ad.cirrus.com [198.61.68.159])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 85C8A82254B;
	Tue, 29 Sep 2026 14:30:42 +0000 (UTC)
Message-ID: <764f8a2d-c949-4297-bb26-af0ba791f331@opensource.cirrus.com>
Date: Tue, 29 Sep 2026 15:30:42 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add support for the bass speakers of Lenovo Yoga Slim
 7 Carbon 14ACN6
To: Takashi Iwai <tiwai@suse.de>, Ilya Pavlukhin <i.pavluhin@ya.ru>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260920092808.17234-1-i.pavluhin@ya.ru>
 <87a4p02xxs.wl-tiwai@suse.de>
Content-Language: en-US
From: Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <87a4p02xxs.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|PH7PR19MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 940f30a9-eaf0-45fd-55c3-08df1e363eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|61400799027|7416014|82310400026|23010399003|36860700016|22082099003|16102099003|18002099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	IJLy+yoIe7f4MRd+Vja/1xXg9HdwOIMwoUQJTSnj5xDYDr205fjxAweHcMhdcagJxLX/2bnmAFVKS0maZ2vhZ4T3UM0fv+Cpa1JUQw9jz2eqzsPqljV4UQvx2KwgCm0nPTdROrXKvVWEGqm1rOD1Ng/tF+1zDIw2T82bY09/O4spmPyqWekSy1JpTUUjfk8BY0t7zBGzZpZleWrJUnl8oObcQvPDTIHoO+M/dzuVR1FObMIlUDcyuadH7NqN/ZIbkk115JB33mwL0YKH3+yomomnemyDobBgZMpPScOu8uvHtce4IwHuJ92KDukkgDszhDOONtwsNtFWgqJSJE0BJnPqf594LX54qVZOyhiEP4nuymK39PPmvTSwutnSb6kNc1u7XWutTicDaIR30C7tcoJHpeulUMSGa6zKCdmhnW0Inrh2rmnAAO0D8Ri3RzNN/saJbcrtyobzNE46OPlsBOkc9JHKOaDiBYUmhyNbv5pbIBAvUZx2h9p2i6VjBVp+PVLsSK4jMzrA61NIJTwa789cIdwcTu0P7YmD0riL+Wee9BA4iiybk3FwaYgBeL6/aT31L/dyU2QMCWzGuAy1r4D2ZxfqeTakDHBnKtVe9siXbth6BR7USeannSlmuuUKeCKWYq9Vll5HH04nrr2cJcOhHBpkPqzKFRJtkpJt4BBkXtg1JEK9RZ7dQ5xdo67XiU+NVPUkTExUJPIVaY9xwQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(61400799027)(7416014)(82310400026)(23010399003)(36860700016)(22082099003)(16102099003)(18002099003)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qgH+i2HMdpxY8IoGPYJ999dDdFEygUtGjRX2/IdN8SVubkTeBj8sJUKU73JiZMn5XLoFM+jjRKqOhjYewON4tEWpYJ+ydrUIjab+Eu+Y56qjudQ6itjR3Y0SXLIsvSBJBJTvLekLnwHSSG/sXGmu7yWHapbSwls4g68kRIneNmbEPlnlj7abl3XAGEtuSRmQHQg5z8luaPKUztzMZhC0x0168VDDTYjFU8ToiV0Pf3a/H7RJ11kHgyqQJUaVbZ9PAhMDCetZG1XLTX8SwLpsWkME76uXJG9PAbhtXnPAWEKosti5IYSuBlGW+wFEOPFHotx9UX1ccLZ/QzPbfUXnUsixn1WaNiAX5hrV/hkCVdTwnMu2YZc9vf6D8VUIS1gAxuCxmzSbrcvbRWGnIlUq2KILhSjfQ3yPzcbSAFp+fwhjxMybbPvB0Yr6uBrFjhId
X-Exchange-RoutingPolicyChecked:
	Fi1fqE5l8GSQOD1roTphkgM49oO+alQ1cJkBmjGvyNKOztrfESiKnmlmlxp+iydgj3thE6hclszXrFoYM2uFFgZ7LwhvkM0ETuAeNWy6F3bPmiaxq073CH9VO4fJPQbEeG5gJj/VG3hfPxBUCl3yZUdavBy3yA6TvllfwpfwEKiYkLeewxx5fG5kxh5pWb+If5OP8j2Fy9CeeF1vcWnj/4tAnvpeULlAXlC0dlXF5CLEqni+kRtaNjN5FatZxGSK7J/5EYDtzHZiqBT7Y5E9+KMP4Ppho/habBaLIIOUTz0MUSMXgHUuUDnVUWULENJZFM36ncpPUxkvUP8RlDWdaQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 14:30:43.6969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 940f30a9-eaf0-45fd-55c3-08df1e363eb6
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6529
X-Authority-Analysis: v=2.4 cv=GvLXaU1C c=1 sm=1 tr=0 ts=6abbcb97 cx=c_pps
 a=e+gafPXuV192R5FN4zVsvQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=jsC0TDLJNKffdWQaGCsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wYxuPvpR1xaN-7BIoZIDGllezDvn_nr8
X-Proofpoint-ORIG-GUID: wYxuPvpR1xaN-7BIoZIDGllezDvn_nr8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1NyBTYWx0ZWRfX26pr76hp0baM
 6EFhJZDp4ZjKejkQgt5VROWbK7MVC18URq6pp5MZRtpZLQlD7106utz+nVIc3AhtZkkbMVTgI4T
 aUJtWxcEEbOn6R/YmxtG24hNWgZMlV4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1NyBTYWx0ZWRfX/TEwbC7uNE1z
 8IT2U6yxmGiiLKBYhztvGDf2lWNHtXK17FMOcnQAB/+g9X04p3pd/Mh0kD1Kik7UGNri6XxdRvk
 0j6D5qqag1M6o2wb7O9gFoaWHxOombSYPRiSpFhIsst/R3/4ea1HBmgf1dj3aDYk2h1fP4Y1EU4
 YFDsBkIDeqssdIWPoTiKOF+wiOrzpwS214CsdLs1YSNt4dobN4ehxJ1CuDu9YcXjBsrndIM+eJd
 aj4HvPE94No4YEKcrHvPXTa3CxLmiFIMxH8ENZH6SXE+shhUTIhn9upF43BewiuD0roN4WCYtf+
 o3ACQ+OsUvNiPSVYtdIiH9eW/gh3//9xTWbu5v0hj9V5UuNL96gU7LhPy2KqTA/nzCSrDPOTG5C
 GZUZ8KtlRffMsRjFEtW3IRdCV4PpFoXadOxui+mP3yp49cXiYhed/PWFxiXNbXdT/hN0ZkOuEd1
 yq51Apl/MeGFsmBYJzw==
X-Proofpoint-Spam-Reason: safe

On 29/09/2026 10:45, Takashi Iwai wrote:
> On Sun, 20 Sep 2026 11:28:04 +0200,
> Ilya Pavlukhin wrote:
>> The Lenovo Yoga Slim 7 Carbon 14ACN6 (82L0, Ryzen 5000) has four
>> speakers. The two tweeters are driven directly by the ALC287, the two
>> bass speakers by a pair of CS35L41 amplifiers on I2C. On Linux only
>> the tweeters work [1].
>>
>> The amplifiers are described by ACPI HID CLSA0102, without _DSD, in a
>> single node with both I2C addresses, the same way as CLSA0100/CLSA0101
>> on the Legion 7. Patches 1-3 add CLSA0102 next to them. The Windows
>> Cirrus driver configures CLSA0102 with an external speaker supply, so
>> external boost is used.
>>
>> Patch 4 adds the codec quirk. The ALC287 only clocks the I2S bus to the
>> amplifiers while pin 0x17 is enabled, and the BIOS marks that pin as
>> unconnected.
>>
>> Tested on a Yoga Slim 7 Carbon 14ACN6 (BIOS H5CN42WW) with all four
>> speakers playing. The DSP firmware (cs35l41-dsp1-spk-prot-17aa3856*)
>> is not in linux-firmware yet. For testing it was taken from the Lenovo
>> Windows driver package (tuning "Lenovo-S760-17AA383D"). Without it the
>> driver falls back to the default spk-prot firmware.
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=215632
>>
>> Ilya Pavlukhin (4):
>>   ACPI: scan: Add CLSA0102 to the serial bus ignore list
>>   platform/x86: serial-multi-instantiate: Add CLSA0102
>>   ALSA: hda: cs35l41: Add support for CLSA0102
>>   ALSA: hda/realtek: Add quirk for Lenovo Yoga Slim 7 Carbon 14ACN6
> I can take the series, but before that, I'd like hear a confirmation
> from Cirrus people.

Looks all OK to me.
I'm going to send up firmware to linux-firmware for this laptop shortly.

Thanks,

Stefan

>
> thanks,
>
> Takashi
