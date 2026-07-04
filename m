Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013078.outbound.protection.outlook.com [52.103.51.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947E256C8B;
	Sat,  4 Jul 2026 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783200539; cv=fail; b=iC4XHTdSkJFRb0/tL/Y0VmM/930S6JDkb+Bgsv5gD3AOGh8672dL5Of4Icgb+SFIgT5fsOB8D1TbKAzv2+NPTqpLYpx/MbudmTeyPnDdllEXY+aaaFwyF9QqBdT0Po1NYlrfqt3adUykbfuk3+p+nPYcRP/YhcR8Kh6hBTSG6Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783200539; c=relaxed/simple;
	bh=fLbodXc3CCRxVD4TbDalMat8pAAcF/sGSgAr9w3gGMM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fy4NEacFYPytPwNZEdeDNaThcTWkRUAKhbxAlfBACar1BEWT0r3djxsIKoDabGln1nher6aWVT3IwT4SrpwDko9fTzzLhij7x/E4WGBAvxAVwKPdRwrapVVyoNBpW4hY/fFDEaadd2zay/5nu6cQOESAe4ahrpw3M/Qf1/iUO3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de; spf=pass smtp.mailfrom=outlook.de; dkim=fail (0-bit key) header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.b=FmLt44db reason="key not found in DNS"; arc=fail smtp.client-ip=52.103.51.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.b="FmLt44db"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8ppG5blFrW6lR+PchyJC40HgVtG3pSCnsPf/4IlR6Rf7IQr5odjEABQnoDCatm7JlxJNpAVVi7K4PrhwdLanKy0PhVBfoZj7Iu1n9TptfHxFcoNv8OYFCUc9TsQ4eNvbnP3c69Dup+ybKdwNfmmO5KA86T/IgNodN3dOoJkgYq/OcEByEGixUyhpFqHpHeKm2h1Nj2mN2xFewTofCNXBGiUdFZKIds9TsJDqQyYqwf7Rsa21D13h5ykJ4ieayWN1UYGpVmIvZOK2DUEMkdVyTxw3S1vhErd1Kg4dtR508Y+9XLRznsspNjFdlq6C8yI5XtCw5s+WzYwj4V9Q98bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLbodXc3CCRxVD4TbDalMat8pAAcF/sGSgAr9w3gGMM=;
 b=VVGDgUZY7TW4KEZz+p9Ir0qwDzCBLWxtb8MjUkl3sIQWLOoFcCDGqWENCTfJ2a2VxT9zcsHmLMVvc7eEcUiWVpf69fCfbuqZ2fCh6la1Vv7Q06yrZz0KMdU/x/8X8sP7NAvZrJPicW7S1bdKRm/o5VuIEMTwTY272yHeFrEPSdYrTHJheX5wFF9/lKp3WFeNHQXJ0ZJFuFoOeOCFltgCDbrJhu58nIX/Ckt1rbv6QDZ3aMAI7TiEcFNFBqttGcs/ZeELRgX5WVLRMOaC0pjC31kCILHYmE+FVUN8uh8In1yNI3VwwO77KlxN/8phwNvMdPWjK288rZ0QPdtYVtcCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLbodXc3CCRxVD4TbDalMat8pAAcF/sGSgAr9w3gGMM=;
 b=FmLt44dbq6L9s6teCaFgGQuAbppSSohPY4tOLw3S63UJb7hrWUkO6EmUrhXSfakiHl9C5dOz0Uyj/pTvNZZLZLk/QbB/eLO2V0YHLVqrlpbR/KNPtfvyGfLdEF7AJg4cpxAtMp0HeyyiA6jRs9mzyBmuUfCPNNqQUruCnZUT7p+HLHuCPa2MJekK/Jyr1w1IJRePxLBmjZTs0k+NH+TRPCe/WlA+QvPUqG5gbgSIwAvhzTEWv5coTZouEnHnr32i0Zi17F3RwdIFlE3JvfDNpnAWPVVd47JW/ZeWk3ySIbcyDEzdJ2hARCdWcKAbbp0JkQZB6Zh7wG+4lHzTTGphAw==
Received: from AM9P193MB1588.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:30f::11)
 by DBAP193MB1146.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.12; Sat, 4 Jul
 2026 21:28:55 +0000
