Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011037.outbound.protection.outlook.com [52.103.12.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2563839CCFD;
	Wed, 29 Jul 2026 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347312; cv=fail; b=HOyedOPpenaM/nWOCzOhxNzt9UjrKsT4/7PDKeT/xX4GIGfj+uSKxsomZ4j87JapXItj2PgnzC39U963Lx71miZGI1yz996M2ty9kwZ57iy9qKUeQhNcso6hkT/sc6DCO6W1Ys1eQUkQL++HzcmKqFIysi6AfMBqTXvN6EIKTIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347312; c=relaxed/simple;
	bh=KOAdxVLoSd242yOLaIzJU3uC628pp5IMByULyye9Mj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RHmrZ/Zcx9f9yt1Q46+nFtck8AuHhXsUTKzArVv63kmLfYbQiShTF6NIN80a7Px+XTOBtAGy0Qfz3u7dUFGmRc2KVR2+9MXB5BxepZhCtiyOlWlHZJjtyzf8A6ndxv+fvKToB0q4ynHl+FCaYIH/aLf6bZ+LMPAOzZeIgh7XwQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=HPRojKGA; arc=fail smtp.client-ip=52.103.12.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="HPRojKGA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJV2aeufinO6fjRXoU0Ymhn1hHTTThmGgSt9yXyLLwQUY1jImO6QenhmfJP8DzmLJKFkUmKM0hAwRwVK0qdRLt3MnXNvawuYS5lxrvMnfLz2U2uOSikacj2EyR3l8AxZ6/BkvM+QcRNGmcWkTZOnVaj4mcUizao/BGIiq17RdpOeem3Whk8iubfyCcO/fL6CWR5R0/aa7xq7HFXLUz4P96fXg798c97NXOgPbrV+dmwimM3QE4KFpr19PAwMvYaDS7MlQHTa80+enq57PZCEhEFryu7nEKne47QBsbQLBt7y4sQf8XvDp+psCObSdQdYA+MEFgb/SYQYkBMr28JdHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1ILbV09Nq0eQ7TMgn4wXI7kuC4flLrOZzxXno/jhDA=;
 b=E7b1k1+9Umccwqv5KXWFDzJI5OQslQfj0JgvSXMAxQQHNczLKb0T37m9QktELG+rdslC9m43NXkI7a93ntt+Lvexyrak/2PMLazVjHZLTOeMMxkxi/yIkNdxDvDaxYDvRoARdRfu0Pr9N/SGMWRitn5W0HVKGDY4x4c0b3yiuPnBVxusN8t68pOZ+L3REjvrR14BvZ3yGXCrprGKfMdT6uiuzreWv65cEUh5fMcOEaLziupR7lf2ek/5NmKOE6zERahsgURsSyDCDQFqYbz1elfIIrG5tAZol+SREX54qWTyj7IV9VY3jYGawLDgcM1rp4XRLMGZWtUdjV18qs3x1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1ILbV09Nq0eQ7TMgn4wXI7kuC4flLrOZzxXno/jhDA=;
 b=HPRojKGAGJR/WuBqzjGTvS2cQsEfldRRsYK6SWgxel/gLq80iHD7hgpIrwt5USWsJ+3S6cM+fWVnrgdLvTQDWDdcGLpWDkPLP6LnjO5qv3Nxt0utdFbInC3qzgkr4B5YRMX7LpxnlPRw7F4w3E5G6o22lFOsT4FklcJEXq4NjnT4L1c52U4lJ+nYGh+PW6AZ4PMtuMZruq4AyxvRUMxnAHUp2xSeFziamTp27v/AAsPXomLMeR2cTIdCJa0uYizyDpgfCaQdQ7cxdvD8XzXW5rjwCOxfTnRET/tDVNCGD9/kXj41LcJ/mXf1TNzjP82zB9tkrRWOmvntYF5rR+P8Rg==
Received: from DS7PR19MB7724.namprd19.prod.outlook.com (2603:10b6:8:d9::20) by
 CY8PR19MB7667.namprd19.prod.outlook.com (2603:10b6:930:77::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.12; Wed, 29 Jul 2026 17:48:27 +0000
Received: from DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86]) by DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 17:48:26 +0000
From: Marco Giunta <marco_giunta@outlook.it>
To: mapengyu@gmail.com
Cc: broonie@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	imitoy@imitoy.top,
	lenb@kernel.org,
	lgirdwood@gmail.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	marco_giunta@outlook.it,
	munzirtaha@gmail.com,
	nadim@symbolic.software,
	perex@perex.cz,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	yakov.till@gmail.com
