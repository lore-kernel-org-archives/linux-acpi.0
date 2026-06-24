Received: from outbound.baidu.com (mx21.baidu.com [220.181.3.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB35C26F2BF;
	Wed, 24 Jun 2026 01:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782266023; cv=none; b=oTN6UBA7884/j8K/WJhbJ2UqVgzOi+FTYYpOHdliU7fKg0/u7cMV04QcOkK83naeGH/0IJALRDuvvAtyGQ7rquFKRC6E4U20DFHIxnmmOssBTkdQSDxdo5NCHmkoW0z3w8T7B8X9vTMt6jWLXs4iUdbcg/FwVcllQf6ltggQ+ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782266023; c=relaxed/simple;
	bh=57BwPhw+2jsNM3qNr+qscKia+O/Fj9nJ6Gilcwg5foo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H00ofm2H7dlaVB6YZKgN+ywI2ZnxKXApYxP5IPWgFhzZC+3acIxj2J9D6IollGCcHW1MsF/3Y6DmUjiGBAgkqxGjFefb/JNNbmy693/AU4wO7rNJ0PyNihcgiHmflx+BcnSU4j9nTP368WSixgJd6/Owsih81opq1qjriAoo6Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=H1yL45qa; arc=none smtp.client-ip=220.181.3.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="H1yL45qa"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.46
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Sunil V L <sunilvl@ventanamicro.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Sudeep Holla <Sudeep.Holla@arm.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "Huisong
 Li" <lihuisong@huawei.com>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXVt2Ml0gQUNQSTog?=
 =?utf-8?B?cHJvY2Vzc29yX2lkbGU6IE1hcmsgTFBJIGVudGVyIGZ1bmN0aW9ucyBhcyBf?=
 =?utf-8?Q?=5Fcpuidle?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF1bdjJdIEFDUEk6IHByb2Nlc3Nv?=
 =?utf-8?B?cl9pZGxlOiBNYXJrIExQSSBlbnRlciBmdW5jdGlvbnMgYXMgX19jcHVpZGxl?=
Thread-Index: AQHc/WFvN8E7xRYeR0ymmalWbQVFC7ZLpvGAgAFVfsA=
Date: Wed, 24 Jun 2026 01:51:14 +0000
Message-ID: <731d81865e444be8a9bc07dd121975f3@baidu.com>
References: <20260616072617.2272-1-lirongqing@baidu.com>
 <CAJZ5v0j3Wnn3exbji-6PzwjCnOCJDe_pUJU9R25Bhvh1ZE3E5A@mail.gmail.com>
In-Reply-To: <CAJZ5v0j3Wnn3exbji-6PzwjCnOCJDe_pUJU9R25Bhvh1ZE3E5A@mail.gmail.com>
Accept-Language: zh-CN, en-US
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1782265880;
	bh=57BwPhw+2jsNM3qNr+qscKia+O/Fj9nJ6Gilcwg5foo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=H1yL45qak3S8QhBufEZr8IkEfQIuSBw/GTdS8HyM2h34cS6OhQRMyXhmg9HXqZueD
	 wBSN9cL+xwCZ5ZB5gXhczySSguMwWuezEqfyvsPgSHt4P1Mt5RcJ/FPMs/XILEkDhH
	 eaRunZJMJPBl00eRssrZ0/AHkOMX1sfL3ggMyyiY8pYaEZSpRtggV/DHUNObicAHtz
	 kQPQIsiMtxE0rLjQHhDRZ1cjy4hlPIo+j7kExO2C/SYXdcQg1bKssDUo86wNbsHSYD
	 +ZI72s63PDipGfILYv/Grrs8RDknq6Qqh6S+V7MC5yKeptJMLMtDxbqVw31jGfQYMN
	 XmBNRUVkNSntg==

PiA+IFRoZSBhY3BpX2lkbGVfbHBpX2VudGVyKCkgZnVuY3Rpb24gaXMgaW52b2tlZCB3aXRoaW4g
dGhlIGNwdWlkbGUgcGF0aA0KPiA+IGFmdGVyIFJDVSBoYXMgYWxyZWFkeSBiZWVuIGRpc2FibGVk
IGZvciB0aGUgY3VycmVudCBsb2NhbCBDUFUuDQo+ID4gQ29uc2VxdWVudGx5LCBmdHJhY2UncyBm
dW5jdGlvbl90cmFjZV9jYWxsKCkgZXhwZWN0cyBSQ1UgdG8gYmUNCj4gPiBhY3RpdmVseSB3YXRj
aGluZyBiZWZvcmUgcmVjb3JkaW5nIHRyYWNlIGRhdGEsIGVtaXR0aW5nIGEgd2FybmluZyBpZg0K
PiA+IGl0IGlzIG5vdC4NCj4gPg0KPiA+IEZpeCB0aGlzIGJ5IGFubm90YXRpbmcgYWNwaV9pZGxl
X2xwaV9lbnRlcigpLCB0aGUgZ2VuZXJpYyBfX3dlYWsgc3R1YiwNCj4gPiBhbmQgdGhlIFJJU0Mt
ViBpbXBsZW1lbnRhdGlvbiBvZiBhY3BpX3Byb2Nlc3Nvcl9mZmhfbHBpX2VudGVyKCkgd2l0aA0K
PiA+IF9fY3B1aWRsZS4gVGhpcyBtb3ZlcyB0aGVzZSBmdW5jdGlvbnMgaW50byB0aGUgJy5jcHVp
ZGxlLnRleHQnDQo+ID4gc2VjdGlvbiwgaW1wbGljaXRseSBkaXNhYmxpbmcgZnRyYWNlIGluc3Ry
dW1lbnRhdGlvbiAobm90cmFjZSkgYWxvbmcNCj4gPiB0aGlzIHNlbnNpdGl2ZSBwYXRoIGFuZCBw
cmV2ZW50aW5nIHRyYWNlLWluZHVjZWQgUkNVIHdhcm5pbmdzIGR1cmluZw0KPiA+IGlkbGUgZW50
cnkuDQo+ID4NCj4gPiBGaXhlczogYTM2YTdmZWNmZTYwICgiQUNQSSAvIHByb2Nlc3Nvcl9pZGxl
OiBBZGQgc3VwcG9ydCBmb3IgTG93IFBvd2VyDQo+ID4gSWRsZShMUEkpIHN0YXRlcyIpDQo+ID4g
U2lnbmVkLW9mZi1ieTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiA+IC0t
LQ0KPiA+IERpZmYgd2l0aCB2MTogYWRkIF9fY3B1aWRsZSB0byBhY3BpX3Byb2Nlc3Nvcl9mZmhf
bHBpX2VudGVyDQo+ID4NCj4gPiAgZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9pZGxlLmMgfCA0ICsr
LS0gIGRyaXZlcnMvYWNwaS9yaXNjdi9jcHVpZGxlLmMNCj4gPiB8IDIgKy0NCj4gPiAgMiBmaWxl
cyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9pZGxlLmMNCj4gPiBiL2RyaXZlcnMvYWNw
aS9wcm9jZXNzb3JfaWRsZS5jIGluZGV4IDM5MGFiNWYuLjQ0ODJjZjIgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9pZGxlLmMNCj4gPiArKysgYi9kcml2ZXJzL2FjcGkv
cHJvY2Vzc29yX2lkbGUuYw0KPiA+IEBAIC0xMTQzLDcgKzExNDMsNyBAQCBzdGF0aWMgaW50IGFj
cGlfcHJvY2Vzc29yX2dldF9scGlfaW5mbyhzdHJ1Y3QNCj4gYWNwaV9wcm9jZXNzb3IgKnByKQ0K
PiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+IC1pbnQgX193ZWFrIGFjcGlf
cHJvY2Vzc29yX2ZmaF9scGlfZW50ZXIoc3RydWN0IGFjcGlfbHBpX3N0YXRlICpscGkpDQo+ID4g
K2ludCBfX3dlYWsgX19jcHVpZGxlIGFjcGlfcHJvY2Vzc29yX2ZmaF9scGlfZW50ZXIoc3RydWN0
DQo+ID4gK2FjcGlfbHBpX3N0YXRlICpscGkpDQo+ID4gIHsNCj4gPiAgICAgICAgIHJldHVybiAt
RU5PREVWOw0KPiA+ICB9DQo+ID4gQEAgLTExNTYsNyArMTE1Niw3IEBAIGludCBfX3dlYWsgYWNw
aV9wcm9jZXNzb3JfZmZoX2xwaV9lbnRlcihzdHJ1Y3QNCj4gYWNwaV9scGlfc3RhdGUgKmxwaSkN
Cj4gPiAgICoNCj4gPiAgICogUmV0dXJuOiAwIGZvciBzdWNjZXNzIG9yIG5lZ2F0aXZlIHZhbHVl
IGZvciBlcnJvcg0KPiA+ICAgKi8NCj4gPiAtc3RhdGljIGludCBhY3BpX2lkbGVfbHBpX2VudGVy
KHN0cnVjdCBjcHVpZGxlX2RldmljZSAqZGV2LA0KPiA+ICtzdGF0aWMgaW50IF9fY3B1aWRsZSBh
Y3BpX2lkbGVfbHBpX2VudGVyKHN0cnVjdCBjcHVpZGxlX2RldmljZSAqZGV2LA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydiwgaW50
IGluZGV4KQ0KPiA+IHsNCj4gPiAgICAgICAgIHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHI7DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9yaXNjdi9jcHVpZGxlLmMNCj4gPiBiL2RyaXZl
cnMvYWNwaS9yaXNjdi9jcHVpZGxlLmMgaW5kZXggNjI0ZjliYi4uYzc2ZGJhYiAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2FjcGkvcmlzY3YvY3B1aWRsZS5jDQo+ID4gKysrIGIvZHJpdmVycy9h
Y3BpL3Jpc2N2L2NwdWlkbGUuYw0KPiA+IEBAIC02Niw3ICs2Niw3IEBAIGludCBhY3BpX3Byb2Nl
c3Nvcl9mZmhfbHBpX3Byb2JlKHVuc2lnbmVkIGludCBjcHUpDQo+ID4gICAgICAgICByZXR1cm4g
YWNwaV9jcHVfaW5pdF9pZGxlKGNwdSk7ICB9DQo+ID4NCj4gPiAtaW50IGFjcGlfcHJvY2Vzc29y
X2ZmaF9scGlfZW50ZXIoc3RydWN0IGFjcGlfbHBpX3N0YXRlICpscGkpDQo+ID4gK2ludCBfX2Nw
dWlkbGUgYWNwaV9wcm9jZXNzb3JfZmZoX2xwaV9lbnRlcihzdHJ1Y3QgYWNwaV9scGlfc3RhdGUN
Cj4gPiArKmxwaSkNCj4gPiAgew0KPiA+ICAgICAgICAgdTMyIHN0YXRlID0gbHBpLT5hZGRyZXNz
Ow0KPiA+DQo+ID4gLS0NCj4gDQo+IFNhc2hpa28gc2F5cyB0aGF0IHRoaXMgY2hhbmdlIG1heSBu
b3QgYmUgc3VmZmljaWVudCB0byBmdWxseSBhZGRyZXNzIHRoZSBpc3N1ZQ0KPiANCj4gaHR0cHM6
Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYwNjE2MDcyNjE3LjIyNzItMS1saXJvbmdxaW5n
JTQwYmFpZHUNCj4gLmNvbQ0KPiANCj4gYW5kIHRoYXQgYXBwZWFycyB0byBiZSBhIHZhbGlkIGNv
bmNlcm4uDQoNClNob3VsZCB0aGlzIGZpeCBiZSBwbGFjZWQgaW4gYSBzZXBhcmF0ZSBwYXRjaD8g
Q1BVX1BNX0NQVV9JRExFX0VOVEVSX1BBUkFNIGlzIGFsc28gaW52b2tlZCBieSBzYmlfY3B1aWRs
ZV9lbnRlcl9zdGF0ZSwgd2hpY2ggaXMgaXRzZWxmIGFscmVhZHkgYW5ub3RhdGVkIHdpdGggX19j
cHVpZGxlLCBzbyB0aGlzIGFwcGVhcnMgdG8gYmUgYSBwcmUtZXhpc3RpbmcgaXNzdWUgaW4gdGhl
IFJJU0MtViB0cmVlLiBJdCB3b3VsZCBiZSBtb3JlIGFwcHJvcHJpYXRlIHRvIGhhdmUgUklTQy1W
IGV4cGVydHMgdG8gZml4IGl0IGluZGVwZW5kZW50bHkuDQoNClRoYW5rcw0KDQpbTGksUm9uZ3Fp
bmddIA0KDQoNCg0KDQo=
