Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013072.outbound.protection.outlook.com [52.103.46.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5279925A359;
	Sun,  5 Jul 2026 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783243711; cv=fail; b=FfK62hCtfPn1mXm3qH6E+FoiwX8Hc3/tdRxNqiaODelN3OEw9WhvDI3A+9vBnEqfVdojznc90RGjV26wgVDPgljo2nWZXxM3SzpO1kERWSoFd62pIW9TzIt62J76X5oZeTPvcD1EU2fdVcASVvSPfx/tsRfDnk+5pw9fwzhcybg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783243711; c=relaxed/simple;
	bh=UtXynRdXPspb/WFA7RVHqBitszt5b+57kE1WE2wILDg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g/RA19mOM0s15DOw++ssH5nNIgVsXY5RV+Hpej8n7SFORKMv19CegKaETi5GIyCz4U5n9fRisrgE+nmmoxSzKg3C7XjgdtYHWzURN8nz2tvuhypJTJzsrXgcGBSb3VEkWRFokTb9QVw6hjmsszFiJ4XpdSBpvQ34bf/SGsdEEXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de; spf=pass smtp.mailfrom=outlook.de; dkim=fail (0-bit key) header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.b=vV3Wu4nF reason="key not found in DNS"; arc=fail smtp.client-ip=52.103.46.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.b="vV3Wu4nF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3t+1DwiS4xx7KX7H9Zj3r3zWN6FGwqE/fG1lSWpj71mMiJnbgbsdNyGycWx4aV7XKoeiT0Hx6k6UW6STowoFYueADyqM43/e0ovHDlOSLFu8Mm2zvLUeHd+3vBmCQpmgwU8lyy+mfL5Kr9fLc82x9+uWuQruH4L3SnhSeLNVBgikz6XfJUoXCqq6MN2K6s0tP3/YHsQn5mNp9oHGWmc6ldoiCJ7XiFWGNoZsujH5EJxQrmehFgkKZ2kDczF3o1P5mfw89/1SayJ8I/1WWLE8A9GSNmv3EdxJHN9eMKi3xOFa5iZAJ+3cUzLpxdENSQ/eRQZpRtl3wA9r9PFoB591A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/nSmIqj2THX1ifHMW+CjuPW12e/u1XxC3TnRHVyVsY=;
 b=YHyr3hZ0LPiN07XPgD7C9tWI6FNLC5dhYtdfmGd1Y9DkdtKQb6RXl9VmAwlTVSQoutaG/h+LDL/BK7ZRB32j1jKKhXu7HomzC5MviCOeKbTZ4avYJmk8QyZRrYbw55GamHQrw1Xt3pCYVFSAr62AGNqPEZK40+P7WJs0ijk7QEHev97NDImuDCO4HipOOBldo9HhLMlHWafa++qAB1fv232+fC2VYr+eRoaLjKsipBUXIsNmM5+UMKas8webFUXv31Bp0G5BVyOk7IdMU8eQ26fV0SKWAIqTVErQNtx9Ra9UZhDFvDv54sBcMGpYjQqZ8rPEQfatXb+2ELL63tQUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/nSmIqj2THX1ifHMW+CjuPW12e/u1XxC3TnRHVyVsY=;
 b=vV3Wu4nFNEaLlZ35qFOu/u6JHEZ+nMVwSFxQo85EyBCt1fkxFvPDRMoNqo3Rw0DDhpOOHzO5V8pp8iFbfcgdajf5FwiGTaSDGoxpyZBqIovlptNnhn5rRp+gFvO/pxg+dFisfDl/ofoq5OIAPfWe0TEjSjzOiDQZYKATf5kUeuA72PVdPFwEuOP7k3v1k2qOxHh9Y1CE2aVpw62O9Xf4ZlIFnwDeiyFwdyg1fZ3FPVTwxffGOhtSo8Vj1nT5GpP1ihlgh6pp9ShWCByjk8ktyQ7bfoaiiVpqDnzfomiUkXRLtgDqGHXkY23Xr9QTd1RVVXIahYAF6PBe0szTFV3hFA==
Received: from AM9P193MB1588.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:30f::11)
 by DU2P193MB2003.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Sun, 5 Jul
 2026 09:28:27 +0000
