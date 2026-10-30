Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.66.52
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793360309;
	b=GTMNpRwqOBbKr7Ps5WOFF058gMDFLeiFRMgrWbN2aZ8lFhoj1FSHu2OggP4kgaqKLhHy
	 1kuvzFdqfZMFPMzEpQx0iyQbCjfRpjL3LnNFnGzOfpQsQTaemnNPDf63O8Yh1NLgzUyep
	 22dMCfF+Vp7Jvc/lIz0RT4LmYa/Vw0qcdFworAwb80n548lr57Rs2tznru7/6imp7Ht1o
	 nawpknu4dZLaQ55PuwYdfxEs5WJEOabTU1kd0M+zc7uI8nWi6LuJnlY7nkfqVUZ6zfanc
	 93u6WB513zo2lohwyccw7BBfqt681XJFZaTRBSQOITKwrqNxrb27tPFIoXGPPV3QmPQ==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360309;
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
	bh=9o6rWwfcBo2JsUv/dE4WK/M4XdzloAkBgeukRoS7SzI=;
	b=CsKkFkyfMVJjHG8oxCGnz0PN66ayNjdHQiJoq7GSNltoftyPwpWKPtI4PnvY1ROYIVdt
	 Dm+EewyCweEXXsJm2kfHIO11jdaRQXvHUiHdPrwLxG535RrmCQfJWlwnE/AYIfyFog+5n
	 FPyYL7OINLfUFl3cB+MKK0ZRmSuBxDOjA3T1zQS+cfH8PBupatKRffYVtX2TAHRvM/NQJ
	 PEtrhl9YIlaYrXz8cYNPV5j0GUBj6VCu3ul2O9DPFm9OraBpNw2DsMBD/VqmSzzhH5+ec
	 U6gyE+gyKAKOpNzuloSWeNycQCjFq8+eA2aO8cnu2ZNbTIIuJQU55WobEHzBhJ/8MjA==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="pY4/+Z5I";
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="pY4/+Z5I";
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.66.52
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3E606A31A;
	Fri, 30 Oct 2026 11:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57E3E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=pY4/+Z5I;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=pY4/+Z5I
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KAYG52eyZ+Ngel+OAAm/okoo/Tdz/8InxiuNbQNUIoESpWR3IvdlZ9k+NIUs7hgJ+OXGDW7dX7e2jE7uqRGboIWfLenEujcirY5eYfk+ckjscDbHKOPBoQaWZ2SPOBPiQVBfS5+WKbJCIBRqjoLvBEUTpqkBMTpdOl0LlDjGfoa6epFh7LU7IYd7Da3l64Di+9hEcJ8DQRcM/lxpf+c2kLxkz5URkgOvJz0aaf9wszd0SUIDdVr0Uyncf8730jDuPqjfLtu4RR5U2S0hDXDuwM+ntRWkDKwzSk0xrH+C04H2Glvd1N8XMjgSGJCG8/nQFwImEWkZnNQoYO+d9002fw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o6rWwfcBo2JsUv/dE4WK/M4XdzloAkBgeukRoS7SzI=;
 b=kaJlAGg4vssXV4U8S0YO7+nOzNIB+f0CFLzy2o7bmez4BBZGtfCdcwNhK43onmTqhMzikV+u3SljLzvagRdC/WrrphwUTiEEuKFXY4b1mepgPvfYbIa11dTwFB9TvjQN6wRFxs9pyjpAjTsXAiwe0qDu0IaNCGZDbwSfT4QQ9gWMdM5KOHoH9cSE+8ydIo2PdtyqfsLszpASZCxkXeGom4mD/7cvZQWo4LabDJierugEeHcgxToybFlnp2yo0vFwfaimeyR9mvC8BYmq933/Pr1t/lTsGi+6bR1rBseP5mlflFpjJjFvAJ8xDczdiNcLrxQyP4aymj/wGnVaaqTxaw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o6rWwfcBo2JsUv/dE4WK/M4XdzloAkBgeukRoS7SzI=;
 b=pY4/+Z5IDeukQM9M5jg5N8g1LXCyRbNjphylQ2j3dRACNACmuQp0+0VkY681qq4fiJ8exb6//jA9BRjMAUDEg87Ty3BYOk83Tk27gqN1AdqY/qK+b6okNKH+fd4ATPisHLYjClVyTn+gMG9fb7XkY0S5CXF9eubJAFRQ71LwH8c=
