Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793806714;
	b=gUEzQ8i7wD5FpqTA8pNeuQni5RqdhfQH94vi4UZLKTrJVDGpII7bp6dAZFfHxMp7Nl7S
	 rEXJGi/fEYmd29wjOo+sY45JQQG1JNYwDaVubaX8GFQpzTtaIujo1iI0TwDrBQmvr8EZ6
	 i/3Gu53kxtgikEU0h0HDI1qnIKwF3UmNmTmqy8d7TC8V/SBvQ65YMPnbQulx6BvM6hlwR
	 q88AUY6nuhL4HLXstyxoeavM0LxfTsG4h9CoFO8lVZD0HrxQc7jLTLpAn/5+C2b1CMWGL
	 Rhb7ln8Q39eWTcAPtYT4reG8dC/Izf5RQA0lZmdpDo5uOnRg+2gj2gFYL793dQAhEqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806714;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Ewv+bqJGqImWxBCeeGsH4x8d1UsFsOuYV62QBeDBeqU=;
	b=Xsd2MSPnaUKimqqlit4Aw4gXlyQyXZHRy9zR9+PbgW9rTGVVzv+PBN/NdR/7XD8w0oPK
	 Rwkj24embd1A9h3TIgHMslQXyi/hoDazBUmgS8P3zPtCtEcacKBbcpZBYcJ+qG0FPcG66
	 E3cmknEKsc3ungAQmn1+hRDbvAxZBxHStNXLwHBP8kw/+mSzMxhSbOJN6IFdcnGAKNFih
	 QXBfJRHLHzmjwfKfrpjfeq+sUU3aUMlB4RCddkG/eo6q5040XzESt4Qr0ostmERzGhZbg
	 7AWbZYGwX1TlUmJ2dOeMBGtLcWc05zLXL6oZ2bh7DtRJtvFwSuJgMdxUeQ5nF8S2+YQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="Q/ITB/4V";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.47
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73082606D833;
	Wed,  4 Nov 2026 15:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73082606D833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Q/ITB/4V
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEVnTLse7TPPiDSKbjTdB7HtZtLPECbY2ra37oRGlWsxGuILbXVuspYNPpfWajognTLtRPovuaAMMABXn7Zvp5BnJGi8c5iMWa2jD7Wt+nJIBy6gOYYHcID8lR9pPExhPrlAta/w3kKejHnYxo137GnLeTdiTrqA/ZbEGyXcb1G1kp1DJnlkRtKJDkvb/2edFOVUomAuKoznjD2ozo9l2t4J9FhV3xWRPjvLGbgDkfZ/qh9hyBqmD4AAVRMi8/idRJsJMAVTPQRf1VMW7kfnCg14I2UTed9ns4gGRf/Wkh+W/jORMaIsLyCZp+bh8vpr9QgyJlmZCZHwv28m8m6L3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ewv+bqJGqImWxBCeeGsH4x8d1UsFsOuYV62QBeDBeqU=;
 b=ohbzKU4dA+FX5sC6Ie9HJ5wEggAx2n8BeDHj4I2FIRDgirNy93gqUfytek7BddkT7jIjKtdTuNpWkpKcnc8YHszQ6NOt9+9eWt0wLwyag3Lodt9O0vvjghFz3lrSOkTIykqYGhPBuLLGdaNYTTpXiXOH+Tb+58BztcX05Tr1dAdYzCTeGBa11oVDMjZ17NgNUJyPgui/5sEDtexbUU8+/Iwf8DXAAwu2bQgbD6im45rn0wO6R50m/kMB3OiNl/VRpaFqm75B4lRkbi3Q06da82HRCMWPelI4GCZsAZtpw1YZXSrv7Y+78mHfEhjwMZsIAA3RYWJijdzJpxQrH+GCOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ewv+bqJGqImWxBCeeGsH4x8d1UsFsOuYV62QBeDBeqU=;
 b=Q/ITB/4VB3ujU1lcKA+U7e7iZYUAuQwPca/WCCFcahvfqe2fGMo3U4f1aviwVQVzA7HJX1Yqv62ddis1tGFnu3PZrNQgolYItdIOVMHR6qYH5HCahjTDU0bbe7nO1CnOEM+96mGZCl/QXX+MT5imseQnaEk2CY1lTuY5k1ATLrsVgpBrxtHBi1pMXHvEopGyGT0wp4uyELxhFaHtx5TPli1i6PgHCth7APGDAGHCOXLXgnPOpHZLfzX3Qs2rx+2m1O3kvVt61YAWwO/Gpx2967xUTKhqMNdGR68RVvUs3xDcUm8N0ceMqa017OvVl8gseSm/NbiK3zoXIK/hToLykg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DBBPR04MB7564.eurprd04.prod.outlook.com (2603:10a6:10:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:38:29 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:38:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/4] software node: fix lookup of swnode in release path
