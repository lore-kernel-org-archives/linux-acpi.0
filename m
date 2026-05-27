Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD339B48D;
	Wed, 27 May 2026 06:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863994; cv=none; b=hZK1ClSP3k1qFoeitxcu31ksbvnR5RntwUnEA64iWRA5VaYzpcUtTJqODpwP10c1aJMpNI1IliIIXViCMKYVHFduTNyhyO8S/gp3ruuSQeuQiG9mhPulfcnoNjEmoqOGMke4ed5T6wmi6KGYuf6oItI3bFk62cHYPWWXILlXA2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863994; c=relaxed/simple;
	bh=UAZ+U+B/rXjDOCV9A2itjO5ZJ83QoPpuhidEhyjII+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GuxnyjaBQe28JBWMqWVkZ0AWCTDxkBe5IZD97gjNm1UeK4ceKxLZ8QbXj9H7aBDwXwjWO/s89lf1m1MiZ3CGaYc6UbOvWb3yAotmwV13N4IlkN70cJJKMa87dKSfy4Za7I+XmDk23Kg4yGI5D4qpfA7+vv4loWUMPg1Ife+VrrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ra6XKr8T; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ra6XKr8T"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64R6aIUO12251887, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779863778; bh=UAZ+U+B/rXjDOCV9A2itjO5ZJ83QoPpuhidEhyjII+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ra6XKr8TYsUZuidTGpQ/j1/jXu3c1qT8saLXkvqjAOirYIRdiWHQjbPzpp0uPGsJ7
	 yE3vc9xYLzU/uAWmqz7O1FN/6zPmizqM007SqquLBlfZHmBRmYJKRJPxnWS4TL8Y8G
	 gVh3nmvLbxT7vSrjXeX8kEw4oMwdVjAi9mULcUwBNyDCxvnG8ZLrGAXZi9g9tELdKY
	 iu/lCGcZt6YdPYjwito53E/uK8VnyIgayD6LAUjaY6jcgO+llH3LWMdpyX66Eh+83x
	 1Z+oWf9jGwSKrUOIvQqjBL7qyfsnh+HzVACSgr+Cn6+rwkgIL7klS1P+64CTyb2FAe
	 mKQJnPhiMnWgg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64R6aIUO12251887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 14:36:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 May 2026 14:36:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Wed, 27 May 2026 14:36:18 +0800
From: =?utf-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
To: Marc Zyngier <maz@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Daniel
 Lezcano" <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Ge Gordon <gordon.ge@bst.ai>, "BST
 Linux Kernel Upstream Group" <bst-upstream@bstai.top>, Jesper Nilsson
	<jesper.nilsson@axis.com>, Lars Persson <lars.persson@axis.com>, Alim Akhtar
	<alim.akhtar@samsung.com>, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Thierry Reding
	<thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, "Bjorn
 Andersson" <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
	=?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, Heiko Stuebner
	<heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, Orson Zhai
	<orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Michal
 Simek" <michal.simek@amd.com>
Subject: RE: [PATCH v3 14/17] arm64: dts: realtek: Add EL2 virtual timer
 interrupt
Thread-Topic: [PATCH v3 14/17] arm64: dts: realtek: Add EL2 virtual timer
 interrupt
Thread-Index: AQHc6rzgHarUxBjaREiSomlba5RzH7Yhb6AQ
Date: Wed, 27 May 2026 06:36:18 +0000
Message-ID: <6fe3e828f8724424bc6aef818ae0aa0f@realtek.com>
References: <20260523140242.586031-1-maz@kernel.org>
 <20260523140242.586031-15-maz@kernel.org>
