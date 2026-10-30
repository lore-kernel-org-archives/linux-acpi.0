Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.84.38
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793357742;
	b=JtGSyjx51Z7XN1FOjdYkUGNFRbwV6FJlNiR+uqaLzzJqBVB+M7dEukIcR5uYDJ4M+Fqn
	 ebF1DQqrtO4DD+LDqmRfJFywDKkeYCN0vkGfbOa7I0qrWTpxuAO75syJDB7vjOQLhO/rn
	 ZBeEivurlkau1SxdYWyWVje7g8r7iC+20rMAcvst7zGJ7QsjIBchO559ZsTse7Tf76nyu
	 naOav5MvJPeQx/iT0tN7jlMjTUjX9XJf783fhUfu73wtaO/lZuVDBgdoyQMsMCKEeaEkJ
	 3ovFPCiWncv98b6GPLjmt1q0dGjOEDW35CBd41etbCk8PXvukWJpZ+vDJbRhPpyDdFQ==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357742;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
	bh=CD4b0oQMs94Xi6NZtsuKk0l+xA4ikDZp6jPB4p4v37g=;
	b=rfKaCH3DmHGXQO9OiPrgBbzx6FMj4F2fyAQI1Yzk24eZZYZ5iiO5ja45KcMvyJxybOrL
	 OuOOgHjEtH7FtxMLUU2/A9ZYLRZP75wBUgFN8COq7E5eCx70IM2lMZ+ZoXrOoI4wpxfqT
	 BSjc6FY9M5uNSLmRJgioH6t0wJ98p4vT56Itq8U8DUm1lSWHNochFtNlxSbbbm8h4tPBv
	 PiKqE/WXkWDnszJn7LCoOkN6GMhLxaOMWEkpZTNzg0gjaWEJIC1hGdqxCf3VVhDft3FYz
	 TOREAZVs607qe247LMb5s/MCEqrL8k4a4+aPeH3yRWkbD1JhPYxgFA5gRVOHM6xqsDg==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="Hmcff/Qh";
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="Hmcff/Qh";
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.84.38
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C9E606A8D5;
	Fri, 30 Oct 2026 10:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7C9E606A8D5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Hmcff/Qh;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Hmcff/Qh
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oS/QrILU9jlDlUTkFjV0bp8pp7UQxL1/L6WetCkeLvTTDTXZe9PYngApZ6m9WNZe+EmMZeBk4r47cxv1zlTHW7y6P5NqAIcPXDP3kscUakwjOc8jGFQ3yG6DTAJE+ode7Zfk4b5aYU7St5eJFk//FRqmD8RIwomPm4zR+bLrRiUi7Bgpd6oIxaha/aRGxh1zMJXnAVT09vaKhQPxYLVlJNvajD3N2RhA/yVKijNrgyvbSxwJ+6YTvo7e6WpFfMOrdR0DpnLEnBdIJLqK1mHxTAD691x+BiUXMIwURpS5+3jlqMtdHe3hWmqncGPhiyMCx/ZNkcIUuhrNq1E0Q21rRQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD4b0oQMs94Xi6NZtsuKk0l+xA4ikDZp6jPB4p4v37g=;
 b=PXGpImbhfREHaasjytSf+54QP8PPpEhG0IXtU8sCuQSyiHCKIqOnoUj0TSLZZvMr9Mye4HbJYYox4NPBHu2mvF8dcGsa0phBKIPvuT4+RaXna7ZBnA7iuP5OcQuFq01afu61GpySHTwL4LiDd8+Yh2Yqq8ll6xMdbRjYj9QBMsMnLpcDABa6vynK2RkKkzv4q8wHQi4SV4BI/+ksw7GhjOS49ru/L4aiGS0lNH/f+SAi16pY7Pb+ZjAgJJIeny16kRkPPRDqfQFyH90u39DU8md3cjDGmAKYvkf3kTU7arTYA1KLkYJ9S8IIvCQXMrk0eBFAJACDXE5ZOKd80CXorA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD4b0oQMs94Xi6NZtsuKk0l+xA4ikDZp6jPB4p4v37g=;
 b=Hmcff/QhcOvxRo44EhEKGs9q9s4Fd2Yyn2NV1vo0N/Xn0fHzhxVxX0KxEEBJMFbSxgv0ofjGwhZeiCLFfpiiJGJ6/KfFRFVswnpuO2TPC5Db044tH5YxieJvIJbm6g/P0P1HR0n3PVRrZ+GaqVFDIkMJVfqc7OymyMJhxLVZ9V8=
