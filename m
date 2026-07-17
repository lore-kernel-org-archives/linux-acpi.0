Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010019.outbound.protection.outlook.com [52.103.20.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A773FE64B;
	Fri, 17 Jul 2026 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294837; cv=fail; b=MTy7AEju5BoLzz3qaau1FOlXuioNYIeUDI7M7Ex67ibTK2/RlHfHltGvrRdkzA6tMUhlwiorv+xuLWjTLN1yUnDYWz4RS9+Fpg1NDjOgjhPfV1BlYQknmf37h7ApgJ+0HZ0PSP0qYlSAi8/LpOvCS1KZeacJ/CKdE7yp8UgJiww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294837; c=relaxed/simple;
	bh=PSHLEWEph0eXmdSAVRKCSxJrAbTkaoF9z+fluQNamHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+VO0lVDNtUp2jW6OmxSOwfQ6AK7JH5IlhS9ZApBVEs6HIJ1z6U/xrWWhYBtQw3Nlh4+8/Ey7Hyoh31oIBe/ryXs7R5xiaJKig54K/FH3ohH1mIMB9dPjRVLfrgHwwHknPijJcv9E/edOVJjshtoTH2LN5t5mY70Ic/rUSlzpKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=oBhwfSoO; arc=fail smtp.client-ip=52.103.20.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="oBhwfSoO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1gkXtLPAVOpQ9PJwXAVOIq4YyEPeAtd86VoRuyg4mnW8ydSMxZmcRwyoYFGNVRWVCIeK/B2HaDBPiEwdF7FrAdRwyVsjaRID5AoE7hVKDHkwudu2rRT9Rv7VJDvMbuzUsUdQb0o+ACKK48KoOVNZ2hzeizncsGcesa7rUrZCMXPCi2oDtzoa+gMAVO/vDx4nnsRHV2N8lR+cwcBnAqg6XU2zsfTEkheRoFgsqnokd/eHK95ktmwaPCDi2FBfeQMhBDWO1sSJkH5bTL4CLa7YqBFGxZVV4RD5OTQaAUUKRmN/JcWFVSXRq9pIxo6SEfi4Hx35Ajejp/2y0NBz/Pq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYesHyNNlTNf0TxuFQsKkFrn1+ClTvuo6v+aiJRP4JE=;
 b=BwT2b80FWHN4JkPWqFwgaHCV8qkdDtCp2GA7jC3Txj173rOrMDd8V5gWp8pnQkpLxlFhZPwUAVpvnnKUymGT+5Y+nL4ZVqn7TFyvebiNoZWRhQyuGd+NPfdBtYuedjLmZqcY4RRtJCNantGUNfuX2BDLkBQjBNPpVUg3Q/DqSTd1GopHX/9UN/XL9QAUGlzxqiAVGoNFUAOOJmXJaYjwkEn1YswqIKGKkvvjBgMeQqqT/69mpnoHMNSWjU1KGQ6H1Dzp17lbswHkYIp2spNGYRxzdr2tgAIpID9Q049Mzgy2TgghjcTPs/Elo9zpuyNIpIrvSsfJcgC7+sKcWq8RJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYesHyNNlTNf0TxuFQsKkFrn1+ClTvuo6v+aiJRP4JE=;
 b=oBhwfSoO2Pc7LO2hhdY+KjKwpprXhQYfjHBsd6SD3oHmv28wOvToKkAiORpr4KMXbdigX6PJ6yL91eMIEw+QqB9/jFmYccGNBdAbui9jm4IaacefaugmAfzBy+Il+/DGwvbdDBtOvNCllcZAX+xkI/T0kuNGsGGKCfZQCQ8SRzVBpR7bSjooC1ZD11DaEv9walOB+5WOZYsz77H+56jWXczOpFc3TZi8wgx6CEmkf0zjY3hz8Hty7oK4zp84sXunJK1yIn/hR90hvzxa+Hd664IeSY9buWoAUPspNe0yHkQzOyzUGeumd9etUyZ2PFS2bdD6YL2xq7I9eoKQMPQdpQ==
Received: from DS7PR19MB7724.namprd19.prod.outlook.com (2603:10b6:8:d9::20) by
 IA3PR19MB8637.namprd19.prod.outlook.com (2603:10b6:208:526::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:27:05 +0000
Received: from DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86]) by DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86%5]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 13:27:05 +0000
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
Subject: [PATCH 8/8] ALSA: hda/realtek: enable AW88399 on Lenovo Legion Pro
Date: Fri, 17 Jul 2026 15:25:10 +0200
Message-ID:
 <DS7PR19MB77245F76680FFF1A63286638FCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