Subject: Re: [PATCH v2 3/3] ALSA: hda/realtek: enable AW88399 on Lenovo Legion Pro
Date: Wed, 29 Jul 2026 19:48:14 +0200
Message-ID:
 <DS7PR19MB7724B08C9CEA36A4A71C06C1FCCA2@DS7PR19MB7724.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CALSz7m1iW_hZbkL56+OMLXm5wE2s+ytxT_oGEU+DHyvYEMx8jQ@mail.gmail.com>
References: <CALSz7m1iW_hZbkL56+OMLXm5wE2s+ytxT_oGEU+DHyvYEMx8jQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DS7PR19MB7724.namprd19.prod.outlook.com
 (2603:10b6:8:d9::20)
X-Microsoft-Original-Message-ID:
 <20260729174814.85411-1-marco_giunta@outlook.it>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB7724:EE_|CY8PR19MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: d52c134c-d4f4-4adb-2002-08deed99974f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|15080799012|25010399006|4140399003|5072599009|51005399006|41001999006|55001999006|24021099003|8060799015|19110799012|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1IqXuY2/CGq0TWiIDMZDuEZDHgvlKcG1S+Gb7rigdPRdFE8Lg+WkvrsKccJP?=
 =?us-ascii?Q?m21xC29oRYG3fT56CzsNyA3C4wUgt4TE6CsRuaN2aTiAiWXI9W6gzNtjmC2j?=
 =?us-ascii?Q?9D32mVDottcQRNUrVkb/63NEVH9A8mBVX9tGvH1vNfsPHqRs6QREaUmWmKVQ?=
 =?us-ascii?Q?YmNHZiMSRXpQz9CaMP1EPRuQV9+nsk3qetacIb+nrSc55wq6mfT5EFiaLLv4?=
 =?us-ascii?Q?0ejvlENDujJDP06I6oK9t00xzjV4VCeEz/Etd6o0rr5nlq0Ro6OqPNRvh3lG?=
 =?us-ascii?Q?Dsoam02jR8u1ru6ZsemQnFog2yK2k/scoKSK/AoKIYLKUAJQM9qyO3VlAM0Y?=
 =?us-ascii?Q?sKsJo+VEn3DOmZjVWFmZBJr4AFGDu5zo7Qc6gn87BRia3hc07aikarDdziS9?=
 =?us-ascii?Q?0r5KtkhSqMOC6OO7R+vT+K2COacaRNiXONvAx+S7PVCv5J4Ap7rOeU7yrlpn?=
 =?us-ascii?Q?ThEW6v9yKLIdB/GNIyqRZgMfSVHXiwac7B06r3BTtBlociH0lxHDc7OcGpcq?=
 =?us-ascii?Q?ou6N3VRHuJ2ZIU+EUNxQMcPJsUL2WV01r5XRLSS669i/UIG7NWXWZWPUD8ry?=
 =?us-ascii?Q?exyKR/PbM7CaNQMdURWVaJR/Vq1+zf6cBm4D50CEP9vsovxd/DSbzlShOXKn?=
 =?us-ascii?Q?EDZ3U2v+ktD0RKa+v38/3hdcQ8j0msAe52lWDPN4roYhI81BbYy2TGsifQSC?=
 =?us-ascii?Q?tZ9UTk+bBS8hM++MeQFEiWFEJHlsGcs+XKk8Qf3VECcD9pLKDIIRdYUJFBt5?=
 =?us-ascii?Q?P+dolBiJkcIfTTBi+N5znomaIHd1X8YuNn8unL8noQJvC11hzX6qCuw3SMr6?=
 =?us-ascii?Q?wWHQ094ZCzYSHJx0k15uqEgfaih0IrlaDoqzUG36eEz7RlIGmbjvIq2OCDP1?=
 =?us-ascii?Q?BY2kLtMF+uTELyoDmzBUd9Zw3meZlJCbv2fcDysrwSEr+cigwgAiA7tnBHDZ?=
 =?us-ascii?Q?SECkh6sjA3odjKItS4iN0y0kZePXG98A2LS0sgd1o/m9jp4TkfsZyYoqkTCy?=
 =?us-ascii?Q?cxaQwF7JpsS0gtr/TQLAkUHkWw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wCZPQIAkQf+LmYTYMqFB5U8ZL+PChYm292Qa1YhgaP+vP1liojUW0cTr3Zq7?=
 =?us-ascii?Q?/sxKeR8IGe0NojIICW3TytuvgSASBz0y94R8eiIpnxxDIhR/EYhBvoEiFxeU?=
 =?us-ascii?Q?pZH1RBosB3rKMnVzhjAWrth+Wp0LyjyhPNveyQIVxHEGt/YVAFQ7WHFiHSXl?=
 =?us-ascii?Q?mD+DKHB/u2tIVO9R66r1cLvTVPDP4ZEnrTlJdpVTnjwudyEqzDMoxzQlEW37?=
 =?us-ascii?Q?wgxLn0KH5IACM9lPx5c608w8OJS8rUVngdA9O921wfTAfJ6QdNqp2dPyAZUQ?=
 =?us-ascii?Q?taEM/zcu0i968UvGCTL/N9a4fb44Ra+dRm/hLYracbOAdc6c8yyUVNLnI/ah?=
 =?us-ascii?Q?F1iteHR/6Ucr+7zGv2TEcNm2c12Uqq/vlMOqEFEbcLP4UTjtjtuME1242a2a?=
 =?us-ascii?Q?qpS+A7DFdqax3SCR4zz/j5VMqMPNoaM5wmM3wrte0OJ93dZW0jpjA6HMsvsK?=
 =?us-ascii?Q?GQZAk7wfoASI1fkT9t32YXDppQexT7txuKtKCxDLWxArlE2+ni2/pem+FlN6?=
 =?us-ascii?Q?iV1/a/gEbVAHKu68EcSnQhEcOksnglIfE0zKomKWPICkCeoMvwrrUt1aCohs?=
 =?us-ascii?Q?oUntCuZvll0ODY1mtj2IWgUO4wrhWiOChhnLzsHd5ZdL5m6WiAdSC0gYRMzX?=
 =?us-ascii?Q?owERrzIR6FY045KjentDZa8m7MJB9745DKox4o/sfJoenveDywIKiEzjUyZL?=
 =?us-ascii?Q?64GbZFWCbNy8CBBxONYxBoS9U8fiJqejgUu3Rwzb7pAZXI+DwL7OL6G3AgFs?=
 =?us-ascii?Q?KkdBzvSBVvI8AAP0WUag1AieVL4lf+60ZR6kc95xhik2fbZCXIggjLT6dWl+?=
 =?us-ascii?Q?7YcNrdKlYlmatApr3vNAyAoVeEdq7oafPZUEXPltEvMTEf+tRtpFjBPBQkmx?=
 =?us-ascii?Q?e9ryApHjvn6mA1BtbwLOs4p9njbuR9sOEIYBEjMYD/XqgIxeZxbs8pj4fGxK?=
 =?us-ascii?Q?+d7q45R8/P8tF5gagVRGsl6V2Flx+ocMn9htvq+tHf4aDAxKQ1uIH8VYJXch?=
 =?us-ascii?Q?87NshvrwdLXpPZvl+dPMOt0J5tt4P6xHA0A5CgN531QrvNxLRzSTbSPovZl1?=
 =?us-ascii?Q?TPdxT7W3StNsAlbi9HIEfiwsMF32+Ej5KHncYA4/ibq0TxJHXIxXkp+YsIsG?=
 =?us-ascii?Q?U2Qq9x9wbwsCokpbFKwaNRBYqHo6kjvU1HMaC87IW4azD4t7LttzAoykS7sF?=
 =?us-ascii?Q?FQTSCCYCwPCFwdCJcjlIKbSC38rBB5SMBLDRWczoasgw4OQMrjAtH2Eok38F?=
 =?us-ascii?Q?1oY1FBSkMdupKYlXEt+kahgSUpasBDstWYDp1c2BIOlKYX/pYhgj9TL3C5Zk?=
 =?us-ascii?Q?13+Un+FuP/U562tjsB1r1w8b2WYJo4OXXY5chFEDFrruWckYP8dQYxGEAti8?=
 =?us-ascii?Q?gNFy9qvhq1mecXxesZXnszjOBe450XKwJ/q/E94bTzWKTx8i50SPGtJNCo3P?=
 =?us-ascii?Q?y4lqsCVGfC4=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d52c134c-d4f4-4adb-2002-08deed99974f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB7724.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 17:48:26.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7667