Received: from AM9P193MB1588.EURP193.PROD.OUTLOOK.COM
 ([fe80::824d:c236:f55b:4ed8]) by AM9P193MB1588.EURP193.PROD.OUTLOOK.COM
 ([fe80::824d:c236:f55b:4ed8%5]) with mapi id 15.21.0181.011; Sat, 4 Jul 2026
 21:28:54 +0000
From: golne tree <lrepper@outlook.de>
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Regression: ACPI battery status incorrectly reported as Not charging
 after bb1256e0ddc7
Thread-Topic: Regression: ACPI battery status incorrectly reported as Not
 charging after bb1256e0ddc7
Thread-Index: AQHdC/t3g5nS2nd2RECA9ast3d8N2Q==
Date: Sat, 4 Jul 2026 21:28:54 +0000
Message-ID:
 <AM9P193MB1588F78FCA2083745CEDD8C3D0F32@AM9P193MB1588.EURP193.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9P193MB1588:EE_|DBAP193MB1146:EE_
x-ms-office365-filtering-correlation-id: 6f204039-0cbb-488f-dca1-08deda134022
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|51005399006|8062599012|31061999003|15080799012|15030799006|9112599006|2604031081799003|6050399003|40105399003|3430499035|3420499032|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?oOtN5xbyJTRJvkiqfFsw4PhbNwZ2dXC55/o+bLrWwyf/KPjkcaHaUriizo?=
 =?iso-8859-1?Q?y2CVFWtHIuMy8pjd9J2pt3/D8ra4Ae+nZckz7Sy+LrpqKxYyb3QbwV5qV+?=
 =?iso-8859-1?Q?U0IefgxocMThibyQMHbDiGhFomGBRS4pM02DjGq/+VudXAkgbMuuShdqes?=
 =?iso-8859-1?Q?vl637xVbyjBZZTyzvjD+g3xgnYv0CyujvvTQFo8eCl12R1oldOP1z5sLnz?=
 =?iso-8859-1?Q?quUer/tfsOvHtO67yGtKgGJ8Jrn6cZx6ODhgHKUItEFck9Kyuhc7gabKK4?=
 =?iso-8859-1?Q?q9Fn7ZnfKwbilQVnkbziWlUEoT0PsdcS0KxnTVwKQjgxS7aG9E1LxjsfG9?=
 =?iso-8859-1?Q?KLGIAT/dfI3n+Zs0f0SRdZevd1ZYgSwtuPMp9VyfVJiCJs7hy6mBfMQ+c3?=
 =?iso-8859-1?Q?f+yfSoHPhvKfmEl9dGs3JO+2exUmT9jUoWeOfgTeM6OtnHNqgDfg8zyNTH?=
 =?iso-8859-1?Q?a7k6zd76HtbUyF/YWv07ImTJ7zahhtFlsHx3O9HpEJj3whufOp7/t5NTVR?=
 =?iso-8859-1?Q?5VvO51H4KDMKH8Q2Jacv9klozDjI/Zns8QrazKZaPtqX4AYBj+tIUsBQtC?=
 =?iso-8859-1?Q?cz/AYscLFrOSjuLHoTubNwbAlkQF+7m5OXPzP52LjxOru5xmVwMOgx4bzk?=
 =?iso-8859-1?Q?eCnGpgCkqSUMGM/w77RidmzLIQzu4aSKcg8FNhS3lLxmCl1QKMen5CGrh5?=
 =?iso-8859-1?Q?fcJ4OqVLJG5UFkaW3RHrRurXJNysyn+LjBxaNTkesCLX4OQJAJeIGRTuWV?=
 =?iso-8859-1?Q?FUVAH1HGDysblzCd5QgNP7kEWo/RNcXiE76HvClzVPStYrAZXO2i8tRhoe?=
 =?iso-8859-1?Q?rNYf1IhRGkdgDe7bUZV3l6FjkXLQ0g0kAU4QbFUnqo8PP0XqyVC/sSEF+s?=
 =?iso-8859-1?Q?xGoojLZ6HIzOlNqDeAk7Bx7yfaTnbfhk+8/wOgHplU1PYwG58qrIEFxXDs?=
 =?iso-8859-1?Q?XTMnaoZVg0mOjfwuTApFZtQgvOQrEIPQsCPnItAUsMfKpDoq1q2VHiZipG?=
 =?iso-8859-1?Q?+lSG66tI0CR5+4c6nHM8k+nW2jCcncW0qBgvUZBSHytEd3AxgbHUSbCo6n?=
 =?iso-8859-1?Q?Dw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Vc2z4f9kG8rkUoV9uH6IbNr/br5BQz+3jbDJvYwuTcI/u1JiW7fyS0sQZk?=
 =?iso-8859-1?Q?qwH3+RX8bSU4FfY6+XkXiNYH7pMtquLEe5xiWAGK3sUsdypY9fBHEKPx6J?=
 =?iso-8859-1?Q?/fNbKE/bqzSpvGnB1/krLg4S+8J0XPhoax+4MuYhZDili1qb7/SKzr2tY3?=
 =?iso-8859-1?Q?byFRbiUyTkzKJedNTuAwyHgLXIvSpKBXKhapVO1htK1sjeebmP6cDEUKsz?=
 =?iso-8859-1?Q?marwNWlklEnjcG8dbu9pNU5Ug5GIQ+I6u1SSGGvq4Fc4FW9XMQ10FjXe+z?=
 =?iso-8859-1?Q?OVD/mrqF2GrA1F5pCfOWh5HYKo5OZUNqNggjj0+A1H8dI8f9czevvR6QTz?=
 =?iso-8859-1?Q?DEYnx0xUBlE0as2y9BhpfEVL3kVnWW2OsXhhZDphNMnKIpgqaFFXVHmfGp?=
 =?iso-8859-1?Q?teQ8Psh1uPMovlGg0dwDLucgNIDb37QHt3TnFn26nLVPxb3NnaeCELg/df?=
 =?iso-8859-1?Q?6op0duoP3NJJxz5CMLvXTYiuNk5C7QfNLSBrbhnGfHuXHNqvVatqWlZP3G?=
 =?iso-8859-1?Q?sL5nKTse3H0GA2IGPvFDnyNyt+Wl/JPQs+NnYD/cAW0+dbMbhEZu6hF16o?=
 =?iso-8859-1?Q?qE11mX7DxS/CXXC1A+3WK1gjIIb4VvNySncL95vXhI1k94ZyIccLidt/iy?=
 =?iso-8859-1?Q?6+Nsm+HZhXrvaDwLa+bOvy33knhrevNShdKmupMR2raCDS9ylx/nL/vNtZ?=
 =?iso-8859-1?Q?CahhrezQN+VG/lO7PQ7JwyWLZGPVU+7dOuCEFI8SLoM5Ik0RMrRHbtrUnc?=
 =?iso-8859-1?Q?IVKTIXEno8LpjXMzL+SYT2gDV4zkefH/wrpzbX/C9bjsjKVVVxnKoE1OA2?=
 =?iso-8859-1?Q?zoVmpGHrUGqMixrxxps3eXV83s/xPtxYU30CeFMZyj4gy0Rx4apZfOzz48?=
 =?iso-8859-1?Q?csfedrc4yieUDfhBY5fzfYYbw2pJMdgwAHqqJOqSku0OqtgPFMMaN/WUrE?=
 =?iso-8859-1?Q?iaXgdrXbljEQXUrLWoCwI7vqwqbTlURDFzcg4t8SnmYgzzJ9oqftkCpYOs?=
 =?iso-8859-1?Q?MREq4k9zHBY13wTBBzzji3tjKHNvnp37RA/UVaDOCBvLLC9AyLCn4DWJIZ?=
 =?iso-8859-1?Q?4NxF69BNWqO6mtJC1DAM54FTIYkGskZvIFW5slqeHUo9MGIgx/sNc8gBQ/?=
 =?iso-8859-1?Q?Q8Qh79jOh+/GAgV9zClhTgD7/i5plf/9DbS+rz97+D/fRC14tCp3qhjJxg?=
 =?iso-8859-1?Q?9STGQc72v4pNUAYqYi2xzRBcJw+ezkUaLsErMvzoNMHH3RNwB4xMsxs1K3?=
 =?iso-8859-1?Q?R8FvPCJt464CJywW2lQ5QkYJnp7HRMaMkSCImWasOFWDDovyz53/VP8OxG?=
 =?iso-8859-1?Q?grnl6eiP9hkW8QSNiG9KBd/KPol11qLdikqH+8Gxpi1v21CtNb5xA2kZx6?=
 =?iso-8859-1?Q?BfWbA3dh1obLCY43mIxoKu0A+ewXXCy0MC49+WSrY5asxoPC1bIaF3dKz5?=
 =?iso-8859-1?Q?rehkWnoN+nTkB/euYki/4HqEyIqGi3gdOcww9b+EfJcWgLVDRHXTICzMzL?=
 =?iso-8859-1?Q?U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-b2714.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1588.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f204039-0cbb-488f-dca1-08deda134022
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2026 21:28:54.7880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP193MB1146

