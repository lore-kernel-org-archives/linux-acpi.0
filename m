Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D203932C2;
	Thu, 28 May 2026 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960945; cv=none; b=a8VsO0jof/LwyCFvKtQx5YpDg7Ecpwb3KYtTrWEm1BFZzhmE4Lrk36daedvHNwsZDyVm8MHdupiTL9pHVlmGRqeef4iTwGkvVC0u5K+BZIyAza+woVdprpxe/MzZd81qwTeLv6khVpn0bpV3ODYkn2a/U9cpCH0Jk/hcfBltK68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960945; c=relaxed/simple;
	bh=OzR3hoiXUNXb5Kns4tDqUU40P9oNv/Wgke1oJxGBmNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lRwUVKbx+N9co2KSo+7uIZ3svTpPWR0CY3+3g6mepIwo1fZtAuq8GBDPu+7Gs60gYh6SIwyYVSYYs6gRyIr+lqZu2i56PZq6Ff9JPEkNsPwvXepVpeZt0AHqskqmw+s06ubMFk36eh+yK04xWgZnC6wfTqj4eWPvIq9zFGEsqg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=UVgfAis2; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="UVgfAis2"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OzR3hoiXUNXb5Kns4tDqUU40P9oNv/Wgke1oJxGBmNs=;
	b=UVgfAis2ZrjPHHvoCeVqS6lcW2CrERGHx2ynlUAi8DD5uq//R6FAYZKlugFOfc3lHKIxJjdZ1
	sGIEE8/lsNT5G8pUICdIGGFHb1blHDiuSv5X0mUdrsUHRjRhZWsvYVxsRXlR9f95Z8LrvGxwV25
	fT55KzbgGBg1jhzXqN1P4s4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gR1Ns3hkbz12LJj;
	Thu, 28 May 2026 17:27:41 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id AB3AF4056D;
	Thu, 28 May 2026 17:35:40 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 May 2026 17:35:40 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 28 May
 2026 17:35:39 +0800
Message-ID: <a5f2a5af-631a-4525-b03e-041d6b748f35@huawei.com>
Date: Thu, 28 May 2026 17:35:39 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: processor: Add cpuidle driver check in
 acpi_processor_register_idle_driver
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <LindaChai@zhaoxin.com>, <lihuisong@huawei.com>
References: <20260519091922.42500-1-TonyWWang-oc@zhaoxin.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260519091922.42500-1-TonyWWang-oc@zhaoxin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)

