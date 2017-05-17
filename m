From: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH 1/2] x86/MCE: Export memory_error()
Date: Wed, 17 May 2017 18:58:00 +0000
Message-ID: <1495047396.20330.16.camel@intel.com>
References: <20170425210740.GA15722@omniknight.lm.intel.com>
         <1494444606.20330.2.camel@intel.com>
         <20170510200406.mphusoidfuyq24ee@pd.tnic>
         <1494446729.20330.4.camel@intel.com>
         <20170510200851.mhz3434jauxdq2u5@pd.tnic>
         <1494450649.20330.6.camel@intel.com>
         <20170510215707.v7zywrslma4o7jao@pd.tnic>
         <1494453738.20330.8.camel@intel.com>
         <20170510221631.3ue63iw3mgh2d6xt@pd.tnic>
         <1494454869.20330.9.camel@intel.com>
         <20170517123839.xkd25bcj3bf7rdlc@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:15688 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbdEQTGp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 May 2017 15:06:45 -0400
In-Reply-To: <20170517123839.xkd25bcj3bf7rdlc@pd.tnic>
Content-Language: en-US
Content-ID: <432CD4436F17744BA6447795DC8ACE24@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

T24gV2VkLCAyMDE3LTA1LTE3IGF0IDE0OjM4ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFdlZCwgTWF5IDEwLCAyMDE3IGF0IDEwOjIyOjMyUE0gKzAwMDAsIFZlcm1hLCBWaXNo
YWwgTCB3cm90ZToNCj4gPiA+IEknbGwgcHJlcCB0aGUgcXVldWUgbmV4dCB3ZWVrIGFuZCBydW4g
dGVzdHMuDQo+ID4gPiANCj4gPiANCj4gPiBPaywgVGhhbmtzIEJvcmlzIQ0KPiANCj4gT2ssIEkn
dmUgcHVzaGVkIGEgYnJhbmNoOg0KPiANCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvYnAvYnAuZ2l0L2xvZy8/aD10aXAtcg0KPiBhcy1wZW5kaW5nDQo+
IA0KPiBQbGVhc2UgaGF2ZSBhIGxvb2ssIHRlc3QsIHBva2UsIGV0Yy4uLg0KDQpRdWljay9taW5v
ciBvYnNlcnZhdGlvbiAtIHlvdSBtb3ZlZCB0aGUgRVhQT1JUX1NZTUJPTF9HUEwgaW50byB5b3Vy
DQpvcmlnaW5hbCBwYXRjaCwgYnV0IHRoZSBjb21taXQgbWVzc2FnZSBvZiBtaW5lIHN0aWxsIHRh
bGtzIGFib3V0DQpleHBvcnRpbmcuIFBlcmhhcHMgaXQgc2hvdWxkIHJlYWQ6DQoNCiJVc2UgdGhl
IG5ldyBtY2VfaXNfbWVtb3J5X2Vycm9yKCkgaGVscGVyLi4iDQoNClRoYW5rcywNCglWaXNoYWwN
Cg0KPiANCj4gVGhhbmtzLg0KPiA=
