Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010019.outbound.protection.outlook.com [52.103.20.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC283FF8A2;
	Fri, 17 Jul 2026 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294816; cv=fail; b=K9kgnQHDAsIK0cmL7ihOSCA2UAdio/R6RnJxc/g+NCgJxZH0IX3ETx/cUqjkeVimIY/29Cn15w6kBWCxJnI8PLT6IqiYY0Rt+IVSiQWOc5P9Oz1m2y2i3/1Weh8vlbml7eRkfNQULJ1krl5TiUurZDYPuJmcb8++D7fJHTjOcsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294816; c=relaxed/simple;
	bh=8aq1nwSwyNBZdrunNET/mLTsTFFMTO4dq8KzKz0u+NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LRvqpavE9zUPlQ+OMaP0grwACYCszRZ+oeXXr7ChcmMirYvHzphne0kmKkK0veBfMZejQw9AHx82vpw1Yb+XRg+gvHmh6uEYb2t5cmfU6UyX3JziOoa/U8MfAWX8I3RTtdVw1haUjRg0guZ3YjW6IQ5IMiDVUH422dhfGf4jgFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=UgwAUcss; arc=fail smtp.client-ip=52.103.20.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="UgwAUcss"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VF5fatF8H4COITgalFvVkV/qYrldI9PSJXqf/eMTCeFSj5md54df1P86r53MqhKXTnEuSzGpaV+2njUFbQ5N6F51nB2D347kPQ+yp1ArPPnBn1POV3giMK5NvEzZrhA7Qd1fR9yf4IKvrKbrwjxMIosrlLtGC/ShESRmsyPaHSwzS3ptpjY1g2yyRn62u7NUGdzgqwJjnTCjGZfayoVbueRg0PqYta1osIg1UmOlxaQlKy/FFR1knmNKb2LbnPXoqsPj6C/JQGDu14LIUVx4V0Vg49hOh90/UxIpASAZqEyniQ2HNXkR6zijd72MhGlkqwZhrcxfamrtzSUWtgDQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RW2RBC8GKK6l8mk4Nt4B65Mubfja5PxvFdf0fSQ9YPU=;
 b=Lx6uJZnkr6Vh/9FXyFhG4yiTfunnSCouLh0sy92Hgg1oCSveG9IIxkj+ZJPadzJKYyXC3YPp5NzIyEYUkLPfUDMVinMaR/OcuSPhapJusN1czGk3KTGXa6/IF93Ulixyl42GhfifLw9i00g7OlfdsgTJEBHdXD4pGoA5iEN9AS5K4IH9P85WVMdx/eVaoRW3nHCnPpPHnsfr7wgfh+iQAp48TTohHP4Nz7nx7xAReBv9HxIUz3bgeAoa4zRu4z/moGf84x8B/LVaGHM98rfQParzBFi70BT62faL1Q7bvqcUFIMoTREU9qY1q62jxiAiVuQYcsYHTQO1pvVRcqK5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RW2RBC8GKK6l8mk4Nt4B65Mubfja5PxvFdf0fSQ9YPU=;
 b=UgwAUcsswWXV70a6RoflX3/YsrsgiNsK5yFIx6yWevEr+4vwxRu4FwsMP4tc4Q70ljQBH5v79jNz/0ptZ0pba6WxLguWW4pvm5JG8tE2cjN479LMLvUYkBRzGrNousIKN9eZVHnxuZkXq9UE96R2w7wkwgaaV5GzQ4oo+AyzUV6VHWltXMpJsPN4kf8dMjhq/SXgHGuoPqfVzH3Mjtv2Qb5OQIGXQNMOlWmkHmXWYefDe21nqFxchKvhYtgX9ntjuohGVjzdszTGEZgeLwpJCziwSQ6mriKQmNQowILyqDgJNdxCS6J9PVhmEgH7TtBhvlinPR1sOrVo3NMPJV160Q==
Received: from DS7PR19MB7724.namprd19.prod.outlook.com (2603:10b6:8:d9::20) by
 IA3PR19MB8637.namprd19.prod.outlook.com (2603:10b6:208:526::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:26:50 +0000
Received: from DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86]) by DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86%5]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 13:26:50 +0000
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
Subject: [PATCH 4/8] ASoC: aw88399: add firmware reload flag for resume
Date: Fri, 17 Jul 2026 15:25:06 +0200
Message-ID:
 <DS7PR19MB77240CB79188C0B7AE243829FCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