References: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To DS7PR19MB7724.namprd19.prod.outlook.com
 (2603:10b6:8:d9::20)
X-Microsoft-Original-Message-ID:
 <20260717132509.148321-10-marco_giunta@outlook.it>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB7724:EE_|IA3PR19MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: b79555f9-1c1c-4d7f-565a-08dee40717aa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|2604032031799003|5040399003|5072599009|51005399006|12121999013|19110799012|8060799015|41001999006|704163111799003|55001999006|15080799012|24021099003|16051099003|3412199025|440099028|40105399003|3430499035|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rX1olW9j+rCgJJGl6r36s7/ce7iRFj5Hvp6cHEvrhjfp8DhwPlGcPn+kvCPS?=
 =?us-ascii?Q?W1uoB7X9z3O8SyCW3ySjUhNrtX40sP5MhFIk94ZsosVEQubRVhOTV7WuipGz?=
 =?us-ascii?Q?+hE2x6WC882kmh4o6jtHz0kE52O5ZAp+f0XLST9+XB0YD+K7bNIsKY7ro/CU?=
 =?us-ascii?Q?MFi59pyTSyszeXlYmWtO/30kZT553WCgxk0tkLVkK2+HxW/wKKOjskVDNwWG?=
 =?us-ascii?Q?Q0/nVAb+wJzJSa18NUe4wJIUg2fnaeEkRQ/l+jKxoBcc9CulCqlC+pvkjLGg?=
 =?us-ascii?Q?9+MGL0pnikV9YK6XimznejAoZcRFU0ducQyQT5RbJalycL8YwPpgqnoqc8mC?=
 =?us-ascii?Q?PA7bVR+B7zCe17Twl0l595FIVzRC1lHpx4xjljDDViKwUdgkokK03W3sV/4s?=
 =?us-ascii?Q?yNm0YCn/BAK8gRPXHVL+lMsFyDYB+qg8GkUFLEuP5ubsitCSfyf3zAaFBtej?=
 =?us-ascii?Q?+xtQa9zA37kUKt9LpYpefXLldcM+/p2ZhCuK/LWcaO0wwU+d9N5JiBkLYp/1?=
 =?us-ascii?Q?228JPeQDK8GpD5y+FwSmv31OKch5pzxYPV/cF54Pt6g4H2ZBBGtR3NNPLE0c?=
 =?us-ascii?Q?e4WALb+tjj8NLDrRrJSy2m0vN3REaCsBIRsT4Dyf+zQFSm4SZM+UvVIAPues?=
 =?us-ascii?Q?F9SiCtIvtcTzL7zamUv04xEy0s1AoF3dSYzwF4MCDovo09R8IJvFRcQnSuPQ?=
 =?us-ascii?Q?6QJF9B9dvGP/0Xo7WPXCcwFG2kUqv+VLd97GstVVtF7dAlPkMp3ITFvo6FYV?=
 =?us-ascii?Q?BeUyPsJObLvZNPi1uQWFVXOjcbKEtEVbu0RLlyxzy94gs1iLPRvvsnlAN50z?=
 =?us-ascii?Q?ULna82OCi+DaRjpGSEnhXSCKdr3tDn/451U5IN2Fh9xtolGOrp/C/s57tbBY?=
 =?us-ascii?Q?cmNyHvgor7hmSZD9t03vwzMcgIY2rxP3oniVqD46JnbZDGP8mbKu7fMOtCW/?=
 =?us-ascii?Q?YkA/uqeDikJALxgYy5+CYUIxq5G/pr9Xmy7nK0zYZvtrQpKMfbzCiTIq6LuP?=
 =?us-ascii?Q?l+g28BLd1a9KdYNeBn/kNQcQTei2FTzN99UOuBUgr4Rt/fJzVjQcdnC2ZVhL?=
 =?us-ascii?Q?K3Ml56awdlTq7uogUWYi+IRGW0gcwbGIlqAvq65rRjKu4u2e/AGUnQ1kF9Rx?=
 =?us-ascii?Q?6KQoZi0Z7VTk5pm9uCOSbKLNrJ5+DT1DN0Nxe9eZLOp0it+7FBqugOEH9CHh?=
 =?us-ascii?Q?eFFEOD0MneC+V8Jd?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XrpOrooTAl9BU7p4kJ0XEOf2sYgVQD8AY6dioJU2pXSR6+GHfQq2k6wB0S/I?=
 =?us-ascii?Q?ykufamznp8H8Bzq/v+5ospJ/03T4IXNlWB+MLhXV09jG3p+idbrivHGD2x9V?=
 =?us-ascii?Q?/YDMowKmpcSBpm3zX7/BqWluZeIorZ88ofDGmXZD6P5SNpnxdRkU/rTSXFv6?=
 =?us-ascii?Q?pzs2l3m0a6cTBg+vUszI1G6J30qowynWCKdw7prCKe2YlirDAsNeQHcFCuay?=
 =?us-ascii?Q?bTnEu6kKKWBLv02YLLwhM4v7upvQdDDu5OajcmTzXR5xHcSnZdOyCI7+x19E?=
 =?us-ascii?Q?+wR2dJxAGxz8ahZU2UV7uSeBQ0iRXfINeJnN3AZQVtF8xX8apQrp1g4w0sJ1?=
 =?us-ascii?Q?0wA1MjVmJFGZ28VYlkwFwplc71nA+x0jVGLtonrGRX4XwUV3X6MTkGbuexF3?=
 =?us-ascii?Q?Sj2iPJ7gPXQg8qzXljNPYAPaH8kzsdYJzvFm5pzq92eRk6byfe5FJCuQb9k1?=
 =?us-ascii?Q?MoGnTJCLDw/VxYLwc31ayT7gy5NRcspVHPxAXNNxFwUofdxv7iHlbHHJcKRP?=
 =?us-ascii?Q?dK1ZuQWrt9Xs5148hTenW77pqN8bgOzpyFybD6ErrbBkQvYsvVUv/dzj7yK0?=
 =?us-ascii?Q?yiP83gdSyv0Ue4mOT5oLLiBhx/xe+NmU/SsaoLMoOPMGeQ1CgLfoji9PcXi4?=
 =?us-ascii?Q?Zs+stziWfe5fTUSY827Kl8TPqfCC0nxrL/ypnOg3xA9EsPArq37YpmM/9pE3?=
 =?us-ascii?Q?7T5hMWmUxfS0/Ma8kXZXVdYENJZGnF98bE+zkbcO5gGhhKGw9GdZUjlSRdLD?=
 =?us-ascii?Q?DmPfYJoRVK0e0+W4MmaJsoLCGVHhfFPjKOEbmvEq5r8DHS5MqsJgffDEVzt2?=
 =?us-ascii?Q?EfUEsPO1qoBhdguiz/zBvVNmGixkWISxV1IXemenhuipoAYSpnt4/kMwrwMI?=
 =?us-ascii?Q?lMU7gWVrprjyS7C6YuJVI4iJtMABnHn0JwHYSrgbv/saFzUKlZukBEtkkrNd?=
 =?us-ascii?Q?Uy8cq8WX2hPxK/p8m+9MJnJdHVGprtiYbw8ubdbMg1YV1Wc35uv6pbBQ3DnV?=
 =?us-ascii?Q?ptoPayo0fApuzgz3+2RJlNrpGVbG0N+OTL+Io/URPSWLsudjdLCmVQqDt6Tk?=
 =?us-ascii?Q?eBgPSMKzdBzqFV34v+s0jWXkTeVcJZbpregdo/IxwC6jLczqNS23ZeM8NoIg?=
 =?us-ascii?Q?mwXOWMyBYj8AuN0lrHZedx6p++F7oze9hI+Cez4f8guBl6Gx5QYALAJHGQE7?=
 =?us-ascii?Q?2YYMxTIWZPI0Lu+/Ukz8gK/zuYcCIvH0SyTlKwtCmqhP/ufekU0DQj47SJ4F?=
 =?us-ascii?Q?S1zNgYUouIPtc32jAdAKnYJkQruiWmtzheBGhRjJqCF0DZLxk3BfqyC8YAaF?=
 =?us-ascii?Q?fBI18LJfcQtdgPTdM4QwDHYK0c97MeGOopoxmHlrq8CCRwSiNx/+ruPrkpeT?=
 =?us-ascii?Q?l+vA+ioyFyF0qw24b9lSCUD7Nbe2?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b79555f9-1c1c-4d7f-565a-08dee40717aa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB7724.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:27:05.0996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8637

