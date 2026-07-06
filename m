Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011035.outbound.protection.outlook.com [40.107.130.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987323AA4E7;
	Mon,  6 Jul 2026 03:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783307872; cv=fail; b=NbSRj3ECcQxF6e/eiyjjqthkKuhL8LPLrJFHk37/8HupaRPsw/jxVZ6IB0VLDgkUCwSYboRpVQvTcy3+9RI58gMLVFAeIFxHu7kq/+8eA5neb9lrlFzQxUrPHAtH6d1yzzogqGm9g3Er+7tSodmgNWQKbL9kMjrRKzPCDPo2GH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783307872; c=relaxed/simple;
	bh=rW9S2jM/O0zzXWcCnETorTD3KCylrRT4O9vYtqlNPTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KhDZMBDrmfPBTIHGaoiTmi5zvSZ6GXzy0srjYDHcXEgp1ZaXUONeDUV+C4RNAubOB8Y8P8nILUSZzuTBNkvFV92rAKafSh6OIqZp1p5loGleWU2VyeN8v0m7YD5bHcwCke+XyfcGelR6ewufVnJQnkBIMWD2cx9LL382SfhRRck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jz6OHjcK; arc=fail smtp.client-ip=40.107.130.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jz6OHjcK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+WPBejISP8IEMQ/7Axz+GMAVLVZ3CiKw3TAhHutNA4gx350/LriGjasFndWQNBlbqv3nFEBba+GVUy/8AX+PxN3QXG9YQRZXHNKGj3eYXRWC2UUzS95gPUDl/bs/qb9W3vzTeoEeHCAJLho9SjvrWbqZrfbB9Zz81LKhMnX9pdgnphXJ83/8eewuDJVif28BAt5Ad2ODskMIbKtbxyFFv+KGoKM/batOik/FOxAdWtmXXvA52VqQ2y6UejCmu+D8ZMTSQSEg9fzgEwMYHglrBnmunGOiaffNGjDEMPI2ddHFWZSW0P3k6J+0j1c2vwSdqHYm9bfRjWyIIeq1kroxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HKzR1mdHrkQE9vL1b0RYIPmoYj2YLMYtbIIB1DkpNI=;
 b=HBIbhjIf4isRTl6wz/XrhxbmJ8hX8BgPX/v2OKZkND7PQ+4UubDz7f7uq04puEGyVLg8RhUVeZOP2cbiCUnR6WnlW4z7yrLinlz688gbDCfANGQrryqCN6rO6puMI4ML+PTjB1nD/as8lSq0/+ijrLbdtWIHp8hA8Ai7WTgYPudvLlWY3unX1MWEsCnGxGERIL+iwfHPt36i+cx2jZFe/MYMdcQ6NYU4Ws2tM2nU+ig5Kz+TJDiwb16J2mtHikaoGdcchDOfidVywsh3VY75buPXVN1iBysVAAEMcv20iHiMpo/3r/7n2k/YQH6hDAU12jdW00+KASnwqJAoj/Iuyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HKzR1mdHrkQE9vL1b0RYIPmoYj2YLMYtbIIB1DkpNI=;
 b=jz6OHjcKgwEVgsUc+oT3QjwoBJ7B5CUFgse2dWhJW223FmfAu75DQ1Yv8etjIe/DmYG4L5jN7jmAw3pTFJbKVxR6EnVv9yYfkKbSTJMdOB41glJ/hdMi3wUqep0yzh6YtsV2OLwyxN5uOhWxVAH9uBbADfKm9oF7XFdnzbvRvn//vnxmYb1jG26MHPuzfoiT1zPcDLQpomGopV4xEIKZgTb59TrrCO/wlu269Za9KqjNJin5gLakOW0gWESdGX77HMatPRrsqa8z6kU3WBzvZZp+R8zhsOxgte2IZGwMB3tntHJMikmvfeHu2GajhB+q36SQhazIbMLwIZhB5rzXDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by AM7PR04MB6773.eurprd04.prod.outlook.com (2603:10a6:20b:dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 03:17:45 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 03:17:45 +0000
Date: Mon, 6 Jul 2026 11:16:27 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v4 0/3] device property: fix child iteration issues with
 secondary fwnodes
