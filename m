From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Fri, 21 Jul 2017 18:38:52 +0000
Message-ID: <1500661773.2042.53.camel@hpe.com>
References: <1500579646.2042.37.camel@hpe.com>
         <20170721133441.GB5036@nazgul.tnic> <20170721104001.3cd2b884@vento.lan>
         <20170721134715.GC5036@nazgul.tnic> <1500649162.2042.43.camel@hpe.com>
         <20170721151317.GA13424@nazgul.tnic> <1500650732.2042.45.camel@hpe.com>
         <20170721124401.5f94aba9@vento.lan> <1500654661.2042.49.camel@hpe.com>
         <20170721140131.40079805@vento.lan> <20170721172344.GA11316@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:43312 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752811AbdGUSko (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2017 14:40:44 -0400
In-Reply-To: <20170721172344.GA11316@nazgul.tnic>
Content-Language: en-US
Content-ID: <3EEA8ED1D0BC644BAC30E3AAB361F283@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "mchehab@s-opensource.com" <mchehab@s-opensource.com>, "bp@alien8.de" <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

T24gRnJpLCAyMDE3LTA3LTIxIGF0IDE5OjIzICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQogOg0KPiBOb3Qgb25seSB0aGF0OiB0aHJlc2hvbGRzIGRlcGVuZCBvbiB0aGUgRElNTSB0eXBl
cyB3aGljaCBtZWFucywNCkJJT1MNCj4gbXVzdCBrbm93IHdoYXQgRElNTSB0eXBlcyBhcmUgaW4g
dGhlcmUgd2hpY2ggSSBkb3VidC4gDQoNCkJJT1Mga25vd3MgRElNTSBtb2RlbCBmcm9tIHRoZSBT
UEQgZGF0YS4NCg0KPiBTbyBleHBvc2luZyB0aGF0IHRvIGNvbmZpZ3VyYXRpb24gaW5zdGVhZCBv
ZiAiZGVjaWRpbmciIGZvciBwZW9wbGUNCj4gd291bGQgYmUgYmV0dGVyLg0KDQpFbnRlcnByaXNl
IHBsYXRmb3JtcyBoYXZlIHZlcnkgZGlmZmVyZW50IG1vZGVsIChJIGRvIG5vdCBzYXkgaXQncw0K
YmV0dGVyIGZvciBldmVyeW9uZSBmcm9tIHRoZSBjb3N0IHBlcnNwZWN0aXZlKS4gIFR5cGljYWxs
eSwgc3VjaA0KcGxhdGZvcm0gdmVuZG9ycyB3b3JrIHdpdGggRElNTSB2ZW5kb3JzIGRpcmVjdGx5
IHRvIGNvbWUgd2l0aCB0aGVpcg0Kc3VwcG9ydGVkIERJTU1zIHdpdGggb3duIHBhcnQgbnVtYmVy
cywgd2hpY2ggYXJlIGNlcnRpZmllZCBmb3IgdGhlDQpwbGF0Zm9ybXMgd2l0aCBleHRlbnNpdmUg
dmFsaWRhdGlvbiB0ZXN0aW5ncy4NCg0KVGhhbmtzLA0KLVRvc2hpDQo=