Hi Aaron,

Thanks for looking at this. I think there are some misunderstandings
I'd like to address.

Regarding default DAC routing and the R9000P codec dump
in bugzilla 218329#c31: that user is running a stock kernel,
without this patch series applied; indeed, they have no
snd_hda_scodec_aw88399 module loaded, and their dmesg shows:

  ALC287: picked fixup  for PCI SSID 17aa:38bb

This is the Yoga S780-14.5 Air quirk (ALC287_FIXUP_TAS2781_I2C)
firing by mistake, because the R9000P shares PCI SSID 17aa:38bb
with that model (one of our R9000P testers independently confirmed this
by providing their lspci output).
That quirk is chained to several other, and in particular it ultimately
calls the function alc285_fixup_thinkpad_x1_gen7, which does:

    static const hda_nid_t conn[] = { 0x02, 0x03 }; /* exclude 0x06 */
    static const hda_nid_t preferred_pairs[] = {
		0x14, 0x02, 0x17, 0x03, 0x21, 0x03, 0
	};

The HDA_CODEC_QUIRK entries in this patch exist precisely to prevent
that collision, matching on codec SSID instead of PCI SSID.
The "0x03*" in that bugzilla codec dump, therefore, comes from the
wrong quirk's override, not the hardware default,
which instead is 0x17->0x06, as can also be seen on the other Legions.

