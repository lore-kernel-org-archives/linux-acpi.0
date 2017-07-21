From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Fri, 21 Jul 2017 15:34:50 +0000
Message-ID: <1500650732.2042.45.camel@hpe.com>
References: <20170718060007.GB8736@nazgul.tnic>
         <1500407379.2042.21.camel@hpe.com> <20170718181545.32bd9181@vento.lan>
         <1500481869.2042.29.camel@hpe.com> <20170720043344.GC14367@nazgul.tnic>
         <1500579646.2042.37.camel@hpe.com> <20170721133441.GB5036@nazgul.tnic>
         <20170721104001.3cd2b884@vento.lan> <20170721134715.GC5036@nazgul.tnic>
         <1500649162.2042.43.camel@hpe.com> <20170721151317.GA13424@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170721151317.GA13424@nazgul.tnic>
Content-Language: en-US
Content-ID: <DC19FB75A9DB6F4AB7105BF3ADAA462F@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mchehab@s-opensource.com" <mchehab@s-opensource.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gRnJpLCAyMDE3LTA3LTIxIGF0IDE3OjEzICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgSnVsIDIxLCAyMDE3IGF0IDAzOjA4OjQxUE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gWWVzLCB0aGF0IGlzIGNvcnJlY3QuwqDCoENvcnJlY3RlZCBlcnJv
cnMgYXJlIHJlcG9ydGVkIHRvIHRoZSBPUyB3aGVuDQo+ID4gdGhleSBleGNlZWRlZCB0aGUgcGxh
dGZvcm0ncyB0aHJlc2hvbGQuDQo+IA0KPiBBcmUgdGhvc2UgdGhyZXNob2xkcyB1c2VyLWNvbmZp
Z3VyYWJsZT8NCg0KSSBzdXBwb3NlIGl0J2QgZGVwZW5kIG9uIHZlbmRvcnMsIGJ1dCBJIGRvIG5v
dCB0aGluayB1c2VycyBjYW4gZG8gaXQNCnByb3Blcmx5IHVubGVzcyB0aGV5IGhhdmUgZGVwdGgg
a25vd2xlZGdlIGFib3V0IHRoZSBoYXJkd2FyZS4NCg0KPiBJZiBub3QsIHdoYXQgYXJlIHlvdSB0
ZWxsaW5nIHVzZXJzIHdobyB3YW50IHRvIHNlZSAqZXZlcnkqIGNvcnJlY3RlZA0KPiBlcnJvciBm
b3IgbWVhc3VyaW5nIERJTU0gd2VhciBhbmQgc28gb24uLi4/DQoNCkNvcnJlY3RlZCBlcnJvcnMg
YXJlIG5vcm1hbCBhbmQgZXhwZWN0ZWQgdG8gb2NjdXIgb24gaGVhbHRoeSBoYXJkd2FyZS4gDQpU
aGV5IGRvIG5vdCBuZWVkIHVzZXIncyBhdHRlbnRpb24gdW50aWwgdGhleSByZXBlYXRlZGx5IG9j
Y3VycmVkIGF0IGENCnNhbWUgcGxhY2UuDQoNClRoYW5rcywNCi1Ub3NoaQ0K