Received: from MA3P292CA0064.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250:49::16)
 by DB9PR08MB11922.eurprd08.prod.outlook.com (2603:10a6:10:601::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 10:55:36 +0000
Received: from MAD0EPF000008BF.eurprd04.prod.outlook.com
 (2603:10a6:250:49:cafe::9e) by MA3P292CA0064.outlook.office365.com
 (2603:10a6:250:49::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 10:55:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008BF.mail.protection.outlook.com (10.167.241.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Fri, 30 Oct 2026 10:55:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlOB6IcnWXD2BfXf9Hn1nBCKFY6djRXTNFr4O2QLwUHKqS6+JXZ6+x02XnBt9hQQPbIqSIl4bTKU1glwDukG1UhlfuRmzI/nCeJ1MMV7lQFAH8oadiEok539nOv0xmeywr9QuWhh6A1HLDOIMa5Z+VEK/IIz4Du+8pshLH2tgO1FyhZgVdVaJFTiqN2kcw6HHddeQNmo3tLaRfed3u2QecNRKqhagOYj4zf/HHE0wbBJxH8sV1B/kbaGcD573a2mZclStekqcijH1j4IqZIOlNyX1OqvG7GAH4QL3id2c8R3jKWfUFAFGd+DcMqcpAnw8i8PVK5/AvyWVp8/uWBwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD4b0oQMs94Xi6NZtsuKk0l+xA4ikDZp6jPB4p4v37g=;
 b=Ckpd6FacbpoQFWT4zMPmRMCYXXldNE8Fn/biiXxJSd+YWR6WJX0HiElimJzgB8ICzubTB5NfUEDeDv29La1UMHq50tLh/WpDwYTM7LvGc/KIWT8jjutnLi42EiWJiUHsa9sp4kg30E00w9bkOhKldVGlmr6cCSuKRXLW+nCgTIlcbGCv/iw5hOf5Q6zJi2c2g6oMHSqa8kmGHzCVdtkU6l6tLD5DqlR7cNmNZ2+SrdI37X1xkU0UD9H+FefT+sXuZe5sI4s4MvWzop/WxM8dznGb0TX247zmTbv/e6URDVMEkyObroCA1YwW+S8SxSxkObM3eWcMb+Mb7PivttFL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD4b0oQMs94Xi6NZtsuKk0l+xA4ikDZp6jPB4p4v37g=;
 b=Hmcff/QhcOvxRo44EhEKGs9q9s4Fd2Yyn2NV1vo0N/Xn0fHzhxVxX0KxEEBJMFbSxgv0ofjGwhZeiCLFfpiiJGJ6/KfFRFVswnpuO2TPC5Db044tH5YxieJvIJbm6g/P0P1HR0n3PVRrZ+GaqVFDIkMJVfqc7OymyMJhxLVZ9V8=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by GV2PR08MB11489.eurprd08.prod.outlook.com
 (2603:10a6:150:2a6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 10:55:02 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 10:55:02 +0000
Message-ID: <0942cd90-51dc-44c5-8672-9ac647cae8e9@arm.com>
Date: Fri, 30 Oct 2026 11:55:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] ACPI: APEI: add separate Memory Error Section 2
 handlers
To: Ashok Raj <ashok.raj@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Dave Jiang <dave.jiang@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
 Dan Williams <djbw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev,
 Ashok Raj <ashoraj@qti.qualcomm.com>, Jonathan Cameron <jic23@kernel.org>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261019203915.2019037-6-pierre.gondois@arm.com>
 <at0oOH1Pma1MvFlU@hu-ashoraj-lv.qualcomm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <at0oOH1Pma1MvFlU@hu-ashoraj-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0270.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:375::8) To BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	BESPR08MB999898:EE_|GV2PR08MB11489:EE_|MAD0EPF000008BF:EE_|DB9PR08MB11922:EE_
X-MS-Office365-Filtering-Correlation-Id: 9528b3d9-29ba-4d37-d2cc-08df367453c2
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|10070799003|7416014|376014|23010399003|1800799024|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003|261021123027099003|261028144727099003|261021121427099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info-Original:
 4Bv0X1MQ4xeEWUQPaEcSEsDbgMfGDu2WFLmhs6dzya6PK6YXdYJT6hLlnb2bK0/UUVySd+a78cgzPSdzDZ6wyU0h7YOLHYcteXOwZZf65iDoWqxO0vp4AgZpKyXXMQJ4KcG8ohDVY/LXI0mBmJJH891MsuS+lRmiDqbHwamf8Wl9pPCwQadNkdSZw7IHmcRhNovLQvRl3b5F1pwJvDvzjmer7FUYyFzqCPh90E90/NHAZl6qfFiEFGWw3trhrptAETLfIaF4JNg5Svm1sZHT2+g7kA7d+rUJIyrTuSpOMQH3uBUpP6IJvksxcks19vh7rQNog+d+DRiSCjKLExKjfl7E9+vCtUY7zR37EU71ZbZ0L3x5hNLbYGO7jd9bQuQ3qcqs/7/t9z4Vz9PlWpS7BjvyzaHbn5vWenERVojojMHMXkw6WPusYcD4JJzFohU58JrwIbfYRo/sK/boSky994kd3HK4COA456NkJXTDegRFpECtWHy6lVkxXtJ65XM3xtIujsiK71qdZ3Alc64V6p4ZU40+Aj1pbSxvFaBFjC/0vN0S129cWLOHKzZuUwrjE/3UE/GkjLqc3YHHiEpe54TB+Kb/I+yQLSopjfZBI024ET30CZ1AvKjeTaxrRKPO
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003)(261021123027099003)(261028144727099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 bhxONj6DGrOE4Ta31LKvswshk3QnerdRbR948wwoR6SvmcmbjcsJAG1Cl16F1hHmWC0aimMLTZuONNDV5ykm8R6N9rg9/OsW63lBpCHkyFRSEUARlc3ExCyPGNL7HAxRboM2w7qbxXZc91Bx3R77ZLgMzrVx+Gl6r+wtczI1o6S3x3ORDwVM9U6/dEui06FojOD9KLd/dEKauWKyf7PT/ec/fDFlb5SPOkyM0XGfg0hTD4KoQlVek8KyffpXRWMQMsH7mAbCcg0x5dwK/btjj+F3yuuRqv7L+Waek+BWLJLgTeBlbA+m0/pSR2IJud9nf5ajEJNEg1QlXS8vf0UlJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11489
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MAD0EPF000008BF.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9fa26423-1914-49f2-9301-08df36743f6b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|14060799003|36860700016|82310400026|23010399003|7416014|35042699022|1800799024|18002099003|22082099003|13003099007|11063799006|56012099006|4143699003|261022105027099003|261021121427099003|261021123027099003|10067099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	0863J/4G2797Iqw/cgJwdZtDm13uVNOV3IYV0yp/9t3iun8u3LlQ85KKPboujzq41B+cCSEdZ4Ra4W7PbVy9y4nvjU9oACs/lcKPPqwElm4wbvmP3+nZBAcEJNtO6aBkPn8zPmVI7Koytji2OCLKrbt4yhez3okWgriGZfZo8KNPRFG8JlcoR3bzpRGxXPnKxY7bCbVItVfFp3l0c2VMRBkP+oRTAdq+wntiKUI1H5a/A/aD0KtZ1tZiP/YqYovv7Tjj8ws5tOxb8q4M4K/7wGRZqKHM20ZByauf4F5y5f8v9tFYt7xFCELc69ATJQL19PnU2SKuTgabqb08M9y3NWiQq0s8cKVwc7Qr9Nt1S0wJ3+A0Jx9Tx4EU5jWKJcVUxS0NDKwNTx+A84E3hZW1zAVUIR6oUub6iA6J7ldJfMXmh8JL6fxPCDks1pZxTSqn5f23YHoe48ZvZ1jYndpA84zEnP5tJawflvnxnwmWZUAbs9Hal/XqdqIBtkQnAFeSs9F7/FHmFjRwiyKz/dqXM10AvqnXwKh9ZamXvDBduwvSp3QXsWwtYBvQeQviLBsDTI+OC7Rpapl2li0nh7RYpyke6XzTsFK2MmIse8YvTRG4/sS2dXWBdkm1j3u0CSOPH/A6vGDgRG+zWaH/9pyKRo1Crmoz149A+sY3GhSAWnk=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(14060799003)(36860700016)(82310400026)(23010399003)(7416014)(35042699022)(1800799024)(18002099003)(22082099003)(13003099007)(11063799006)(56012099006)(4143699003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/fmFtiH8JOeDQFlRIM3gHfHZvYOookAKz70V+ZbdbvfAJBtInIAwBWdUeLfKbrbyNd3ukZYA68CKqcTN1QaJTRD4JHCgWqog25Pvt9Qw+OXz5WX/mDmK62Pm5L88nxKUAAAeine9i/hDTiJJW8dh4Gspw+IqZsSumW837jpQRdvYWKcxNPg9ShtqSkJzMoEreIfEFE+VJNIZWTQKQWKKZ/SqctJdcJjhO/MHQNLGw6UR0PVd5+Ncgq2J9wVgYrBWFMW0Njy2BEaMD30VTpyUoCFirNAeqQd45SHMvnK8FAo/Wug4MKLJDIJHRa59eOfJtgPD0zbXKY1l6wd8eP20yDyTeb7QfUc7P6JY4jvJEsB0CbpeBxS94wINbhQyG44vPrCTJ5Uifhbc584xn0zdmrvVi9u9QChpwGL8MmlusgYJpFsY/P/j8gfiUcd/0Tth
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 10:55:35.7682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9528b3d9-29ba-4d37-d2cc-08df367453c2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008BF.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11922

Hi Ashok,

On 10/24/26 23:50, Ashok Raj wrote:
> Hi Pierre,
>
>
> On Mon, Oct 19, 2026 at 10:38:44PM +0200, Pierre Gondois wrote:
>> Add dedicated GHES and EDAC callbacks for Memory Error Section 2
>> records. Use a separate GHES notifier chain so existing consumers
>> continue to receive legacy memory error sections.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/acpi/apei/ghes.c |  49 +++++++++++++++-
>>   drivers/edac/ghes_edac.c | 118 +++++++++++++++++++++++++++++++++++++++
>>   include/acpi/ghes.h      |   2 +
>>   3 files changed, 168 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index fe10ab0e02f6..c7fb15543b56 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -101,6 +101,7 @@
>>   #endif
>>
> [snip]
>
>> @@ -952,6 +977,16 @@ static void ghes_do_proc(struct ghes *ghes,
>>   
>>   			arch_apei_report_mem_error(sev, mem_err);
>>   			queued = ghes_handle_memory_failure(gdata, sev, sync);
> One issue here.
>
>> +		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
>> +			struct cper_sec_mem_err2 *mem_err = acpi_hest_get_payload(gdata);
>> +
>> +			if (gdata->error_data_length < sizeof(*mem_err)) {
>> +				pr_warn(FW_WARN "Memory Error Section 2 length is too small\n");
>> +				continue;
>> +			}
>> +
>> +			atomic_notifier_call_chain(&ghes_report_mem2_chain, sev, mem_err);
>> +			queued = ghes_handle_memory_failure2(gdata, sev, sync);
> could this accumulate queued with |= ?
>
> queued describes whether any section in this GHES status record queued
> memory-failure work. The synchronous GHES path sends SIGBUS after the
> section loop when `!queued`.
>
> For example, a synchronous record can contain an eligible legacy memory
> section followed by a Memory Error Section 2 record without a valid
> physical address. The legacy section queues memory-failure work and sets
> queued, but the Section 2 handler returns false and this assignment clears
> the previous result. ghes_do_proc() then reaches the `sync && !queued`
> path and sends SIGBUS despite having queued recovery work for the earlier
> section.
>
> This series appears to be based before the queued accumulation fix [1].
> Could the new Memory Error Section 2 branch follow the same pattern?
>
>> +                     queued = ghes_handle_memory_failure2(gdata, sev, sync);
> should be:
>
>          queued |= ghes_handle_memory_failure2(gdata, sev, sync);
>
> Otherwise, an earlier section can queue memory-failure work, while a later
> Section 2 record for which no work is queued clears `queued`. For a
> synchronous GHES record, ghes_do_proc() will then reach `sync && !queued`
> and send SIGBUS despite recovery work having been queued for the earlier
> section.
>
> Thoughts?
>
> [1] https://lore.kernel.org/r/20260925-ghes-queued-accumulate-v1-1-df50553957d4@debian.org/
>
Ok sure, I will rebase the serie and do similar changes