SGVsbG8gVG9ueSwNCg0KVGhhbmsgeW91IGZvciByZXBvcnRpbmcgdGhpcyBpc3N1ZS4gR29v
ZCBwb2ludC4NClRoaXMgcGF0Y2ggaXMgbWVzc3kgYW5kIG5vdCBnb29kIHRvIHJldmlldyBh
bmQgbWVyZ2UuIHBsZWFzZSByZXNlbmQgaXQuDQpJbiBhZGRpdGlvbiwgc3VnZ2VzdCB5b3Ug
YWRkIGEgZml4ZWQgdGFnLg0KDQovSHVpc29uZw0KDQoNCk9uIDUvMTkvMjAyNiA1OjE5IFBN
LCBUb255IFcgV2FuZy1vYyB3cm90ZToNCj4gQ29tbWl0IDdhOGM5OTRjYmIyZCAoIkFDUEk6
IHByb2Nlc3NvcjogaWRsZTogT3B0aW1pemUgQUNQSSBpZGxlZHJpdmVyIHJlZ2lzdHJhdGlv
biIpIG1vdmVkIHRoZSBBQ1BJIGlkbGUgZHJpdmVyIHJlZ2lzdHJhdGlvbiB0b2FjcGlfcHJv
Y2Vzc29yX2RyaXZlcl9pbml0KCksIGJ1dCBpdCBkaWRuJ3QgY2hlY2sgd2hldGhlciBhIGNw
dWlkbGVkcml2ZXIgd2FzIGFscmVhZHkgcmVnaXN0ZXJlZC5Gb3IgZXhhbXBsZSwgb24gSW50
ZWwgcGxhdGZvcm1zLCBpZiB0aGUgaW50ZWxfaWRsZSBkcml2ZXIgaXMgYWxyZWFkeWxvYWRl
ZCwgdGhlIGNvZGUgd291bGQgc3RpbGwgZXZhbHVhdGUgdGhlIF9DU1Qgb2JqZWN0IGluIHRo
ZSBBQ1BJdGFibGUgYW5kIGF0dGVtcHQgdG8gcmVnaXN0ZXIgdGhlIGFjcGlfaWRsZSBkcml2
ZXIuIFRoaXMgcmVnaXN0cmF0aW9ud291bGQgZmFpbCB3aXRoIC1FQlVTWSBkdWUgdG8gdGhl
IGV4aXN0aW5nIGNoZWNrIGluIGNwdWlkbGVfcmVnaXN0ZXJfZHJpdmVyLkFkZCBhIGNoZWNr
IGF0IHRoZSBiZWdpbm5pbmcgb2YgYWNwaV9wcm9jZXNzb3JfcmVnaXN0ZXJfaWRsZV9kcml2
ZXIoKXRvIGF2b2lkIHVubmVjZXNzYXJ5IF9DU1QgZXZhbHVhdGUgYW5kIHBvdGVudGlhbCBy
ZWdpc3RyYXRpb24gZmFpbHVyZXMuLS0tIGRyaXZlcnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5j
IHwgNSArKysrKyAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspZGlmZiAtLWdpdCBh
L2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5jIGIvZHJpdmVycy9hY3BpL3Byb2Nlc3Nv
cl9pZGxlLmNpbmRleCBlZTVmYWNjY2JlMTAuLjA0MDk0MTFhYmI4MyAxMDA2NDQtLS0gYS9k
cml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYysrKyBiL2RyaXZlcnMvYWNwaS9wcm9jZXNz
b3JfaWRsZS5jQEAgLTEzNTUsNiArMTM1NSwxMSBAQCB2b2lkIGFjcGlfcHJvY2Vzc29yX3Jl
Z2lzdGVyX2lkbGVfZHJpdmVyKHZvaWQpIAlpbnQgcmV0ID0gLUVOT0RFVjsgCWludCBjcHU7
ICsJaWYgKGNwdWlkbGVfZ2V0X2RyaXZlcigpKSB7KwkJcHJfZGVidWcoImNwdWlkbGUgZHJp
dmVyICVwUyBhbHJlYWR5IHJlZ2lzdGVyZWQuXG4iLCBjcHVpZGxlX2dldF9kcml2ZXIoKSk7
KwkJcmV0dXJuOysJfSsgCWFjcGlfcHJvY2Vzc29yX3VwZGF0ZV9tYXhfY3N0YXRlKCk7ICAJ
LyotLSAyLjI1LjENCj4NCj4NCj4NCj4NCj4g5L+d5a+G5aOw5piODQo+IOacrOmCruS7tuWQ
q+acieS/neWvhuaIluS4k+acieS/oeaBr++8jOS7heS+m+aMh+WumuaUtuS7tuS6uuS9v+eU
qOOAguS4peemgeWvueacrOmCruS7tuaIluWFtuWGheWuueWBmuS7u+S9leacque7j+aOiOad
g+eahOafpemYheOAgeS9v+eUqOOAgeWkjeWItuaIlui9rOWPkeOAgg0KPg0KPiBUaGlzIGVt
YWlsIGNvbnRhaW5zIGNvbmZpZGVudGlhbCBvciBsZWdhbGx5IHByaXZpbGVnZWQgaW5mb3Jt
YXRpb24gYW5kIGlzIGZvciB0aGUgc29sZSB1c2Ugb2YgaXRzIGludGVuZGVkIHJlY2lwaWVu
dC4gQW55IHVuYXV0aG9yaXplZCByZXZpZXcsIHVzZSwgY29weWluZyBvciBmb3J3YXJkaW5n
IG9mIHRoaXMgZW1haWwgb3IgdGhlIGNvbnRlbnQgb2YgdGhpcyBlbWFpbCBpcyBzdHJpY3Rs
eSBwcm9oaWJpdGVkLg0K
