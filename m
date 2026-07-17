Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010019.outbound.protection.outlook.com [52.103.20.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EF83FE67A;
	Fri, 17 Jul 2026 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294828; cv=fail; b=CBeRRhYRBAmmFZ5atCoiheL1b/VGT2tFC4tJKNuow0Q+bE/dLtkV30buqAcmzbzFudhXslFaFUYiQIj+9AgNLaqu4kuk6gZ5N8ZjnxbfWquNOpun9ivBo1SkFWj504ap6AMmqiv/oYhNoN3OVkD27qWcPH1Ky0kCKl/iQob38Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294828; c=relaxed/simple;
	bh=Pp2aCIQ/U70UtbfwOMwpdn9BzAxbFeAhwr7Dl9O6Wkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cr7LJv3KfAuuSzohapcYAmdMjTh9xE4WBLKjzJOH6PJFiTskSpgHCMgB86zH41ehEsvBmOCFFgOlr0dDbLrsM+BURysXjhu6RpiEgD8xdg3+8G8l3OC26J2Dej/y33KJvPQyE9LKl9d0uPSVSzeK/2irQF1umXYjQpYfhy4I364=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=YBtbzeag; arc=fail smtp.client-ip=52.103.20.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="YBtbzeag"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbR4TE7eOA7sYQs+Ru1Kp/esi2qOSEZOc4DzLHCAnjvwpzoEYCvU4CK8MrLQRs6+Wf0iw/teGqCydDs4GAZQGJ6codJV3COAQuSmQDnqjxG4j7x8oF4cvkkgQCUcIXE/DahaXZF3PAMvUPifcc1Z4dKXdcGgl2y6I/RGs5NydEbJB+V1J8O3Gkx7PRiqipkx0xy5tuXIWk21Scbho6r7Mjlgz3K2BExlbWv0n3OLlrOmyOEskMXxQ3BNTUvLelJOlDtNT4tG8SzN7vcs4dgY0fg2tSxNSDJaMnJAUitahUeM85ardClnpN2zgXkfjDAtivE4riOYYAnDUBUwFKSqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZroQUjDf/NN7f5Esft71IO3ayVsxc/APft1ft37shs=;
 b=KJyHj7MqUfnf3g6ZZjt6SwaMhck7YaBAphiAcPk0eFPp13TcYGDW4qTWUI+qpTrQGXhYgWkF0nf0LxIoPVyuceOF/UGRs2y83ksvX0h6uNXVD9Lm95RUDM6hBoekL4F1PyE8Bln1dJrEOTNNVrp4GiIjpiRHRWT0a5/X2Axpl4p4EaUnNH+qxBSoBqHcK/+Rz1+Ma8iXftwDC/3zj0IZDAJldrcw0L8xJB9DyFIaDsfxKH7GW8SY9d1GHejdcQaWWsNaQXRJhvEO/Z0hPogK+oFDj53jPqviLog2OwNFW+UVVVoC9T7D+ywcwYkGXfGNLS6hsD+SRxipAC1Lp3KwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZroQUjDf/NN7f5Esft71IO3ayVsxc/APft1ft37shs=;
 b=YBtbzeaglIR3/B+MASo0Bfjmzzaar7dioYBGgt0BJFtDQG+FGSeHqUbCEkuTATSR3oHsTsfl06gHkM/Jt7lY8YbRDcqwVolW9KeszZTj4OWRbmYOa+Q4l0h81ASTSbJIHMdL2V9ZeFy+DlBA9QpuUpXwCUZpKTqYaejvbERQE14EIt7aM6xXhQpZf3FPGOscn7luIKYZMsJcI/Q1P2UVPOFed4qlx3uXKoTHz3o5J8GlT2uBttMQwZvfHrI3HxCqNAC/rsiFsayLicf/0shMHV39OxNRRF8AL5HQbytBXivlWh7kH4yVdoCjvGn9zfztaHcHVVsAVv6ZbIQAczWG8w==
Received: from DS7PR19MB7724.namprd19.prod.outlook.com (2603:10b6:8:d9::20) by
 IA3PR19MB8637.namprd19.prod.outlook.com (2603:10b6:208:526::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:26:57 +0000
Received: from DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86]) by DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86%5]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 13:26:57 +0000
From: Marco Giunta <marco_giunta@outlook.it>
To: tiwai@suse.com
Cc: perex@perex.cz,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	wangweidong.a@awinic.com,
	nadim@symbolic.software,
	imitoy@imitoy.top,
	munzirtaha@gmail.com,
	yakov.till@gmail.com,
	Marco Giunta <marco_giunta@outlook.it>
