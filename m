Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19012011.outbound.protection.outlook.com [52.103.32.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3686B175A87;
	Fri,  3 Jul 2026 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783100876; cv=fail; b=TjJmFh0cG7MuZF+GnB+iv52/rp6m0Tozh5NMhV/giFlPCoP1jueHVN1wNWLfFF9jpRRv8ugewpTjBiYcI2nXYaLY79C6QUciW7gXf7ptAE8h8MEgEQ8b/U96EPZh6hCT38Bfc/gVWWzI0ruwzj6+U2o85Kkgosgi3CoKXRoOiDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783100876; c=relaxed/simple;
	bh=r7CDxOIZ2Oi6mS/qzE9aYxjFix6vSAVAtEdn2rdhNv8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HML/WleGriGTg4O6pvBjDWGXdv8YxABFaFm9YOV66U4h2Mki8HfXkr83JQBIRFQLI+e2rV1qtm7wZgZEftsQyRNNgSgT5B+OMy3WgtrpvG+4VKXtYcP8XUAkAy6UspF5y3ECgoW2+9Un4/0JNMP1eKVt8uRF1VpRevcMhYwE2to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de; spf=pass smtp.mailfrom=outlook.de; dkim=fail (0-bit key) header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.b=HVZ4Y9DG reason="key not found in DNS"; arc=fail smtp.client-ip=52.103.32.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=OUTLOOK.DE header.i=@OUTLOOK.DE header.b="HVZ4Y9DG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Es7DW41RGqRDjPPtROjIIK+BYTbo4q3XJa8NCKVVfMidfiH0dwizJl6ZYMvvUa50FMd8YcsYrll1bn8lG7QFDNZRwUvvytlVCcYpD+0Zo9Fw4NjFdr6Jcw/dUlLel6lyW62Q8vXjUMQp/gV/pyEmklCphhdMvFVc3fsNeMbTIhcaoAkR3AJoxEysrqV4Kx5fSESNNE5oJgvH7R7m72PqzI/f4smEvTKxQhFf/wif4GoCaP5EeEJ8+Vb0KqGB1k6IKCLrYD/yhx+KYRLUa2QGzEAuxv+zvFqsUUWguVMCK8WXQBwknDSVzjjJAT8zYNwAKpt2bfKWOmuJlhjIO/xJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7CDxOIZ2Oi6mS/qzE9aYxjFix6vSAVAtEdn2rdhNv8=;
 b=JcaC3KQceDgTIbWIenKCfHbaJAuEDXnaO6hY1IAsrRg376OxlHGX/utV0M9kq58SrabOxt2rockRisv5CUk0pvhLLa4+Xx9tgGUORZ1XeAYoQrd0SwpJQRHYfNoX9MDjxKyg2JHF8LIE5e0D2CLilFbQhQciKXB22T0QWkljc1LuC5nlX3nuUuZVGTTuIDxDdg2PXF3tl5bK1wASrvBptkhd7azJtafbf9kXTMGKeuv9GRgZQGAVPA3G+nVL1lakNY0YO/SKmeOKotYvdInDaTwNkvU+N1r8KecHKXS/zt960Qet/eh3x0YsSrphEuSDvYri0ITDJrBJXmk03wq3CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7CDxOIZ2Oi6mS/qzE9aYxjFix6vSAVAtEdn2rdhNv8=;
 b=HVZ4Y9DGnctFEDUlzPFOPn56BQnM7cM9SxuLKY1LZ4WzUMF8daSYEZL+jnLlavv+mBLZ5hJJUjKPXt0XanxkGQypGGgOnOkzHc0QONBETYgq+iEtaLi4BFGPZpuTtviGCgLZWBqj53sl2z2/p/RQjy4O5D8sspT94yBIe4EZ+0SJ8o0UgrIU7s1WnirlGFnl6uy1nzIww5d9YFePM+DlMdPWyqpAOIQfrdP9qBJOaQWL2WErDglBUP/eeRG0qxL/stmdUVjtnk5VPt7vSnnpqpJAneBqtcjkVVsx/aiGQds6DL2+2pXg1ZTkAossC/f616kc/U0cwDn9nhFfwMP4jA==
Received: from AM9P193MB1588.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:30f::11)
 by PAXP193MB2170.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:22f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 17:47:52 +0000