Enable audio output through the AW88399 woofer amplifiers on Lenovo
Legion laptops by adding the necessary Realtek ALC287 fixups and
AW88399 per-model quirks.

Realtek fixups (alc269.c):

* ALC287_FIXUP_AW88399_I2C_2: registers the AW88399 as a two-instance
  I2C companion codec using comp_generic_fixup, matching ACPI HID
  "AWDZ8399".

* ALC287_FIXUP_LENOVO_LEGION_AW88399: forces DAC 0x02 for the bass
  speaker pin 0x17, as the default DAC 0x06 lacks volume controls.
  Also applies internal microphone boost calibration via
  alc269_fixup_limit_int_mic_boost and disables unused pin 0x1d
  to match the Windows driver's pin configuration.
  Chained to ALC287_FIXUP_AW88399_I2C_2.

Per-model quirks (aw88399_hda.c):

* Channel swap: the I2C wiring on these Legion models is reversed
  (0x34 is physically the right speaker, 0x35 is the left). The
  quirk swaps the channel assignment to correct L/R audio.

* BSTS status bypass: the AW88399's boost-finished status bit (BSTS,
  SYSST register bit 9) does not reliably assert on this hardware.
  Register dumps during normal playback show both amplifiers
  reporting BSTS=0 on both channels despite clean audio output.
  The quirk sets the bsts_unreliable flag (introduced in patch 3)
  so the startup status check skips the BSTS requirement
  on these devices.