Dear ACPI maintainers,=0A=
I would like to report a regression caused by commit:=0A=
bb1256e0ddc7 ("ACPI: battery: fix incorrect charging status when current is=
 zero")=0A=
The commit fixes a real issue on Huawei laptops, but it appears to introduc=
e a regression on my system.=0A=
Hardware:=0A=
Manufacturer: Default string=0A=
Product: Default string=0A=
Laptop: Denver NID-14106SSDDE=0A=
Kernel: 7.0.11-1-cachyos=0A=
The same issue is also present with the unmodified Fedora Workstation kerne=
l.=0A=
Observed behavior:=0A=
When the AC adapter is connected, the battery is actually charging. The bat=
tery percentage continuously increases (for example from 81% to 84%).=0A=
However, the kernel reports:=0A=
POWER_SUPPLY_STATUS=3DNot charging=0A=
POWER_SUPPLY_POWER_NOW=3D0=0A=
Relevant values from /sys/class/power_supply/BAT0/uevent:=0A=
POWER_SUPPLY_STATUS=3DNot charging=0A=
POWER_SUPPLY_POWER_NOW=3D0=0A=
POWER_SUPPLY_VOLTAGE_NOW=3D7400000=0A=
POWER_SUPPLY_ENERGY_NOW=3D24760000=0A=
POWER_SUPPLY_CAPACITY=3D84=0A=
The battery does not provide current_now, and DMI information is unfortunat=
ely only:=0A=
system-manufacturer: Default string=0A=
system-product-name: Default string=0A=
Looking at commit bb1256e0ddc7, the following logic was introduced:=0A=
if (battery->rate_now !=3D ACPI_BATTERY_VALUE_UNKNOWN &&=0A=
 =A0 =A0battery->rate_now =3D=3D 0)=0A=
 =A0 =A0 =A0 =A0status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;=0A=
On my system, rate_now=A0is always reported as zero even while the battery =
is clearly charging. As a result, userspace always receives Not charging, a=
lthough the battery level continues to increase.=0A=
This suggests that some firmware reports an incorrect rate_now=A0value whil=
e still charging, making the new heuristic unsuitable for all systems.=0A=
Please let me know if you need additional information (acpidump, DSDT, debu=
g logs, etc.). I would be happy to provide them.=0A=
Thank you for your time.=0A=
Best regards,=0A=
Goldi Tree=
