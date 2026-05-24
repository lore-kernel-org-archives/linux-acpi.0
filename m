Received: from WA0P291CU002.outbound.protection.outlook.com (mail-polandcentralazolkn19013077.outbound.protection.outlook.com [52.103.53.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718F327F4F5;
	Sun, 24 May 2026 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.53.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779619169; cv=fail; b=XR0WrciOFAz8brL1ebskplM06Wsm49NTQtdaYvfpR18bMX5oMkKoMSreXc+pmrrnKlTs0PrnI6A+QsaSK+SEPbdsnOxJL/LMUENQciyZdDvF488j1/fWx54dHAnFP5yqF/vhCKpOWLHdwngXya7didP6dsfSvwr3H2HW8U66DuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779619169; c=relaxed/simple;
	bh=R2bcLQo7Ae37F8XlBT4JUW8K3YtAwkEUHFezUawvs/Y=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jKvaewzkVaL0BzFNFX07INjVZqws66T2r3ztXwHsu/ZHwIN60AtUehzOU9QO93Uk2saxLhY0sJQVDFPRFzqe3DBIQMHYmPHdktsudUbtdsjIPS7b7h9Gi507EfFuFO7ygv4Wg3lGNq3xHDaBSJV3SYptBU1siCYxix9c9ey+/UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de; spf=pass smtp.mailfrom=outlook.de; dkim=fail (0-bit key) header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.b=P3sLAdQb reason="key not found in DNS"; arc=fail smtp.client-ip=52.103.53.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.b="P3sLAdQb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8bgMkCCyAXO9OVbEcCsXHfbz8eMtvsNBXzjjkHoRSY96Ws7kveeH7WQUf078SWyIO7YaWQG6JTFekGuqz1PzrwLrrFhedBfi4g2A/CXJA0pXrVgNveyLG83uzjzA77o2eMd9NZY97NtoFSdtVk/HCGgbR97YAi4Htqv4x0oXEgCiRaTuzD+gLOVjWqbl7FrfkcxBUBkreTTpx0+UFVg73IC1S8eBzFPYBxo4jtjneNqZKigopV16uHMp72LIqAq1ZKgkncDzAPBO9idmZWlNdRLga6npcrdE8F70vm2qQtgo3IZvaRT/z1YnByVs06wm2XUXLeJKDjIjZFrlGvMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2GlNziYn7dKCw/xkPXxpEZddAKkVr5Q5L+5BYiEu/Y=;
 b=F6n0fkmMNruWnuFlU/kOETEpKbJQNNO251kJxAuqqfO0hc9lxvhdHIdiHYE7bmPv3oxE+fsGINrkHeVG1HUwTAZvlzDp9W8pqEbhXfRKn7VyTZW3qc/zR5ukEx5vZUuxYnQ8tXnPlPlAlaT96tdYG3pmcwAvOsSjFUpKHTWvw6G/2iQrlPOpKjeHEevtjKZ7yWlhvdYKwDi0xtfw7fOMul/eRxTGbm+NY1TepUbNmpzjzJxPVNAN1mRJQt91xG36dfH5nzQ+sV5hR+crjndRuLmEcf9eOCxtLDMu3vhVUFmjd+5A88F2mbXO2V3vqr2C9+sb3RD86NcaSUdCohgsaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2GlNziYn7dKCw/xkPXxpEZddAKkVr5Q5L+5BYiEu/Y=;
 b=P3sLAdQbDUDGVRgmgSQNImATB8jAqW+1CgEQ0XWtvZGQ/vfoQZ2L1bW2rnlFxmjPgu2Nze/QjVw2Dwv2giywblnNua5PHeylSKembPz7SysEnyQcC4qYln8OfTTdrY1WmogJ50UcuyA5MzVPyoxiWPtbPYlkGeMvq0oYvtSHBrb12d565hzUurTfqLipPRvu23QZq4PgXFCqdYgMmm7GOUI+mAaZulgKSCFiJbGKJ1Eslo1MKy44EJfH3I6vf79HIwvaDV4rbSWpastl0Sw28a+snOH62u06ty63PjCElfDZlRVffoyuIZxAjJ+0eGdY+7Rc47jGx3GzTP0/ILWj+w==
Received: from WA1P291MB0033.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:15::5) by
 WA2P291MB0310.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:23::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.19; Sun, 24 May 2026 10:39:23 +0000
Received: from WA1P291MB0033.POLP291.PROD.OUTLOOK.COM
 ([fe80::f2:ec94:fb1e:ef07]) by WA1P291MB0033.POLP291.PROD.OUTLOOK.COM
 ([fe80::f2:ec94:fb1e:ef07%4]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 10:39:23 +0000
From: Norman Becker <Ryleno@outlook.de>
To: "rafael@kernel.org" <rafael@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
CC: "lenb@kernel.org" <lenb@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: battery: Add ASUS Vivobook 18 M1807HA status quirk
Thread-Topic: [PATCH] ACPI: battery: Add ASUS Vivobook 18 M1807HA status quirk
Thread-Index: AQHc62fQ3wtoBFff1UC3Qst9vD696A==
Date: Sun, 24 May 2026 10:39:23 +0000
Message-ID:
 <WA1P291MB0033B3D85FEAC77DFF319741BF0D2@WA1P291MB0033.POLP291.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: WA1P291MB0033:EE_|WA2P291MB0310:EE_
x-ms-office365-filtering-correlation-id: 5bd14904-02a6-4b54-430c-08deb980b8aa
x-microsoft-antispam:
 BCL:0;ARA:14566002|39105399006|25031999004|15080799012|15030799006|24071999003|24021099003|6092099016|8062599012|8060799015|19110799012|31061999003|20031999006|3412199025|440099028|3430499032|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?lYwNE4qy0AXnCz1EQe5aadvMIQnKF/YWl+BCMKl19eycSnqrVd6lT07NZX?=
 =?iso-8859-1?Q?z6VBrs8ivGBLoAuVrE1b4f0raB/AX11XuMNG+bnmdGWMyeMwPfqss0rXPg?=
 =?iso-8859-1?Q?V6UQry4YMkOvsgH/OXQ8JwlrwemCwzv4zfDrsfv4kVtfIBxRl40IYM+ZKA?=
 =?iso-8859-1?Q?X/ctxAadV/V3M1GvrBHgkIlUequ4lOXKOmP5RfwdgiMX9Op0dUmAfg+oG9?=
 =?iso-8859-1?Q?DWDe1OLsn9vQx8YNKFFqI2K3YzSJODYVcem7QMv6xtQgL4DlvOyBxSEQGu?=
 =?iso-8859-1?Q?yrtonn+U3cZvK9ozDMlV5okCEpqY5UF/dDZfU5Airn6u/tOkavam82Fhxq?=
 =?iso-8859-1?Q?MNbDjkJLIwZiYkfShf6RNC5KNqb9CzbACS87mjE6LRoh0jnUx8RrPUzf42?=
 =?iso-8859-1?Q?XD26x6ELcJrCZV8QrSWUvZC6ABY0i8uNdUB9F3kMNs7uaQUJxghf3JP20I?=
 =?iso-8859-1?Q?LZt/7+vQTrErDnWZdsmhbKt70lLCuEOfPkV0oNyzjcslvwLKeGEUGAYyEo?=
 =?iso-8859-1?Q?B26018c8F4NIsSUgvn7NoF8S5fe0R5LcdYQfDTP3UrhNd5cbfeIwcsA5g2?=
 =?iso-8859-1?Q?9noxlfKjedl3lK657H/CiS4lmb40D7NjW+HxizsstlySBEflPVtaqnS8yF?=
 =?iso-8859-1?Q?+Q1lV3F6MzNdCKNbQjADGUwilQBbuFLz8egx3Gpd08kXMDAIgGTVl4GgHF?=
 =?iso-8859-1?Q?R0qFCmKF/lCMU8uPSY/rS30Yf3gV5wxX9S1qXpDApZ0YLaUAa89m8/YTHZ?=
 =?iso-8859-1?Q?1B9ISB6/T7wkoXZLycp6+FQXDa6xPcSuez0xOEDArT9TG+mtadGTYAPtaa?=
 =?iso-8859-1?Q?XTnTtttefxePvjEhMBm20bQp39hbVak6mKAwxKIo3J16IZuxeW3jXHlDMZ?=
 =?iso-8859-1?Q?25RRLBm5kypeW9EjShUin66KeQp9c87bCilNS+/QZk93LxWCy6snqCpn3g?=
 =?iso-8859-1?Q?Ht+ZfWWwBdWx1gHzwm4FaApvv8bxUMbjO+thySsAJlXkz3qGr5aLTb5sbR?=
 =?iso-8859-1?Q?FDc2ufL5URQEb24teqRJyOqMlXN5V+gutgOs+BjLxiKZghg3uScdb6ATpb?=
 =?iso-8859-1?Q?0JvwKkeNRF93LrejoxyuZtw2i5HXcYaGLFtVgWJgjaoxobs1bUa+DaF8rL?=
 =?iso-8859-1?Q?tbISAOMb8F92YIUzl/r553lcgRY14=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7tKYwlDK4ay1GA44VDaFfcQGahjgnUODXaUKVWTOZ4BK0nQsUL1DymnUzE?=
 =?iso-8859-1?Q?tJJ77uknAjPtNQMCXe4YXU4P/sKNr3sF/SrNzn7cb+CE+07EH+z4V0YDCJ?=
 =?iso-8859-1?Q?/TpzqpL8X8HYEAW3nNJ8fPL9bZO/Mf6EGO4NXeA+wvbQo2RZ3TYVWuVOud?=
 =?iso-8859-1?Q?LwhfQbbN8v3O3YmpajioPrKyqJDZdXW+3osRbuJPt8iH9xD5z9eyHkNBmb?=
 =?iso-8859-1?Q?LQ2I7wfwKT8s+/cnCMxgp8JKacsQ/OGv7vCwzLhJUG1VkBvheRrSjZEhzA?=
 =?iso-8859-1?Q?bfNDC4CCF6fiUVNotQhbbTgPiw3fTXGWZgO5VMdpjyGTQdBYbZH0G2bVM5?=
 =?iso-8859-1?Q?HlYGigNvw+V/qsMFRDv9OoFGpoT5ieNb7YLzt8IfLeSBCDhHTSy9lFidfQ?=
 =?iso-8859-1?Q?YLvYsQE6LkZJRwkcv+lx5q1KoEjXjl/B8UnwIcPmJeCLEbW2PkWU//09jO?=
 =?iso-8859-1?Q?xg2c137eOSdc5DJm2hRiEpFnLlSc8kuduSjePiTcq2JgcTRJOrHR8wBAI+?=
 =?iso-8859-1?Q?rpzjccru2grMtpB9Q6qXPYNCuLgrXJMP54LI8n8Moqs2FSFxjdOeBqBFsz?=
 =?iso-8859-1?Q?F6M/6B+QNpt3Qq5y+JK5L9dXe/9OGlwTfRyN7K8qCDNYdwQ6PRA/rDYr/r?=
 =?iso-8859-1?Q?c3gxnBQ7Alvgmsun4MAuSLpKSqJvoi7BBGRoZuOSVYkRb9TBDtzMw7qGJi?=
 =?iso-8859-1?Q?hWalFJT57HGuxOvf8iltrbvTQdLPXsgoFlTyYL7LvsL9KGky4KIl5nrRs5?=
 =?iso-8859-1?Q?MqK6b8AX7VscslQJjyyPEDAYr1ExloN4kytRBSLFIszBlmA8OtTk1kD9Am?=
 =?iso-8859-1?Q?OfPaPesX52ng8+t7xanBMwkpUT7vBNycaVWQ66dAQlqXZnhu5FRbSN7nVL?=
 =?iso-8859-1?Q?p0gT9bMeomZXF5QwhRyw2cVony7QF9/K4/pac9ozs3FApMqxwZ2hqq9BET?=
 =?iso-8859-1?Q?gdPvTwXTp1ePrZtCm/hosG3AmpSg3jYqfuzVYnLJbW4mownCMpLmBQiYWh?=
 =?iso-8859-1?Q?9Y7fCFDSB2WEAKZrYUNpSgpDq1Bx2cDK6LIby6mHYa3GO/9SuFLLcRlGLg?=
 =?iso-8859-1?Q?VKM2uZL6nggy08R16Atlgr9d8XBxD0Cc1hNt/qbrQuxLUULXNRtrJtiqUi?=
 =?iso-8859-1?Q?KNae4qMI/k0ppThzDhWa18O+PjpmnbL6aYKIp+BfxUu5mhIJJVZoOsUCu5?=
 =?iso-8859-1?Q?OKsf3zRNDMbI3jQu0yqfXUa1XM5bggjMcmdp7q+ncxpK6p2b6Y9i6IAHrs?=
 =?iso-8859-1?Q?P8HnnKnexJ7MS0SY5fwlg0PAMgX359SbY6PsNYai509rUo9Z5lzRN1wffu?=
 =?iso-8859-1?Q?URUvRqUFl1ZtPVBDxDnDbwqx/3H6BABd2Lrc7d/0o2H9CCAYEJsBZ+ezrq?=
 =?iso-8859-1?Q?25/4PkJEa0SEZSht0duJBZMCSOcCrq8+RioBBiaxJyrdsZ9aN0yB89P3pp?=
 =?iso-8859-1?Q?nVaEub7Hs3JD9vekCSYWgZYV7XEfINlcG+oOy74oyLGH8Y4HMkkncmyfyK?=
 =?iso-8859-1?Q?U=3D?=
Content-Type: multipart/mixed;
	boundary="_004_WA1P291MB0033B3D85FEAC77DFF319741BF0D2WA1P291MB0033POLP_"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-2112e.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: WA1P291MB0033.POLP291.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd14904-02a6-4b54-430c-08deb980b8aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2026 10:39:23.7678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA2P291MB0310

--_004_WA1P291MB0033B3D85FEAC77DFF319741BF0D2WA1P291MB0033POLP_
Content-Type: multipart/alternative;
	boundary="_000_WA1P291MB0033B3D85FEAC77DFF319741BF0D2WA1P291MB0033POLP_"

--_000_WA1P291MB0033B3D85FEAC77DFF319741BF0D2WA1P291MB0033POLP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Rafael, Len, and ACPI maintainers,
this is my first Linux kernel patch.
I observed incorrect battery status reporting on my ASUS Vivobook 18 M1807H=
A.
When AC power is unplugged and ADP0/online reports 0, the battery status ma=
y incorrectly oscillate between:
Full
Not charging
Discharging
This behavior also caused KDE Plasma energy/power profiles to switch repeat=
edly.
The attached patch adds a DMI-specific quirk for the ASUS Vivobook 18 M1807=
HA. When AC power is offline, Full and Not charging are treated as Discharg=
ing.
I tested the patch locally on:
ASUSTeK COMPUTER INC.
ASUS Vivobook 18 M1807HA_M1807HA
Board: M1807HA
After applying the patch:

  *
battery status remains stable
  *
no more Full/Not charging oscillation while unplugged
  *
KDE energy profile switching stopped

I used ChatGPT as an auxiliary learning and review tool while understanding=
 the kernel code and preparing the patch, but I reproduced, tested, and ver=
ified the issue and fix myself on real hardware.
Thank you for your time and review.
Best regards,
Norman Becker


--_000_WA1P291MB0033B3D85FEAC77DFF319741BF0D2WA1P291MB0033POLP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: &quot;Calib=
ri&quot;, &quot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);" class=3D"elementToProof">
Hello Rafael, Len, and ACPI maintainers,</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: &quot;Calib=
ri&quot;, &quot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);" class=3D"elementToProof">
this is my first Linux kernel patch.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: &quot;Calib=
ri&quot;, &quot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);" class=3D"elementToProof">
I observed incorrect battery status reporting on my ASUS Vivobook 18 M1807H=
A.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: &quot;Calib=
ri&quot;, &quot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);" class=3D"elementToProof">
When AC power is unplugged and ADP0/online reports 0, the battery status ma=
y incorrectly oscillate between:</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: &quot;Calib=
ri&quot;, &quot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);" class=3D"elementToProof">
Full<br>
Not charging<br>
Discharging</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: &quot;Calib=
ri&quot;, &quot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);" class=3D"elementToProof">
This behavior also caused KDE Plasma energy/power profiles to switch repeat=
edly.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: &quot;Calib=
ri&quot;, &quot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);" class=3D"elementToProof">
The attached patch adds a DMI-specific quirk for the ASUS Vivobook 18 M1807=
HA. When AC power is offline, Full and Not charging are treated as Discharg=
ing.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: &quot;Calib=
ri&quot;, &quot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);" class=3D"elementToProof">
I tested the patch locally on:</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: &quot;Calib=
ri&quot;, &quot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);" class=3D"elementToProof">
ASUSTeK COMPUTER INC.<br>
ASUS Vivobook 18 M1807HA_M1807HA<br>
Board: M1807HA</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: &quot;Calib=
ri&quot;, &quot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);" class=3D"elementToProof">
After applying the patch:</div>
<ul>
<li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof=
" role=3D"presentation">
battery status remains stable</div>
</li><li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof=
" role=3D"presentation">
no more Full/Not charging oscillation while unplugged</div>
</li><li style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin-top: 1em; margin-bottom: 1em;" class=3D"elementToProof=
" role=3D"presentation">
KDE energy profile switching stopped</div>
</li></ul>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: &quot;Calib=
ri&quot;, &quot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);" class=3D"elementToProof">
I used ChatGPT as an auxiliary learning and review tool while understanding=
 the kernel code and preparing the patch, but I reproduced, tested, and ver=
