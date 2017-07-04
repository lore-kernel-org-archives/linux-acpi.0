From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: RE: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
 devices before scanning
Date: Tue, 4 Jul 2017 16:22:11 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40B16310@FRAEML521-MBX.china.huawei.com>
References: <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
 <20170616083313.GY3187@lahna.fi.intel.com>
 <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
 <20170616120048.GC629@lahna.fi.intel.com>
 <CAJZ5v0g+qVui6RU=Hy3c_3qAAWngqaAu6B3JxGOpqF06kitbzA@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40ACFB8D@FRAEML521-MBX.china.huawei.com>
 <20170619100209.GC629@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40ACFC3D@FRAEML521-MBX.china.huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40B10487@FRAEML521-MBX.china.huawei.com>
 <CAHp75VevOno613gk8QHDA7kmLZJj9TLZRiu7oJUs_xaRzcbpnw@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40B15AA2@FRAEML521-MBX.china.huawei.com>
 <CAHp75VccwpesvDxMcxZ+349rhrAq8QxNoau9XmquMnv9DBLBfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:8430 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752500AbdGDQ0J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Jul 2017 12:26:09 -0400
In-Reply-To: <CAHp75VccwpesvDxMcxZ+349rhrAq8QxNoau9XmquMnv9DBLBfA@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "brian.starkey@arm.com" <brian.starkey@arm.com>, "olof@lixom.net" <olof@lixom.net>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.ke>

SGkgQW5keQ0KDQpbLi4uXQ0KDQo+IA0KPiBZb3UgbWF5IGRvIGl0IG9uIHN0YWNrLiBEZWZpbmUg
eW91ciBjZWxsIHN0YXRpY2FsbHkgKGJ1dCBub3QgY29uc3QpDQo+IGFuZCBhcHBseSByZXNvdXJj
ZXMganVzdCBiZWZvcmUgbWZkX2FkZF9kZXZpY2VzKCkgY2FsbC4NCg0KT2sgdGhhbmtzIGdvdCBp
dA0KDQo+IFRoZXJlIGFyZSBleGFtcGxlcyBpbiB0aGUgZXhpc3RpbmcgZHJpdmVycy4gSW50ZWwg
TFBDIGNvbWVzIHRvIG15IG1pbmQNCj4gYW5kIHBlcmhhcHMgUE1DIChCcm94dG9uKSwgdGhvdWdo
IGxhdHRlciBoYXMgdG9vIG11Y2ggb3RoZXIgc3R1ZmYNCj4gYXJvdW5kLg0KDQpVaCB5ZXMgSSBz
ZWUgbm93IGluIGxwY19pY2guYyAoYmFzZSBhZGRyZXNzIGlzIHJlYWQgZnJvbSBQQ0kgY29uZmln
IHNwYWNlDQphbmQgcmVzb3VyY2VzIGFyZSBzZXQgYWNjb3JkaW5nbHkpLg0KDQpDaGVlcnMNCkdh
Yg0KDQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
