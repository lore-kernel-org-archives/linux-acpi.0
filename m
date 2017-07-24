From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Mon, 24 Jul 2017 15:56:27 +0000
Message-ID: <1500911226.2042.60.camel@hpe.com>
References: <1500650732.2042.45.camel@hpe.com>
         <20170721124401.5f94aba9@vento.lan> <1500654661.2042.49.camel@hpe.com>
         <20170721140131.40079805@vento.lan> <20170721172344.GA11316@nazgul.tnic>
         <1500661773.2042.53.camel@hpe.com> <20170722062853.GA2050@nazgul.tnic>
         <1500907209.2042.55.camel@hpe.com> <20170724150432.GA31295@nazgul.tnic>
         <1500909372.2042.58.camel@hpe.com> <20170724153716.GA17708@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:35607 "EHLO
        g2t2354.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbdGXP4a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jul 2017 11:56:30 -0400
In-Reply-To: <20170724153716.GA17708@nazgul.tnic>
Content-Language: en-US
Content-ID: <92E95868DF8E124F8F0F329F2555A121@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mchehab@s-opensource.com" <mchehab@s-opensource.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

T24gTW9uLCAyMDE3LTA3LTI0IGF0IDE3OjM3ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgSnVsIDI0LCAyMDE3IGF0IDAzOjI1OjM0UE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQogOg0KPiANCj4gPiBXZSd2ZSBiZWVuIHByb3ZpZGluZyB0aGlzIG1vZGVs
IGZvciBtYW55IHllYXJzIG5vdy4NCj4gDQo+IER1ZGUsIHJlbGF4LCBJJ20gb25seSB0cnlpbmcg
dG8gcG9pbnQgb3V0IHRvIHlvdSB0aGF0IHRoZXJlIGFyZQ0KPiBjdXN0b21lcnMgd2hvIHdhbnQg
dG8gc2VlICpldmVyeSogZXJyb3IgYW5kIHRodXMgdHJhY2sgaG93IHRoZWlyDQo+IGhhcmR3YXJl
IGJlaGF2ZXMuIEFuZCB0aGF0IGZvciB0aG9zZSBjdXN0b21lcnMgaXQgaXMgcHJvYmFibHkgd29y
dGgNCj4gY29uc2lkZXJpbmcgZXhwb3NpbmcgdGhhdCBpbmZvIGFuZCBwcm92aWRpbmcgYSBzd2l0
Y2ggdG8gZGlzYWJsZSB0aGF0DQo+IGR1bWJpbmcgb2YgdGhlIFJBUyBmdW5jdGlvbmFsaXR5IGlu
IHRoZSBCSU9TIHNvIHRoYXQgcGVvcGxlIGNhbg0KPiBkZWNpZGUgZm9yIHRoZW1zZWx2ZXMuIFRo
YXQncyBhbGwuDQoNClllcywgTWF1cm8gaGFzIGFscmVhZHkgcG9pbnRlZCB0aGlzIG91dC4gIEFz
IEkgcmVwbGllZCB0byBoaW0sIHdlIGRvDQpoYXZlIGEgc2VwYXJhdGUgc2VyaWVzIG9mIHBsYXRm
b3JtcyB0aGF0IGRvIG5vdCBoYXZlIGJ1aWx0LWluIFJBUywgYW5kDQpyZXBvcnQgYWxsIGVycm9y
cy4gwqBTdWNoIGN1c3RvbWVycyBjYW4gc2ltcGx5IGNob29zZSB0aGVtLiAgVGhleSBkbyBub3QN
Cm5lZWQgdG8gcGF5IGZvciBidWlsdC1pbiBSQVMuDQoNClRoZSBtb2RlbCB3LyBidWlsdC1pbiBS
QVMgcHJvdmlkZXMgd2FycmFudHkgJiBmdWxsIHN1cHBvcnQuICBBcyBJIHNhaWQsDQppdCdzIGEg
ZGlmZmVyZW50IG1vZGVsLiANCg0KVGhhbmtzLA0KLVRvc2hpDQo=