ified the issue and fix myself on real hardware.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: &quot;Calib=
ri&quot;, &quot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);" class=3D"elementToProof">
Thank you for your time and review.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: &quot;Calib=
ri&quot;, &quot;Helvetica&quot;, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);" class=3D"elementToProof">
Best regards,<br>
Norman Becker</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_WA1P291MB0033B3D85FEAC77DFF319741BF0D2WA1P291MB0033POLP_--

--_004_WA1P291MB0033B3D85FEAC77DFF319741BF0D2WA1P291MB0033POLP_
Content-Type: text/x-patch;
	name="0001-ACPI-battery-Add-ASUS-Vivobook-18-M1807HA-status-quirk.patch"
Content-Description:
 0001-ACPI-battery-Add-ASUS-Vivobook-18-M1807HA-status-quirk.patch
Content-Disposition: attachment;
	filename="0001-ACPI-battery-Add-ASUS-Vivobook-18-M1807HA-status-quirk.patch";
	size=3547; creation-date="Sun, 24 May 2026 10:28:21 GMT";
	modification-date="Sun, 24 May 2026 10:39:21 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOb3JtYW4gQmVja2VyIDxyeWxlbm9Ab3V0bG9vay5kZT4KRGF0
ZTogU3VuLCAyNCBNYXkgMjAyNiAxMToyMDowMCArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIEFDUEk6
IGJhdHRlcnk6IEFkZCBBU1VTIFZpdm9ib29rIDE4IE0xODA3SEEgc3RhdHVzIHF1aXJrCgpPbiB0
aGUgQVNVUyBWaXZvYm9vayAxOCBNMTgwN0hBX00xODA3SEEsIHRoZSBBQ1BJIGJhdHRlcnkgY2Fu
IGtlZXAKcmVwb3J0aW5nIEZ1bGwgYXQgMTAwJSBjaGFyZ2UsIG9yIE5vdCBjaGFyZ2luZyBiZWxv
dyBmdWxsIGNoYXJnZSwgYWZ0ZXIKdGhlIEFDIGFkYXB0ZXIgaGFzIGJlZW4gdW5wbHVnZ2VkLgoK
VGhlIEFDIGFkYXB0ZXIgcG93ZXJfc3VwcGx5IEFEUDAgcmVwb3J0cyB0aGUgb2ZmbGluZSBzdGF0
ZSBjb3JyZWN0bHksCndoaWxlIEJBVDAvc3RhdHVzIG9zY2lsbGF0ZXMgYmV0d2VlbiBEaXNjaGFy
Z2luZyBhbmQgRnVsbC9Ob3QgY2hhcmdpbmc6CgogIEFEUDA9MAogIEJBVDA9RnVsbAogIENBUD0x
MDAKCmFuZDoKCiAgQURQMD0wCiAgQkFUMD1Ob3QgY2hhcmdpbmcKICBDQVA9OTgKCkFkZCBhIERN
SS1saW1pdGVkIHF1aXJrIGZvciB0aGlzIHN5c3RlbS4gIFdoZW4gQURQMCBpcyBvZmZsaW5lLCBy
ZXBvcnQKRnVsbCBhbmQgTm90IGNoYXJnaW5nIGJhdHRlcnkgc3RhdGVzIGFzIERpc2NoYXJnaW5n
LiAgQ2hhcmdpbmcgYW5kClVua25vd24gYXJlIGxlZnQgdW5jaGFuZ2VkLgoKVGVzdGVkIG9uIEFT
VVMgVml2b2Jvb2sgMTggTTE4MDdIQV9NMTgwN0hBLgoKU2lnbmVkLW9mZi1ieTogTm9ybWFuIEJl
Y2tlciA8cnlsZW5vQG91dGxvb2suZGU+Ci0tLQogZHJpdmVycy9hY3BpL2JhdHRlcnkuYyB8IDU4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDU4IGluc2VydGlvbnMoKykKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9iYXR0ZXJ5LmMg
Yi9kcml2ZXJzL2FjcGkvYmF0dGVyeS5jCmluZGV4IDAwMDAwMDAwMDAwMC4uMDAwMDAwMDAwMDAw
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvYmF0dGVyeS5jCisrKyBiL2RyaXZlcnMvYWNwaS9i
YXR0ZXJ5LmMKQEAgLTUxLDYgKzUxLDcgQEAKIHN0YXRpYyBpbnQgYmF0dGVyeV9iaXhfYnJva2Vu
X3BhY2thZ2U7CiBzdGF0aWMgaW50IGJhdHRlcnlfbm90aWZpY2F0aW9uX2RlbGF5X21zOwogc3Rh
dGljIGludCBiYXR0ZXJ5X2FjX2lzX2Jyb2tlbjsKK3N0YXRpYyBib29sIGJhdHRlcnlfYXN1c19t
MTgwN2hhX2ZvcmNlX2Rpc2NoYXJnZTsKIHN0YXRpYyB1bnNpZ25lZCBpbnQgY2FjaGVfdGltZSA9
IDEwMDA7CiBtb2R1bGVfcGFyYW0oY2FjaGVfdGltZSwgdWludCwgMDY0NCk7CiBNT0RVTEVfUEFS
TV9ERVNDKGNhY2hlX3RpbWUsICJjYWNoZSB0aW1lIGluIG1pbGxpc2Vjb25kcyIpOwpAQCAtMTk0
LDYgKzE5NSwzNyBAQAogCXJldHVybiBQT1dFUl9TVVBQTFlfU1RBVFVTX0RJU0NIQVJHSU5HOwog
fQogCitzdGF0aWMgYm9vbCBhY3BpX2JhdHRlcnlfYXN1c19tMTgwN2hhX2FjX29mZmxpbmUodm9p
ZCkKK3sKKwlzdHJ1Y3QgcG93ZXJfc3VwcGx5ICpwc3k7CisJdW5pb24gcG93ZXJfc3VwcGx5X3By
b3B2YWwgdmFsOworCWJvb2wgb2ZmbGluZSA9IGZhbHNlOworCisJaWYgKCFiYXR0ZXJ5X2FzdXNf
bTE4MDdoYV9mb3JjZV9kaXNjaGFyZ2UpCisJCXJldHVybiBmYWxzZTsKKworCXBzeSA9IHBvd2Vy
X3N1cHBseV9nZXRfYnlfbmFtZSgiQURQMCIpOworCWlmICghcHN5KQorCQlyZXR1cm4gZmFsc2U7
CisKKwlpZiAoIXBvd2VyX3N1cHBseV9nZXRfcHJvcGVydHkocHN5LCBQT1dFUl9TVVBQTFlfUFJP
UF9PTkxJTkUsICZ2YWwpKQorCQlvZmZsaW5lID0gdmFsLmludHZhbCA9PSAwOworCisJcG93ZXJf
c3VwcGx5X3B1dChwc3kpOworCisJcmV0dXJuIG9mZmxpbmU7Cit9CisKK3N0YXRpYyB2b2lkIGFj
cGlfYmF0dGVyeV9hc3VzX20xODA3aGFfZml4X3N0YXR1cyh1bmlvbiBwb3dlcl9zdXBwbHlfcHJv
cHZhbCAqdmFsKQoreworCWlmICghYWNwaV9iYXR0ZXJ5X2FzdXNfbTE4MDdoYV9hY19vZmZsaW5l
KCkpCisJCXJldHVybjsKKworCWlmICh2YWwtPmludHZhbCA9PSBQT1dFUl9TVVBQTFlfU1RBVFVT
X0ZVTEwgfHwKKwkgICAgdmFsLT5pbnR2YWwgPT0gUE9XRVJfU1VQUExZX1NUQVRVU19OT1RfQ0hB
UkdJTkcpCisJCXZhbC0+aW50dmFsID0gUE9XRVJfU1VQUExZX1NUQVRVU19ESVNDSEFSR0lORzsK
K30KKwogc3RhdGljIGludCBhY3BpX2JhdHRlcnlfZ2V0X3Byb3BlcnR5KHN0cnVjdCBwb3dlcl9z
dXBwbHkgKnBzeSwKIAkJCQkgICAgIGVudW0gcG93ZXJfc3VwcGx5X3Byb3BlcnR5IHBzcCwKIAkJ
CQkgICAgIHVuaW9uIHBvd2VyX3N1cHBseV9wcm9wdmFsICp2YWwpCkBAIC0yMjUsNiArMjU3LDgg
QEAKIAkJCXZhbC0+aW50dmFsID0gUE9XRVJfU1VQUExZX1NUQVRVU19GVUxMOwogCQllbHNlCiAJ
CQl2YWwtPmludHZhbCA9IFBPV0VSX1NVUFBMWV9TVEFUVVNfTk9UX0NIQVJHSU5HOworCisJCWFj
cGlfYmF0dGVyeV9hc3VzX20xODA3aGFfZml4X3N0YXR1cyh2YWwpOwogCQlicmVhazsKIAljYXNl
IFBPV0VSX1NVUFBMWV9QUk9QX1BSRVNFTlQ6CiAJCXZhbC0+aW50dmFsID0gYWNwaV9iYXR0ZXJ5
X3ByZXNlbnQoYmF0dGVyeSk7CkBAIC0xMTQzLDYgKzExNzcsMTMgQEAKIAlyZXR1cm4gMDsKIH0K
IAorc3RhdGljIGludCBfX2luaXQKK2JhdHRlcnlfYXN1c19tMTgwN2hhX2ZvcmNlX2Rpc2NoYXJn
ZV9xdWlyayhjb25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCAqZCkKK3sKKwliYXR0ZXJ5X2FzdXNf
bTE4MDdoYV9mb3JjZV9kaXNjaGFyZ2UgPSB0cnVlOworCXJldHVybiAwOworfQorCiBzdGF0aWMg
Y29uc3Qgc3RydWN0IGRtaV9zeXN0ZW1faWQgYmF0X2RtaV90YWJsZVtdIF9faW5pdGNvbnN0ID0g
ewogCXsKIAkJLyogTkVDIExaNzUwL0xTICovCkBAIC0xMTc5LDYgKzEyMjAsMTkgQEAKIAkJCURN
SV9NQVRDSChETUlfUFJPRFVDVF9OQU1FLCAiU3VyZmFjZSBHbyAzIiksCiAJCX0sCiAJfSwKKwl7
CisJCS8qCisJCSAqIFRoZSBmaXJtd2FyZSByZXBvcnRzIEJBVDAgYXMgRnVsbCBvciBOb3QgY2hh
cmdpbmcgYWZ0ZXIgQUMKKwkJICogaGFzIGJlZW4gdW5wbHVnZ2VkLiAgQURQMCBjb3JyZWN0bHkg
cmVwb3J0cyBvZmZsaW5lLgorCQkgKi8KKwkJLmNhbGxiYWNrID0gYmF0dGVyeV9hc3VzX20xODA3
aGFfZm9yY2VfZGlzY2hhcmdlX3F1aXJrLAorCQkubWF0Y2hlcyA9IHsKKwkJCURNSV9NQVRDSChE
TUlfU1lTX1ZFTkRPUiwgIkFTVVNUZUsgQ09NUFVURVIgSU5DLiIpLAorCQkJRE1JX01BVENIKERN
SV9QUk9EVUNUX05BTUUsICJBU1VTIFZpdm9ib29rIDE4IE0xODA3SEFfTTE4MDdIQSIpLAorCQkJ
RE1JX01BVENIKERNSV9QUk9EVUNUX0ZBTUlMWSwgIkFTVVMgVml2b2Jvb2sgMTgiKSwKKwkJCURN
SV9NQVRDSChETUlfQk9BUkRfTkFNRSwgIk0xODA3SEEiKSwKKwkJfSwKKwl9LAogCXt9LAogfTsK
IAotLSAKMi41MC4wCg==

--_004_WA1P291MB0033B3D85FEAC77DFF319741BF0D2WA1P291MB0033POLP_--