References: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To DS7PR19MB7724.namprd19.prod.outlook.com
 (2603:10b6:8:d9::20)
X-Microsoft-Original-Message-ID:
 <20260717132509.148321-6-marco_giunta@outlook.it>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB7724:EE_|IA3PR19MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9a0b95-933c-40b8-0f82-08dee4070e8c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|2604032031799003|5040399003|5072599009|51005399006|12121999013|19110799012|8060799015|41001999006|704163111799003|55001999006|15080799012|24021099003|16051099003|3412199025|440099028|40105399003|3430499035|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5b5aCjFJ+k0HiuFdXorHvyg3JkntS1QvmvCNXr8WqUun1UFNCuZpFw8BuMGB?=
 =?us-ascii?Q?HTxbuEIt4WTKZF5X8o5z+Dw47qwI4j/lpMScTF27mpvNJ6BFXEHowk1d6q94?=
 =?us-ascii?Q?Li6ckBEUSOve1ASLaK3RyQFQHMX252BRJ6ZaS/7up2wrxY6JwJ+uoPg1lGjN?=
 =?us-ascii?Q?oopui+auzCTqy6u79kGWL46PT7Sq1Mzh1HVOSN66/1ddc/Z51l/SCyVIcEyR?=
 =?us-ascii?Q?vWW4G7nM7LXxHod1sHpGiQRqqBv/ah3Lshb2HAhlHKNATbzZoNO8QCKNEhlJ?=
 =?us-ascii?Q?jgA7AoEQ0uMzBLi2LRoh6Aob6c/9kSAntkrBKHfRcluzQ1jehPg1jIse8VPe?=
 =?us-ascii?Q?rzFTDgabpGmjJnL6Q5+164o86hqsdgH84EPillEiCPVMIqqT8jgptV3tCW7n?=
 =?us-ascii?Q?11d7cTuYPZsxwJLF5GF9FeksdgYbiz2zzFqXJCJiTOLLJqI9JoYCDuASGXdj?=
 =?us-ascii?Q?k3ETzf+uC5/yLkQaRF3pDB3n/k990OsyRvErADaW+A1FzFPOzMpzEyKnjHSm?=
 =?us-ascii?Q?JU9xyWvm9XLoEiNqLcYk88xVg3Swib3FyphblE4WmfVQPb+AqJ6eRU3zrj9D?=
 =?us-ascii?Q?sf6MOcUC3bf+j6P5/Kmpd0bzxXBis5+x8VDY0RMRHTFDsPZ3sfd7kH7nZml4?=
 =?us-ascii?Q?QaejB7eXZMDx74jfuP6rHkb/DcBXJ/2fOZKTLMl8wjOymX1H1FAaqC5yrRkj?=
 =?us-ascii?Q?+9VKC6KGKRrPeP3rAqPRrKW/Ri9fZaFh0M7eDYd8tt3QHc47Uzh904zY1OV+?=
 =?us-ascii?Q?eQESZJiCtLsMfO77mN4JbW8FlE6HS4qHdVLUfsFi4gEnZtqtpQz2Z3DdTYhB?=
 =?us-ascii?Q?jawCAcfRKh/s0+vOSkDeZZXCuqVApEVyH0BnbRkRZ8dCqJSj3GknnBhU+rVC?=
 =?us-ascii?Q?kAfKvNt8w0DJMHjy0rAIiXTph1ig3aMlPljEXDLd5ShDCSclFyTPNnurLlYe?=
 =?us-ascii?Q?+xNEcydbRQi4OqLO6CUlIPhIBt1Q1g51oaBAE+ZPxB4QwdxFbk9xZxBHcTWx?=
 =?us-ascii?Q?dBEuArteoEmFsc35lo/P3Z3zpZIOwIPMYuIlLYoGdxEiWHCz95Mn/4d01NG3?=
 =?us-ascii?Q?aOqtoYJ37OdGoMJyiM1ukS7Dw+SKF6zFMbUgY/WngO9EM2Vh6N36eJAqxYGh?=
 =?us-ascii?Q?5HcKmRwkvGLBRflU1EKo3jzyG4SM8ZjTkghBsmzGnn4s0GW6LrgzuCFjVoUf?=
 =?us-ascii?Q?orMfwYDLkaggKaUG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+R3f0KaPV03oDWGZUCpVGBPWlDHBvw6NX0U2InBUXcrNPgWDirWj9NKO8Qt?=
 =?us-ascii?Q?pba4186mUzooQRLCxHIg3bKu8eIIcV189yMul6MIQNqEieOCECq74eqXzbsW?=
 =?us-ascii?Q?QMU9TDfxC1hQTqUl6XXMbZcNCgfdHpQgpHXfHMn1EV9ej3vLM7Z0Y6KOKt7f?=
 =?us-ascii?Q?APhnCBFgBMYCHb/Y3Mc6NjHuJecYWd6nHgiYZQNNR+cXcUcdaPYM0Wwc/5q5?=
 =?us-ascii?Q?osN8ShZEqFitDh1CEyrWtE/JMIDivuXfUF7WxVqpBaE0OYmMDvlqKxTn5FZ1?=
 =?us-ascii?Q?3q9m8EwZxJ9XxC00JZ+50NtAl4W+9Ol0Jlg3OV+uKxK/IdV/2WDRZ0ezXodP?=
 =?us-ascii?Q?9zt3CY/FQua1aRbFrh98rdOspCdNyZCoWv7oxNwX72e6Ii1i5CU0KaI6OGY3?=
 =?us-ascii?Q?afQ7GOrjuWz9mgXGSd2yAYNx4zFtuIH/BtdFzNMre7Nr09OBmPyV1WbfEYt9?=
 =?us-ascii?Q?P4f8BaQOaJ86mFAuQ6pgw8PdloV/VW86IYlb7hal5o+D4YsI8+WLc114Ve0T?=
 =?us-ascii?Q?QrGcgeLy5x1jlyA9GkD5GZdVW9NasACl5HUJZFwU31MYn50VXRfeGdTut2u8?=
 =?us-ascii?Q?xFxzMKyzdpXEc+YkM3pSIVVsHxXx2NEuIDF9uyQPb6D3qqJyWu+yGZVe7mAz?=
 =?us-ascii?Q?vzH7px/8fQ4LR2mlTLC3jIdHg6mrATY2JDadO4Jg3+mZ1EL2HyA1kY0ADyIZ?=
 =?us-ascii?Q?QtzIEvmzen0IsfKaIzxbWp4/Ke9pFkfuYLiO0oI7xxNGjgkyqwnO+ehrh9L3?=
 =?us-ascii?Q?wgb5iXlWL1OPUPFFq9Avk7gc0CJ8DMxXHQx1AC4ZIiBSlLa6gv7i7ydGbX6M?=
 =?us-ascii?Q?tgFQtdjWn22hNi6IXztoqAs7ru+RI7tzDwMGt+y69PUoTK+3ucNT2gfdYTph?=
 =?us-ascii?Q?ezCBumspdfNE62TFJKXp3qjQzayRQMT8lJaCh0MKVUnzE8yCSIX9PN/2KHeu?=
 =?us-ascii?Q?3r+KPlqxaa1aJ5+gqLA8AJXYdC8+9DtlYcvb0jZvE03OSUKEue+hDewchZJ5?=
 =?us-ascii?Q?7ls7QFo5bxUUPLcnqFAA4x5hMB/4p4ul1BQ9wdL0gWjxKr5UVOiAF3hKSjRv?=
 =?us-ascii?Q?o3ofaLGTJFoNF0tOd8EromayqvYkZvC/bXanzoOsV1M6pL4ZO2aTb/5udlbc?=
 =?us-ascii?Q?FOxhrOB4NGeRAWg6HhqIretiqAuet0cq4VPRaKRjT/Y5KQX3Cft6QGSHxIeh?=
 =?us-ascii?Q?0l9AeAgA7WwquKTwGubusPh6MDeVx+I3Kqb/0Xxcxmcvu4IQOCtRi+Lig21z?=
 =?us-ascii?Q?mJjZRUCtZGq+9I7wuobeDZfLSPlZeufOzUQ1lqyXLCQhtyfwRW0E2+EwcBvC?=
 =?us-ascii?Q?c4yFh/GZBTYWtoFFs2AGCT2aechmYP0VFxhLuPF/AjptGvbGzjIFiQEJLjlj?=
 =?us-ascii?Q?q/OaZhwDLJcPwDcwPI/gqPJNaXER?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9a0b95-933c-40b8-0f82-08dee4070e8c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB7724.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:26:50.4146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8637

