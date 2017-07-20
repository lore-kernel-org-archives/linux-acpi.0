From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Thu, 20 Jul 2017 19:50:03 +0000
Message-ID: <1500579646.2042.37.camel@hpe.com>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
         <20170717215912.26070-4-toshi.kani@hpe.com>
         <20170718060007.GB8736@nazgul.tnic> <1500407379.2042.21.camel@hpe.com>
         <20170718181545.32bd9181@vento.lan> <1500481869.2042.29.camel@hpe.com>
         <20170720043344.GC14367@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3427.houston.hpe.com ([15.241.140.73]:43092 "EHLO
        g4t3427.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935971AbdGTTuH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jul 2017 15:50:07 -0400
In-Reply-To: <20170720043344.GC14367@nazgul.tnic>
Content-Language: en-US
Content-ID: <A3BFE52D4D0A8E49A0FC82B581AEA96F@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mchehab@s-opensource.com" <mchehab@s-opensource.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

T24gVGh1LCAyMDE3LTA3LTIwIGF0IDA2OjMzICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFdlZCwgSnVsIDE5LCAyMDE3IGF0IDA0OjQwOjI1UE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gwqBnaGVzX2VkYWMgYWxsb3dzIHRvIHJlcG9ydCBlcnJvcnMgdG8g
T1MgbWFuYWdlbWVudCB0b29scyBsaWtlDQo+ID4gcmFzZGFlbW9uIGluIGFkZGl0aW9uIHRvIHBs
YXRmb3JtLSBzcGVjaWZpYyBtYW5hZ2VtZW50cy4NCj4gDQo+IFNvIGdoZXNfZWRhYyAqaXMqIGEg
cG9vciBtYW4ncyBkcml2ZXIgaW4gdGhlIHNlbnNlIHRoYXQgaXQgZG9lc24ndCBkbw0KPiBhbnl0
aGluZyBmYW5jeSBidXQgcmVwZWF0IGxpa2UgYSBwYXJyb3QgZGF0YSBpdCBoYXMgZ290dGVuIGZy
b20gdGhlDQo+IGZpcm13YXJlIGFuZCBzaG92aW5nIGl0IGludG8gdGhlIEVEQUMgY291bnRlcnMu
IEF0IGxlYXN0IHRoYXQncyB0aGUNCj4gaW50ZW50aW9uLiBOb3RoaW5nIG1vcmUuIA0KDQpSaWdo
dCBmb3IgZ2hlc19lZGFjLg0KDQo+IEFsbCB0aGUgYWN0aW9uIHN0dWZmIGxpa2UgZXJyb3IgZGV0
ZWN0aW9uIGFuZCByZWNvdmVyeSBzaG91bGQgYmUgZG9uZQ0KPiBieSB0aGUgZmlybXdhcmUuDQoN
CkdIRVMgLyBmaXJtd2FyZS1maXJzdCBzdGlsbCByZXF1aXJlcyBPUyByZWNvdmVyeSBhY3Rpb25z
wqB3aGVuIGFuIGVycm9yDQpjYW5ub3QgYmUgY29ycmVjdGVkIGJ5IHRoZSBwbGF0Zm9ybS4gIFRo
ZXkgYXJlIGhhbmRsZWQgYnkgZ2hlc19wcm9jKCksDQphbmQgZ2hlc19lZGFjIHJlbWFpbnMgaXRz
IGVycm9yLXJlcG9ydGluZyB3cmFwcGVyLg0KDQo+IEJ1dCBjb25zaWRlcmluZyBob3cgU05BRlUn
ZCBmaXJtd2FyZSBpcywgSSB3b3VsZG4ndCBleHBlY3QgYW55IGdyZWF0DQo+IFJBUyBmdW5jdGlv
bmFsaXR5IHRoZXJlLiBPZiBjb3Vyc2UsIEknZCBiZSBkZWxpZ2h0ZWQgdG8gYmUgcHJvdmVuDQo+
IHdyb25nLg0KDQpGaXJtd2FyZSBoYXMgYmV0dGVyIGtub3dsZWRnZSBhYm91dCB0aGUgcGxhdGZv
cm0gYW5kIGNhbiBwcm92aWRlIGJldHRlcg0KUkFTIHdoZW4gaW1wbGVtZW50ZWQgcHJvcGVybHku
ICBJIGFncmVlIHRoYXQgdXNlciBleHBlcmllbmNlcyBtYXkgdmFyeQ0Kb24gcGxhdGZvcm1zLg0K
DQpUaGFua3MsDQotVG9zaGkNCg==