Subject: [PATCH 6/8] ACPI/platform: add AWDZ8399 to serial-multi-instantiate
Date: Fri, 17 Jul 2026 15:25:08 +0200
Message-ID:
 <DS7PR19MB772444EB48828D8ED8EB3175FCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
References: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To DS7PR19MB7724.namprd19.prod.outlook.com
 (2603:10b6:8:d9::20)
X-Microsoft-Original-Message-ID:
 <20260717132509.148321-8-marco_giunta@outlook.it>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB7724:EE_|IA3PR19MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b799de1-c814-481a-751b-08dee407134a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|2604032031799003|5040399003|5072599009|51005399006|19110799012|8060799015|704163111799003|55001999006|15080799012|24021099003|16051099003|3412199025|440099028|40105399003|3430499035|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uEaDK2YHSpfEyNYtN0vVTRfnoe/Ab+BsgFtqHqwbzFHu4o0HWJC4b8xvmkqj?=
 =?us-ascii?Q?F8MmSZWWHVFavDhby9UC2/eDF83yKbyyor370xBNKJWQ70ghn/ac1Sp02LoY?=
 =?us-ascii?Q?1omML80OGf/gkSYc7nGMF/U1SDFyCIm7WrX/yCzAKtdbBE5JOaydZzkauBvX?=
 =?us-ascii?Q?w02NvZc7c6bl8X/r3USbsI/uuWS7+cwWSCAXO8gjzH8XbNDYpfb6YeU7tQlc?=
 =?us-ascii?Q?u0cxQF3wxOWfHk7Wrqal7szn11UWN+X/9tsOZPrb/AgLFORKfmfw1rnO2AEs?=
 =?us-ascii?Q?SdAI5jiNUHau7mW5CuuC/lyBLwOcBuBvRGD0gyTl4/lsCWvx5FiJowj4KFVu?=
 =?us-ascii?Q?JT4ZMOpQzJmsz6+70CTl1kuI7rtpXmsrD2nH1y2oSjBgBk+0Shsr3yiqQyOl?=
 =?us-ascii?Q?4oOUvF4QnjjVSQ51q/pGzxLFTaOfZsyCLNSIM2bOCHF22C0KgxNaqKg6Cdtk?=
 =?us-ascii?Q?Nhf76PSyUSVhg8Qbu7jvOsuAEL5Ph2M2Izl/bci8vykD9Wi7rv06sZTG5SgA?=
 =?us-ascii?Q?lYzHu2FEacIqdghWffeFkb4Vv+2YRYV6WqWn4oCjW5qZbtuMNkGoKopiUAhu?=
 =?us-ascii?Q?vM+KOsjFFVbhbxIgh1wqcQepwf7r58TnBVKmJ/HxBdz4I5w3H4bb+2UuJW/6?=
 =?us-ascii?Q?ZRijTyTSH9et2Q5Hf3W+OkfzI3OUEp4KJlaZs59hGcc7xEaTElnO2uoA7s1p?=
 =?us-ascii?Q?1h79SlpUyC0b4wqKcFF88nr1FPqgLXzuHSMIwIi8xd1jaeAeIxnqCyHFCQ4E?=
 =?us-ascii?Q?MstHRaoyC99+qmTNWDjRIUgyJz+VGLFyWF7Mn31KoVb/HRwEbeywaJcM0OSX?=
 =?us-ascii?Q?IQhJ2umt9UPwTLOxr64irkuxR7Wccee4vin/PHY6kw3rA9chT+i04ESrzy8c?=
 =?us-ascii?Q?Qf8FpZmlWxpBVmffSr6eBE+0apThf73mDtFiHrmX1x/dGwhzF6TFQxzO0b9u?=
 =?us-ascii?Q?wtkcA/EuuOqkGsClB5th2LjSKibaeBILqfKi+1a8d+2s8/5n01Mry4p9B/st?=
 =?us-ascii?Q?3P5z3tKnXhiyDFHcKOnP/Djzii41T8DoHa5BsvmsCq8Gq+VYA5fW+w6R8OCV?=
 =?us-ascii?Q?JjSIfpBeht2MOmewWvrFpwGYrfMPy9Rem+8T0V7vEldvTU8InYQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AaD6AiRSg8Zd/fAy8QIKoyzjFtlMx+5JGlQGUaTE0g7J2bJHWAWNHeF/4l8j?=
 =?us-ascii?Q?OkVc2LR3+WBPYxH2jUZLVqlYHbiB62OEvlCLH668YE/DHdAZL0yf/mOPmlWr?=
 =?us-ascii?Q?Mrdg4gcj3dwOLrczJhg/A7d/clVoz90pUD7nrrCyzpgzXEl7pquynJmu+Zzh?=
 =?us-ascii?Q?kdCcLyB3ULInhpwppNBYxYwBMPJUtaVG15HU4uwNOBMs0x7lZjUyysoXSA9p?=
 =?us-ascii?Q?mmV6So/u8gW1ceYt5UiqciG3jJ23vafezvR54xyyXI918XRG59t12wqEjYaL?=
 =?us-ascii?Q?3TeMWWSL7TCQb64aMmZQTvEChEKIG5rrLy1FaCof8t+fRU/DlYwyh/Ogn6vg?=
 =?us-ascii?Q?gxXpTEY5uBCZ7jgqk8aoVUNOz/MSYpGiZQfpyCSs2Q8+iQZcKfAH4sU63GlH?=
 =?us-ascii?Q?2UruuoCaSAs7zitfu/DstAOrsoofdDztGD8ONtjVNoj6BZdNnwi+BWC8GQdC?=
 =?us-ascii?Q?Tsvnpdgl29/ETTz2AxpS8X5KNzB31K+WgjYcVOpSqA/scxBC3HxDEXKXOEJh?=
 =?us-ascii?Q?YNPeJjKcj0uoTT+sGtJIj5MVFj9xa1FVq2V7iGObANpVXyn35Gx4FPH+UGI4?=
 =?us-ascii?Q?DgJF0nuYvQ+96kHuU0jXi+AT3NRwLk+BbfoI50Eaj3ZvjRmfWcT7XRA7CJpy?=
 =?us-ascii?Q?GVtZCIO1xTRvRaJRlDAzuZ5Rf437GlQY+BLOJVHKND0TJdx0NBsNfakPJyZz?=
 =?us-ascii?Q?D8+5CjbXwdYP1jKnOhX7Ahl/+GzfheqNmZqLZSv28+zfsBci1003kYYbqS7g?=
 =?us-ascii?Q?KJNMSdzPZENoBDy8bdWYezpmunG/i5D3+S51m3Tp88MAI15X/TtrvWgCWjlj?=
 =?us-ascii?Q?9Z9ze/3pyNAd1i8+9NpZTUT9vZS1dZiOWC+LArErARXeWj4ABibvlo2szngw?=
 =?us-ascii?Q?m+OdWrN/DcXH1XFRPiam5BXswIsHlNcq0qVjJkRsqlMW/MOOxgCuVMFJaawb?=
 =?us-ascii?Q?O+0PMvRLKpgQU5fZiSEOfsftC/K8rPKg9NobGfEX+3ivr3i1cRh5PGFa5Nyn?=
 =?us-ascii?Q?qq1o5w/A6+KpFOjbhvTHwUL9bQ5HH9oz5lFjXHZATF01y+1G9+UA5mMdsMcN?=
 =?us-ascii?Q?AjYcLtbr0HptlCYgRToq2V2h7nF55RQMuB7NOob/kNDqwFFQOgQdsLE0Qg0K?=
 =?us-ascii?Q?uT1+9bvx3PAUZ377QXFfBnr3/9R6EZkCgu8oW74erii/aJUsv91PKr9gG+mv?=
 =?us-ascii?Q?UOH3zcSQAulf63v0tZjAeyozt2EjpuwfwMWiV6nWLUJhB7XpFy9CmPSRN6DY?=
 =?us-ascii?Q?c3VX4TpVOHFu7bwOGdEZl0ooeEAj4l1l+yWopst3zonI684hNn3elY6U6l/u?=
 =?us-ascii?Q?Vb39Vzsajr3SmH6o43nkzAxReqAivvXG+R872YKxqOaIVKbRarVB0Zyb8bQ/?=
 =?us-ascii?Q?dMgI2+u0oaBxWMNX8ElIe8x0ZMtD?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b799de1-c814-481a-751b-08dee407134a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB7724.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:26:57.6211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8637

