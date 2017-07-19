From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Wed, 19 Jul 2017 16:10:07 +0000
Message-ID: <1500480051.2042.27.camel@hpe.com>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
         <20170717215912.26070-4-toshi.kani@hpe.com>
         <20170718060007.GB8736@nazgul.tnic> <20170718080836.GB8372@nazgul.tnic>
         <1500412288.2042.25.camel@hpe.com> <20170719055235.GD26030@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:46288 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754369AbdGSQKS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jul 2017 12:10:18 -0400
In-Reply-To: <20170719055235.GD26030@nazgul.tnic>
Content-Language: en-US
Content-ID: <52895BDA465CFE48BB7EBD21C875F15B@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

T24gV2VkLCAyMDE3LTA3LTE5IGF0IDA3OjUyICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFR1ZSwgSnVsIDE4LCAyMDE3IGF0IDA5OjIwOjQ0UE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gSSBhZ3JlZSB0aGF0ICdvc2Nfc2JfYXBlaV9zdXBwb3J0X2Fja2Vk
JyBzaG91bGQgYmUgY2hlY2tlZCB3aGVuDQo+ID4gZW5hYmxpbmcgZ2hlc19lZGFjLsKgwqBJIGRv
IG5vdCBrbm93IHRoZSBkZXRhaWxzIG9mIGV4aXN0aW5nIGlzc3VlcywNCj4gPiBidXQgaXQgc291
bmRzIHVubGlrZWx5IHRoYXQgdGhpcyB3aWxsIGFkZHJlc3MgYWxsIG9mIHRoZW0gc2luY2UNCj4g
PiBidWdzIGNhbiBiZSBldmVyeXdoZXJlLg0KPiANCj4gTm8sIHNlZSBiZWxvdy4NCj4gDQo+ID4g
Rm9yIGluc3RhbmNlLCBnaGVzX2VkYWMgcmVsaWVzIG9uIERNSS9TTUJJT1MgaW5mbywgdW5saWtl
DQo+ID4gb3RoZXIgRURBQyBkcml2ZXJzLCB3aGljaCBjYW4gYmUgYnVnZ3kgcmVnYXJkbGVzcyBv
ZiB0aGlzIF9PU0MNCj4gPiBpbmZvLg0KPiANCj4gVGhhdCdzIHRoZSBwcm9ibGVtIHdpdGggZmly
bXdhcmUuIFlvdSBjYW4ndCByZWFsbHkgZml4IGl0IGFuZCBpdCBpcw0KPiBidWdneSBhcyBoZWxs
Lg0KDQpSaWdodCwgYW5kIHRoYXQncyB3aGF0IEkgd2FzIHRvbGQgYXMgYW4gaXNzdWUgZm9yIGdo
ZXNfZWRhYy4gIFRoaXMgaXMNCndoeSB0aGlzIHBhdGNoIGludHJvZHVjZXMgYSB3aGl0ZS1saXN0
IHRvIHByZWNsdWRlIGFsbCBidWdneSBmaXJtd2FyZXMNCnRoYXQgYXJlIHVua25vd24gdG8gdXMu
Li4NCg0KPiA+IEkgYWdyZWUgdGhhdCBtYWtpbmcgZ2hlc19lZGFjIGFzIGEgbm9ybWFsIG1vZHVs
ZSBpcyBhIGdvb2QgdGhpbmcsDQo+ID4gYnV0IEkgZG8gbm90IHRoaW5rIGl0J3MgZ29pbmcgdG8g
c29sdmUgdGhpcyBpc3N1ZS4NCj4gDQo+IE9mIGNvdXJzZSBpdCB3aWxsIC0gaWYgdGhlIGZpcm13
YXJlIHNheXMgaXQgd2FudHMgdG8gbG9vayBhdCB0aGUNCj4gZXJyb3JzIGZpcnN0LCB0aGVuIGl0
IGdldHMgdG8gZG8gc28uIFRoaXMgaXMgdGhlIHdob2xlIGhhbmRsaW5nIG9mDQo+IGhhcmR3YXJl
IGVycm9ycyBpbiB0aGUgZmlybXdhcmUgZGVhbC4gSSBhZG1pdCwgc29tZXRpbWVzIGl0IG1ha2Vz
DQo+IHNlbnNlIGJlY2F1c2UgdGhlIGZpcm13YXJlIGhhcyB0aGUgbW9zdCBpbnRpbWF0ZSBrbm93
bGVkZ2Ugb2YgdGhlDQo+IHBsYXRmb3JtIGFuZCwgaW4gYSBwZXJmZWN0IHdvcmxkLCB3ZSB3b24n
dCBldmVyIG5lZWQgdG8gaGF2ZQ0KPiBwbGF0Zm9ybS1zcGVjaWZpYyBFREFDIGRyaXZlcnMuDQo+
DQo+IEJ1dCwgd2UgZG9uJ3QgbGl2ZSBpbiBhIHBlcmZlY3Qgd29ybGQuIEFuZCB0aGUgdmVuZG9y
IGV4ZWN1dGlvbiBvZg0KPiB0aGUgd2hvbGUgZmlybXdhcmUtZXJyb3ItaGFuZGxpbmcgZGVhbCBp
cyBhbiBhYm9taW5hdGlvbiBhdCBiZXN0Lg0KPiANCj4gU28sIGlmIHdlIHJlYWxpemUgdGhhdCB0
aGUgZmlybXdhcmUgaXMgYnVnZ3ksIHdlIGNhbiB1c2UgYSBwbGF0Zm9ybQ0KPiBsaXN0IHRvIGJs
YWNrbGlzdCBpdCAoXmhpbnQgaGludF4pIGFuZCBoYXZlIGEgcGFyYW1ldGVyIHRvIGRpc2FibGUN
Cj4gZ2hlc19lZGFjIGZyb20gbG9hZGluZy4NCg0KU2V0dGluZyBibGFja2xpc3QgbmVlZHMgdXMg
dG8gZW5hYmxlIGdoZXNfZWRhYyBhbmQgZmluZCBhbGwgYnVnZ3kNCmZpcm13YXJlcyB0byBkYXRl
LiAgSSB0aGluayB0aGlzIGlzIHRvbyBkaXN0dXJiaW5nIGZvciBwZW9wbGUgd2hvIGFyZQ0KaGFw
cGlseSB1c2luZyByZWd1bGFyIGVkYWMgZHJpdmVycyB0b2RheSBldmVuIHRob3VnaCB0aGVpciBw
bGF0Zm9ybXMNCmhhdmUgR0hFUy4NCg0KPiBCdXQgd2UnbGwgZGVhbCB3aXRoIHRoYXQgd2hlbiB3
ZSBnZXQgdG8gY3Jvc3MgdGhhdCBicmlkZ2UuIFJpZ2h0IG5vdywNCj4gSSdkIGxpa2UgdG8gZG8g
dGhlIGxvYWRpbmcgc3BlYy1jb25mb3JtIGFuZCBub3QgZmlkZGxlIHdpdGggd2hpdGUtLA0KPiBi
bGFjay0sIG9yIGFueS1vdGhlci1jb2xvciBsaXN0cy4NCg0KSSBkbyBwcmVmZXIgdG8gYXZvaWQg
YW55IHdoaXRlIC8gYmxhY2sgbGlzdGluZy4gIEJ1dCBJIGRvIG5vdCBzZWUgaG93DQppdCBzb2x2
ZXMgdGhlIGJ1Z2d5IERNSS9TTUJJT1MgaW5mbyBhcyBhbiBleGFtcGxlIG9mIGZpcm13YXJlIGJ1
Z3Mgd2UNCm1heSBoYXZlIHRvIGRlYWwgd2l0aC4NCg0KVGhhbmtzLA0KLVRvc2hpDQo=
