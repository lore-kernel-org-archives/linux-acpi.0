From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 4/7] ghes_edac: avoid multiple calls to dmi_walk()
Date: Mon, 14 Aug 2017 18:17:47 +0000
Message-ID: <1502734083.2042.143.camel@hpe.com>
References: <20170804040525.GE12082@nazgul.tnic>
         <1501879964.2042.117.camel@hpe.com> <20170805051615.GC23214@nazgul.tnic>
         <1502128177.2042.131.camel@hpe.com> <20170811090414.GB9432@nazgul.tnic>
         <1502725671.2042.137.camel@hpe.com>
         <20170814162436.lta5xm742hh6g7yk@pd.tnic>
         <1502728754.2042.139.camel@hpe.com>
         <20170814170552.j3lhzvnwlpz75y4g@pd.tnic>
         <1502732561.2042.141.camel@hpe.com>
         <20170814180526.wtfjzgc6uye2qtx6@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814180526.wtfjzgc6uye2qtx6@pd.tnic>
Content-Language: en-US
Content-ID: <076EC60BF0A0834AACF71A15613DE467@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: "bp@alien8.de" <bp@alien8.de>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gTW9uLCAyMDE3LTA4LTE0IGF0IDIwOjA1ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgQXVnIDE0LCAyMDE3IGF0IDA1OjUyOjI1UE0gKzAwMDAsIEthbmksIFRvc2hp
bWl0c3Ugd3JvdGU6DQo+ID4gWWVzLCBidXQgdGhpcyBBQ0sgaXMgZG9uZSBwZXIgYSBHSEVTIGVu
dHJ5IGFzIHdlbGwuDQo+IA0KPiBTbyBpcyB0aGUgZ2hlc19lZGFjX3JlcG9ydF9tZW1fZXJyb3Io
KSBjYWxsLg0KDQpSaWdodCwgZ2hlc19lZGFjX3JlcG9ydF9tZW1fZXJyb3IoKSBnZXRzIHNlcmlh
bGl6ZWQgcGVyIGEgR0hFUyBlbnRyeSwNCmJ1dCBub3QgZ2xvYmFsbHkuDQoNClRoYW5rcywNCi1U
b3NoaQ0K