Received: from AM9P193MB1588.EURP193.PROD.OUTLOOK.COM
 ([fe80::824d:c236:f55b:4ed8]) by AM9P193MB1588.EURP193.PROD.OUTLOOK.COM
 ([fe80::824d:c236:f55b:4ed8%5]) with mapi id 15.21.0181.012; Sun, 5 Jul 2026
 09:28:27 +0000
From: golne tree <lrepper@outlook.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Regression: ACPI battery status incorrectly reported as Not charging
 after bb1256e0ddc7
Thread-Topic: Regression: ACPI battery status incorrectly reported as Not
 charging after bb1256e0ddc7
Thread-Index: AQHdDF9LvWWCiaJdtUyrCye/o7pQqA==
Date: Sun, 5 Jul 2026 09:28:27 +0000
Message-ID:
 <AM9P193MB158895CFE0DDFA62FCD1DA5ED0F22@AM9P193MB1588.EURP193.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9P193MB1588:EE_|DU2P193MB2003:EE_
x-ms-office365-filtering-correlation-id: 0c91ba52-b0da-4149-3dba-08deda77c528
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|2604031081799003|9112599006|15030799006|15080799012|31061999003|8060799015|8062599012|19110799012|6140399003|40105399003|3430499035|3420499032|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?q/Lt+rt3CCnlUt0bPdy/tS+ICWokjU2XPJABw7YQ0CYlY+ZNtoz5mnElBF?=
 =?iso-8859-1?Q?LXoBTpLs+XGu9v7f2pbecnyhYXpo6Ct/+HH5HMq6C0h9P/TtqhiaXMOUpp?=
 =?iso-8859-1?Q?zlocgM+vgCH7zHgOMbwNgb6GAC1J3pz3PAt++dIkXXqbOmHWidAJFT2H3h?=
 =?iso-8859-1?Q?aLMHIjxwuZjmPDwWXlNTj15iDiz0ipTkjodL7eJ8Rggc5E09A4zzgHj4K9?=
 =?iso-8859-1?Q?QqjF76RsySq/E7UU8txr9uYg2KLkKfMCQOGXPBnfDv3Sg5dRi5CtvfNgcn?=
 =?iso-8859-1?Q?3aU5JBZqMg6jEpd33aLId65Qs43yBmCqDapR1ogWliXjBNRsoUR1PPZMWK?=
 =?iso-8859-1?Q?4FGFqQgh1Bh1ZZLZ+JfNAbmXMZ0ipNkyUcR9AL8nxKcb80GL4wLcMhNOql?=
 =?iso-8859-1?Q?PvIdykxsfoqwPn0a+au1y1J+rObH0mK2Yg5hd+xClt0h1nC/2EkD+Cggjv?=
 =?iso-8859-1?Q?medKCYjWsACeXCo+hsPq1g9f8wKBAArFbUbC+AaP+IOtUvfYkRXlTpywuq?=
 =?iso-8859-1?Q?n7MyX8A7pYHqF1EOwbZSyJFfBv9X2HtmeyFxyCGdyeKwV09BTD70WUGAuz?=
 =?iso-8859-1?Q?H90Sc/yvX0Hw3pJi/EXiWnX6f2tYE7l68Y3cTqaRkfZgoONVVSZ5nQN9/5?=
 =?iso-8859-1?Q?wXRnWiHf/eR+7bljvNZbZ9FuGW8M1awMb36PMPt17UwPL4h7mcM44NCVpo?=
 =?iso-8859-1?Q?zXMFwmZx7H0iaQuHZrVLUa7NtdrhOMf2rFQ0sWnPgJSpT1KefB2+173C2F?=
 =?iso-8859-1?Q?1jYIaSOuiqc7GyFvGRpOocBZIMqOhmWJtvU3mFnEMnciGGru9gQb9fIpEE?=
 =?iso-8859-1?Q?4xpB+hnHlGxEe/GvO41iy4/IfLvIyDpYE20tU8gShc64OFSZ3S15ozRAz4?=
 =?iso-8859-1?Q?GA0zQqNhUWiZ/w/Q4O2TkORCvgkmtSXTkbjCj/e+4XiND3rlRhgas3+OHO?=
 =?iso-8859-1?Q?EAaTZEC9MeHkVIdDKYnevUeQEah9tATcxdpKV/vgQLeCp7j5DGm4bmZ5wR?=
 =?iso-8859-1?Q?IgbHTLOS6WuZAFkO2awMh5HhUyB43vvb/MOjvoo6FsH9YLcHXZNd4ijZO1?=
 =?iso-8859-1?Q?wQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?o6hkfoJhp7C74gQu55hOJNzUcChbCSeG0FOWU21PbZktboTZNmEYUVbMw9?=
 =?iso-8859-1?Q?/y//frG5kqCBEHzJkSv338LIeJS7/vXvSG0hflT2eZdU0pKRO6UKXsw0HG?=
 =?iso-8859-1?Q?wpy5QYilZfZz15q3doXz0ZnKbgFpSqXFT4xBAcsC+4eZG7MtG58DSEps83?=
 =?iso-8859-1?Q?5ebisvmpSZ44PVOh+Yo0DxFT8cj3WdNHTQ7GHK1qSpPPo8NPGudCHVM29L?=
 =?iso-8859-1?Q?5gerT0YwJu95b0PWXQMM5ouOGIv/BY3r8Pc286yM64N3SWgl2NfM3p3Q3U?=
 =?iso-8859-1?Q?z8QdyzDMARfag83YdRgI/8DXoHoHgX67qUcr66tP2SekTiTL19+CldeTS7?=
 =?iso-8859-1?Q?xHs1CaSNovaQrV5NMJ6Bl7G0hVZBA5DbnYnk1VObPQ76R9GkHyhzOWxA8x?=
 =?iso-8859-1?Q?ZCMlEXrcnWNefpsGgSLfW3lR3LTs9o0VOnvKeEx0265HY9cT+tYClDqBBV?=
 =?iso-8859-1?Q?q9lxI0wbFWTvS2WiyTb5ohmXz6MOci4VXhJJWvVdqqtcL5Gh1E2w1qGDt/?=
 =?iso-8859-1?Q?8SyuFB1CK0lZ3eHy5tc5Zec9kfzoZxzkj7oOHawrYMKtlLX/fFhSUw5PcL?=
 =?iso-8859-1?Q?GVRYZeUZeEkb9RKUvKospa0vEeAvGPARdnZsNqhv9kXHSSHmSzOORq3rOm?=
 =?iso-8859-1?Q?XNpRjnKRIHdXdnbOHIYm55iuOmkEfCLBH5nSCCim/erK8dnc79ohwjTJU/?=
 =?iso-8859-1?Q?cuO0LA6rTVI9swR2FtTuNSOHDCK6R7Svu1KXNFTEO2tMD+AeDI/Lbu47R3?=
 =?iso-8859-1?Q?s7ZzsPYqWF5RHxezZHL90Med6l61kgkVNBLyfBVXEozQcsDpOjr+Sdz5nK?=
 =?iso-8859-1?Q?RQH5R5MAtJJbq5SjEpCwpMGbavyRT2dCOO9Vfi5+iMaAj3gx93XelQkQSS?=
 =?iso-8859-1?Q?hJA0g/0BIod6ory4nBtvUYUA5GmjNMaQDNmvIYXUSlNMe+vom3fRp1tLop?=
 =?iso-8859-1?Q?9U197MH35e3LMAO1/f8ZSzTv9MnvcoQDjcA+PHnv1S91ugQw/1ryKPpV/x?=
 =?iso-8859-1?Q?2jFo2oWDOKdsiuCMGFLruJhBb2eXq2bw/zwFgFl/UcvT+gCu1uRJH+2ft6?=
 =?iso-8859-1?Q?u8k7N2D9uWMHetudr//0G/4gsjTA3m10/okD7W1iLeOVw0hvL0nVY7cz4P?=
 =?iso-8859-1?Q?XSkeBH44Efq8qTJHf3onipqHYWlQGyxMHWK1G10gp8uYt8mxhKtpYaoa70?=
 =?iso-8859-1?Q?Ej1fAySpjD7uVZZmzSGlhIiSl4U8Q7zUfnncyNImqZRgf8Y5Gnq7RR33qH?=
 =?iso-8859-1?Q?Rv4ILZv3eawCrv0i3dLCqirzALUY9SH9WNE7h2tl/pWYBgStIe3+UiXKg0?=
 =?iso-8859-1?Q?Zx53mHsj5fWgILGTzxqcSGIl/1kWuNoJA3ihq8ry7nMkm/lHEoAUzqwauI?=
 =?iso-8859-1?Q?L3ewGRX7lfpCBh9GpdiTlZ8edswbrSJ+gtk7pEtz6sa7JXZfKYhcmZXZmP?=
 =?iso-8859-1?Q?X3nCVzsV+5AKKgXp/QpUevqGV43ZX57vkvYL1yaLH6o26o+00ex7k86vns?=
 =?iso-8859-1?Q?E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c91ba52-b0da-4149-3dba-08deda77c528
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2026 09:28:27.6405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2003