The R9000P ADR10 entries use HDA_CODEC_QUIRK and are placed before
the existing SND_PCI_QUIRK for 17aa:38bb (Yoga S780-14.5 Air) to
ensure the codec SSID match takes priority over the shared PCI SSID,
following the pattern established by e.g.
commit 0f3a822ae225 ("ALSA: hda/realtek: Fix quirk matching for Legion Pro 7"),
commit dd074f04e046 ("ALSA: hda/realtek: Fix Legion 7 16ITHG6 speaker amp binding").
All other entries also use HDA_CODEC_QUIRK for consistency.

Supported models (Lenovo vendor ID 0x17aa):

* 0x3906: Legion Pro 7i 16IAX10H / Y9000P IAX10 (Intel)
* 0x3907: Legion Pro 7i 16IAX10H / Y9000P IAX10 (Intel)
* 0x3927: Legion R9000P ADR10 (AMD)
* 0x3928: Legion R9000P ADR10 (AMD)
* 0x3938: Legion Pro 7 16AFR10H (AMD)
* 0x3939: Legion Pro 7 16AFR10H (AMD)

Tested-by: Nadim Kobeissi <nadim@symbolic.software>
Tested-by: Xia Yun'an <imitoy@imitoy.top>
Tested-by: Munzir Taha <munzirtaha@gmail.com>
Co-developed-by: Yakov Till <yakov.till@gmail.com>
Signed-off-by: Yakov Till <yakov.till@gmail.com>
Signed-off-by: Marco Giunta <marco_giunta@outlook.it>
---
 sound/hda/codecs/realtek/alc269.c          | 50 ++++++++++++++++++++++
 sound/hda/codecs/side-codecs/aw88399_hda.c | 42 ++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index b3562c821954..5aa30569595d 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -3262,6 +3262,34 @@ static void find_cirrus_companion_amps(struct hda_codec *cdc)
 	comp_generic_fixup(cdc, HDA_FIXUP_ACT_PRE_PROBE, bus, acpi_ids[i].hid, match, count);
 }
 