Regarding the DAC 0x02 override for pin 0x17: this is necessary
in order to fix broken volume controls. The fact that this override
achieves this goal has been confirmed by every tester
across all three supported models.
Indeed, before adding this override, earlier versions of the patch
required alsa-ucm-conf workarounds to make volume controls work at all.
Without it and the rest of the patch as-is, the woofers turn on, but
speaker volume is always 0 or 100% irrespective of OS volume controls.

Three independent lines of evidence support this being
the correct DAC rerouting:

1. The official Lenovo Windows driver selects DAC 0x02
   for both 0x14 and 0x17, as can be confirmed by performing a
   realtek codec dump on a stock Windows install.

2. Multiple existing quirks in alc269.c perform the same override on
   laptops (Lenovo or otherwise) with similar sound architectures,
   with comments explicitly stating that this is done to fix
   volume controls, and therefore implying that this is a common issue
   on laptops with realtek chips from this family.
   Some examples of these quirks and comments include:
   * alc274_fixup_hp_aio_bind_dacs:
     "avoid DAC 0x06 for speaker switch 0x17; it has no volume
     control"
     "The speaker is routed to the Node 0x06 by a mistake, thus the
     speaker's volume can't be adjusted"
   * alc289_fixup_asus_ga401:
     "avoid DAC 0x06 for bass speaker 0x17; it has no volume
     control"
   * alc287_fixup_yoga9_14iap7_bass_spk_pin:
     "Avoid DAC 0x06 and 0x08, as they have no volume controls"
     "Prefer both speakerbar (0x14) and bass speakers (0x17) connected
     to DAC 0x02."
   * alc285_fixup_hp_spectre_x360_eb1:
     "share DAC [0x02 among 0x14 and 0x17] to have unified volume control"
   * alc285_fixup_thinkpad_x1_gen7 itself:
     "DAC3 (NID 0x06) -> Unused, due to the lack of volume amp"

   In particular, many of these quirks share a single DAC between
   tweeters and woofers (typically 0x02 and 0x14/0x17) without issue.

3. All testers confirmed working volume control with DAC 0x02 rerouting
   on SSIDs 3906/3907, 3927/3928, and 3938/3939. Without an override of
   the default 0x06 routing, instead, woofer volume is either 0 or 100%
   regardless of OS volume levels.

In light of these points, an override away from 0x06 is absolutely needed
on these machines, and preferentially towards DAC 0x02.

Regarding DAC 0x03 and 4-channel playback: a 4.0 surround profile is not
meaningful on this hardware regardless of DAC assignment.
Indeed, selecting a 4.0 profile results in one pair of L/R channels
(either front or rear) being silent; no DAC configuration makes
all four channels work. I verified this empirically with both
0x17->0x02 and 0x17->0x03 (as well as no override), so in this sense
which DAC override is used is actually completely irrelevant.
The correct audio profile for this hardware is analog stereo (2.0),
which works perfectly with the DAC 0x02 override, and makes front and rear
channels sound the same and work correctly when using speaker-test -c 4.
More generally, the tweeters and woofers reproduce the same stereo signal,
and don't actually represent separate channels in a true surround setup.
That the 4.0 profiles are exposed at all is an artifact of the HDA parser,
not a consequence of this patch's DAC override.

Regarding pin 0x1d: it's true that, in practice,
leaving the hardware default 0x40600001 untouched won't change
anything meaningful for this node, which is essentially
already disabled for all practical purposes. The override to
0x411111f0 matches the Windows driver's pin configuration, which,
as can be seen from a realtek codec dump from the official driver,
performs this pincfg override anyway.
I'm happy to drop this line if a maintainer considers it redundant.

Happy to answer further questions, and thanks again for looking at this.

Best regards,
Marco