Dear ACPI maintainers,=0A=
=0A=
I would like to report a regression caused by commit:=0A=
=0A=
bb1256e0ddc7 ("ACPI: battery: fix incorrect charging status when current is=
 zero")=0A=
=0A=
The commit fixes a real issue on Huawei laptops, but it appears to introduc=
e a regression on my system.=0A=
=0A=
Hardware:=0A=
=0A=
Manufacturer: Default string=0A=
Product: Default string=0A=
Laptop: Denver NID-14106SSDDE=0A=
Kernel: 7.0.11-1-cachyos=0A=
The same issue is also present with the unmodified Fedora Workstation kerne=
l.=0A=
=0A=
Observed behavior:=0A=
=0A=
When the AC adapter is connected, the battery is actually charging. The bat=
tery percentage increases=0A=
=0A=
However, the kernel reports:=0A=
=0A=
POWER_SUPPLY_STATUS=3DNot charging=0A=
POWER_SUPPLY_POWER_NOW=3D0=0A=
=0A=
Relevant values from /sys/class/power_supply/BAT0/uevent:=0A=
=0A=
POWER_SUPPLY_STATUS=3DNot charging=0A=
POWER_SUPPLY_POWER_NOW=3D0=0A=
POWER_SUPPLY_VOLTAGE_NOW=3D7400000=0A=
POWER_SUPPLY_ENERGY_NOW=3D24760000=0A=
POWER_SUPPLY_CAPACITY=3D84=0A=
=0A=
The battery does not provide current_now, and DMI information is unfortunat=
ely only:=0A=
=0A=
system-manufacturer: Default string=0A=
system-product-name: Default string=0A=
=0A=
Looking at commit bb1256e0ddc7, the following logic was introduced:=0A=
=0A=
if (battery->rate_now !=3D ACPI_BATTERY_VALUE_UNKNOWN &&=0A=
    battery->rate_now =3D=3D 0)=0A=
        status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;=0A=
=0A=
On my system, rate_now is always reported as zero even while the battery is=
 clearly charging. As a result, userspace always receives Not charging, alt=
hough the battery level continues to increase.=0A=
=0A=
This suggests that some firmware reports an incorrect rate_now value while =
still charging, making the new heuristic unsuitable for all systems.=0A=
=0A=
Please let me know if you need additional information (acpidump, DSDT, debu=
g logs, etc.). I would be happy to provide them.=0A=
=0A=
Thank you for your time.=0A=
=0A=
Best regards,=0A=
Goldi Tree=