+static void aw88399_fixup_i2c_two(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
+{
+	comp_generic_fixup(cdc, action, "i2c", "AWDZ8399", "-%s:00-aw88399-hda.%d", 2);
+}
+
+static void alc287_fixup_legion_16iax10h_aw88399(struct hda_codec *codec,
+						 const struct hda_fixup *fix, int action)
+{
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x1d, 0x411111f0 }, /* unused bogus pin */
+		{ }
+	};
+
+	/*
+	 * Force DAC 0x02 for the bass speaker 0x17, as the default 0x06 lacks volume controls.
+	 */
+	static const hda_nid_t conn[] = { 0x02 };
+
+	alc269_fixup_limit_int_mic_boost(codec, fix, action);
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		snd_hda_apply_pincfgs(codec, pincfgs);
+		snd_hda_override_conn_list(codec, 0x17, ARRAY_SIZE(conn), conn);
+		break;
+	}
+}
+
 static void cs35l41_fixup_i2c_two(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
 {
 	comp_generic_fixup(cdc, action, "i2c", "CSC3551", "-%s:00-cs35l41-hda.%d", 2);
@@ -4216,6 +4244,8 @@ enum {
 	ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX,
 	ALC287_FIXUP_ACER_MICMUTE_LED,
 	ALC236_FIXUP_DELL_HP_POP_NOISE,
+	ALC287_FIXUP_AW88399_I2C_2,
+	ALC287_FIXUP_LENOVO_LEGION_AW88399,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -6852,6 +6882,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_invalidate_dacs,
 	},
+	[ALC287_FIXUP_AW88399_I2C_2] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = aw88399_fixup_i2c_two,
+	},
+	[ALC287_FIXUP_LENOVO_LEGION_AW88399] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_legion_16iax10h_aw88399,
+		.chained = true,
+		.chain_id = ALC287_FIXUP_AW88399_I2C_2,
+	},
 };
 
 static const struct hda_quirk alc269_fixup_tbl[] = {
@@ -7900,6 +7940,11 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38b8, "Yoga S780-14.5 proX AMD YC Dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38b9, "Yoga S780-14.5 proX AMD LX Dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38ba, "Yoga S780-14.5 Air AMD quad YC", ALC287_FIXUP_TAS2781_I2C),
+	/* Legion R9000P ADR10 shares PCI SSID 17aa:38bb with Yoga S780-14.5 Air AMD quad AAC;
+	 * use codec SSID to distinguish them
+	 */
+	HDA_CODEC_QUIRK(0x17aa, 0x3927, "Legion R9000P ADR10", ALC287_FIXUP_LENOVO_LEGION_AW88399),
+	HDA_CODEC_QUIRK(0x17aa, 0x3928, "Legion R9000P ADR10", ALC287_FIXUP_LENOVO_LEGION_AW88399),
 	SND_PCI_QUIRK(0x17aa, 0x38bb, "Yoga S780-14.5 Air AMD quad AAC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38be, "Yoga S980-14.5 proX YC Dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38bf, "Yoga S980-14.5 proX LX Dual", ALC287_FIXUP_TAS2781_I2C),
