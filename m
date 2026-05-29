Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011034.outbound.protection.outlook.com [52.103.33.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8E11DE8BE
	for <linux-acpi@vger.kernel.org>; Fri, 29 May 2026 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082279; cv=fail; b=PRiw0Z0dHXQ9xIi2JBLbnZC5SF4DvDs+gpVfBv5osDucCPwqYse7Wf4KnNhkivEyFvk2qnSmunbddIKvMyAxYMI12/wotdOAXEedeUL/JZhdLwaqoP6xOL7+VQY99gpqQY6BIzVG91lbKZzkrE3ubur2iipEgC++aEgZgqjyg+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082279; c=relaxed/simple;
	bh=nuelkGf+oAyso1GxUOpmBhCwwjKt4HmI6r861HxzD+8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q2feR8BhAYA6hFuaa+stkv+k/RgMCVSEtLYIC32B5wjN2fOHTjs2SVj1dxsqrlpzYUWGjCrdmqRcdYpjvnjEmT9TwER6CktepP9GoTcy2dyC0EdymOlAGxZNK10p1NhOr2uk8olKrHK1FTMwKobXWW80tUokHCNbS78SLeyhILo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de; spf=pass smtp.mailfrom=outlook.de; dkim=fail (0-bit key) header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.b=b6ESm5a4 reason="key not found in DNS"; arc=fail smtp.client-ip=52.103.33.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.b="b6ESm5a4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNLZcf5A80H4HMtXZ06wpQiJ3Bw0FdhMbk0CCspBjZwEsyNi6S9w2JweGBTdBX9irtaQ2MrNBkwp4q9uvnxZxwte8X0mfHp7aI07FExvXair8TaD0whlIR0sST0kNN8+GsRQECOCzqRtQoeAoT8bsUk3KXq5OPRR8iBLZkW69IjCrSCJaJiECA/wPRbcjfO2cIYZFDfPJmBbWvGLO4PPQ+WXnNQ3t3/i4N64YysUasIH2UALcwN0qt1js98ktsXSqGUsRMhJDS9/FCEMuSoGBAOzaifTJwxy0rNglFGuZElqL1FVvUJV5nqL9/+vjaBd4MXI14cpKLsmCNNv+FquvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuelkGf+oAyso1GxUOpmBhCwwjKt4HmI6r861HxzD+8=;
 b=bKhBdE537ME/9Uk6ugKWc9oIXMJHYmyzG6pO7OVbuwEFR7zhyMyOVImTX9+otbtkx5/9+QFCapH4aB3t1iOIDGla2ykpNoHpe8C7qLpHIcxxZx0RoixXQTIkMxZyjJfsML+/at18Oh1DGtOMnYdJxVEqy/kS5g62bWaPDzWGbqIjjsOZ6utKHru2mGdDVb4aD401flHpLndmbXfoU2mH2tfz7gT3nRuidjuOq506h3GIISB8GVkGyclNZ3yBiY6dBsguIN1bLPoZ1riJTytwkdMdCDSwGKkCWW+Mc0l/5Z0Lhyl2YNumpGSP79erH7pfyy9kTj1913PkXaJ+NCnThw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuelkGf+oAyso1GxUOpmBhCwwjKt4HmI6r861HxzD+8=;
 b=b6ESm5a4SD53D7AEQPRMbTfP+tI5Jua82kw3PqKZNI/IJUb4oeulCPoi7zvpmEyOhRcsgX+0UX8sGKFDXWW6D8brrdCqRxHVakijiCpnfuJkajH5rcYU3ds+cTnEmvcgUEZNkNp9AEGA219XNMTot5LYiv1G9XCd3z6Fdb5tUX8Pn5pO+8T6Fqnaz95CWrUj7J4KoEiWVKe8xX92m9nbOdudfa44biTkr2h/yVSJjUbTf7HIxOh6tZK7H6yI5xltfQeJz5ApVKNOByc1AROjZKMpjZtZ5D7fI7l3wlJKpN0l8fjr4QOtqcOIhuYmNm7glVV5ugpvI3b++BDaw8C4Qg==
Received: from FRWP193MB2795.EURP193.PROD.OUTLOOK.COM (2603:10a6:d10:16f::5)
 by PA3P193MB2839.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:4b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 19:17:56 +0000
Received: from FRWP193MB2795.EURP193.PROD.OUTLOOK.COM
 ([fe80::1286:b469:5525:33c6]) by FRWP193MB2795.EURP193.PROD.OUTLOOK.COM
 ([fe80::1286:b469:5525:33c6%4]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 19:17:56 +0000
From: goldi fiche <goldifiche@outlook.de>
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Regression in ACPI battery charging state handling on GLK MRD /
 Gemini Lake ODM devices
Thread-Topic: Regression in ACPI battery charging state handling on GLK MRD /
 Gemini Lake ODM devices
Thread-Index: AQHc759paZHtYI44BUC+wt73DeUDXg==
Date: Fri, 29 May 2026 19:17:55 +0000
Message-ID:
 <FRWP193MB27953B3CF220760EAFB37116B4162@FRWP193MB2795.EURP193.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRWP193MB2795:EE_|PA3P193MB2839:EE_
x-ms-office365-filtering-correlation-id: 6433862c-f039-4f4f-80a3-08debdb6fd0e
x-ms-exchange-slblob-mailprops:
 02NmSoc12DcIjUPJ2moxjQENgrvELoQOsSSgsrWHQ+48NMcfPo8Zp88ttIdHTzdVxot1RdWJYxj/SY+z/2PPk+x8V5dkm/I7+NHBH5bJXIZ9FZRCd/z/d1qtC1ahdp3fyTM/aoyyiFhQoUIa9ZuvHe0m5KZ42GcffEKhtSJJlGKgSR8do9hLD7/BDCwoQra+1D9eZx0lY+0ZLs2cX+gchX92MtStgX1Nl04yC0xrI2VgWU2CL9nOFDMlvHSB81e8YGFKq8HO+z9lRPRq5ihT+vBjxW3g5Nyn1qiu8l08qtSa+MwM43sxrsBdOXsNm2+nyUM0BaYjSVAogpT4Dz2s2XxIGyyMsUh5QayrJucQvDgSU4xK6UKEoF7IqERvF6Cjo5wCzpCjVIAzptLxlEmQxK8u295YMLBgEteBs5oxVSDuGabhsITVk6e26z/CYYuCWpo5BN54BNuFri25xkQ8XsGYGZ0CL090SnJDURcqMmPmTzGE59nwE9bNXH+AdU9i0YT96/5vWP4ntpBW3cG5R3zi6kdWpWW+DQj1GPofYPnutKirYRrohGtvvNos7ZI5mfVm8ACs6KlQS7UIumFTuHV0w0iTG5JLoFiKXsUSV0ZIqPZ87aejt+XrH/8HQI6oShA0O6iVo0yPI88FQrbwxeUO3K4RE8OWUDVM8uu7mxgjK7e05uekEb4Zqmdtse/5K43XbO72NJXZ8DOel0lU6k5tqIjEi89o+HBWVy/SC+zOKRnAJygoXsTYoZ7NpGBn
x-microsoft-antispam:
 BCL:0;ARA:14566002|9112599006|31061999003|10092599007|8040799003|2604031081799003|24071999003|15030799006|22081999006|20031999006|39105399006|41001999006|8062599012|19110799012|8060799015|440099028|3412199025|16045399007|102099032|3420499032|3430499032|40105399003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?biyNeTgGf3Bo4upg9fHzc2hYsdklRUD2ZUqq8euufvdP1oYNVZ1y3S2zUV?=
 =?iso-8859-1?Q?GOksvJF+QYTpKWyFw+6Ew8cg2gXgooWaC88oGQmiOgb++0UIPC+hFV4CML?=
 =?iso-8859-1?Q?yVwJGblrg2u1PQboPq8G9PbLhZFgy6baaEh27rGJmmBznTS+RyM9Xtmad8?=
 =?iso-8859-1?Q?3yjsBtNHvu6al7pfv4bsPTJ1PBd7ArHJXh6aAJwNdHCNYP4umPm/HPxqvj?=
 =?iso-8859-1?Q?bzKX5q0UnDZmxBd7623CMS2T33piQU8vGpbcsE5ZBJicTPEu9G7eC4YVCy?=
 =?iso-8859-1?Q?MluY6E6ws1XmBBEWUAU1wuSlof/cmhsGERv8XYQv+oF2Vi1whSK1PnLqCc?=
 =?iso-8859-1?Q?LV6ES4OKvea2Af1sogrC8Pwa0LG30QHuC+Md8pS4A3Gx8qqemy37s254yv?=
 =?iso-8859-1?Q?Jbt4V114ejR0G4jC+zTl6hbcjOvV6yShgGoYZ/NaWxzyBBdRswAozY1beC?=
 =?iso-8859-1?Q?/skHYSsnJbt8Syonr276IogIxknu3aTXkiD6++I3Lp61TFD+ifDzE9ajvO?=
 =?iso-8859-1?Q?j0iqzHL91gAkaENe/tmWqOPE0dNDCVMkQmlMYgwJ0Q7qORQKc8eJR5Bzal?=
 =?iso-8859-1?Q?gL4WDVb+FO16JzGiRwfL+TwWaGI4W1YS1yD45clLZy3FOlgOW+N0EkoTKf?=
 =?iso-8859-1?Q?7BpC9o77RG1FTKsMWOxuug17e+8PvZfFbnKwrZyDQq1T+TjoDd9rdK0wgI?=
 =?iso-8859-1?Q?TZXjfKMfKoaZfxg4EkQy+oF5riL31JbS9pR2HC7do30uTu4jNxljLtBBaM?=
 =?iso-8859-1?Q?Ed1V58aQZULuozqqXmO7gyxJDzSVCqoMrNoj/tHVxgwfKP7zmCxRIeb9DQ?=
 =?iso-8859-1?Q?/Cqk8PsmKFvH/WVZEehculT5d75QUAZjjYRZTl0timRRQHE2CqIsH2rhpI?=
 =?iso-8859-1?Q?6VBnJWx9H0LP5WKOT9OOCOiPAkAL5/CBiI4RlU+I3Sye6X5RJnaXG0Katt?=
 =?iso-8859-1?Q?KBF+Zr4EBoMBRbNgLi0qBdPJYxlvuJdmwYNKtAJNKLcX0jlQTBjQ2J78/o?=
 =?iso-8859-1?Q?ttlp6AEMMZ8oKD13Q5IkXKBjm8BZ+ZvirlODALUAnSYlbvN6UKaLss2XbB?=
 =?iso-8859-1?Q?YLjEoGLQ0UkWDX0x2UTS6p11dyF+dbcsfx627YAlQXGpWGHfAmO34LrUc+?=
 =?iso-8859-1?Q?gqnj2sKYtB4z4Caol9L/N/Da0v+GumT7qHSiV+D7gv9y+iExI7mYyo/mu2?=
 =?iso-8859-1?Q?LFX4CSjb5sc+BtKq+/O6BruCZvmD6aRf4MsFKJpw8Yy/prlcITeFC4NbaV?=
 =?iso-8859-1?Q?fbkSMznTJmSMrJbTFz6w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YPcEa1QDjfg/0lk/6IdkeQmkz4tDnvnM3gcDvsJR8YIs0kYhKS0r9l2npV?=
 =?iso-8859-1?Q?4w6Q0jFaqUF+TpqKISsJAhk3TD1cikBV4uXiLd6aaga2hTJalELaV/qPmD?=
 =?iso-8859-1?Q?SW2Q0JvL5zzwsY+djoz2xlZoInmYcdqMU2bb2KB8WrMVZqM8HE0ccFSJdH?=
 =?iso-8859-1?Q?1DRTbDZR1cmuDEVZNljyDn5s9rWTNneEouR44tJptTAz9DvJSwxAnsTIal?=
 =?iso-8859-1?Q?ZXO9hqKUv7rg8Q6S3/6VbxheBdqpvK6Tb4lOrXaI2B+Ia+FuK0mUYwavBV?=
 =?iso-8859-1?Q?LNJ97Feb04wr6x34UMRJr5NpneDPufUkQ6NEigwQ6QgvrZ7dCtUlPi3jfV?=
 =?iso-8859-1?Q?VGyJLIt8wWNGoLnmosmWS9w8VqeWPYPZuTjwToCvBmVb/wrttNOvp49uBO?=
 =?iso-8859-1?Q?vsIFjOs7Hp1i/9HUkPvhtsgMdEw2wOzsM5dnhulvO+BgaZJHRMIb3yYB43?=
 =?iso-8859-1?Q?C4xTMpC7TPpVd0u9dII2xl5JJs3P3nFfQCyoeS6aO/j4ky3sMdl2VuJEfY?=
 =?iso-8859-1?Q?OvpgL2DHzWOzC48tho0SK+dtCnDS1Ckt0lgH+ZMEDbuItKc/OufWnNPZtl?=
 =?iso-8859-1?Q?FKWekijj4jRiOBxzV4AYa+XrMzQ8eUe64gL1o/cK+7Tx3i3jGc+8uP9nCF?=
 =?iso-8859-1?Q?+gbv4m9XVLK/GniyKue1/qWjjkVj368r1Hi3GcgoofCNBuMGi0JjPqGdOB?=
 =?iso-8859-1?Q?gVp6fJlAOiTAXDnVZHnGxQGNeg+goiuwY+1jooPf/aQ3z4sRrVF2Bm+FVr?=
 =?iso-8859-1?Q?/F6RChqwwBBuabdJpSfyYBH5M7UYo0tyRxHrl05QIbEKr2E5adQRHnV4yn?=
 =?iso-8859-1?Q?CUzOzLYGAxYWn5tXXBHR87et3i6Bo/W1ungUccytqS9VL2pNOw0JszVCDH?=
 =?iso-8859-1?Q?eE58XHrbH53/92BvDkvSWLrs9/pJD4CuFFFfpU12MT/76F4BCaFjZ+s2HG?=
 =?iso-8859-1?Q?EppfqWTBVCuYOB4Y2duT2P8I08p1Cv42Cot9BjpaROLFGJpf0JjJwjWZHY?=
 =?iso-8859-1?Q?2e8+2y56Dc/GM85WG2q8qshq8n8tWi/E0BxkbJprQbzfxlXjZrjxmyZmqj?=
 =?iso-8859-1?Q?GXGqvpwEMEVDMT9vThpdZnZ/V7asI0O1UMrCKdFt8ynNEGsms6F/8Lt/cf?=
 =?iso-8859-1?Q?F61dxFq3inrAmw+2nxEHjmB3Pb87Om4m4H0kYtYgGNCU26plyq3IR2RJ7F?=
 =?iso-8859-1?Q?gX2eX+UuFXQPlQ4H3AfNbtGJ6wQe1Y8Ta2M4WpvXBAEKrStRoxMYVrGk51?=
 =?iso-8859-1?Q?H9CUiSZHP9rZqLzTQeZZ8V2GUIq+CrGbykjN50pgBnBMDg3jTuJiiwdqHH?=
 =?iso-8859-1?Q?T7EIv4WEWEA0nlD1BgF0Jo5yZhKBN538W7Vjsn+BxQnAipwOOcxsV1igcE?=
 =?iso-8859-1?Q?t8nUV9dSr/wsIInazQlbN3x2AUkot21fYcvvsnbs3yPNTOz3vgBseOpDHA?=
 =?iso-8859-1?Q?rkFG82gzE9sxZgPHdWMM44ERYCI7UjiTbX+NhKt3rQNP68J20ntnoyuODe?=
 =?iso-8859-1?Q?I=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: FRWP193MB2795.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6433862c-f039-4f4f-80a3-08debdb6fd0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 19:17:55.9816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P193MB2839

Kernel versions:=0A=
Works correctly: 6.18.13=0A=
Regression starts: 6.18.16=0A=
Affected hardware:=0A=
Intel Gemini Lake (Celeron N4020)=0A=
GLK MRD platform=0A=
White-label ODM/OEM laptop (Denver branded)=0A=
Broken SMBIOS/DMI firmware=0A=
Relevant commit:=0A=
bb1256e0ddc7e9e406164319769b9f8d8389f056=0A=
"ACPI: battery: fix incorrect charging status when current is zero"=0A=
Problem description:=0A=
The=0A=
 heuristic introduced in the above commit appears to regress charging =0A=
state reporting on some Gemini Lake GLK MRD systems with broken OEM =0A=
firmware.=0A=
The firmware reports inconsistent battery information:=0A=
AC connected=0A=
battery charging or pending-charge state active=0A=
but energy-rate/current reported as 0 W=0A=
Example UPower output while charger is connected and battery is at 37%:=0A=
state: pending-charge=0A=
energy-rate: 0 W=0A=
online: yes=0A=
percentage: 37%=0A=
Before this commit/kernel version, the battery charging state behaved corre=
ctly from the user perspective.=0A=
The affected system also contains severely broken SMBIOS/DMI data:=0A=
"Default string"=0A=
unresolved AMI template variables=0A=
invalid cache sizes=0A=
"To Be Filled By O.E.M."=0A=
This appears to be common among Gemini Lake white-label ODM devices using G=
LK MRD firmware.=0A=
A local test patch that bypasses the rate_now =3D=3D 0=A0charging-state ove=
rride restores expected charging-state behavior on this hardware.=0A=
The=0A=
 Huawei-oriented heuristic in the referenced commit appears to be too =0A=
broad for some GLK MRD systems with faulty EC/ACPI implementations.=0A=