Register the AWINIC AW88399 ACPI hardware ID "AWDZ8399" with the
serial-multi-instantiate driver and add it to the ACPI scan ignore
list so that the two I2C amplifier instances on Lenovo Legion laptops
are enumerated as separate I2C client devices rather than a single
ACPI platform device.

The SMI node creates two instances named "aw88399-hda" with
IRQ_RESOURCE_AUTO, matching the pattern used by CS35L41.

Tested-by: Nadim Kobeissi <nadim@symbolic.software>
Tested-by: Xia Yun'an <imitoy@imitoy.top>
Tested-by: Munzir Taha <munzirtaha@gmail.com>
Co-developed-by: Yakov Till <yakov.till@gmail.com>
Signed-off-by: Yakov Till <yakov.till@gmail.com>
Signed-off-by: Marco Giunta <marco_giunta@outlook.it>
---
 drivers/acpi/scan.c                             |  1 +
 drivers/platform/x86/serial-multi-instantiate.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9a7ac2eb9ce0..4f4552b1551b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1752,6 +1752,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 * by the drivers/platform/x86/serial-multi-instantiate.c driver, which
 	 * knows which client device id to use for each resource.
 	 */
+		{"AWDZ8399", },
 		{"BSG1160", },
 		{"BSG2150", },
 		{"CSC3551", },
diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 1a369334f9cb..3e89fcdd45f7 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -307,6 +307,15 @@ static void smi_remove(struct platform_device *pdev)
 	smi_devs_unregister(smi);
 }
 
+static const struct smi_node aw88399_hda = {
+	.instances = {
+		{ "aw88399-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "aw88399-hda", IRQ_RESOURCE_AUTO, 0 },
+		{}
+	},
+	.bus_type = SMI_AUTO_DETECT,
+};
+
 static const struct smi_node bsg1160_data = {
 	.instances = {
 		{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
@@ -405,6 +414,7 @@ static const struct smi_node tas2781_hda = {
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
  */
 static const struct acpi_device_id smi_acpi_ids[] = {
+	{ "AWDZ8399", (unsigned long)&aw88399_hda },
 	{ "BSG1160", (unsigned long)&bsg1160_data },
 	{ "BSG2150", (unsigned long)&bsg2150_data },
 	{ "CSC3551", (unsigned long)&cs35l41_hda },
-- 
2.55.0