@@ -7923,6 +7968,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38fc, "Lenovo Yoga Pro 7 15ASH11", ALC287_FIXUP_LENOVO_YOGA_PRO7),
 	SND_PCI_QUIRK(0x17aa, 0x38fd, "ThinkBook plus Gen5 Hybrid", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
+	HDA_CODEC_QUIRK(0x17aa, 0x3906, "Legion Pro 7i 16IAX10H / Y9000P IAX10", ALC287_FIXUP_LENOVO_LEGION_AW88399),
+	HDA_CODEC_QUIRK(0x17aa, 0x3907, "Legion Pro 7i 16IAX10H / Y9000P IAX10", ALC287_FIXUP_LENOVO_LEGION_AW88399),
 	SND_PCI_QUIRK(0x17aa, 0x390d, "Lenovo Yoga Pro 7 14ASP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3911, "Lenovo Yoga Pro 7 14IAH10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3912, "Lenovo Xiaoxin 14 GT", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
@@ -7932,6 +7979,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3920, "Yoga S990-16 pro Quad VECO Quad", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3929, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x392b, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	HDA_CODEC_QUIRK(0x17aa, 0x3938, "Legion Pro 7 16AFR10H", ALC287_FIXUP_LENOVO_LEGION_AW88399),
+	HDA_CODEC_QUIRK(0x17aa, 0x3939, "Legion Pro 7 16AFR10H", ALC287_FIXUP_LENOVO_LEGION_AW88399),
 	HDA_CODEC_QUIRK(0x17aa, 0x394c, "Lenovo Yoga Slim 7 14AGP11", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
@@ -8230,6 +8279,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC2XX_FIXUP_HEADSET_MIC, .name = "alc2xx-fixup-headset-mic"},
 	{.id = ALC245_FIXUP_BASS_HP_DAC, .name = "alc245-fixup-bass-hp-dac"},
 	{.id = ALC256_FIXUP_HONOR_MRB_XXX_M1020_AUDIO, .name = "alc256-honor-mrb-xxx-m1020-audio"},
+	{.id = ALC287_FIXUP_LENOVO_LEGION_AW88399, .name = "alc287-lenovo-legion-aw88399"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
diff --git a/sound/hda/codecs/side-codecs/aw88399_hda.c b/sound/hda/codecs/side-codecs/aw88399_hda.c
index 9f6f4cbcf641..934fe68129a0 100644
--- a/sound/hda/codecs/side-codecs/aw88399_hda.c
+++ b/sound/hda/codecs/side-codecs/aw88399_hda.c
@@ -140,12 +140,54 @@ static int aw88399_hda_init(struct aw88399_hda *aw88399)
 	return 0;
 }
 
+static int aw88399_swap_channels(struct aw88399_hda *aw88399)
+{
+	/*
+	 * Certain Lenovo Legion laptops have their
+	 * I2C wiring reversed: 0x34 is physically the right speaker,
+	 * 0x35 is the left. Swap channels to correct L/R assignment.
+	 * This is a model-specific hardware wiring issue, not a driver bug.
+	 */
+	aw88399->channel = 1 - aw88399->channel;
+	dev_dbg(aw88399->dev,
+		"Channel swap applied: index %d -> channel %d\n",
+		aw88399->index, aw88399->channel);
+	return 0;
+}
+
+static int aw88399_skip_bsts_check(struct aw88399_hda *aw88399)
+{
+	/*
+	 * BSTS (boost-finished) status bit does not reliably report on
+	 * some hardware. On certain Lenovo Legion laptops, both amps
+	 * report BSTS=0 (boost not finished) during normal playback
+	 * despite clean audio output. Skip BSTS in the startup status
+	 * check to avoid false init failures.
+	 */
+	aw88399->bsts_unreliable = true;
+	dev_dbg(aw88399->dev, "BSTS status check disabled\n");
+	return 0;
+}
+
+static int aw88399_apply_legion_quirks(struct aw88399_hda *aw88399)
+{
+	aw88399_swap_channels(aw88399);
+	aw88399_skip_bsts_check(aw88399);
+	return 0;
+}
+
 struct aw88399_prop_model {
 	const char *ssid;
 	int (*apply_prop)(struct aw88399_hda *aw88399);
 };
 
 static const struct aw88399_prop_model aw88399_prop_model_table[] = {
+	{ "17AA3906", aw88399_apply_legion_quirks },
+	{ "17AA3907", aw88399_apply_legion_quirks },
+	{ "17AA3927", aw88399_apply_legion_quirks },
+	{ "17AA3928", aw88399_apply_legion_quirks },
+	{ "17AA3938", aw88399_apply_legion_quirks },
+	{ "17AA3939", aw88399_apply_legion_quirks },
 	{ }
 };
 
-- 
2.55.0

