From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Tue, 25 Jul 2017 23:00:40 +0000
Message-ID: <1501023077.2042.73.camel@hpe.com>
References: <20170721172344.GA11316@nazgul.tnic>
         <1500661773.2042.53.camel@hpe.com> <20170722062853.GA2050@nazgul.tnic>
         <1500907209.2042.55.camel@hpe.com> <20170724150432.GA31295@nazgul.tnic>
         <1500909372.2042.58.camel@hpe.com> <20170724153716.GA17708@nazgul.tnic>
         <20170724130402.0f05c0ba@vento.lan> <20170724164400.GB18184@nazgul.tnic>
         <20170724151013.513d5fc8@vento.lan> <20170724183014.GB20501@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724183014.GB20501@nazgul.tnic>
Content-Language: en-US
Content-ID: <8F53A1445D7A0A45B98164815A7B41DA@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: "mchehab@osg.samsung.com" <mchehab@osg.samsung.com>, "bp@alien8.de" <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mchehab@s-opensource.com" <mchehab@s-opensource.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gTW9uLCAyMDE3LTA3LTI0IGF0IDIwOjMwICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQogOg0KPiANCj4gU28gSSBkb24ndCB3YW50IHRvIGJyZWFrIGV4aXN0aW5nIHVzZXJzIGFuZCB0
aHVzIG1ha2Ugb25seSBleHBsaWNpdGx5DQo+IGtub3duIHBsYXRmb3JtcyBsb2FkIGdoZXNfZWRh
Yy4gSW4gdGhlIGN1cnJlbnQgY2FzZSwgdGhlIEhQRQ0KPiBtYWNoaW5lcy4gIEFsbCB0aGUgcmVz
dCB3aWxsIHNpbXBseSB1c2UgdGhlIHBsYXRmb3JtIGRyaXZlcnMgYW5kDQo+IG5vdGhpbmcgd2ls
bCBjaGFuZ2UgZm9yIHRoZW0uDQo+IA0KPiBMYXRlciB3ZSdsbCBwcm9iYWJseSBuZWVkIHRvIHJl
dmlzaXQgdGhpcyBkZWNpc2lvbiBidXQgcmlnaHQgbm93IGFuZA0KPiB3aXRoIGFsbCB0aGluZ3Mg
Y29uc2lkZXJlZCwgdGhlIHdoaXRlbGlzdCBzZWVtcyAtIGFzIHVnbHkgYXMgaXQgaXMgLQ0KPiB0
aGUgbW9zdCB3b3JrYWJsZSBzb2x1dGlvbiBmb3IgYWxsIHRoZSBkaWZmZXJlbnQgdXNlIGNhc2Vz
IGFuZA0KPiBtYWNoaW5lcy4uLg0KDQpBZ3JlZWQuICBJIHdpbGwgdmVyaWZ5IE9FTUlEIGluZm8g
b2Ygb3VyIG90aGVyIHBsYXRmb3JtcywgYW5kIGFkZCBBUEVJDQpPU0MgY2hlY2sgYmVmb3JlIGNh
bGxpbmcgZ2hlc19lZGFjX3JlZ2lzdGVyKCkuDQoNClRoYW5rcywNCi1Ub3NoaQ0K