Received: from AM9P193MB1588.EURP193.PROD.OUTLOOK.COM
 ([fe80::824d:c236:f55b:4ed8]) by AM9P193MB1588.EURP193.PROD.OUTLOOK.COM
 ([fe80::824d:c236:f55b:4ed8%5]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 17:47:52 +0000
From: golne tree <lrepper@outlook.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: ACPI: Suggest revisiting charging detection logic for non-Huawei
 systems
Thread-Topic: ACPI: Suggest revisiting charging detection logic for non-Huawei
 systems
Thread-Index: AQHdCxPlmexCDmq4q027qsLLzP6wIg==
Date: Fri, 3 Jul 2026 17:47:52 +0000
Message-ID:
 <AM9P193MB1588A9F4CDEF58D5F40DFC15D0F42@AM9P193MB1588.EURP193.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9P193MB1588:EE_|PAXP193MB2170:EE_
x-ms-office365-filtering-correlation-id: bdb4d1b7-2aab-44a3-d6a0-08ded92b34a3
x-ms-exchange-slblob-mailprops:
 y6i5DlZWd5thk0O7n0anMu/bnzDflMYaJOiMBbmn3peRsnE0LaT+CsRbhhi0BLZn1JkNs9FqwuBnUgemUeOpLesJ2RheVkrchaJB0ti2eXyAfsQ5FZKISyvcA2XphNuqkBt2R3jswMhI2DgJ1x6Z+Kkd3M9tI8l9FJSrKNkJsX9KkEu38dNhlViBa5LQHMtQNbsxbFfdf6IvIgO0BiE/nEzw1DUJRrhXkF1cKozGMmjDZgHUxqlAxDk/lz5O1ia0i3usZonHGL5qqw9I34lOzPBmn9yJgrDTbTOm5L4BMysYYPSEoRk0kS0tTDARNfDSW5XA5tBswHosmk6QJYf6/jwrNNt2tGeXQdSWQsDjxHGzrCfdZn+r29l1iSKHCx09KfZRGXHUqosstKFAcd0Hh7J1b63BM9Kh576jhOXwFWBJTzc0Q7bhz2ZJ01uDaL6pAsZqXcgXs8COoy4cRfgIESFOI9qFkE+xFPyN2d+etSIsZQk9ay5faX5xDJEUce4/EMH2L/SO2ShyI5ppEyODSict0VlSvMOrKdSkXn96F7cf5paYcCjaHO+JrZb/SscGv54uCBv/0vVqScdVdFJj7VQjxhacpmnEpmXmUE0q+gqRjHgCPDSn1qMrBHaSmNujFnR0+2hDCcvfAe/ISaYB2g==
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799006|31061999003|8040799003|9112599006|8060799015|8062599012|51005399006|2604031081799003|6050399003|19110799012|40105399003|3430499035|3412199025|3420499032|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?/Vkgso2gh/jxYsdkps99xGV8iVYaoYeVsoVxNPN96d7m99PmrqSSDl7J57?=
 =?iso-8859-1?Q?2420y+ZTtTuWkJ0ExlGExELPk9OnW0+TbH3jNU5A6FYi8fDL9rxgAHA4PY?=
 =?iso-8859-1?Q?uTm1n6qbtHJVN7KrUiB5vk4ZrTVt++s0LMPwtDV77nllvbNEab7e9vdDLM?=
 =?iso-8859-1?Q?IQ4Hz/gSw8A8T4TRMMPYAmcFYtehDk5/aC2aCDlmQHO+2yhPOhPkDbqn5k?=
 =?iso-8859-1?Q?+XprLR+W9KXVbtqMajbgNCGeOSv/CzLB3z64+zQ6jAvqcWkAOm4L/PU1++?=
 =?iso-8859-1?Q?tuTLKzV8/LLzbtHD9LTyOsMtSv7OwSduuTcWZQ8wfgzoSPvRDZpBfob3uO?=
 =?iso-8859-1?Q?CbDUhjnD23o00VyEO1KjP+jpE4ZqHs6RTtJvshMn8+l4U2kX/z67v4sa1c?=
 =?iso-8859-1?Q?sPse/DnMXWzm+JIu1GlG0F7ZVOLC2pDHV3hUhHhC6ajpXr4FPX9xG12NGa?=
 =?iso-8859-1?Q?UZVVht65xSirUetlwtgSc4wPaJMv3EEuMaU6mmr/+u+n4d7HbxclD3VJHe?=
 =?iso-8859-1?Q?flfmUnr0j//Q3vt0KPOTObmeHitwumojEdoYLuW8I+CFXM4UTNVg2Nzy1a?=
 =?iso-8859-1?Q?lhsWf8s771U2oYn45YaeRmE4rm9PjalZcXTubhHAJbnlu254iTLfMqc8sE?=
 =?iso-8859-1?Q?s5eEQa+j7FmxYZBmx/7P/QlO2FX3cb7kcou/lZpeGl+fg0L+iLh+HdyS8u?=
 =?iso-8859-1?Q?0BvO2CEORPprmQsY7ehopLlENvXGuzDWyS3JD1mpHkbmpNGMwjXMLtF1pJ?=
 =?iso-8859-1?Q?BXLgDTrOrGpKfj1deqtP2r+twRN4gsNNfPWLx7XNzZyQrsqbE1D+dbHnrN?=
 =?iso-8859-1?Q?5+6NUrx3YykYihJjz7EucjsvjYStuSe5mlJdgfn2LNfj/QN6ZE98IkXxmQ?=
 =?iso-8859-1?Q?5tfTagexwjp3vwn0gpzuk2xt9esR6oSN5dVIGpwzBOyO/hI5Cane9JOC7O?=
 =?iso-8859-1?Q?vokXaTp9/WIfLVQRairAd553awe+MwUhfhY+bAGG2SAFuJP0e7J9JnZc70?=
 =?iso-8859-1?Q?KTKlIUNXcUNMVsGpXqtDyxzLvP+yhReq98Z7tUMhHi4wt9mDcjPWcAUv/U?=
 =?iso-8859-1?Q?VQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?x5YHdS8rFXqudj3lwK25qk8WyZlurrJ6Jq4E3yp6aR/6qXi5LLowNBGJ3M?=
 =?iso-8859-1?Q?fer2HM6Pbra9i3Japz659ec+6pqL7HgvqAXIORtQzF34zmfUrhQ+cXWy6x?=
 =?iso-8859-1?Q?H/fEY+i7vdQ6p7cZkNq8SULsuv+nuUkN2Mue7WsRGQV4kay/6XEEX7KTpI?=
 =?iso-8859-1?Q?EaTpi/EMuN4TL4QWJnU6a/amvfWIraz3JA3Ci6LExad2Y/kgpKiUsyENA/?=
 =?iso-8859-1?Q?cgU9/sDCWAj4sKkxiKW9xzTLPZx6sV1Gui77+sareKJgiG/eEgjele4xyb?=
 =?iso-8859-1?Q?h9tAsVxJ/CmVyQmObmZUlj1YcDVzJ3DZEPCUwtlgw2DHRaJwGzBs8x6vd8?=
 =?iso-8859-1?Q?0/i9Sv1kOck4dz+XxmGWNd1ZCLeSHw0/AQ9kiWTUARmlNY5QZo9ipungsV?=
 =?iso-8859-1?Q?kH8mRk7K8MzwfIwsI3RzTiO8BDuz8UGoXw3t2DiTp6y1FrvegcAZN9WK9k?=
 =?iso-8859-1?Q?1dO9Dl7AMw8HPwTugvDXEMl++aVEZxtMLgNKxxskwbKyPmnsN3QU8KQQ2X?=
 =?iso-8859-1?Q?5RW1AmWH6m68XTvOWXdzOGOs5Bt+GfWtsBTi8cdFsmVYJgr3iwTKxzIdis?=
 =?iso-8859-1?Q?bbMmbvvarF5HIYTjwKK4neh+XIqsbFflnoU+OJrq7ivokRH6MZ5h7ZHqbp?=
 =?iso-8859-1?Q?oZ3bAXDj4beiu4CneVRm3fwtIn0qxgHEugj1PeXgdjZFxCwq5jmvu4Vrky?=
 =?iso-8859-1?Q?tNko1ghLo8oefWXntfe5fvfY8+D5oYWfDFHe+Fzxa4kx9UTVCm7GK31nVI?=
 =?iso-8859-1?Q?uOm/AJUzyD7feYNi8wby27CrMMMc0GBooHhwxyujcuPNPPuOiXI8AGD7uI?=
 =?iso-8859-1?Q?UzX5+HurBNJV+QMsfdOPQLcVBSBxHNfARFaX+D+oyrhFHUC/H32+IIMLSG?=
 =?iso-8859-1?Q?6fOMEifERpHxd62qRX46FJF/yew9VGefYuK3iM81bf51ixZu6d3YwgzxhL?=
 =?iso-8859-1?Q?rAHq1Lw9dwqkikMQF93gvrT8mWMoiEPkm+XwhfyiechY6aECZwCAFmkydd?=
 =?iso-8859-1?Q?2EjEnlb6yREkhCzBSO4yIx7XGCiQzBn88RKdjYhWmiJTS1Hm+RrhWAME+y?=
 =?iso-8859-1?Q?NIInSnjuGme0709UdyF3QbYiU20IuDOBxmXKqMigtCYiUOR2Tc1QM9aM9K?=
 =?iso-8859-1?Q?HXPtSrTKWgrS53jcYTQ6CJ05gOtuUb/1CbD4X9QU0jB6OQt1Sq4Uy9KzNr?=
 =?iso-8859-1?Q?5bYgckm77sn3JCcMekLjgh3AphiUu8Sr19yerTXGapORCL3tNM+3g3UbpE?=
 =?iso-8859-1?Q?3p//6NN9CS/s0zphZ6D4Qm23Og8F8XJQfNMp0wLU/fyzHNFkufxlu6hDhr?=
 =?iso-8859-1?Q?y25opNAZD1RM6AnjR/Xospg7vC5X8h6CTx0SBU1EzKKAEeMD3HVYc09pWk?=
 =?iso-8859-1?Q?ZkQExC6eZ76S6dLDJbonOl4B5S490zmgaXvuk9VYxOgAjAIkdo4hC9Igx9?=
 =?iso-8859-1?Q?56uWiom+3mNczsbvqAD9wpR80ds11NoS2Go1X2VoTWHC2+A11gbztzf9/m?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb4d1b7-2aab-44a3-d6a0-08ded92b34a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 17:47:52.3140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2170

Dear ACPI Maintainer,=0A=
I would like to suggest changing the charging detection logic.=0A=
For=0A=
 most devices, I believe the kernel should trust the firmware-reported =0A=
charging state. In other words, whenever the firmware reports charging, the=
 battery should be considered charging.=0A=
The=0A=
 Huawei-specific behavior should remain an exception. For Huawei =0A=
systems, the existing logic could continue to apply: only report the =0A=
battery as charging when the firmware reports both charging=A0and a valid p=
ower value (watts).=0A=
This would preserve the Huawei workaround while avoiding incorrect behavior=
 on other devices whose firmware reports charging=A0but an invalid or unava=
ilable power value.=0A=
My system is an example of a device affected by this bug.=
