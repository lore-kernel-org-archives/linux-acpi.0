Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1732E4257;
	Mon, 21 Sep 2026 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789954167; cv=none; b=eS4Cr73NgP3J9xBNhlJ3hnabwL6iLWdfwKmjJRCzlHCr5ezN+qkIdsyMX6L2zEftVUZQpf+/oJs1Y/eSXP1RQMrunFRnXBChHyzvoZ0W3g9mGB7deAxVlJeHrzJjLvoEVELPDl3O2G6uYa3cNhbFeV1KtXN1/IikNfUELyloeNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789954167; c=relaxed/simple;
	bh=DAE219f5tMZqeDu8ckq5EAa+nuR3kmP7HERcmmGKrgU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cPSwgAWYAa5RISuUlAhHBHzTMHdA/NtVGSjMieQr0LJ4bdrvjE9MM0He8ugLc4IzYYCUbloU6UDeXwzTLK94DwAzFKOKjzKD7YoJ0ZcAOuJscOL2euBVCiDhVrSGJYU7k1JpDnoVRtivt8Zn4+VapHw2MiPPIHPAkfJMgtIR2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MRXcAnYA; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MRXcAnYA"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DAE219f5tMZqeDu8ckq5EAa+nuR3kmP7HERcmmGKrgU=;
	b=MRXcAnYA4g4fGFuw364CKUio8yQbFlDtFNfoBeaxFhTCHMUe3BszjYis6BvIb3W+lGaKrrfKz
	0QksJ2iPklKTDvoWE9XskWvjSz5aQZyEYawFWuXL5cWhsHDiZ+6BE39Pi9Bl2RayhMQv7R6YTt7
	zd+MyaPvESvY4d8XgLVwd54=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hp52Y0Gvpz1K9D2;
	Mon, 21 Sep 2026 09:18:13 +0800 (CST)
Received: from kwepemf200007.china.huawei.com (unknown [7.202.181.233])
	by mail.maildlp.com (Postfix) with ESMTPS id BD0464057A;
	Mon, 21 Sep 2026 09:29:14 +0800 (CST)
Received: from kwepemf100015.china.huawei.com (7.202.181.14) by
 kwepemf200007.china.huawei.com (7.202.181.233) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 09:29:14 +0800
Received: from kwepemf100015.china.huawei.com ([7.202.181.14]) by
 kwepemf100015.china.huawei.com ([7.202.181.14]) with mapi id 15.02.2562.045;
 Mon, 21 Sep 2026 09:29:14 +0800
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
Subject: Re: [PATCH v4 1/3] RAS: Fix inverted context info bounds check in ARM
 processor errors
Thread-Topic: [PATCH v4 1/3] RAS: Fix inverted context info bounds check in
 ARM processor errors
