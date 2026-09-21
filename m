Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC281ACD;
	Mon, 21 Sep 2026 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789954073; cv=none; b=ftLiAPxT/cuRNF7YH+fYZ9IvxU7Aol/257T+K/B2iAfFGOGgw2ZOxrvHe/8vPaiLXUDZK3u0SqpAhUfCbfPSUUnDjB4S/rVUw+BbslhqVJLe0XWmvBHs5cK7ydsjUm86/1VCv0AZaID3Nixx90cSZ2xaJd2qKGruOMXvaxLRGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789954073; c=relaxed/simple;
	bh=SXl5V4pIsOhS+3Wt9MkFa+DHhxLA7Jcq8jKcpxgMrDY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UX4EZ1aZXlrO3dcyC7g39o+4oozP42hG0+3fj3xp5dN5QIvm62Iad+pxdhAlnlpqPfALazC2eyArIiBgNk0SC8WssmBM7dr+lTszQfVWCxPRFGvbILU8yqmemiBqgtCA4c6c/rdETh8xCVVQW4w0sNp4IfcNLOzBfRzz7llLTac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kLMUxbru; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kLMUxbru"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SXl5V4pIsOhS+3Wt9MkFa+DHhxLA7Jcq8jKcpxgMrDY=;
	b=kLMUxbruBd7IPk5l8bYoDuH0k+3OiioKXbP9nd6BxZSd2VWa3GhjqziC9xHEGagCOmE7Tx6eH
	2QPc93F0b2KQGrT/ubN8l4pGwW5uNNl6T8YcI7IdXMCgJpGJbKbsYr7Hqo5KjWW0RVnb+9oi6dD
	RWVsnWMyM05mhsSLr+zqA2I=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hp4zx3Chvz1T4Fq;
	Mon, 21 Sep 2026 09:15:57 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 788B240561;
	Mon, 21 Sep 2026 09:27:45 +0800 (CST)
Received: from kwepemf100015.china.huawei.com (7.202.181.14) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 21 Sep 2026 09:27:45 +0800
Received: from kwepemf100015.china.huawei.com ([7.202.181.14]) by
 kwepemf100015.china.huawei.com ([7.202.181.14]) with mapi id 15.02.2562.045;
 Mon, 21 Sep 2026 09:27:45 +0800
From: "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com>
To: "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, "ardb@kernel.org"
	<ardb@kernel.org>, "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "jic23@kernel.org"
	<jic23@kernel.org>, "jason@os.amperecomputing.com"
	<jason@os.amperecomputing.com>, "danielf@os.amperecomputing.com"
	<danielf@os.amperecomputing.com>, luoshengwei <luoshengwei@huawei.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "yangzhuohao (A)" <yangzhuohao1@huawei.com>, douzhaolei
	<douzhaolei@huawei.com>, zouyipeng <zouyipeng@huawei.com>, Wangbing
	<wangbing6@huawei.com>, Nixiaoming <nixiaoming@huawei.com>, "ACPI Devel
 Maling List" <linux-acpi@vger.kernel.org>, "Liuwenliang (Abbott Liu)"
	<liuwenliang@huawei.com>
Subject: Re: [PATCH v4 2/3] RAS: Fix out-of-bounds read when tracing arm_event
Thread-Topic: [PATCH v4 2/3] RAS: Fix out-of-bounds read when tracing
 arm_event
