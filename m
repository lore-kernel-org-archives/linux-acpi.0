From: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH 2/3] acpi: add a utility function for evaluating _FIT
Date: Fri, 9 Oct 2015 17:54:06 +0000
Message-ID: <1444413246.9638.7.camel@intel.com>
References: <1444254577-23744-1-git-send-email-vishal.l.verma@intel.com>
	 <1444254577-23744-3-git-send-email-vishal.l.verma@intel.com>
	 <x497fmwj6ia.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:24338 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755741AbbJIRyM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Oct 2015 13:54:12 -0400
In-Reply-To: <x497fmwj6ia.fsf@segfault.boston.devel.redhat.com>
Content-Language: en-US
Content-ID: <8FC7F589B1FC784E9D372747FF5BB04A@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "jmoyer@redhat.com" <jmoyer@redhat.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-nvdimm@ml01.01.org" <linux-nvdimm@ml01.01.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

T24gRnJpLCAyMDE1LTEwLTA5IGF0IDEzOjI4IC0wNDAwLCBKZWZmIE1veWVyIHdyb3RlOg0KPiBW
aXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4gd3JpdGVzOg0KPiANCj4gPiAg
LyoqDQo+ID4gKyAqIGFjcGlfZXZhbHVhdGVfZml0OiBFdmFsdWF0ZSBfRklUIG1ldGhvZCB0byBn
ZXQgYW4gdXBkYXRlZCBORklUDQo+ID4gKyAqIEBoYW5kbGU6IEFDUEkgZGV2aWNlIGhhbmRsZQ0K
PiA+ICsgKiBAYnVmOiBidWZmZXIgZm9yIHRoZSB1cGRhdGVkIE5GSVQNCj4gPiArICoNCj4gPiAr
ICogRXZhbHVhdGUgZGV2aWNlJ3MgX0ZJVCBtZXRob2QgaWYgcHJlc2VudCB0byBnZXQgYW4gdXBk
YXRlZCBORklUDQo+ID4gKyAqLw0KPiA+ICthY3BpX3N0YXR1cyBhY3BpX2V2YWx1YXRlX2ZpdChh
Y3BpX2hhbmRsZSBoYW5kbGUsIHN0cnVjdA0KPiA+IGFjcGlfYnVmZmVyICoqYnVmKQ0KPiA+ICt7
DQo+ID4gKwlhY3BpX3N0YXR1cyBzdGF0dXM7DQo+ID4gKwlzdHJ1Y3QgYWNwaV9idWZmZXIgYnVm
ZmVyID0geyBBQ1BJX0FMTE9DQVRFX0JVRkZFUiwgTlVMTA0KPiA+IH07DQo+ID4gKw0KPiA+ICsJ
c3RhdHVzID0gYWNwaV9ldmFsdWF0ZV9vYmplY3QoaGFuZGxlLCAiX0ZJVCIsIE5VTEwsDQo+ID4g
JmJ1ZmZlcik7DQo+ID4gKw0KPiA+ICsJaWYgKEFDUElfRkFJTFVSRShzdGF0dXMpKQ0KPiA+ICsJ
CXJldHVybiBzdGF0dXM7DQo+ID4gKw0KPiA+ICsJKmJ1ZiA9ICZidWZmZXI7DQo+IA0KPiBVbW0s
IHVubGVzcyBJJ20gbWlzc2luZyBzb21ldGhpbmcsIHlvdSdyZSByZXR1cm5pbmcgYSBzdGFjayBh
ZGRyZXNzLg0KDQpHb29kIHBvaW50LCB5b3UncmUgcmlnaHQuIERhbi9SYWZhZWwsIGlzIGl0IE9L
IHRvIGp1c3QgcmVtb3ZlIHRoaXMNCnBhdGNoIGVudGlyZWx5LCBhbmQgY2FsbCBhY3BpX2V2YWx1
YXRlX29iamVjdCBkaXJlY3RseSBmcm9tIG5maXQuYz8gVGhlDQpjdXJyZW50IHdheSBkaWQgZmVl
bCBhIGJpdCBrbHVkZ2V5IHRvIG1lIGFueSB3YXkgYmVjYXVzZSBJIHdhcw0KYWxsb2NhdGluZyBh
IGJ1ZmZlciBoZXJlIChhYm92ZSksIGJ1dCB0cnlpbmcgdG8gZnJlZSBpdCBpbiB0aGUgY2FsbGVy
LA0Kd2hpY2ggc2VlbXMgdmVyeSB1Z2x5Li4NCg==
