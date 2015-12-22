From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH v4 7/7] ACPI / x86: introduce acpi_os_readable() support
Date: Tue, 22 Dec 2015 01:03:43 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE640286886D1@shsmsx102.ccr.corp.intel.com>
References: <cover.1446790780.git.lv.zheng@intel.com>
 <cover.1449108825.git.lv.zheng@intel.com>
 <af8b1799e7eec686fbb3bf239f6f400adb3b8082.1449108826.git.lv.zheng@intel.com>
 <CALCETrXeoGZhrNr9OmqFB+i7-tbM+d3sO8uCNnMx40JfDsjoEw@mail.gmail.com>
 <36DF59CE26D8EE47B0655C516E9CE64028686D35@shsmsx102.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BB08C24@SHSMSX101.ccr.corp.intel.com>
 <CALCETrWzn_9wL_7zL4GdHrFB3c9qaAjnEbLdU+bppLf-GVsx3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53546 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932109AbbLVBDs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Dec 2015 20:03:48 -0500
In-Reply-To: <CALCETrWzn_9wL_7zL4GdHrFB3c9qaAjnEbLdU+bppLf-GVsx3w@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Andy Lutomirski <luto@kernel.org>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>

SGkgQW5keSwNCnRoYW5rcyBmb3IgeW91ciByZXZpZXcsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQW5keSBMdXRvbWlyc2tpIFttYWlsdG86bHV0b0BhbWFjYXBpdGFs
Lm5ldF0NCj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciAxOCwgMjAxNSAxOjAwIEFNDQo+IFRvOiBa
aGVuZywgTHYNCj4gQ2M6IENoZW4sIFl1IEM7IE1vb3JlLCBSb2JlcnQ7IFd5c29ja2ksIFJhZmFl
bCBKOyBCcm93biwgTGVuOyBBbmR5DQo+IEx1dG9taXJza2k7IEx2IFpoZW5nOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBMaW51eCBBQ1BJOyBILiBQZXRlcg0KPiBBbnZpbjsgQm9yaXNs
YXYgUGV0a292DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNy83XSBBQ1BJIC8geDg2OiBpbnRy
b2R1Y2UgYWNwaV9vc19yZWFkYWJsZSgpIHN1cHBvcnQNCj4gDQpbY3V0XQ0KPiANCj4gSSB0aGlu
ayB0aGF0IGhwYSBvciBCb3Jpc2xhdiBbY2MnZF0gY291bGQgYWRkcmVzcyB0aGUgbWVtb3J5IG1h
cCBkZXRhaWxzDQo+IGJldHRlciB0aGFuIEkgY291bGQuICBIb3dldmVyLCB0aGlzIGZ1bmN0aW9u
YWxpdHkgc2VlbXMgc3RyYW5nZS4NCj4gDQo+IEFyZSB0aGVzZSBwaHlzaWNhbCBhZGRyZXNzZXMg
b3IgdmlydHVhbCBhZGRyZXNzZXMgdGhhdCBhcmUgYmVpbmcgZHVtcGVkPyAgDQpbWXVdIFRoZXkg
YXJlICB2aXJ0dWFsIGFkZHJlc3NlcyB0byBiZSBkdW1wZWQuDQo+IEluICBlaXRoZXIgY2FzZSwg
SVNUTSB0aGF0IHVzaW5nIHNvbWV0aGluZyBpaWtlIHBhZ2VfaXNfcmFtIG1pZ2h0IGJlIGEgbG90
DQo+IHNpbXBsZXIuDQpbWXVdIGlmIGkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHRoaXMgQVBJIGlz
IHVzZWQgdG8gY2hlY2sgaWYgdGhlIGFkZHJlc3MgaXMgYSB2YWxpZCANCidrbWFsbG9jJyBzdHls
ZSBhZGRyZXNzLCBidXQgbm90ICdrbWFwJyBvciAndm1hbGxvYycgYWRkcmVzcywgYW5kIHBhZ2Vf
aXNfcmFtDQptaWdodCB0cmVhdCB0aGUgbGF0dGVyIGFzIHZhbGlkIGFkZHJlc3M/DQoNCnRoYW5r
cywNCll1DQo=