Thread-Index: Ad1JaF2+cHTM7sAYSUqrERfvzztfPw==
Date: Mon, 21 Sep 2026 01:27:45 +0000
Message-ID: <a5d1d20b5f2642429aa89f01a614f531@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgSGFuanVuLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuDQoNCk9uIDIwMjYvOS8xNyAx
MDoxNCwgSGFuanVuIEd1byB3cm90ZToNCj4gT24gMjAyNi85LzkgMTk6MjgsIEFiYm90dCBMaXUg
d3JvdGU6DQo+ID4gVGhlIHZzZWlfbGVuIDwgMCBlcnJvciBwYXRoIGRpZCBub3QgdmVyaWZ5IHRo
ZSBwZWlfbGVuIGFuZCBjdHhfbGVuLg0KPiA+IFdoZW4gdnNlaV9sZW4gaXMgbmVnYXRpdmUsIHNl
Y3Rpb25fbGVuZ3RoIGlzIHRvbyBzbWFsbCB0byBob2xkIHRoZQ0KPiA+IGZ1bGwgcmVjb3JkLCB5
ZXQgcGVpX2xlbiBhbmQgY3R4X2xlbiB3ZXJlIGRlcml2ZWQgZnJvbQ0KPiA+IGVycl9pbmZvX251
bS9jb250ZXh0X2luZm9fbnVtIGFuZCBtYXkgZGVzY3JpYmUgcmVnaW9ucyBiZXlvbmQgdGhlDQo+
ID4gKGxvbmcpZXJyIC4uIGVyciArIHNlY3Rpb25fbGVuZ3RoIGJ1ZmZlci4gVG8gcHJldmVudCB0
cmFjZV9hcm1fZXZlbnQNCj4gPiBmcm9tIHJlYWRpbmcgcGFzdCB0aGUgYWxsb2NhdGVkIHJlY29y
ZCwgc2FuaXRpemUgdGhlIHBhcmFtZXRlcnM6DQo+ID4gcmVjYWxjdWxhdGUgY3R4X2xlbiBhbmQg
cGVpX2xlbiBiYXNlZCBvbiBzZWN0aW9uX2xlbmd0aCwgbGltaXQgdGhlbSwNCj4gPiBhbmQgc2V0
IHRoZSBjb3JyZXNwb25kaW5nIHBvaW50ZXJzIHRvIE5VTEwgYW5kIGxlbmd0aHMgdG8gMCB3aGVu
DQo+ID4gdGhlcmUgaXMgbm8gcmVtYWluaW5nIHNwYWNlLg0KPiA+DQo+ID4gcGVpX2xlbiBhbmQg
Y3R4X2xlbiBiZWNvbWUgczMyIHNvIHRoYXQgdGhlIHJlY2FsY3VsYXRlZCBsZW5ndGhzIGNhbg0K
PiA+IGJlIGNoZWNrZWQgZm9yIG5lZ2F0aXZlIHZhbHVlcy4NCj4gPg0KPiA+IEZpeGVzOiAwNTk1
NDUxMWI3M2UgKCJSQVM6IFJlcG9ydCBhbGwgQVJNIHByb2Nlc3NvciBDUEVSIGluZm9ybWF0aW9u
IHRvIHVzZXJzcGFjZSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogQWJib3R0IExpdSA8bGl1d2VubGlh
bmdAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvcmFzL3Jhcy5jIHwgMjIgKysr
KysrKysrKysrKysrKysrLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yYXMvcmFz
LmMgYi9kcml2ZXJzL3Jhcy9yYXMuYw0KPiA+IGluZGV4IDI1NDA1MzhhMTZhOC4uMDg1ZmUyZDk4
MGU1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcmFzL3Jhcy5jDQo+ID4gKysrIGIvZHJpdmVy
cy9yYXMvcmFzLmMNCj4gPiBAQCAtNTgsMTAgKzU4LDEwIEBAIHZvaWQgbG9nX2FybV9od19lcnJv
cihzdHJ1Y3QgY3Blcl9zZWNfcHJvY19hcm0gKmVyciwgY29uc3QgdTggc2V2KQ0KPiA+ICAgCXN0
cnVjdCBjcGVyX2FybV9lcnJfaW5mbyAqZXJyX2luZm87DQo+ID4gICAJc3RydWN0IGNwZXJfYXJt
X2N0eF9pbmZvICpjdHhfaW5mbzsNCj4gPiAgIAl1OCAqdmVuX2Vycl9kYXRhOw0KPiA+IC0JdTMy
IGN0eF9sZW4gPSAwOw0KPiA+ICsJczMyIGN0eF9sZW4gPSAwOw0KPiA+ICAgCWludCBuLCBzeiwg
Y3B1Ow0KPiA+ICAgCXMzMiB2c2VpX2xlbjsNCj4gPiAtCXUzMiBwZWlfbGVuOw0KPiA+ICsJczMy
IHBlaV9sZW47DQo+ID4gICAJdTggKnBlaV9lcnIsICpjdHhfZXJyOw0KPiA+DQo+ID4gICAJcGVp
X2xlbiA9IHNpemVvZihzdHJ1Y3QgY3Blcl9hcm1fZXJyX2luZm8pICogZXJyLT5lcnJfaW5mb19u
dW07DQo+ID4gQEAgLTg3LDE0ICs4NywyOCBAQCB2b2lkIGxvZ19hcm1faHdfZXJyb3Ioc3RydWN0
IGNwZXJfc2VjX3Byb2NfYXJtICplcnIsIGNvbnN0IHU4IHNldikNCj4gPiAgIAkJcHJfd2FybihG
V19CVUcgInNlY3Rpb24gbGVuZ3RoIGlzIHRvbyBzbWFsbFxuIik7DQo+ID4gICAJCXByX3dhcm4o
RldfQlVHICJmaXJtd2FyZS1nZW5lcmF0ZWQgZXJyb3IgcmVjb3JkIGlzIGluY29ycmVjdFxuIik7
DQo+ID4gICAJCXZzZWlfbGVuID0gMDsNCj4gPiArCQl2ZW5fZXJyX2RhdGEgPSBOVUxMOw0KPiA+
ICsNCj4gPiArCQljdHhfbGVuID0gZXJyLT5zZWN0aW9uX2xlbmd0aCAtIChzaXplb2Yoc3RydWN0
IGNwZXJfc2VjX3Byb2NfYXJtKSArIHBlaV9sZW4pOw0KPiA+ICsJCWlmIChjdHhfbGVuIDwgMCkg
ew0KPiA+ICsJCQljdHhfbGVuID0gMDsNCj4gPiArCQkJY3R4X2VyciA9IE5VTEw7DQo+ID4gKw0K
PiA+ICsJCQlwZWlfbGVuID0gZXJyLT5zZWN0aW9uX2xlbmd0aCAtIHNpemVvZihzdHJ1Y3QgY3Bl
cl9zZWNfcHJvY19hcm0pOw0KPiA+ICsJCQlpZiAocGVpX2xlbiA8IDApIHsNCj4gPiArCQkJCXBl
aV9sZW4gPSAwOw0KPiA+ICsJCQkJcGVpX2VyciA9IE5VTEw7DQo+ID4gKwkJCX0NCj4gPiArCQl9
DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCXZlbl9lcnJfZGF0YSA9ICh1OCAqKWN0eF9pbmZvOw0K
PiA+ICAgCX0NCj4gPiAtCXZlbl9lcnJfZGF0YSA9ICh1OCAqKWN0eF9pbmZvOw0KPiA+DQo+ID4g
ICAJY3B1ID0gR0VUX0xPR0lDQUxfSU5ERVgoZXJyLT5tcGlkcik7DQo+ID4gICAJaWYgKGNwdSA8
IDApDQo+ID4gICAJCWNwdSA9IC0xOw0KPiA+DQo+ID4gLQl0cmFjZV9hcm1fZXZlbnQoZXJyLCBw
ZWlfZXJyLCBwZWlfbGVuLCBjdHhfZXJyLCBjdHhfbGVuLA0KPiA+ICsJdHJhY2VfYXJtX2V2ZW50
KGVyciwgcGVpX2VyciwgKHUzMilwZWlfbGVuLCBjdHhfZXJyLCAodTMyKWN0eF9sZW4sDQo+ID4g
ICAJCQl2ZW5fZXJyX2RhdGEsICh1MzIpdnNlaV9sZW4sIHNldiwgY3B1KTsNCj4gPiAgIH0NCj4N
Cj4gUmV2aWV3ZWQtYnk6IEhhbmp1biBHdW8gPGd1b2hhbmp1bkBodWF3ZWkuY29tPg0KDQpUaGFu
a3MsIEkgd2lsbCBhZGQgeW91ciBSZXZpZXdlZC1ieSB0YWcgaW4gdjUsIHRoZXJlIHdpbGwgYmUg
bm8gY29kZSBjaGFuZ2VzIGluDQp0aGF0IHZlcnNpb24sIHNvIHRoZSB0YWcgcmVtYWlucyB2YWxp
ZC4NCg0KPg0KPiBUaGFua3MNCj4gSGFuanVuDQo=