Received: from OS6P279CA0169.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:38::10)
 by DB4PR08MB8104.eurprd08.prod.outlook.com (2603:10a6:10:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Fri, 30 Oct
 2026 11:38:20 +0000
Received: from CPH1EPF00000530.eurprd05.prod.outlook.com
 (2603:10a6:e10:38:cafe::3e) by OS6P279CA0169.outlook.office365.com
 (2603:10a6:e10:38::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 11:38:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000530.mail.protection.outlook.com (10.167.241.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Fri, 30 Oct 2026 11:38:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uINbn5yo04SoIPHtqMQ9n0THlECrwfAslqjExwk0cD4YkB41bdNKim1jiKpZuLzYxT+mB0/EoNQpLyuHdsXL4PGyhzv2R1bCMf3KaJoW1B8SKSNtTg+7523yMuuPeYZHKIMKlei5GH4dLjeWItMk5kTYURHUORugofqC2rR1RfX4xZnCA5ah8OUUwTI4lrRvv7XYjFFOt1+7weNr/GOPqdsjFpOaegt8r9zZix6zTT8MpaV6qaZSAjogcf0Hftj1dOm77rtb4yPBbyY4itwaNmQ4kvlmQ23V0HhJHAgO7+Z4n6m2mOwyYlaTinm5Wgv+AqSk20Qvl+EfHb+L3BU6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o6rWwfcBo2JsUv/dE4WK/M4XdzloAkBgeukRoS7SzI=;
 b=CKaD8uVWN8IENVvRQDsQYZIoN67h77nV5IcDg5ATBOITDFIW5JiI3jMCpcFf5Ve3w/LpsdNTgUG2lB+l1Dh2VBuy+1ozq2+0A99a6yvaWdW0MQvMzBN9PbMhnlVaT2hofoxqbXDgZAuzU3CLHbzubCJIPCWGKFcZfI0nH40/4DowvycZsVHuO2QrouLo/dutr/s2x79QlGK6AM3XyUIVJBPLcGRDqiGV5C9Ds31FvB2BhHbJYMFeWuv5E0nFPf+jbVE/QQiqepWPPOmM8eMlGTgwo0rVtCheAYy24AEvDYxV7YiCXC/6GJWpLzcIKZlSnoWntWEeAbuAa9itMXS9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o6rWwfcBo2JsUv/dE4WK/M4XdzloAkBgeukRoS7SzI=;
 b=pY4/+Z5IDeukQM9M5jg5N8g1LXCyRbNjphylQ2j3dRACNACmuQp0+0VkY681qq4fiJ8exb6//jA9BRjMAUDEg87Ty3BYOk83Tk27gqN1AdqY/qK+b6okNKH+fd4ATPisHLYjClVyTn+gMG9fb7XkY0S5CXF9eubJAFRQ71LwH8c=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by MMZPR08MB912510.eurprd08.prod.outlook.com
 (2603:10a6:190:59::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 11:37:46 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 11:37:46 +0000
Message-ID: <71b97017-93e4-47fe-81a3-081099a9c8c7@arm.com>
Date: Fri, 30 Oct 2026 12:37:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] EDAC/ghes: Extract error report initialization
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
 Dan Williams <djbw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261019203915.2019037-5-pierre.gondois@arm.com>
 <20261020100937.00000d06@oss.qualcomm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20261020100937.00000d06@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::13) To BESPR08MB999898.eurprd08.prod.outlook.com
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
	BESPR08MB999898:EE_|MMZPR08MB912510:EE_|CPH1EPF00000530:EE_|DB4PR08MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: 62054144-c657-47d3-ba2e-08df367a4bc5
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|7416014|10070799003|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003|261026121527099003|261026140227099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info-Original:
 4fF3H7sV/fDdNWbwNL2fdn/hcK0GSMlgSkNpenJdWuuEdyyrpWOjKlpqGrweRowUZBhIdePrd2rhqn13OmvJSpxK2/If3Q8Cv+at3ldGeFwELb8ro2QqBzpdfJU478cvi0q18w9JFGHvTXk6iiTY8/tpg6osPdrTvLJzOVXO2+RBqkLjSoA8okQV5OmiLUQ5jXfoqm/YDV+3N8B6GOCFxaGIcFemaCPyluVMsPUwXHGFYG9W81Simvv4dXxcLs8CwUi4W4G+rrMN68tY//LaGNbHDD8YHuj8tCTn2ewOXwshWJ8ZbN15x8seNWPRxo8r79zfp8EW3TFHdokT5LQeJy6yn6Ce12j6UTH/x5rg94kGoEEqa/FvzZfSz7DlncaSZhBu6S0FsKZJn4JYxZ9QR9KVRt5EgZzly1D3C0qYPbxXEnyacnrB+ciYEqgWr8+R7iV51hS8TZs8dd/fsbSzM5svpuQft4HazTpW7i1PmMM/wKT23ghiOEGK/rGnu3GcZammYIWBGe4bf0J+GLU0Mu4Dj+0lgKedAOfq5pAoXQOkpmUruCHyuI2JaRKAMqZldyXyiYJUX2EC5xTvDQOT/MQ8h9s+v3UIyB2KE5EdsRHfMTZJsuh9yJcuLDUIYn3IzKix6VjF+d/kkOdrCEkRYpMXY0lMWeWG29OAw33f2Pc=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 o+PNKH9Vo48yLxrt3y2WhprNEB9wqPRplvZ1ISSA6AMZVVW/8caOW6LfodFe8ZIDoy6dVcW5soDuoz2JbtMHKL5sJSD1nIljzvVN30nIFzqaQBALGrhRh8aq7qeXhR8PcGNin55rcatYdhjSGerk7fvVmwWeaMiPfD3VtaGRS9XoNYNzROvZXxDYagFkJo42deBNq0hxRQYcc1tfKXI4z+EdRDDbw36zILuN4jLLfvi+sOknqtCW1Rc8WzAqxRAgFrVGa5YjKEotI1VPRZp/mbZ/Ho6FP1qCdsje1gqd+WPzrVaAE6v2baWa/71fmC0UdOsOSqxgX2jhkQpnQpbs+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR08MB912510
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 CPH1EPF00000530.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7043c8ab-024f-46fb-9e1b-08df367a37c4
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|14060799003|23010399003|36860700016|1800799024|35042699022|22082099003|18002099003|4143699003|5023799004|56012099006|10067099003|261021123027099003|261021121427099003|261022105027099003|261026121527099003|261022075727099003|261009223027099003|11063799006|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	pbYKZaSvLK8fuppUcPGcPc8ABV7sdGXLnA+YehOW/EdXZbRhrqOE8+/bzByvRqIMnnfBD0JZWkHFB0R0x9bt7R57ibOpZGh9ZQFVGx2PWuaUL22wlbZ5/EmRIxLug1R1xmAdoj7X0A+XQM39VRSilpn5SXo4+I70TdUG9ktqQab5y56YIuhUFbL7/8FKwvQGaBkfYkes8bX5uZVnp0hCb8661WWcJ03ISFmWPFnPZPnZtxlgTnFHxKzl8bhKbW1LN2+uXL2y6b7RIlAtWPhhLBM6BtpQIQSRJrz4Zm+KoqPxqPglHEW+LHHtZSZuxzveL3DfGlvy7plKBW37dSEo91CFQNFfXRdrBo2LOxm96pK/cWCGiDEtKKcu358cIY3OXRZmG5uAY0CETX25iY2wzzPcGeJYyqOF5daVtu6Fo2dsTrkPW3KRxKPn6OM5kaRKpaBCRVMqHQrKhLIERrlSKPStVa3maEJ9wrZS0Yj2K1aDMwKQZU9H7qqLiP58pyqHvJoa+6MVMIzB5+z1q1NdZrfLE0CbI/YeYX3fTriqRWBDu/teJHijPSQ9N6istA1ALqoE3SVJBScYrgN0Ovh0SsqLsKcFMtjx/+yXUwTr8DaAhTZEzFpE/eBP80/0oNYu4CWY/6997soLhGp6Mwh3SD4P32U97q9RQZDe4GStcYXNgCC00aOUj9v645tvfHi6QVVJnMr06HpW3N4LQ7I9qg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(14060799003)(23010399003)(36860700016)(1800799024)(35042699022)(22082099003)(18002099003)(4143699003)(5023799004)(56012099006)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026121527099003)(261022075727099003)(261009223027099003)(11063799006)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gvc4/4GnQknDFHV/DeTCBSBCPuHADTZGRdNyU+0pYG3UxX9++GyuJ2nfJZS4nn9aewFT3iDzzc6J2TEIQRW9JyZ+YeMhkU7JDmpgs+WYuC7I8zdRrFLicscgIF7s23P2K2n1ysUaFglefAX07VtegiQF5Lw1CkWk/k+X44LAiBZ4XxcUHK7ESxbUISrjVkhV+gFjro1fHfrkipm60Q5dmLozdHM+qSkh7Hi6vpsdhv3zFsVM/zOAmERTP2YNM4NlUV5cOKq8z9p/zhYKpapBeP3ghwpcUxtsjHW3TifY6pSiMe9v6zHwQL+7gG+blm9gFSafqwqXGredGZc8u52CKEuT5Q8u4YNrMOGGvRPnbC4B+bXrdER3n4uwpl9bq5U0MMjskHwe1CYsi05JtF2OBwjObaDlNHQLsozO1stP1wGweHmTm1gqE2Ygtd8ibEiX
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:38:19.3696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62054144-c657-47d3-ba2e-08df367a4bc5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000530.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8104

Hello Jonathan,

On 10/20/26 19:09, Jonathan Cameron wrote:
> On Mon, 19 Oct 2026 22:38:43 +0200
> Pierre Gondois <pierre.gondois@arm.com> wrote:
>
>> Extract a ghes_edac_init_error() function to prepare for
>> Memory Error Section 2 support (and re-usage).
>>
>> Also use a guard in the caller ghes_edac_report_mem_error()
>> function for code simplification.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/edac/ghes_edac.c | 66 +++++++++++++++++++++-------------------
>>   1 file changed, 35 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
>> index d80c88818691..b90150c67f4b 100644
>> --- a/drivers/edac/ghes_edac.c
>> +++ b/drivers/edac/ghes_edac.c
>> @@ -267,37 +267,14 @@ static int print_mem_error_other_detail(const struct cper_sec_mem_err *mem, char
>>   	return n;
>>   }
>>   
>> -static int ghes_edac_report_mem_error(struct notifier_block *nb,
>> -				      unsigned long val, void *data)
>> +/* Caller must hold ghes_lock. */
>> +static struct edac_raw_error_desc *
>> +ghes_edac_init_error(struct ghes_pvt *pvt, unsigned long sev)
> Slightly unusual to have an init function that doesn't directly take the thing
> being initialized. I'd pass it in. The clearly of pvt->msg and pvt->other_detail
> is also a bit of a surprise for a function that claims to be initializing something
> else so I'd do those outside of the helper.
>
> Or maybe rename helper to something like
> ghes_edac_fill_error_from_pvt()
> Not sure that really conveys the modification of pvt data hidden in here though.

I can rename the function to ghes_edac_fill_error_from_pvt() and factor out:

*pvt->other_detail = '\0'; *pvt->msg = '\0';

if that helps making the function clearer.

> Perhaps this refactor was a bad suggestion from me and better to just duplicate
> the code.  What do ACPI maintainers think?
>
>