Date: Wed, 04 Nov 2026 23:43:12 +0800
Message-Id: <20261104-swnode-race-v1-v1-0-9406a67e25be@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJBS62oC/yXMQQ5EQBBA0atIrVWiO0xwFbGguoyyaNKFmUTcX
 WP5Fv8foByEFerkgMC7qMw+wqQJ0Nj5L6O4aLCZ/RiT5ag/PzvG0BHjbrCvBuuIqiKnEmK0BB7
 k/wyb9rVu/cS03hc4zwsTa7VucgAAAA==
X-Change-ID: 20261104-swnode-race-v1-b9f2dcc954c8
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DBBPR04MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a03e3d-7d69-4c76-c433-08df3a89ac78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|6133799003|10067099003|18002099003|56012099006|11063799006|261022075727099003|261022105027099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	SgAtjMBZUYTGhtDzeTB85njazmOCe28gD9XbzozxoJkEaiYlT0JMJ1vlesBVjZpPbhil68xPvZKwRrpSCUi9VTd3vMVUicCjBhUerrPBbEkZfJQTo/BJ/rqbhl65WxA7i8t7EqE20WjvSnkc1CRKk+YS4GAyNpann2Nee7f8O2K3nuWu+vc0pvKFF4u9+t60ip9sew4AGnZMfp7vtATXIsav70FE+B5lpFgDieJdOl3cW8cKbg4STNhEvXbHIrWyzgjG2q4PjHKTdnQCyBbJESSrDULH+NoEZZrQjvdBGyOIYg9BYW+19XWKSvg2ILI8MVjh1YPjfCGPJUMqPnwlZm+v5Yuf0/3867u86svB/iBu9OHyNA7NCU9Ade8nMXKnZN/d344ZWubPUf4kWQ+SfvbJrdt3wO2ktR6UyRhijEPlH6Orb+KPvwWHospoQC5QtYIyfntQZ5BK55rSOLk4z3+f3HgeVWvm7A/vl7pS4uxPFE3BWDv8A5y0jhxDIRN6hGK3SJ/7JWUDzTs06o3wTLgSB6toVbAowXnGvzuRCNCXuMcgzEyfatGjgHMMVeZ8x556tGU8HIhc7VIFxdNBxgs1ZNObuwWQBHxYGLlzuNfPfl3NJZU918XeKy0wcIz4+x8N4WmX+zBsSX+gzaIeNPF+ip4Hb8U1PtqfOV4/nik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(56012099006)(11063799006)(261022075727099003)(261022105027099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFFxU1ZmU1MxdW9tbVJHOTFzZGplUXp4bVJSSkFONnVFQWkwOWp5VjhidjMz?=
 =?utf-8?B?VEhWNHZqSXhoSnI1SlArTmxSc0JlYTBWSW5vK2daejliMUsyQjFSV0FXTWYx?=
 =?utf-8?B?aUxNQ0RaeVFqeGJiZ3ZNR3FUUTZMNzFZOWNqb0hSMWJWdGJrbmdaYjZPMWF0?=
 =?utf-8?B?VXBmUEVsQW51eGpMUzltSTVyVDVzdlFvZkR5Q3p6N3lXaFNnZDFqYkJhZGNq?=
 =?utf-8?B?b2JoMXZKVEcrKzd1ZGlFZ3hDWnNVUWVKMU9sOURkS2pHeHpzRkE0dWZ2czcv?=
 =?utf-8?B?YkNNQjcyWm9kbzZQS0JSTlZ1aHZwblFLVHVmTlZ1UGQ1N1VSY1Q4eWIyZUV1?=
 =?utf-8?B?SzBsVVp3RnNzd25iSmlQNloyTjFWMjVuUFdJRVZ5VXVicFU1V29YTHpKdGhG?=
 =?utf-8?B?QzRFNmdXd0dYeEovN2dpeTVKNGVHMWJtajhHVXRlN2lvQlB1R3hoYW5PN21s?=
 =?utf-8?B?cmhDS1h1QjlWdW91K0JubW80SVl5VXhwWXZpMHZxVnAyYytVUXdLRElNSUM4?=
 =?utf-8?B?bEdKbmo5SXByakpneU9mV0M4NFhyazgvTFFnYWlCcWZTOTN3TG5YR0dycVk0?=
 =?utf-8?B?b29kbG16ZE5qMkRDYmpnVVEyamt3bkRBaDU5S0xCRkthVkR1aVBabzhzMjAy?=
 =?utf-8?B?V2YrOE5wWDdrYzBKWW1DbFBMdG91UE1TcUkxaXNBZitmcGZUSkVtL1FzTUFX?=
 =?utf-8?B?SE1CQTRlSEUyL25HcG8ybWVmOTlRYXlyWVBZdWVqNFUyWkliUUo2Nk5tSS9H?=
 =?utf-8?B?QkpJSTJlREpCKzB3aEJmN1NidUdla1FJbHdHdGtOak16ZGxNZ1ptdW05bVZz?=
 =?utf-8?B?VmtRLzkwR0RxUTdVM2dJeUh0UjV6aktCSWRDVjZjMEtxVWpUMW5ON2I2N3k5?=
 =?utf-8?B?KzZyajJTSCtjVU0xK2IrUWluMUU4MTJkTzNtUHoyS3dQc3ROOGJWMWVPQ3Vv?=
 =?utf-8?B?RWJ4RXgxZ2RWSlNuNTNGTlFJeWJuRVJVWFB4N2dRWXFXVG9MU3FaRDNYUkNR?=
 =?utf-8?B?bVNrTWJhQWc3c29kSWVHcGVENDdkS1JUT0s4WUZhR2Q4N21SQmRVT2lFL2tj?=
 =?utf-8?B?bjZpa0F6VXoveTd4dDVmRGtZcVNHTjkyczFkcUtCcFNuUUJQZ21ZcERFb3BF?=
 =?utf-8?B?eW9XVCtkeTYzcTF6eW9yY0hOSkFvdnVhRW0yNlEzS2YrZ1NlWnQzUllKdit2?=
 =?utf-8?B?c0VCei9TRjR3VkpJMjZPOGlrc3dVbUR2THRnUldJUDBNRmJZeDZTcE9CN0ZD?=
 =?utf-8?B?eS9HREl6OHhxTjRRNUFJRGhWdmthTGRyVDFOS1MwczVyQVlTTnVKSHBGUjdV?=
 =?utf-8?B?VU1TejBLYXhCU1JycDRtSlpaY29UaWtoOHAzdlpiWXNnQkVxd2tPdWpIOVdT?=
 =?utf-8?B?T3ZpRGVnN25aQ2srR3o3ZXQ1VVl6MW5NNU43RmhlQjBQdTB5ak1FaHRrUjg2?=
 =?utf-8?B?UFNvNTFwV2l2RXBjSkdkcklFT1ExbEFyS2F2eW1oakVpT0xNb1hDNi9FelNS?=
 =?utf-8?B?WVdJMktmcmwrSFhJRCtIUVZLcjB2UXJFekZJUi9KUlBnbC9BSmhodExKSUpL?=
 =?utf-8?B?Tm1NYmVnMm91a1NqR1VKZXBWQTdUZmVyeEFleVo5bTBya2p0c3phOVF6eUkv?=
 =?utf-8?B?bS9jeDIxQVhHdXdVSVJoSlY2WVB2NXZEZVljQmxETi9OWnQwQ2Qwc04xUlhu?=
 =?utf-8?B?bVc4WWs4WUNsS1M0cTVkb1ZiM0haZC9kY0kza2RobGZKTVBid2ZWLzBjRHNC?=
 =?utf-8?B?d3BKM1doRzNOK0M2M0dvVmRaWEwweFdRYS9ncDNEZlRuclVLMm5lZHVYaTlN?=
 =?utf-8?B?Q2pLTjVpN3hrZy91b3lISWc1OUV0TnN5MU5SdndSOWFmbnhIR2orQ1ZjeUMz?=
 =?utf-8?B?MTBoNlByV2hrYS9VbmlUUDAxUlN2ZlpzRENQRm1iUGJaTHJsemMzKzNwZ3RF?=
 =?utf-8?B?Skk1OUJRNng2RUIwamRUN3hNUlNDdGhQR0hUY2VWUTFLSXZsb0l6YmdnZmxD?=
 =?utf-8?B?NzZlNXZzU2RiRURZQUFuaGVyN0NqQkU2QjRCclhSWmsvWi94ZWNqRXJ4dmVl?=
 =?utf-8?B?MkVUc2JwVXB4OUlZUGFQVGJLYmthdXh4cnR2OG5vOE9Hc1M1ZU5WVURGLzJx?=
 =?utf-8?B?ZFU3VDVoalRwem92YytkcHpRbmVSQ1UxOGlPZExvdDV0aVRJOWRzSVc4K0gv?=
 =?utf-8?B?UHI1eFJoNlNhSXZHQnVEMVNtWlA5eDk0a0dPMjlGSFpKMGQxS05pYkswbldR?=
 =?utf-8?B?N1FZYndWcVNuazZ2MzBQUnlJYjFJVHRRVmo0ODRkeDFFaWQ1SUVPUzZZcVdJ?=
 =?utf-8?B?S1dhcDFpVXd0QnJNcGhKdXk5MzdXM3lTZEZtYmlhcXBkTHZ0c2xHSUFyR2hO?=
 =?utf-8?Q?yU2vBjCN5icVKUI13NDjUQH6mPFC7JkO/+lKP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a03e3d-7d69-4c76-c433-08df3a89ac78
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:38:28.9946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRUk3sZK6HE5VzaR7ZYvdjM3Af2c28KD+1k4GKIVG9wYJ2oXyTOrotYV5zytU74npS3pSaD3yMyPBcokH7yQKZV3L5Xwp7v306WANL2G+Kp3cUIEBP1e/aj5jJqomW2W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7564

This series fixes a software node lifetime bug where a lookup can find an
swnode whose kobject refcount has already reached zero.

The kset list keeps an swnode linked until kobject_cleanup() calls
kobj_kset_leave(), which happens after the last kobject_put() has already
dropped the refcount to zero. A lookup that does not check whether the
object is still referenceable can therefore call kobject_get() on a dead
object, triggering:

  refcount_t: addition on 0; use-after-free
  refcount_t: saturated; leaking memory
  refcount_t: underflow; use-after-free

The problem is easily reproduced on i.MX95 with dwc3-imx when
dwc3_core_probe() returns -EPROBE_DEFER. dwc3_imx_probe() removes its
static software node from the device and the deferred probe retry
immediately adds the same node again. With
CONFIG_DEBUG_KOBJECT_RELEASE the old swnode stays on the kset list for
some time after its refcount reaches zero, so the retry reliably finds
it.

The first patch fixes the pointer-based kset lookup by using
kobject_get_unless_zero() and skipping entries that are already in their
release path. It also makes registration return the newly created swnode
reference so that device_add_software_node() does not have to look the
node up again after registering it. Reference-owning callers get a
reference from the lookup, while software_node_fwnode() keeps its
borrowed-pointer semantics by dropping the temporary lookup reference.

The remaining patches harden related weak lookups for the same class of
problem. The series is organized as follows:

  1. Fix the pointer-based kset lookup and avoid the second lookup after
     registration.
  2. Harden software_node_find_by_name() against dying entries.
  3. Check the result of software_node_fwnode() in the graph
     remote-endpoint path.
  4. Skip dying children when walking the parent's children list.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (4):
      software node: do not resurrect swnode being released
      software node: use kobject_get_unless_zero() in software_node_find_by_name()
      software node: handle missing remote endpoint node
      software node: skip dying children during traversal

 drivers/base/swnode.c | 143 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 100 insertions(+), 43 deletions(-)
---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
change-id: 20261104-swnode-race-v1-b9f2dcc954c8

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