Add a fw_needs_reload flag to struct aw88399 that, when set, causes
aw88399_start to perform a full DSP firmware upload instead of
assuming the firmware binary is already present in memory.

After system sleep, the AW88399 loses its memory contents. The
existing start sequence assumes the firmware binary persists from
initialization and only uploads register configuration and DSP
config (AW88399_DSP_FW_UPDATE_OFF). When memory is empty, this causes
the subsequent CRC check to fail, triggering the retry mechanism in
aw88399_start_pa which re-uploads the firmware on the second
attempt.

While the retry mechanism recovers correctly, it produces
misleading error-level log messages on every resume cycle. The
fw_needs_reload flag allows the HDA side codec driver to signal
that a full firmware reload is needed after resume, eliminating
the spurious CRC failures.

The flag defaults to false via kzalloc, preserving the original
behavior for existing ASoC users. No existing code path sets this
flag; it will be set by the HDA side codec driver's system suspend
handler.

Tested-by: Nadim Kobeissi <nadim@symbolic.software>
Tested-by: Xia Yun'an <imitoy@imitoy.top>
Tested-by: Munzir Taha <munzirtaha@gmail.com>
Signed-off-by: Marco Giunta <marco_giunta@outlook.it>
---
 include/sound/aw88399.h        | 1 +
 sound/soc/codecs/aw88399-lib.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/sound/aw88399.h b/include/sound/aw88399.h
