From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH][v2] ACPI: Do not report _OSI("Darwin") when
 acpi_osi=!Darwin provided
Date: Mon, 1 Feb 2016 14:00:12 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE640286C0CB1@shsmsx102.ccr.corp.intel.com>
References: <1454293612-13161-1-git-send-email-yu.c.chen@intel.com>
	<CAHp75VdaNFVA10X_N-URqmKAv3upOF2zT083T0tiN1=DnLqNbA@mail.gmail.com>
	<36DF59CE26D8EE47B0655C516E9CE640286C0A85@shsmsx102.ccr.corp.intel.com>
 <CAHp75Vc-8H_Kzxux7mFZLFjQhhNfzxGfo64xDhE9ot339Uy=GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vc-8H_Kzxux7mFZLFjQhhNfzxGfo64xDhE9ot339Uy=GQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>, "Zhang, Rui" <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gW21h
aWx0bzphbmR5LnNoZXZjaGVua29AZ21haWwuY29tXQ0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5
IDAxLCAyMDE2IDU6MzEgUE0NCj4gVG86IENoZW4sIFl1IEMNCj4gQ2M6IGxpbnV4LWFjcGlAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBSYWZhZWwgSi4NCj4g
V3lzb2NraTsgTGVuIEJyb3duOyBtYXR0aGV3LmdhcnJldHRAbmVidWxhLmNvbTsgWmhhbmcsIFJ1
aQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXVt2Ml0gQUNQSTogRG8gbm90IHJlcG9ydCBfT1NJKCJE
YXJ3aW4iKSB3aGVuDQo+IGFjcGlfb3NpPSFEYXJ3aW4gcHJvdmlkZWQNCj4gDQo+IE9uIE1vbiwg
RmViIDEsIDIwMTYgYXQgMTE6MTMgQU0sIENoZW4sIFl1IEMgPHl1LmMuY2hlbkBpbnRlbC5jb20+
IHdyb3RlOg0KPiANCj4gPj4gPiArc3RhdGljIGJvb2wgYWNwaV9vc2lfc2V0dXBfZGlzYWJsZWQo
Y2hhciAqc3RyKSB7DQo+ID4+ID4gKyAgICAgICBpbnQgaTsNCj4gPj4gPiArICAgICAgIHN0cnVj
dCBvc2lfc2V0dXBfZW50cnkgKm9zaTsNCj4gPj4gPiArDQo+ID4+ID4gKyAgICAgICBpZiAoIXN0
cikNCj4gPj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+PiA+ICsNCj4gPj4g
PiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBPU0lfU1RSSU5HX0VOVFJJRVNfTUFYOyBpKyspIHsN
Cj4gPj4gPiArICAgICAgICAgICAgICAgb3NpID0gJm9zaV9zZXR1cF9lbnRyaWVzW2ldOw0KPiA+
PiA+ICsgICAgICAgICAgICAgICBpZiAoIXN0cmNtcChvc2ktPnN0cmluZywgc3RyKSkgew0KPiA+
Pg0KPiA+PiBTZWVtcyBsaWtlIHdlIGhhdmUgb25lIG1vcmUgdXNlciBmb3INCj4gPj4gaHR0cDov
L3d3dy5zcGluaWNzLm5ldC9saXN0cy9rZXJuZWwvbXNnMjE1NzUzNS5odG1sDQo+ID4gW1l1XSBU
aGlzIGlzIG5pY2UsIEkgY2FuIGNvbnZlcnQgdGhpcyBwYXRjaCB0byB1c2UgbWF0Y2hfc3RyaW5n
LCBhbmQNCj4gPiBtYXkgSSBhZGQgbXkgcGF0Y2ggaW50byB5b3VyIHBhdGNoc2V0PyBJIHNhdyB0
aGVyZSBhcmUgc29tZQ0KPiA+IG1vZGlmaWNhdGlvbnMgb24gZHJpdmVycyBpbiB5b3VyIHBhdGNo
c2V0IGFib3ZlLg0KPiANCj4gQWN0dWFsbHkgaXQgd2lsbCBub3QgaGVscCBpbiB0aGlzIGNhc2Uu
IFNvcnJ5Lg0KQWgsICBvc2lfc2V0dXBfZW50cmllcyBpcyBhIGFycmF5IG9mIHN0cnVjdHVyZSBy
YXRoZXIgdGhhbiBzdHJpbmcuDQo=