In-Reply-To: <20260523140242.586031-15-maz@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBTdWJqZWN0OiBbUEFUQ0ggdjMgMTQvMTddIGFybTY0OiBkdHM6IHJlYWx0ZWs6IEFkZCBFTDIg
dmlydHVhbCB0aW1lciBpbnRlcnJ1cHQNCj4gDQo+IFRoZSBBUk12OC4yIGJhc2VkIENQVXMgdXNl
ZCBpbiBhIG51bWJlciBvZiBSZWFsdGVrIFNvQ3MgYXJlIG1pc3NpbmcgdGhlDQo+IEVMMiB2aXJ0
dWFsIHRpbWVyIGludGVycnVwdC4gQWRkIGl0Lg0KPiANCj4gRnVydGhlcm1vcmUsIHRoZSAia2Vu
dCIgcGxhdGZvcm0gYXBwZWFycyB0byBhc3NpZ24gUFBJOSB0byBib3RoIHRoZQ0KPiBFTDIgdmly
dHVhbCB0aW1lciBhbmQgdGhlIEdJQyBNYWludGVuYW5jZSBJbnRlcnJ1cHQsIHdoaWNoIGNhbid0
IGJlIHJpZ2h0Lg0KPiBBdHRlbXB0IGEgZml4IGJ5IHNldHRpbmcgdGhlIGZvcm1lciB0byBQUEkx
MiwgYXMgUFBJOSBpcyB0cmFkaXRpb25hbGx5IHdpcmVkIHRvDQo+IHRoZSBHSUMgaXRzZWxmLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4NCj4gLS0t
DQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlYWx0ZWsva2VudC5kdHNpICAgIHwgMiArLQ0KPiAg
YXJjaC9hcm02NC9ib290L2R0cy9yZWFsdGVrL3J0ZDE2eHguZHRzaSB8IDMgKystDQo+ICAyIGZp
bGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlYWx0ZWsva2VudC5kdHNpDQo+IGIvYXJjaC9h
cm02NC9ib290L2R0cy9yZWFsdGVrL2tlbnQuZHRzaQ0KPiBpbmRleCBhZTAwNmNlMjQ0MjA1Li40
MTQ3ZTQyNjkyNDdhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlYWx0ZWsv
a2VudC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVhbHRlay9rZW50LmR0c2kN
Cj4gQEAgLTIzLDcgKzIzLDcgQEAgdGltZXIgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDxHSUNfUFBJIDE0IElSUV9UWVBFX0xFVkVMX0xPVz4sDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgPEdJQ19QUEkgMTEgSVJRX1RZUEVfTEVWRUxfTE9XPiwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA8R0lDX1BQSSAxMCBJUlFfVFlQRV9MRVZFTF9MT1c+LA0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxHSUNfUFBJICA5IElSUV9UWVBFX0xFVkVMX0hJ
R0g+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxHSUNfUFBJIDEyIElSUV9UWVBF
X0xFVkVMX0hJR0g+Ow0KDQpUaGFua3MgZm9yIHRoaXMgcGF0Y2guIEhvd2V2ZXIsIHRoZSA1dGgg
aW50ZXJydXB0IHNob3VsZCBiZQ0KDQo8R0lDX1BQSSAxMiBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0K
DQpJZiB5b3UgYXJlIG9rIHdpdGggaXQsIEkgd2lsbCBhbWVuZCBpdCB3aGVuIGFwcGx5aW5nLg0K
DQpCZXN0IHJlZ2FyZHMsDQpZdS1DaHVuDQo+ICAgICAgICAgfTsNCj4gDQo+ICAgICAgICAgY3B1
cyB7DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlYWx0ZWsvcnRkMTZ4eC5k
dHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9yZWFsdGVrL3J0ZDE2eHguZHRzaQ0KPiBpbmRl
eCAzYTdmNmUzNWI3Zjc0Li40M2IxM2QxMzNjMzI0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL3JlYWx0ZWsvcnRkMTZ4eC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvcmVhbHRlay9ydGQxNnh4LmR0c2kNCj4gQEAgLTEwNSw3ICsxMDUsOCBAQCB0aW1lciB7DQo+
ICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19QUEkgMTMgSVJRX1RZUEVfTEVWRUxf
TE9XPiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8R0lDX1BQSSAxNCBJUlFfVFlQ
RV9MRVZFTF9MT1c+LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDxHSUNfUFBJIDEx
IElSUV9UWVBFX0xFVkVMX0xPVz4sDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgPEdJ
Q19QUEkgMTAgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA8R0lDX1BQSSAxMCBJUlFfVFlQRV9MRVZFTF9MT1c+LA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDxHSUNfUFBJIDEyIElSUV9UWVBFX0xFVkVMX0xPVz47DQo+ICAgICAgICAg
fTsNCj4gDQo+ICAgICAgICAgYXJtX3BtdTogcG11IHsNCj4gLS0NCj4gMi40Ny4zDQoNCg==