index dee91b540b81..3dbc37dc13d1 100644
--- a/include/sound/aw88399.h
+++ b/include/sound/aw88399.h
@@ -599,6 +599,7 @@ struct aw88399 {
 	unsigned int vcalb_init_val;
 	unsigned int dither_st;
 	bool bsts_unreliable;
+	bool fw_needs_reload;
 };
 
 int aw_dev_check_syspll(struct aw_device *aw_dev);
diff --git a/sound/soc/codecs/aw88399-lib.c b/sound/soc/codecs/aw88399-lib.c
index 2045c4171be0..094a37b66fb5 100644
--- a/sound/soc/codecs/aw88399-lib.c
+++ b/sound/soc/codecs/aw88399-lib.c
@@ -1171,12 +1171,15 @@ void aw88399_start(struct aw88399 *aw88399, bool sync_start)
 	if (aw88399->aw_pa->status == AW88399_DEV_PW_ON)
 		return;
 
-	ret = aw88399_dev_fw_update(aw88399, AW88399_DSP_FW_UPDATE_OFF, true);
+	ret = aw88399_dev_fw_update(aw88399, aw88399->fw_needs_reload ?
+		AW88399_DSP_FW_UPDATE_ON : AW88399_DSP_FW_UPDATE_OFF, true);
 	if (ret) {
 		dev_err(aw88399->aw_pa->dev, "fw update failed.");
 		return;
 	}
 
+	aw88399->fw_needs_reload = false;
+
 	if (sync_start == AW88399_SYNC_START)
 		aw88399_start_pa(aw88399);
 	else
-- 
2.55.0