Thread-Index: Ad1JaIeBlTuG+PDBTjeySqUEELugtg==
Date: Mon, 21 Sep 2026 01:29:14 +0000
Message-ID: <d581dbd171c04e33a358863de0840f78@huawei.com>
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
MDoxMywgSGFuanVuIEd1byB3cm90ZToNCj4gT24gMjAyNi85LzkgMTk6MjgsIEFiYm90dCBMaXUg
d3JvdGU6DQo+ID4gQ29tbWl0IDg3ODgwYWYyZDI0ZSAoIkFQRUkvR0hFUzogQVJNIHByb2Nlc3Nv
ciBFcnJvcjogZG9uJ3QgZ28gcGFzdA0KPiA+IGFsbG9jYXRlZCBtZW1vcnkiKSBhZGRlZCBib3Vu
ZHMgY2hlY2tzIGZvciBtYWxmb3JtZWQgQVJNIHByb2Nlc3Nvcg0KPiA+IGVycm9yIHJlY29yZHMg
YnV0IGNvbnRhaW5lZCBhIGJ1ZzoNCj4gPg0KPiA+ICAgIEluIGxvZ19hcm1faHdfZXJyb3IoKSwg
dGhlIGN0eF9pbmZvIGJvdW5kcyBjaGVjayBpcyBpbnZlcnRlZC4gVGhlDQo+ID4gICAgY29uZGl0
aW9uICJzeiArIChsb25nKWN0eF9pbmZvIC0gKGxvbmcpZXJyID49IGVyci0+c2VjdGlvbl9sZW5n
dGgiDQo+ID4gICAgYWRkcyBjdHhfaW5mby0+c2l6ZSB3aGVuIHRoZSBjb250ZXh0IGhlYWRlciBp
cyBhbHJlYWR5IHBhc3QgdGhlIGVuZA0KPiA+ICAgIG9mIHRoZSBzZWN0aW9uIGluc3RlYWQgb2Yg
d2hlbiBpdCBpcyB3aXRoaW4gYm91bmRzLiBTbyBjaGFuZ2UgdGhlDQo+ID4gICAgY29tcGFyaXNv
biB0byA8PS4NCj4gPg0KPiA+IEZpeGVzOiA4Nzg4MGFmMmQyNGUgKCJBUEVJL0dIRVM6IEFSTSBw
cm9jZXNzb3IgRXJyb3I6IGRvbid0IGdvIHBhc3QgYWxsb2NhdGVkIG1lbW9yeSIpDQo+ID4gU2ln
bmVkLW9mZi1ieTogQWJib3R0IExpdSA8bGl1d2VubGlhbmdAaHVhd2VpLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgIGRyaXZlcnMvcmFzL3Jhcy5jIHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9yYXMvcmFzLmMgYi9kcml2ZXJzL3Jhcy9yYXMuYw0KPiA+IGluZGV4IDAzZGYzZGI2MjMzNC4u
MjU0MDUzOGExNmE4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcmFzL3Jhcy5jDQo+ID4gKysr
IGIvZHJpdmVycy9yYXMvcmFzLmMNCj4gPiBAQCAtNzQsNyArNzQsNyBAQCB2b2lkIGxvZ19hcm1f
aHdfZXJyb3Ioc3RydWN0IGNwZXJfc2VjX3Byb2NfYXJtICplcnIsIGNvbnN0IHU4IHNldikNCj4g
PiAgIAlmb3IgKG4gPSAwOyBuIDwgZXJyLT5jb250ZXh0X2luZm9fbnVtOyBuKyspIHsNCj4gPiAg
IAkJc3ogPSBzaXplb2Yoc3RydWN0IGNwZXJfYXJtX2N0eF9pbmZvKTsNCj4gPg0KPiA+IC0JCWlm
IChzeiArIChsb25nKWN0eF9pbmZvIC0gKGxvbmcpZXJyID49IGVyci0+c2VjdGlvbl9sZW5ndGgp
DQo+ID4gKwkJaWYgKHN6ICsgKGxvbmcpY3R4X2luZm8gLSAobG9uZyllcnIgPD0gZXJyLT5zZWN0
aW9uX2xlbmd0aCkNCj4gPiAgIAkJCXN6ICs9IGN0eF9pbmZvLT5zaXplOw0KPiA+DQo+ID4gICAJ
CWN0eF9pbmZvID0gKHN0cnVjdCBjcGVyX2FybV9jdHhfaW5mbyAqKSgobG9uZyljdHhfaW5mbyAr
IHN6KTsNCj4gPg0KPg0KPiBSZXZpZXdlZC1ieTogSGFuanVuIEd1byA8Z3VvaGFuanVuQGh1YXdl
aS5jb20+DQoNClRoYW5rcywgSSB3aWxsIGFkZCB5b3VyIFJldmlld2VkLWJ5IHRhZyBpbiB2NSwg
dGhlcmUgd2lsbCBiZSBubyBjb2RlIGNoYW5nZXMgaW4NCnRoYXQgdmVyc2lvbiwgc28gdGhlIHRh
ZyByZW1haW5zIHZhbGlkLg0KDQo+DQo+IFRoYW5rcw0KPiBIYW5qdW4NCg==