Message-ID: <3a6p2uwaomykb2doqwmsb56wy4ekkqee4midivs5umnqgxvhxc@2dhlrlyexee2>
References: <20260611203537.1786399-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611203537.1786399-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: FR4P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::13) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|AM7PR04MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: a2839e44-640d-4698-3954-08dedb0d2630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|23010399003|366016|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	9SDIzcSDi/SLzs2KP4D4bMT1+AxZr+ePvbI+wUUDe6nVvK5qocNgNG/fcYym54bIXEb3rd6yqO0hDcJVncbo0/5Exm1XcdtNMayujK2AlbfZREtlHeyYddNLJNxNwV/KzvlPzlAaW914uMvd7xC1Vu5QuRqlxfrSwD7wbgwvgUlff+f6GUCLy4NPZY8QtbdmDQ7oQRLdiZeNH7aX7o+QzR9FmSJ5+T4Z8nnJAdOPU8Z6FXA7QlyC5DgUU/p964BJj+gQtn/ZvWmUE2zQCYdx2LJv8NK1sIu4eO2w1NEWJInWxAIFl3uVNNtmgXkAFhPKXeWuhvt4Ml5FBqcQsOm+jRRv9d/QIRV5ey9Vru6NJn8Rrn6GhSW4nwNf9/dYLejyv3bg8Flh+NxLN+twD6aSbAR6ecpqowfj4LCXlC+zAeKnQNWMlQC0v3sNK0341jW7NVYdX93pBhb1ZRQjbZ7/yJZdVFzBT+MlcDQ1tb3Sj764S6fwzfL8/Yg6yydmZmd0ACoQPQrmcYQBKV0tJyGAkXV1MirQWZUQ5sjCohWJjUNlSiz5PZAutRtlGSp1VnrbmzkvSvst7x7DbyrVsv0S0MfpAxKEuNzr3ptmPTSe703y7zkpnH53XLP/jbf0PEHa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zp0WtkYoeZVapocdJuL9HQXPOsq1g/YGvaVw+ut6EJ202vaee0MDWvWRN/Px?=
 =?us-ascii?Q?siYosoyzhEro0OJNQmsLF0r+CK3Ixj76Yk3/3rJFKxwtl3cAXEd8LZXUPPK1?=
 =?us-ascii?Q?kCghier97ldB97MjtSyS84XFCkmqaIAs8OXTl0cJ93iYTv+HW+WkjBareqGG?=
 =?us-ascii?Q?ddOx8CBT7bgTjXFz8F5OhGYs8LXdjzMaw7pVTaAE8d3KO5m1Vmj6qjF6ahFn?=
 =?us-ascii?Q?j3VY9WKFiD8vvWz92LA9LEC+gMIhcZha0E0lbLeIHAtD8V/KGrdAVibMgSR0?=
 =?us-ascii?Q?jCWGnVY3vbxZQrwvEcAF2RGB7aHX5ko9b4Gf3StXDTXxW1yX9jNwHSvD2pr8?=
 =?us-ascii?Q?U0fRYNQWYoll0YmGqDyWB+LVnWYaVcNvFG2v+r7R6zuwPf8/XBrTckXoFWjH?=
 =?us-ascii?Q?hDDLR1Ttms9swwuzof6M66DEJiEBOUMCLo1CTLm8e7dxy/DukO99cJmvFkpF?=
 =?us-ascii?Q?UReSWjxWQUB3ajvkd0CoCh2ZsTjLKaTeDKoZbAJq41PlzHJEc8zuoqlt4sl8?=
 =?us-ascii?Q?rHv5mNQp6FqfD7cim6e28PBJxxflW0gt2lH4kS6k285FxyHCiFTAUYh96Mzo?=
 =?us-ascii?Q?nu3pwmmJifUxW5QdlvGKIeX05gsCzQIoKmuqCIPNLjcEkBk94jAjZfPwwujT?=
 =?us-ascii?Q?YJgRNbRzLdti4oyHQ8oqKAwtaCbj1IoR5Ph4gqOePCXZIfAJcGmWs2PMkWLv?=
 =?us-ascii?Q?5uBAnvt9cyOTj2NYMoaW8JmTJJ+Tx4ZXykIcC0O3y1Piu4qBsilrC6I+652m?=
 =?us-ascii?Q?lrd999Dt3X8EA5Q4q+4uBcU2jr1H8d5Qu2rrDVBJWm/64PdBkZN92l10vYNw?=
 =?us-ascii?Q?a3U6QrodYypD/XOfn6NJroWcScYAx7+mX9HJOe7CVQNdSO4YzG0F+TOjz9kW?=
 =?us-ascii?Q?Du4/Uf+RSNnxrGiDtzBvGwQgNzMDlxe/CzSk1Up2XkZfYYF9xX1ux0/eVH0u?=
 =?us-ascii?Q?yG3wLREwXxRcFkFPyARHIS6/fCrwwj462kiXloThGxtKFQ0TEEy8iTTsrN9u?=
 =?us-ascii?Q?tcKCvestigy5sFh9Mkm9sUQMA6kpDNvBv8W9dE4ckjfWrUIGPLBmIckUELJg?=
 =?us-ascii?Q?ZU0jBH+xb1jP/6QL1xxfckgCOSQBroKPq50TjOxoPAU3ZmaLbJhIGnumGFbO?=
 =?us-ascii?Q?oFJ/2jv66T/uEj8fyER+L5YdrxvQ3rTNQYzjhtTKDBAT0yQA1H4VKbR0ZVb4?=
 =?us-ascii?Q?nktDAGsOl5swAt7/bfK/RGkZAOaRmROYzq7UVzFeWl2np56tJ5pI/fjkE2HR?=
 =?us-ascii?Q?m37tZO+UyG224eksVFl3VRNsULeW+SNtX2WQOlvHxmk508g0G87OXsPZ0l2j?=
 =?us-ascii?Q?Msy8Gf1uQqp0Z+57VKTwOQ8FoC99kSxO61JjPlC9PPe0uzpr6ihXSV651jkw?=
 =?us-ascii?Q?KHOdRDBFgP0qbhufjAiDFkixTWinbzL8ob1llQTX8xkRYFTuBqQW1tkOYAlk?=
 =?us-ascii?Q?SRrY1IQMU5O0jAjsHdfGFHmw3C8ueP0FRXymzSyY0tvItx8cA5HVFIQdsI3S?=
 =?us-ascii?Q?F3vyZEyHpOWxY5hvwwEcdtVARt8GQuUtr1aqRN41f9Rlfgb21zokRr1rQg4f?=
 =?us-ascii?Q?4Wxf+i/bktnHfM3EfraFICTcaBmoAqySHZDbO89QI+iTvPQj6m3dNDX+Z2DM?=
 =?us-ascii?Q?twOUKZghkUrMgjDYZl2ZbkCvWvN3oeu1HynSZQxUDzKo9tC1IMMjHubmgyp0?=
 =?us-ascii?Q?Iz10UBbi4O11ofKypaFVM4bOJsmFglVVliU1w2F/oW1wSNtI5PbE1ws4kt+U?=
 =?us-ascii?Q?A9Mux9yXcug6x10jVMje1qPEeVzWDONcrjrMZWZCu76pUbdh4l2q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2839e44-640d-4698-3954-08dedb0d2630
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 03:17:45.7331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEC3S55+aw27JtE8SdNUT1Fy6m8Znxv+XmsHHEu0uzUHMZivOhlT2Rd7jK28tF/rre8WwNvcyyh/rDFLrGr2rh1ggMKParvfuXUy5JpwMAAYkZzY61lDj6GKTTGv+ujQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6773

