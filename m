Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022091.outbound.protection.outlook.com [52.101.53.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53641ABEDE;
	Wed,  7 Oct 2026 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338620; cv=fail; b=hVIFmKgIlx+ZJvh1dnVjU6GeRBK6C6pktUhJZBUkD1FWPOO+dhA6zg1E8SS8Xhp8cOggY2q2I6Ye3h1ZUs8XPoLFsyyXSNFpxnU4aYfBpiT9DLuGavJeNKB/6H3lQYFa7jBefR1hkcAoyfVyqztJqjSgxX+gzjnYVmBXitQZiCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338620; c=relaxed/simple;
	bh=GB+BWImuq2fehFPCqWlD/3DqMVBK4OfnFct5I2Oadhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U72qWuIKJjtHsujGH82hYNQdhAFz3z/coijmZAjnupk6wlY7S2NKSdX9gER6LrAb4y8EPthFixF1YeE86uOWRATqfuTrER7zbZcu1wAU98P7aXwv9mL0iH5XNVnsgAbgcVQFyOXzqv+PDdIBFIqnjRNBHEBNkCP5teMZBYcmkS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=DLylmah3; arc=fail smtp.client-ip=52.101.53.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="DLylmah3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+uf60tFbx7EhYJSWWq5sDVb2XAybGGaeTG9GAj+YLf4CL1G5R3RcPZMTVWsWoXeXUoKtMhp4h88HZQgiI69G1y65aO+/zH9POWPvVfdlkKbx8OzlRDtnByftWzCPUUh/GYlymwHPS7UNuJpYdYXuiqhBK8vuezPvL7+tpmM21iyGYAQzmtic58gYOt3USvwG+a/95tIdjQUcaiFyEcm4QZm0SokfkO3dne18hyvSZZOmUCEUdYfwiEjNbZASCkJX7TyfpDySW8ykER1WFCW0wWAjeVDQTo3ovsZDYdH8bF5NURPzlJkwmRkBZdf+bz7rzSK2uWg487IqRu0CzHW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yzVwqG+gu09eGYrNf0Y2eApirQYiRpz6bXn2qWBpOw=;
 b=EyL71FWfID3ow3G0h5CpI4KUS81f4CK0P+39CvOD3i7oxAdvALwmAYvbgOI6UTqSd7Kv5AlfDBPvW39LYv4eRZLdK9EsfSukDQde1i/Ijaqp2Gt2yJfgLbAWjmS+kai7bhiTDstcnuKw39pCjH64VLgVRxGoBj+B5S9xkhV9Y3QB9EUK8gLhG7OdpyNDej2vMnzAh+k0Y6aqkWCKc8B/DmsBlkU6D1ZZcH14ixHy/URIgXGCfVhjKhu6aBVIlpoJ8x+KU5Uonp/DvatVoJz3I9pUoJ8Oj7ZieCt4fzlc+nqA+GEQKi5YKSsrYUoUVFFTujtAZrepKkBQC0ap0WSDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yzVwqG+gu09eGYrNf0Y2eApirQYiRpz6bXn2qWBpOw=;
 b=DLylmah3DmtK6Pt39PFShwr35UgRcNrzHFNd6bIssXzmUUVx4t7sAqcc0lIlgM03xmuWy3Bpktsg3bTYfpHIz7j8MSiiiKTnNrew2Bb3TVCBCg68iyA5ITzHmxcGmiwHKgCzyStxNK6nuA8ssg9dJLFT0ZcGvwHwwB3KJReehHU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DS0PR01MB994109.prod.exchangelabs.com (2603:10b6:8:2f1::9) by
 LV1PR01MB994424.prod.exchangelabs.com (2603:10b6:408:2ce::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.20; Wed, 7 Oct 2026 02:03:34 +0000
Received: from DS0PR01MB994109.prod.exchangelabs.com
 ([fe80::9262:65a4:c559:e413]) by DS0PR01MB994109.prod.exchangelabs.com
 ([fe80::9262:65a4:c559:e413%3]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 02:03:34 +0000
Date: Tue, 6 Oct 2026 19:03:32 -0700
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org, 
	zhenglifeng1@huawei.com, zhongqiu.han@oss.qualcomm.com, viresh.kumar@linaro.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Shubhang Kaushik <sh@gentwo.org>, 
	Pierre Gondois <pierre.gondois@arm.com>, Beata Michalska <beata.michalska@arm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, jonathanh@nvidia.com, zhanjie9@hisilicon.com, 
	Vincent Guittot <vincent.guittot@linaro.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/3] cpufreq: CPPC: Resolve frequencies to performance
 levels
Message-ID: <20261006-electric-ibex-of-beauty-5aadbf-vanshikonda@os.amperecomputing.com>
References: <20260929102957.2591657-1-christian.loehle@arm.com>
 <20260929102957.2591657-3-christian.loehle@arm.com>
 <fcfc5d26-b3ec-47dc-9d17-0e4c1d9a36ae@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fcfc5d26-b3ec-47dc-9d17-0e4c1d9a36ae@arm.com>
X-ClientProxiedBy: MW4PR04CA0193.namprd04.prod.outlook.com
 (2603:10b6:303:86::18) To DS0PR01MB994109.prod.exchangelabs.com
 (2603:10b6:8:2f1::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR01MB994109:EE_|LV1PR01MB994424:EE_
X-MS-Office365-Filtering-Correlation-Id: 556f651f-8f45-49cc-4a76-08df241731b5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|6133799003|18002099003|55112099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	VhyTcDp/k1Ce5h/kJD7oykaG/w+iKfn0HEO/en/mLc5Ynok7sAI5ZF64ckCKjT01I75YFxpLguDrl4AUh8rzGdbn8Ys3KAAtUd1s2K3ms/TzEpiBL0lKKByXTse4JuOkHt4k0ThScN3XuGhmUZvlSPgmZ8zh3KA89Z93wwO4riSSrIBrddz6+piVkjatV6bjY4bh5KdsabKhCEi7HKQ0auS2hbMA40CRzolb7tLRdCEVXGOY3Y+Y0fk7sTBOKuKhSyLGSvXpOqUHN1hqVuj+QRqb5nyrzI8ln33rh1YbNgyC8OrAp+IyQs6rFt8XXuCE08LMe/i41XdOB3okp4hZRRleLc/8yNe13MiH/3UuVus2mdx2A4Ljw1Hexdik1nDdT1QS/gKpggVfkPHRE8wKm+IJkAJuu0jX47PKJ9lQedgtOvs1XAzVBcZFPu0vY6ljO4mRE2HBiVvaCwoER5pHbXCA+3Q5HMTUOXA1DHerOqSyMKA8iVPPxYlrQL3eQaDmeD4SN/oyb2Hwf0NCT7ZsktJds3Pk4NLiWeI+hufCyhwKl4D5r0mi9GQ5WOwATuZuMh/ti3BAFiiTCGoT+av5FJKY2K91rqno3840jpZfOwyS8DQx70S8IXPX6Vd+CQam
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR01MB994109.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(6133799003)(18002099003)(55112099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RMd28fDM6BEndKsvN59S1nu95zjS04sEIYCGSrt0PFb3odbmnJKt6vVmONsA?=
 =?us-ascii?Q?UX+tFaSAVCYtsf77nHfADN836+Vwvnk98USnyAqjtG4sv+IirFCr2bU27Cs7?=
 =?us-ascii?Q?3v2qiawMjriiSnVeY4PXBkuWRlhPZ5qsWfs/Iv3PN+izln5BS755rRycEloc?=
 =?us-ascii?Q?ajk2haxxKnkoVCdOo/Bfr7YAx5U4EK/ffVefxwaAacpnX8cmjn+9XOWS+u1L?=
 =?us-ascii?Q?S2nMMWftqYW19AjQ26oJ1guvIVVGBDrugHPX8gDszIOQd8ZgME7khIF0nz9V?=
 =?us-ascii?Q?iyu6GGtshGeTcbdWALyYs2vHxPHmpns7evwX9bfe2DYUHoNBvYiPb3npPJaH?=
 =?us-ascii?Q?wS+iT+7hDo4OBIkQEgcsOYV6y4chDPjfi4Y/xemd7E8DiWO5jKHCq9rPofVu?=
 =?us-ascii?Q?6OGpY6alCCMy5wu2i6S1cyaQbNfsjjoAnM/VD5L5qtN3n51PneYFUCWrdB3C?=
 =?us-ascii?Q?24NswhI3TQlI2dbRc92kyejHVDfmfl4cZO6M1RpVUuX9llL0fvArcnOKZGAp?=
 =?us-ascii?Q?H/Q+nXmSQ8JH3IqW3z6ZOdkxAaGbo8Zn9FRzzO3G87ulARNJxyIrQh6rM4aV?=
 =?us-ascii?Q?bAET6Qz//0hPqroBXaWIMzGQ31JsKyeC8y1CM1N66eIJMNm9cF6jvGSCu1XA?=
 =?us-ascii?Q?bPKP3WDHUf5pXt0a4OVM6BILpE36ogKDFj6vwMrgp19MWrPVAEkc9nfyMcPK?=
 =?us-ascii?Q?JVO4DCJuEIa3zU1Pb+LUlUVUhCNXyz61Rih4KjunAD6kFqIIqgQUIqfr2je1?=
 =?us-ascii?Q?M8GJ+2ecR103DDmV/7l/eeZx/vvna9KVznn4obN7MsPHRXrUcK2XLn/KezEq?=
 =?us-ascii?Q?9wCTEYoCQbQcx2GFlKO1CAe+yla2IqXquSRuLJm3zgEB1V7l6CIkPi/u9pSG?=
 =?us-ascii?Q?yyI0Gfxwll0VQKTFu4vIAFa4l8jtxYHOS24fCVnHGGEaC8AePMkEZ7TTbi8P?=
 =?us-ascii?Q?jDtYCveT+Q1Gv+8rSzdY6M5CwGcn4e0Nry/IPGvmyAwSOFTLwQCnSQL7acSy?=
 =?us-ascii?Q?4YMVpIJnTKg/j+boyTG3F+y33M1j1U7yic3Iq7Voogj7DU6LyXH0I+U7ljMt?=
 =?us-ascii?Q?+qTaJbPZxuWMbB0rBpjWteUN1pr6LEfkrCs3bsvY1fuGFTE/F6bIl/KBBp3p?=
 =?us-ascii?Q?tYODTc1ATWki08XFrtZRV+lLUnEgpvt9c4HMRiOfb/p//Ybl/BTa1gVWU3pL?=
 =?us-ascii?Q?rkFSQOlQ7/uKf8gXvD8fpIM2jccAHPJxkkh2Mlam/utGyc1zEiTvcVKczrSg?=
 =?us-ascii?Q?iOuyWquZxkmk/FMQEfM8vYiXViwBzGU8ZNND3bWDCz5HWvfe/6afvfdlyNup?=
 =?us-ascii?Q?7XdF2tUGq4+eyxpLvYlg/pr6ltyP+9yPdoK8ewxtjqWx5RqyYHh83aYDUEms?=
 =?us-ascii?Q?ULMTmleV+HX1bTF9nzReo9R0DQcdlLST53PSk0UuXcNQZcUrls4F00fgLN/w?=
 =?us-ascii?Q?gieon8UCl4g+icuNJzN6Pnt8pU6Rr69SptVHqJnbfwq71SH0lVSejqrdudPe?=
 =?us-ascii?Q?/IZ+UTQVTnYNq7ZcgWzj+yQnp9PnrxFTKr2FBB78mQtB0sS9e1SvyKgEWm6Z?=
 =?us-ascii?Q?4yGn8qokdVORu6s98Q4GIYOpB9hNsQV53nYu/DB4DR3bA6N168PAmIUkaexP?=
 =?us-ascii?Q?rJ92wHx2ULa3voyEJZ5h3RnDm0KBIPR+onwcCSI7a5ACTCEWM4hMbiAVNQ2J?=
 =?us-ascii?Q?yx9atbYoxPpQZvhGd35GywuzyW9bmMOyaOUmT7Q4cwjh4YKOZ6GjMDKSoiOg?=
 =?us-ascii?Q?oE3IM4eynL7CF56TQVqhzasg80buuXI2LJG7/lOoLOvkoNsVPTX3?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556f651f-8f45-49cc-4a76-08df241731b5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR01MB994109.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 02:03:34.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKHErafpkZd7LPWm4pxGjwv6b6WlQH9/n8ew97af1+hCwhiHdH3GznjCQcOh+js93zstfwUFVdEUf3NovKs4clwORfAsKeFH/fUo/WWPiZtpuwxtYqrkBrqDHfXHKEMU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR01MB994424

On Mon, Oct 05, 2026 at 08:14:11PM -0500, Jeremy Linton wrote:
>Hi,
>
>
>At a high level this helps, but it also means cppc_cpufreq is 
>depending more heavily on lowest_freq/nominal_freq for control 
>decisions. ACPI documents those fields as reporting aids rather than 
>control inputs. CPPC perf is the abstract control space and may encode 
>platform behavior beyond frequency. Longer term it seems that we 
>should be moving away from synthesizing frequences like this.
>

I have additional concerns with using lowest and nominal frequency fields in
this series. These fields are marked as "Optional" in the specification.

As Jeremy mentioned, the ACPI spec clearly calls out that these are for
information only and should not be used for functional decisions.

Table 8.23 - Continuous Performance Control Package Values in ACPI 6.6
specification [1]:

Nominal Frequency:

"Optional. If supported, indicates the nominal frequency for this processor in
MHz. It should correspond roughly to the Nominal Performance value, but is not
guaranteed to have any precise correlation. This value should only be used for
the purpose of reporting processor performance in absolute frequency rather than
on an abstract scale, and not for functional decisions or platform
communication."

[1] - https://uefi.org/specs/ACPI/6.6/08_Processor_Configuration_and_Control.html#continuous-performance-control-package-values

Regards,
Vanshidhar

>code comment inline.
>
>On 9/29/26 5:29 AM, Christian Loehle wrote:
>>Different kHz requests can select the same CPPC performance level.
>>Implement ->resolve_freq() so governors such as schedutil can skip
>>redundant writes.
>>
>>Precompute the affine conversion and invert its integer rounding directly.
>>Share bounded conversions with ->target() and ->fast_switch(), choosing the
>>first performance level when several share a kHz value. Recompute limits
>>from each policy snapshot to avoid caching sysfs-shared mutable controls.
>>
>>Cap intervals at or below nominal kHz at Nominal Performance, excluding
>>boosted levels that alias it. Unchanged frequency limits then imply
>>unchanged performance limits across boost toggles.
>>
>>After clamping to CPU limits, snap the limits to supported frequencies.
>>If none lies in the interval, collapse both limits to the highest supported
>>frequency not above its maximum, as frequency-table verification does.
>>
>>Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>---
>>  drivers/cpufreq/cppc_cpufreq.c | 257 ++++++++++++++++++++++++++++++---
>>  1 file changed, 239 insertions(+), 18 deletions(-)
>>
>>diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>index 4ea444ff889e..fa85efb9f701 100644
>>--- a/drivers/cpufreq/cppc_cpufreq.c
>>+++ b/drivers/cpufreq/cppc_cpufreq.c
>>@@ -18,8 +18,10 @@
>>  #include <linux/cpufreq.h>
>>  #include <linux/irq_work.h>
>>  #include <linux/kthread.h>
>>+#include <linux/math64.h>
>>  #include <linux/mutex.h>
>>  #include <linux/time.h>
>>+#include <linux/units.h>
>>  #include <linux/vmalloc.h>
>>  #include <uapi/linux/sched/types.h>
>>@@ -29,6 +31,24 @@
>>  static struct cpufreq_driver cppc_cpufreq_driver;
>>+struct cppc_perf_freq_map {
>>+	s64 offset;
>>+	u64 multiplier;
>>+	u32 divisor;
>>+};
>>+
>>+struct cppc_cpufreq_data {
>>+	struct cppc_cpudata cpu_data;
>>+	struct cppc_perf_freq_map map;
>>+	unsigned int nominal_khz;
>>+};
>>+
>>+static struct cppc_cpufreq_data *
>>+cppc_cpufreq_data(struct cppc_cpudata *cpu_data)
>>+{
>>+	return container_of(cpu_data, struct cppc_cpufreq_data, cpu_data);
>>+}
>>+
>>  #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>  static enum {
>>  	FIE_UNSET = -1,
>>@@ -302,11 +322,159 @@ static inline void cppc_freq_invariance_exit(void)
>>  }
>>  #endif /* CONFIG_ACPI_CPPC_CPUFREQ_FIE */
>>+/* Precompute the affine mapping used by cppc_perf_to_khz(). */
>>+static void cppc_cpufreq_init_perf_map(struct cppc_perf_caps *caps,
>>+				       struct cppc_perf_freq_map *map)
>>+{
>>+	if (caps->lowest_freq && caps->nominal_freq) {
>>+		if (caps->lowest_freq == caps->nominal_freq) {
>>+			map->multiplier = (u64)caps->nominal_freq * KHZ_PER_MHZ;
>>+			map->divisor = caps->nominal_perf;
>>+			map->offset = 0;
>>+		} else {
>>+			map->multiplier = (u64)(caps->nominal_freq -
>>+					   caps->lowest_freq) * KHZ_PER_MHZ;
>>+			map->divisor = caps->nominal_perf - caps->lowest_perf;
>>+			map->offset = (s64)caps->nominal_freq * KHZ_PER_MHZ -
>>+				div64_u64(caps->nominal_perf * map->multiplier,
>>+					  map->divisor);
>>+		}
>>+	} else {
>>+		map->multiplier = cppc_get_dmi_max_khz();
>>+		map->divisor = caps->highest_perf;
>>+		map->offset = 0;
>>+	}
>>+}
>
>This appears be a rework of the scaling computation code in 
>cppc_khz_to_perf() from cppc_acpi.c. And it appears that all the 
>callers of that function are in this module, so is there a reason that 
>the implementation of cppc_khz_to_perf() couldn't be moved here and 
>make use of cppc_cpufreq_init_perf_map() to generate a map and then 
>compute perf as its inverse (freq - map->offset) * map.div/map.mul?
>
>That can preserve the rouding/etc if i'm understanding this.
>
>
>
>>+
>>+static unsigned int
>>+cppc_cpufreq_perf_to_khz(const struct cppc_perf_freq_map *map, u32 perf)
>>+{
>>+	s64 freq = map->offset + div64_u64(perf * map->multiplier,
>>+					    map->divisor);
>>+
>>+	return freq > 0 ? freq : 0;
>>+}
>>+
>>+/*
>>+ * Invert integer-kHz rounding: L finds the first level at or above the
>>+ * target frequency, H the last at or below it, within the supplied bounds.
>>+ */
>>+static u32 cppc_cpufreq_perf_for_freq(const struct cppc_perf_freq_map *map,
>>+				      unsigned int target_freq,
>>+				      u32 min_perf, u32 max_perf,
>>+				      unsigned int relation)
>>+{
>>+	s64 scaled_freq = (s64)target_freq - map->offset;
>>+	u64 perf;
>>+
>>+	switch (relation) {
>>+	case CPUFREQ_RELATION_L:
>>+		if (!target_freq || scaled_freq <= 0)
>>+			perf = 0;
>>+		else
>>+			perf = mul_u64_u64_div_u64_roundup(scaled_freq,
>>+							   map->divisor,
>>+							   map->multiplier);
>>+		break;
>>+
>>+	case CPUFREQ_RELATION_H:
>>+		if (scaled_freq < 0) {
>>+			perf = 0;
>>+		} else {
>>+			perf = mul_u64_u64_div_u64_roundup(scaled_freq + 1,
>>+							   map->divisor,
>>+							   map->multiplier);
>>+			perf--;
>>+		}
>>+		break;
>>+
>>+	default:
>>+		WARN_ON_ONCE(1);
>>+		return min_perf;
>>+	}
>>+
>>+	return clamp_t(u64, perf, min_perf, max_perf);
>>+}
>>+
>>+static void cppc_cpufreq_perf_limits(struct cppc_perf_caps *caps,
>>+				     struct cppc_cpufreq_data *data,
>>+				     unsigned int min_freq,
>>+				     unsigned int max_freq,
>>+				     u32 *min_perf, u32 *max_perf)
>>+{
>>+	u32 policy_max_perf;
>>+
>>+	/* Do not include boosted levels that alias the nominal frequency. */
>>+	policy_max_perf = max_freq <= data->nominal_khz ?
>>+			  caps->nominal_perf : caps->highest_perf;
>>+	*min_perf = cppc_cpufreq_perf_for_freq(&data->map, min_freq,
>>+					       caps->lowest_perf,
>>+					       policy_max_perf,
>>+					       CPUFREQ_RELATION_L);
>>+	*max_perf = cppc_cpufreq_perf_for_freq(&data->map, max_freq,
>>+					       caps->lowest_perf,
>>+					       policy_max_perf,
>>+					       CPUFREQ_RELATION_H);
>What is the actual consequence of not just picking min_perf = 
>caps->lowest_perf and max_perf as nominal/highest? Is it possible the 
>HW is never instructed into either its highest or lowest state since 
>its rounding away from the firmware provided min/max?
>
>>+}
>>+
>>+static unsigned int
>>+cppc_cpufreq_resolve_freq(struct cpufreq_policy *policy,
>>+			  unsigned int target_freq,
>>+			  unsigned int min_freq,
>>+			  unsigned int max_freq,
>>+			  unsigned int relation)
>>+{
>>+	struct cppc_cpudata *cpu_data = policy->driver_data;
>>+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>>+	struct cppc_cpufreq_data *data = cppc_cpufreq_data(cpu_data);
>>+	const struct cppc_perf_freq_map *map = &data->map;
>>+	u32 min_perf, max_perf, perf;
>>+
>>+	cppc_cpufreq_perf_limits(caps, data, min_freq, max_freq,
>>+				 &min_perf, &max_perf);
>>+	if (WARN_ON_ONCE(min_perf > max_perf))
>>+		return cppc_cpufreq_perf_to_khz(map, max_perf);
>>+
>>+	switch (relation) {
>>+	case CPUFREQ_RELATION_L:
>>+	case CPUFREQ_RELATION_H:
>>+		perf = cppc_cpufreq_perf_for_freq(map, target_freq,
>>+						  min_perf, max_perf, relation);
>>+		break;
>>+	case CPUFREQ_RELATION_C: {
>>+		u32 lower = cppc_cpufreq_perf_for_freq(map, target_freq,
>>+							min_perf, max_perf,
>>+							CPUFREQ_RELATION_H);
>>+		u32 upper = cppc_cpufreq_perf_for_freq(map, target_freq,
>>+							min_perf, max_perf,
>>+							CPUFREQ_RELATION_L);
>>+		unsigned int lower_freq = cppc_cpufreq_perf_to_khz(map, lower);
>>+		unsigned int upper_freq = cppc_cpufreq_perf_to_khz(map, upper);
>>+
>>+		if (lower_freq >= target_freq)
>>+			perf = lower;
>>+		else if (upper_freq <= target_freq)
>>+			perf = upper;
>>+		else if (target_freq - lower_freq < upper_freq - target_freq)
>>+			perf = lower;
>>+		else
>>+			perf = upper;
>>+		break;
>>+	}
>>+	default:
>>+		WARN_ON_ONCE(1);
>>+		return target_freq;
>>+	}
>>+
>>+	return cppc_cpufreq_perf_to_khz(map, perf);
>>+}
>>+
>>  static void cppc_cpufreq_get_perf_limits(struct cppc_cpudata *cpu_data,
>>  					 struct cpufreq_policy *policy,
>>  					 u32 *min_perf, u32 *max_perf)
>>  {
>>  	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>>+	struct cppc_cpufreq_data *data = cppc_cpufreq_data(cpu_data);
>>  	unsigned int min_freq, max_freq;
>>  	u32 min, max;
>>@@ -315,11 +483,11 @@ static void cppc_cpufreq_get_perf_limits(struct cppc_cpudata *cpu_data,
>>  	if (unlikely(min_freq > max_freq))
>>  		min_freq = max_freq;
>>-	min = cppc_khz_to_perf(caps, min_freq);
>>-	max = cppc_khz_to_perf(caps, max_freq);
>>+	cppc_cpufreq_perf_limits(caps, data, min_freq, max_freq,
>>+				 &min, &max);
>>-	*min_perf = clamp_t(u32, min, caps->lowest_perf, caps->highest_perf);
>>-	*max_perf = clamp_t(u32, max, caps->lowest_perf, caps->highest_perf);
>>+	*min_perf = min(min, max);
>>+	*max_perf = max;
>>  }
>>  static void cppc_cpufreq_update_perf_limits(struct cppc_cpudata *cpu_data,
>>@@ -330,6 +498,26 @@ static void cppc_cpufreq_update_perf_limits(struct cppc_cpudata *cpu_data,
>>  				     &cpu_data->perf_ctrls.max_perf);
>>  }
>>+static unsigned int
>>+cppc_cpufreq_update_perf_ctrls(struct cppc_cpudata *cpu_data,
>>+			       struct cpufreq_policy *policy,
>>+			       unsigned int target_freq)
>>+{
>>+	struct cppc_cpufreq_data *data = cppc_cpufreq_data(cpu_data);
>>+	u32 min_perf, max_perf, desired_perf;
>>+
>>+	cppc_cpufreq_get_perf_limits(cpu_data, policy, &min_perf, &max_perf);
>>+	/* Use the first level when several share the same integer-kHz value. */
>>+	desired_perf = cppc_cpufreq_perf_for_freq(&data->map, target_freq,
>>+						  min_perf, max_perf,
>>+						  CPUFREQ_RELATION_L);
>>+	cpu_data->perf_ctrls.min_perf = min_perf;
>>+	cpu_data->perf_ctrls.max_perf = max_perf;
>>+	cpu_data->perf_ctrls.desired_perf = desired_perf;
>>+
>>+	return cppc_cpufreq_perf_to_khz(&data->map, desired_perf);
>>+}
>>+
>>  static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>>  				   unsigned int target_freq,
>>  				   unsigned int relation)
>>@@ -339,12 +527,9 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>>  	struct cpufreq_freqs freqs;
>>  	int ret = 0;
>>-	cpu_data->perf_ctrls.desired_perf =
>>-			cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
>>-	cppc_cpufreq_update_perf_limits(cpu_data, policy);
>>-
>>  	freqs.old = policy->cur;
>>-	freqs.new = target_freq;
>>+	freqs.new = cppc_cpufreq_update_perf_ctrls(cpu_data, policy,
>>+						   target_freq);
>>  	cpufreq_freq_transition_begin(policy, &freqs);
>>  	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>@@ -361,13 +546,12 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>>  					      unsigned int target_freq)
>>  {
>>  	struct cppc_cpudata *cpu_data = policy->driver_data;
>>+	unsigned int resolved_freq;
>>  	unsigned int cpu = policy->cpu;
>>-	u32 desired_perf;
>>  	int ret;
>>-	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
>>-	cpu_data->perf_ctrls.desired_perf = desired_perf;
>>-	cppc_cpufreq_update_perf_limits(cpu_data, policy);
>>+	resolved_freq = cppc_cpufreq_update_perf_ctrls(cpu_data, policy,
>>+						       target_freq);
>>  	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>  	if (ret) {
>>@@ -376,12 +560,39 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>>  		return 0;
>>  	}
>>-	return target_freq;
>>+	return resolved_freq;
>>  }
>>  static int cppc_verify_policy(struct cpufreq_policy_data *policy)
>>  {
>>+	struct cpufreq_policy *cur_policy;
>>+	struct cppc_cpudata *cpu_data;
>>+	struct cppc_cpufreq_data *data;
>>+	struct cppc_perf_caps *caps;
>>+	unsigned int min_freq, max_freq;
>>+	u32 min_perf, max_perf;
>>+
>>  	cpufreq_verify_within_cpu_limits(policy);
>>+
>>+	cur_policy = cpufreq_cpu_get_raw(policy->cpu);
>>+	if (WARN_ON_ONCE(!cur_policy || !cur_policy->driver_data))
>>+		return -ENODEV;
>>+
>>+	cpu_data = cur_policy->driver_data;
>>+	data = cppc_cpufreq_data(cpu_data);
>>+	caps = &cpu_data->perf_caps;
>>+	cppc_cpufreq_perf_limits(caps, data, policy->min, policy->max,
>>+				 &min_perf, &max_perf);
>>+	min_freq = cppc_cpufreq_perf_to_khz(&data->map, min_perf);
>>+	max_freq = cppc_cpufreq_perf_to_khz(&data->map, max_perf);
>>+
>>+	/* Favor the maximum if no supported frequency lies in the interval. */
>>+	if (min_perf > max_perf || min_freq > policy->max ||
>>+	    max_freq < policy->min)
>>+		min_freq = max_freq;
>>+
>>+	policy->min = min_freq;
>>+	policy->max = max_freq;
>>  	return 0;
>>  }
>>@@ -618,12 +829,14 @@ static void populate_efficiency_class(void)
>>  static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>  {
>>+	struct cppc_cpufreq_data *data;
>>  	struct cppc_cpudata *cpu_data;
>>  	int ret;
>>-	cpu_data = kzalloc_obj(struct cppc_cpudata);
>>-	if (!cpu_data)
>>+	data = kzalloc_obj(struct cppc_cpufreq_data);
>>+	if (!data)
>>  		goto out;
>>+	cpu_data = &data->cpu_data;
>>  	if (!zalloc_cpumask_var(&cpu_data->shared_cpu_map, GFP_KERNEL))
>>  		goto free_cpu;
>>@@ -640,6 +853,10 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>  		goto free_mask;
>>  	}
>>+	cppc_cpufreq_init_perf_map(&cpu_data->perf_caps, &data->map);
>>+	data->nominal_khz = cppc_cpufreq_perf_to_khz(&data->map,
>>+						     cpu_data->perf_caps.nominal_perf);
>>+
>>  	ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
>>  	if (ret) {
>>  		pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, ret);
>>@@ -651,7 +868,7 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>  free_mask:
>>  	free_cpumask_var(cpu_data->shared_cpu_map);
>>  free_cpu:
>>-	kfree(cpu_data);
>>+	kfree(data);
>>  out:
>>  	return NULL;
>>  }
>>@@ -659,9 +876,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>  static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
>>  {
>>  	struct cppc_cpudata *cpu_data = policy->driver_data;
>>+	struct cppc_cpufreq_data *data;
>>+
>>+	data = container_of(cpu_data, struct cppc_cpufreq_data, cpu_data);
>>  	free_cpumask_var(cpu_data->shared_cpu_map);
>>-	kfree(cpu_data);
>>+	kfree(data);
>>  	policy->driver_data = NULL;
>>  }
>>@@ -1056,6 +1276,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>>  	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>>  	.verify = cppc_verify_policy,
>>  	.target = cppc_cpufreq_set_target,
>>+	.resolve_freq = cppc_cpufreq_resolve_freq,
>>  	.get = cppc_cpufreq_get_rate,
>>  	.fast_switch = cppc_cpufreq_fast_switch,
>>  	.init = cppc_cpufreq_cpu_init,
>
