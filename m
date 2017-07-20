From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Thu, 20 Jul 2017 21:07:03 +0000
Message-ID: <1500584265.2042.39.camel@hpe.com>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
         <20170717215912.26070-4-toshi.kani@hpe.com>
         <20170718060007.GB8736@nazgul.tnic> <1500407379.2042.21.camel@hpe.com>
         <20170718181545.32bd9181@vento.lan> <1500481869.2042.29.camel@hpe.com>
         <20170720043344.GC14367@nazgul.tnic> <1500579646.2042.37.camel@hpe.com>
         <20170720171523.4812a8b4@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3427.houston.hpe.com ([15.241.140.73]:43166 "EHLO
        g4t3427.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936098AbdGTVHO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jul 2017 17:07:14 -0400
In-Reply-To: <20170720171523.4812a8b4@vento.lan>
Content-Language: en-US
Content-ID: <A107250500091245866BE797647BB7CC@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "mchehab@s-opensource.com" <mchehab@s-opensource.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

T24gVGh1LCAyMDE3LTA3LTIwIGF0IDE3OjE1IC0wMzAwLCBNYXVybyBDYXJ2YWxobyBDaGVoYWIg
d3JvdGU6DQo+IEVtIFRodSwgMjAgSnVsIDIwMTcgMTk6NTA6MDMgKzAwMDANCj4gIkthbmksIFRv
c2hpbWl0c3UiIDx0b3NoaS5rYW5pQGhwZS5jb20+IGVzY3JldmV1Og0KIDoNCj4gPiBGaXJtd2Fy
ZSBoYXMgYmV0dGVyIGtub3dsZWRnZSBhYm91dCB0aGUgcGxhdGZvcm0gYW5kIGNhbiBwcm92aWRl
DQo+ID4gYmV0dGVyIFJBUyB3aGVuIGltcGxlbWVudGVkIHByb3Blcmx5LsKgwqBJIGFncmVlIHRo
YXQgdXNlcg0KPiA+IGV4cGVyaWVuY2VzIG1heSB2YXJ5IG9uIHBsYXRmb3Jtcy4NCj4gDQo+IEl0
IG1heSBoYXZlIGEgYmV0dGVyIGtub3dsZWRnZSwgd2hlbiB0aGUgdmVuZG9yIHNoaXBzIGRpZmZl
cmVudCBCSU9TDQo+IGZvciBwbGF0Zm9ybXMgd2l0aCBkaWZmZXJlbnQgbW90aGVyYm9hcmQgc2ls
a3NjcmVlbnMsIGJ1dCBhIGxvdCBvZg0KPiB2ZW5kb3JzIGp1c3QgdXNlIHRoZSBzYW1lIEJJT1Mg
b24gZGlmZmVyZW50IG1vZGVscywgd2l0aCB0aGUgc2FtZQ0KPiBpbmZvcm1hdGlvbiBhdCAiTG9j
YXRvciIgYW5kICJCYW5rIExvY2F0b3IiIGRhdGEgYXQgRE1JIHRhYmxlcywNCj4gdGhhdCBkb24n
dCBtYXRjaCB3aGF0J3MgcHJpbnRlZCBhdCB0aGUgYm9hcmQncyBzaWxrc2NyZWVuLg0KPiANCj4g
U28sIEdIRVMgZW5kcyBieSBleHBvc2luZyB3cm9uZyBkYXRhLiBBbHNvLCBzdWNoIEJJT1MgZmFp
bA0KPiB0byBwcm9wZXJseSBleHBvc2Ugc3VjaCBrbm93bGVkZ2UgdG8gZHJpdmVycy91c2Vyc3Bh
Y2UuDQoNCkkgc2VlLiAgWWVhaCwgSSBjYW4gc2VlIHN1Y2ggcHJvYmxlbXMgY291bGQgYmUgb3Zl
cmxvb2tlZCBzaW5jZSBub3JtYWwNCnRlc3RzIHJ1biBqdXN0IGZpbmUgZXZlbiBpZiB0aGVyZSBp
cyBhIG1pc21hdGNoIGluIHN1Y2ggaW5mby4uLg0KDQo+IE9uIHRoZSBkaXNjdXNzaW9ucyBJIGhh
ZCB3aXRoIEhQLCBiYWNrIGluIDIwMTIsIHRoZSBpZGVhIHdhcyB0byB0cnnCoA0KPiB0byBoYXZl
IHNvbWUgc29ydCBvZiB3YXkgZm9yIHRoZSBHSEVTIGRyaXZlciB0byBxdWVyeSB0aGUgQklPUw0K
PiBvbiBhIHJlbGlhYmxlIHdheSwgaW4gb3JkZXIgdG8gZ2V0IGl0cyBsYXlvdXQsIGluIGEgd2F5
DQo+IHRoYXQgdG9vbHMgbGlrZSByYXMtbWMtY3RsIHdvdWxkIHByb3Blcmx5IHJlcG9ydCB0aGUg
bWVtb3J5DQo+IGNvbmZpZ3VyYXRpb24gKHdpdGggLS1sYXlvdXQpIGFuZCB0aGUgbW90aGVyYm9h
cmQgc2lsa3NjcmVlbg0KPiBsYWJlbHMgKHdpdGggLS1wcmludC1sYWJlbHMpLiBVbmZvcnR1bmF0
ZWx5LCBhdCBsZWFzdCBvbiB0aGF0DQo+IHRpbWUsIHRoZSBkaXNjdXNzaW9ucyB3aXRoIEhQIGRp
ZG4ndCBwcm9jZWVkLg0KDQpUaGFua3MgZm9yIHRoZSBpbmZvLiAgSSBob3BlIHdlIGNhbiBlbmFi
bGUgaXQgdGhpcyB0aW1lIGFyb3VuZC4NCi1Ub3NoaQ0KDQoNCg==