Hi Greg and Danilo,

On Thu, Jun 11, 2026 at 10:31:05PM +0200, Andy Shevchenko wrote:
> This series fixes two issues in the fwnode child iteration logic when
> a secondary fwnode is present.
> 
> The first issue is  a refcount imbalance in software_node_get_next_child().
> When a software node is used as a secondary fwnode, the iteration code may
> incorrectly decrement the refcount of child nodes that do not belong to the
> software node hierarchy. This results in refcount underflow and possible
> use-after-free.
> 
> The second issue is an infinite loop in fwnode_for_each_child_node(), caused
> by improper handling of iteration state across primary and secondary fwnodes.
> When iterating over children from both primary and secondary fwnodes, the code
> may incorrectly resume iteration from the primary fwnode even when the current
> child belongs to the secondary, leading to repeated traversal and a loop.
> 
> Both issues are triggered when mixing different fwnode types through the
> secondary mechanism, and stem from incorrect assumptions about ownership
> and traversal context of child nodes.

Gentle ping on this series.

Thanks,
Xu Yang

> 
> Changes in v4:
> - amended the fix and test case (Andy)
> - added patch 2 to align other implementations with RAII approach (Andy)
> - tested on Intel Galileo board for which the initial code was developed (Andy)
> - Link to v3: https://patch.msgid.link/20260605-fixes_fwnode_iteration-v3-0-44c18472e1d1@nxp.com
> 
> Changes in v3:
> - remove software node patch
> - add a kunit test case suggested by Andy Shevchenko
> - Link to v2: https://patch.msgid.link/20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com
> 
> Changes in v2:
> - use __free() to cleanup parent fwnode
> - Link to v1: https://lore.kernel.org/r/20260525-fixes_fwnode_iteration-v1-0-a12903fb2919@nxp.com
> 
> Andy Shevchenko (1):
>   device property: Refactor to use RAII approach
> 
> Xu Yang (2):
>   device property: fix infinite loop in fwnode_for_each_child_node()
>   device property: add test cases for fwnode_for_each_child_node()
> 
>  drivers/base/property.c                 |  41 ++++---
>  drivers/base/test/Kconfig               |   1 +
>  drivers/base/test/property-entry-test.c | 136 ++++++++++++++++++++++++
>  3 files changed, 161 insertions(+), 17 deletions(-)
> 
> -- 
> 2.50.1
> 
