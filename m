Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792735587;
	b=Tt3pvqlInTxsVD8vbKLhyVliCZD7cyWGkUn4/+CdMwEJBrVji0p3BoDg533ojEzuxht8
	 Wvl7QVqsmQNLL1+NUnkkUy0FFXzn9tyrpBzLqUSJkWjY9aQB2b3poSY474i40Eqf26RAW
	 YrBOAVzBfyuPBv6W/5Igl+x6feN1oqeQ3CCN7nWmYtiUxoVa2QG5N0PG2REWp6USbRSFq
	 cytD3I7ixd1ZG9ZOI0nfnW3h3Nc+H1LH1811n4l3rUfeVh79BUw6mUnKHpsAids+CnNS0
	 JRX+exdwdNxSMbLh+vJ3zbubgpxT8E5alFw+DbHwaOxebdV2D5wYkbS/ois5KLpHshQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792735587;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=lK+m7ik69YXcs6qx7/ygemIdumc8s3WuGTyhC3fT1LE=;
	b=iDTr9WrORqASy8ESCzTNq5Br6fnttfdm7u1sGy9ipbmXspByBNrlrHbq0XmiMUJf/eQ8
	 6U0kuyztDffkUH6XCjI3wbTec1bZ8xFXPkJFM6TihV0bCvADyjxDQAYIlZ36e47RgGEU3
	 Y8IUVKs7XCUtcW7MZ8Ii+hZXyCYqidbAOfr0/6ukMoCQbfg1tAl9NDaATuJuNj1lCUlRR
	 gC5XAw9UsLSge9QcnQBxZPdj6izfWZK4Wo7M6HH5lbLNIPhieTsxf9pmCybGFSaoRgYsV
	 B31gN8mNu/fFWGaSr6xkJ5ch0M6kcre/avzNxxJ5AEXQh2JutmeSGauxyIKmWuh9CJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=YwnW+cBa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145C3606A31A
	for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2026 06:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 145C3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=YwnW+cBa
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N51UHI1936009;
	Fri, 23 Oct 2026 06:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=lK+m7ik69
	YXcs6qx7/ygemIdumc8s3WuGTyhC3fT1LE=; b=YwnW+cBar9rGRiVZImTIms1Dr
	0XU+xYLxAf8qeCMJNkC7DwwecSgY2wLxm5CNCZSDokgArhs5ha+NLs7pYkiOqY5y
	aVW6s5IQv7q2iaYbNXl9Ee3n1IXoNTlXr5VOXb8vyJ10R/1g6IzOdgagOkk2i3Oy
	PDkcdigeWGvkBw2tNcx6k/11JDE36YvD61BJCkJfYehU4iSDPpZUK6z2pzlfcuj3
	hHeHwqYMs1Ly6w56mJ2N55FTNMZ7nZ/ftaiDgQINF7R5sINYv+pSS71lRZk68nlj
	hIVuWlUHxjFQEjOeCrcs04ghcYc2APCuIzh3Eormf7d8JOAebKPCZybwLQJpQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022076.outbound.protection.outlook.com [52.101.48.76])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4hf9h1t8du-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 06:06:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEPiUDfwTglmCCfEjOh2J+SJiQe81tlmjSnfkgf303rA16WnmnvJWIJHqHmgTz40PNJxthK/9csNCXCTz3B9l+N1Zs5bR742tcRWPYDJNd71syBKcKHoHjCWRC8NApfuyfQY5eLv7EMwMh3w/w5HV43mOHbplTSj0qmCjESYXiJ6PYZyVCCWqhtD8493Ez7D2EiiNguoxBHP+bhcbmAMpFBfZ3ycgG6QULacozTeiLq/debCGhtPHBfN6s7+P8vkIDVnNsgbtoDjHeR7AUpvOL1+Pv1PDNDurwPkjLTeGSTYpSZYGrexog547by542+8nVXeYZ3Vq1JjMLPZ9Cjflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lK+m7ik69YXcs6qx7/ygemIdumc8s3WuGTyhC3fT1LE=;
 b=ycib42/U5D5RWGIBUEMOoVfHtm79c8X4FDCVNBww9sVxTP4cwDpwuA94h7DxhWMy33G4VX1bjLmP5RqIDvNw71M9N8Z3qTqi9/ZySFHp+j0xb+0naJ7sLlTeiigAhzhPdIbJY+khmiCenvDZX5Sqey92kRekjVUqOSkp0Z2Teg5VQ4vSnCa43jtVLogZ02cAtY3DVaf80Gul7uQJ1g/L2ShBxBRWLl6FMbxoRtmUsqQ1MqM3O+JLJyx8V1RQyskx3ppSJ/V2ZNlVKkZOKFR7VyrHUFh8/3k4gD50J+B2JEng/Io/6tfiXhHKrhlQ4sSTRv1V/2y6coNHtWLJpquTUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from CH3PR11MB7763.namprd11.prod.outlook.com (2603:10b6:610:145::13)
 by CY8PR11MB7011.namprd11.prod.outlook.com (2603:10b6:930:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Fri, 23 Oct
 2026 06:06:05 +0000
Received: from CH3PR11MB7763.namprd11.prod.outlook.com
 ([fe80::eb7c:818d:3474:7b95]) by CH3PR11MB7763.namprd11.prod.outlook.com
 ([fe80::eb7c:818d:3474:7b95%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 06:06:04 +0000
From: Yong Hu <yong.hu@windriver.com>
To: linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org
Subject: [PATCH] ACPICA: Initialize parser_state.aml_end in acpi_install_method()
Date: Fri, 23 Oct 2026 14:04:26 +0800
Message-ID: <20261023060426.3821716-1-yong.hu@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0125.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::17) To CH3PR11MB7763.namprd11.prod.outlook.com
 (2603:10b6:610:145::13)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7763:EE_|CY8PR11MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: b871cb53-7bdd-4e9c-5b47-08df30cbb89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|23010399003|261022105027099003|38350700014|56012099006|260925022911599003|260925021311599003|260925021911599003|11063799006|261009223027099003|18002099003|6133799003|10067099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	JCAMcrCNgzv3jNTLKj/NwaXk88up3TiqV/+V2mdmor16QhocUAflniXL6iawvrn/G3tZmn6IWVx6esnUb3eJYf81WkG3DCwP9aYhi0y7gy42V3/ARhEk5DjHvr4/uPwmuYADI1yVI7Zvfx5sO+l6LIN9SrF12WtPnUAXeswvWCF5ZfWFpjkIVhap56I1Of5VUKVTwVZNyvXJRQoE2/dFiOo6/tuzo5RUa88yzAA03kvu8TZ7A6bVmUYP29UUFzLlzc8P8s/x8gzayMX2zVgt09/ZbzzztWPgpIuu8iyYa9nbztFavLDnd/yaC16nKjnEpsQXMlgJJaMbCbkcT2jodL9Vk71K/js4uDK4gareKIsrHuVtSa+5WnSm5+EvJQWFapOZiKM6+vtWJgTX/Dp5XsuFifmBIl0KJ5j0+va9ffxIDg1xf5m8068FI3PW/Qn6NNy3JeFDfr37qJtmY1xgq8aQH+n5hFu6F8Clt2QDefTOVOy9fxJ80NM/RFr1dFDxfFCo/bl07jmG5gDofJP33sMNvO6IqmcD7nZ0DZhDlVzYWqkGW83n9NIiZR3/6cH6M6PqBLw+LzV3OGOgo2prnarwI59v+eZO+zFtQQcx/qDSpLrI0fYR6CW+L04cMG61h9yYoHhJ4x+Is3y7zXQdRbe8n7aI9NSVdkX36cWOKUZz5q0fpRGqSrRcDZ3vfNQi5MR3f9vxc+TpOY1lfT77xt9AUPkvEy/7dVbM3hRLp1E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7763.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(23010399003)(261022105027099003)(38350700014)(56012099006)(260925022911599003)(260925021311599003)(260925021911599003)(11063799006)(261009223027099003)(18002099003)(6133799003)(10067099003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WoOHzhZE7HsDdC7CZldecfqQE3L6moR7z35/Ow1hI7rsQf3BjsBX8EmdMPdI?=
 =?us-ascii?Q?9bMDP38tya42glU7pfxrrrZpc/kRh+4uPA4MeTpbAPqNQWEmySucYWWcSsap?=
 =?us-ascii?Q?cHHHYDxGNW28jqMUhIedNo04r2+V3tT5O2wW2zSGkxKRHARmwPNGjmnsKneW?=
 =?us-ascii?Q?oHGUf5BR5ToX/892vc2+dRXdvwXGTMdBj+9OmsGN3Jj5EqwVceTMm4aj19mw?=
 =?us-ascii?Q?1YZvyEXPyORZIG6duoDGxKrF4DHY13HYRm9/vgVuQrIQXqHdzPycxVd7Sl0h?=
 =?us-ascii?Q?Qlpi8Kz/2GmPcVe9TruPjzfDLaTH9mk/fl05otVpyx1z3rFURgyvnCG2YYKG?=
 =?us-ascii?Q?lQOu8y33haqxRYnKZ1FqwoGZil9uBP18Rn54XkjTeAcFu1No8KsPTIZiFEx7?=
 =?us-ascii?Q?HD5Q8lj7JYF6IZvNPDVaGE0W5fQvcPezShyYXDqtQW2V72Uj9Lh0PQvzKfci?=
 =?us-ascii?Q?eLthoX7aJREsVQWV7e1NDYSS4WegGEPQNL1bSGnQ6itcp7tzoXCN0eb2aTP0?=
 =?us-ascii?Q?QhWNyaOidNA6AvVRXB21Posyv8Q8WQ1UROxmu8zSzgCmF/V5sabJXCyNHqM1?=
 =?us-ascii?Q?juSTy2eimyXqEpVAH8UNkHckZNOvPdpm2JNPmoB1ap31z41DgelmglcGtY1/?=
 =?us-ascii?Q?iIX90gwoSHid8eHrg0eStduAM+RzaI0c1hJHJLNYsomlrEcwuK+D06oNYR2W?=
 =?us-ascii?Q?4wckwvVZ19i5XTK1Es1kGI5gvcFlEYQZ6mHxgpydhDcyilEz7BdBWZXBXq0L?=
 =?us-ascii?Q?MjngF0TYaoJg3eLb0BekypLJJ53V8fP8LCcWC8BpTIuDTrd8Ju6eVsi8pb1W?=
 =?us-ascii?Q?mKfyW9OUBiy7jrwYBO0LXVoxuHZuNSrIVzmT9c+fZ9OT/TzkI14tMLN4Zs1v?=
 =?us-ascii?Q?MlyooJ8aYc3AqSKsJpdCC96/ORZTLWt8/hQ+4I/enTL+4+LzZ8WBAqhUHKvm?=
 =?us-ascii?Q?JjZ4Vj0zZbYXxmmdlddjURK3Rx4u6PgTGP52hHcx34Bax+up7aHO+8OFcYq4?=
 =?us-ascii?Q?SvVDbIOBhci7Y7bLI7PlgoWp3fNxREijXrxAbNVSrSrnm3oTJ8b2ikgbFnRu?=
 =?us-ascii?Q?Qf7uBBRMckqGaAFB1tU3n/RSCMIWahEbYodBvFS3KrbLHhvxvxgGyGQPfsW/?=
 =?us-ascii?Q?V9VXSbv6gjg+Vgq98ANnKfjRk9TCivPtb4EI364ytWl9XVBfSXXU8a4u1leJ?=
 =?us-ascii?Q?31KvmvHUOx8XR//8JK0rhlLd5P5Sz3Zwi4ehkXS5qmlkpPZ7pTFAfQwBPfXO?=
 =?us-ascii?Q?wOHiigYI9IZoLvdV0UAFUG4X0wATsRSWv24KvXh2z10nfzIZrIx+1Y0vjl78?=
 =?us-ascii?Q?Z2S72R0hb/FgiX9i/f9b34Grl+Z0dqsckAVH1iJWVz/B/RRa0IYMqFaQWVzL?=
 =?us-ascii?Q?VCmAC/24UE3nT4ucVZ4DVP+nzjauoqkSZSRiTgtcpMcE+NQV7gi//sBPnc7Z?=
 =?us-ascii?Q?ly/X2lYdI/xtoA2MSRWKVIKLUUYZypJb8bAk2THBOipZgr4CRDnVnBTOq9Bh?=
 =?us-ascii?Q?45yY7a111R+otN6UWOOGbioKbL/58D164dieogJzfBkt/QtRUnDep2994j59?=
 =?us-ascii?Q?37VVvoHyqGfeMoN7DN82SGekdOm/mQ3lweUY9U4kqTaqolTQ9j3u3ScTNZSp?=
 =?us-ascii?Q?4v4QFF+68eaPqh8m3ybLdfSoOn4oRB3RgPi5VrU0VQ/pIUQ3VSmpJ6oaQbyv?=
 =?us-ascii?Q?4Eiyfaz4Q4cnpv6r692gipG3OtWsYXdEu2sXhid7oVnLGhzbkpSeIhO19Squ?=
 =?us-ascii?Q?RkaCUStJ9g=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	gjnofLHirfG0BvKce5wtwB3CnG5pXG5jkkYpNQiy7hNx67zsa42FNfhpNYs0ChXu9aO3Tl790fnCNB+MllxsD+aDhV1hgRNGqtaklr1q05i1qN3nimjdZehQqozGXexaQikzAMq+lTIVpubvQCUo5T16k2YLAi3ObBzBnlPAvMrNZl/EK/nIHajFbboM/ju3OnwtkzMty8RSsszfwAIrowJxju6Xk+i7JSnOwerLxYdUjCzDMl0VtRNnrlrBetmnBldAenPXAX5lEQqlzLfIhP3pmlEQ8UTHj8c+kFrqYwfFEgiV5009ozdS0erPndPw/WGAo+m+7ge2ei5aDBL3Qg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b871cb53-7bdd-4e9c-5b47-08df30cbb89c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7763.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 06:06:04.7982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvtbZqoLVIxWWQwqi4k2jV593cRb0WzssJMwtWVtyqfzLVsABnrYOdV/7yOSQNQ7N6ZYIShuVr6ELS1BVN7Pag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7011
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyNCBTYWx0ZWRfXzuPC8rZR5KfW
 DR1WJ8ZdfvokI5Sd/Vj2dMQnbTl9Hdym/4hFCgpHxOUk92dUifbO6TnRXuQkRHLUPXu/NiS7Zek
 R9RmnL53GGF0dcQ8nGUexlL82YK8jAL2XD6Z5SQ2gMZCHhMPStQtuN2gS4n+qzjHGvaKc9uo3UM
 DQUC92FpkeT9ZJckn8lw76B2CaMZesyApB3m+Eb14+hA+dZAFAy1UbqXn0ENj4f3zPVosNhOr1D
 zXYtkHwkVpCbFWScaU+I1A1yDEO/bW9X9mFZ9QUzWmaucOL2VVfV+n+AJQXAI45Z4vPxvKXqkn4
 4AiMN+4yVOm9XYwtsu4utAVvobPmUc+7NJad6LCmtwABOFkDz2IcOex7nZN/pfit0lpOfX2wdfq
 /EidFCUFA+UF3MV/yq59mdBfNfQ5VtANW/9LARU/yuJQn9Ad2O87kDAMfaGseDq6C8EXgLqF4pN
 AEtACcdQnVYXgsEnXOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyNCBTYWx0ZWRfX/lOsK/Ub8g9T
 AjZiSrORI9OxEU3KBJ9SP5OSJ3tZDT6LxjLrOUkSMv5mkNTFVBZmyO++k7UiCfklI/g5VE/HkBj
 VK0DfkGWAMrRRohYWqbpa++al8U2jR5vNcLw44l3xhC8l0p1kpZc
X-Authority-Analysis: v=2.4 cv=Ro1QvymK c=1 sm=1 tr=0 ts=6adaf950 cx=c_pps
 a=xCxiqQzq1gljYw3WCSuH1A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=NEAV23lmAAAA:8
 a=t7CeM3EgAAAA:8 a=97zkmFOFYdDQx_DV-zoA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: D_ufJq6hz_K-Lp6BJ3jhTdn-OU3w_WLn
X-Proofpoint-ORIG-GUID: D_ufJq6hz_K-Lp6BJ3jhTdn-OU3w_WLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230024

In acpi_install_method(), the local parser_state is stack-allocated and
only parser_state.aml was initialized. Parser helpers called by this path
read parser_state.aml_end for bounds checking: acpi_ps_peek_opcode() reads
it before validating the first AML opcode, and acpi_ps_get_next_package_end()
reads it indirectly via acpi_ps_get_next_package_length(). The subsequent
package-limit check also compares against parser_state.aml_end. Because
aml_end was never set, these checks operated on an uninitialized value,
which could lead to incorrect parser bounds decisions.

Initialize parser_state.aml_end to the end of the table (buffer +
table->length) so the parser bounds checks operate on a valid limit.

Fixes: bdc357540129 ("ACPICA: add boundary checks in two places")
Link: https://github.com/acpica/acpica/commit/19429ef91ebfb2144c918038dce13e297b4ef051
Signed-off-by: Yong Hu <yong.hu@windriver.com>
---
 drivers/acpi/acpica/nsxfname.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index fabae9b08e31..b1234567890a 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -503,6 +503,7 @@ acpi_status acpi_install_method(u8 *buffer)
 	/* First AML opcode in the table must be a control method */
 
 	parser_state.aml = buffer + sizeof(struct acpi_table_header);
+	parser_state.aml_end = buffer + table->length;
 	opcode = acpi_ps_peek_opcode(&parser_state);
 	if (opcode != AML_METHOD_OP) {
 		return (AE_BAD_PARAMETER);
-- 
2.34.1
