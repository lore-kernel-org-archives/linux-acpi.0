From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH v4 7/7] ACPI / x86: introduce acpi_os_readable() support
Date: Thu, 24 Dec 2015 07:57:34 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE64028688FC9@shsmsx102.ccr.corp.intel.com>
References: <cover.1446790780.git.lv.zheng@intel.com>
 <cover.1449108825.git.lv.zheng@intel.com>
 <af8b1799e7eec686fbb3bf239f6f400adb3b8082.1449108826.git.lv.zheng@intel.com>
 <CALCETrXeoGZhrNr9OmqFB+i7-tbM+d3sO8uCNnMx40JfDsjoEw@mail.gmail.com>
 <36DF59CE26D8EE47B0655C516E9CE64028686D35@shsmsx102.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BB08C24@SHSMSX101.ccr.corp.intel.com>
 <CALCETrWzn_9wL_7zL4GdHrFB3c9qaAjnEbLdU+bppLf-GVsx3w@mail.gmail.com>
 <36DF59CE26D8EE47B0655C516E9CE640286886D1@shsmsx102.ccr.corp.intel.com>
 <CALCETrVcYbqNpVi4J_iQL1WPYCA1zPJAs+csx73CaQvYziDY1g@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E883BB0A29B@SHSMSX101.ccr.corp.intel.com>
 <CALCETrWBavzmaDy5u_O09rdqiRn4K=pjDwkwd+hdGd4OWV-+6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64591 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753050AbbLXH5x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Dec 2015 02:57:53 -0500
In-Reply-To: <CALCETrWBavzmaDy5u_O09rdqiRn4K=pjDwkwd+hdGd4OWV-+6g@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Andy Lutomirski <luto@kernel.org>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>

SGksQW5keQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHkgTHV0
b21pcnNraSBbbWFpbHRvOmx1dG9AYW1hY2FwaXRhbC5uZXRdDQo+IFNlbnQ6IFRodXJzZGF5LCBE
ZWNlbWJlciAyNCwgMjAxNSA5OjQwIEFNDQo+IFRvOiBaaGVuZywgTHYNCj4gQ2M6IENoZW4sIFl1
IEM7IE1vb3JlLCBSb2JlcnQ7IFd5c29ja2ksIFJhZmFlbCBKOyBCcm93biwgTGVuOyBBbmR5DQo+
IEx1dG9taXJza2k7IEx2IFpoZW5nOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBMaW51
eCBBQ1BJOyBILiBQZXRlcg0KPiBBbnZpbjsgQm9yaXNsYXYgUGV0a292DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjQgNy83XSBBQ1BJIC8geDg2OiBpbnRyb2R1Y2UgYWNwaV9vc19yZWFkYWJsZSgp
IHN1cHBvcnQNCj4gDQo+IE9uIFR1ZSwgRGVjIDIyLCAyMDE1IGF0IDc6MjUgUE0sIFpoZW5nLCBM
diA8bHYuemhlbmdAaW50ZWwuY29tPiB3cm90ZToNCltjdXRdDQo+IA0KPiBJdCBzZWVtcyBhIGJp
dCB1bmZvcnR1bmF0ZSB0byBtZSB0aGF0IHRoZSBBQ1BJQ0EgZGVidWdnZXIgbGV0cyB1c2Vyc3Bh
Y2UNCj4gY2hvb3NlIHdoYXQgYWRkcmVzcyB0byBkdW1wIHJhdGhlciB0aGFuIGR1bXBpbmcgYnkg
cGF0aG5hbWUsIGJ1dCBnaXZlbg0KPiB0aGF0IGNvbnN0cmFpbnQsIEkgZ3Vlc3MgdGhpcyBmdW5j
dGlvbiBpcyBuZWVkZWQuDQo+IA0KPiBDYW4geW91IGRvIHNvbWV0aGluZyBsaWtlIGNoZWNraW5n
IHZpcnRfYWRkcl92YWxpZCBhbmQgdGhlbiB1c2luZw0KPiB2aXJ0X3RvX3BmbiBhbmQgcGFnZV9p
c19yYW0/ICBJZiB0aGF0J3Mgbm90IGVub3VnaCAoZS5nLiBpZiBpdCBkb2Vzbid0IHdvcmsgZm9y
DQo+IHZtYWxsb2MgYWRkcmVzc2VzIGFuZCB5b3UgbmVlZCB0aG9zZSksIHlvdSBjb3VsZCB0cnkg
dG8gZG8gc29tZXRoaW5nIGxpa2UNCj4gc2xvd192aXJ0X3RvX3BoeXMsIGJ1dCB5b3UnZCBuZWVk
IHRvIGRvIHNvbWUgZXh0cmEgY2hlY2tzIHRvIGF2b2lkIHRoZQ0KPiBCVUcgaW4gdGhlIGZ1bmN0
aW9uLg0KPiANCltZdV0gVGhpcyBpcyBhICBnb29kIG1ldGhvZCwgIGZpcnN0bHkgdmlydF9hZGRy
X3ZhbGlkIGNhbiAgZXhjbHVkZSB0aGUgdmFkZHIgb2Ygdm1hbGxvYy9rbWFwDQosIHRoZW4gc2xv
d192aXJ0X3RvX3BoeXMgY2FuIGNoZWNrIGlmIHRoaXMgdmFkZHIgaGFzIGEgdmFsaWQgcHRlIHBo
eXNpY2FsIGFkZHJlc3MsIGJ1dCBJIGd1ZXNzDQp3ZSBuZWVkIGFub3RoZXIgbm9uLUJVR19vbiB2
ZXJzaW9uIG9mIHNsb3dfdmlydF90b19waHlzLCAgSSdsbCB0cnkgdG8gdGVzdCB3aXRoIHlvdXIg
c3VnZ2VzdGlvbiwNCnRoYW5rcyENCll1DQoNCg0K
