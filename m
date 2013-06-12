From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] ACPI / APEI: fix error return code in einj_init()
Date: Wed, 12 Jun 2013 13:42:02 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F2DA7A526@ORSMSX106.amr.corp.intel.com>
References: <CAPgLHd-uB=hWRNCgoUhzFzsjQiPj1cuedUk0ttu1g7UXAx=3=Q@mail.gmail.com>
 <4984765.hSvoDJCYAH@vostro.rjw.lan>
 <3908561D78D1C84285E8C5FCA982C28F2DA79B4D@ORSMSX106.amr.corp.intel.com>
 <3066984.NhLpaQnhPR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28390 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168Ab3FLNm3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jun 2013 09:42:29 -0400
In-Reply-To: <3066984.NhLpaQnhPR@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Chen Gong <gong.chen@linux.intel.com>, Wei Yongjun <weiyj.lk@gmail.com>, "lenb@kernel.org" <lenb@kernel.org>, "yongjun_wei@trendmicro.com.cn" <yongjun_wei@trendmicro.com.cn>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

PiBXZWxsLCBhcyBpdCBoYXBwZW5zLCBhbGwgb2YgdGhlc2UgcGF0Y2hlcyBhcmUgaW4gbXkgdHJl
ZSBhcyB3ZWxsLiA6LSkNCg0KRXhjZWxsZW50IQ0KDQo+IEkgYWN0dWFsbHkgZGlkbid0IGtub3cg
dGhhdCB0aGVyZSB3YXMgYSBzZXBhcmF0ZSBwYXRoIHRvIExpbnVzIGZvciBBUEVJDQo+IG1hdGVy
aWFsLg0KDQpJdCdzIG9uZSBvZiB0aGUgbWFueSBncmF5IGFyZWFzIC4uLiBBUEVJIGlzIGNsZWFy
bHkgcGFydCBvZiBBQ1BJLCBidXQgaXQgaXMgYWxzbw0KYWxsIGFib3V0IFJBUyB0b28uDQoNCj4g
RG8geW91IHdhbnQgdG8gaGFuZGxlIGl0IGdvaW5nIGZvcndhcmQgb3IgZG8geW91IHdhbnQgbWUg
dG8gZG8gdGhhdD8gIE9yIGRvDQo+IHlvdSB3YW50IG1lIHRvIHB1bGwgaXQgZnJvbSB5b3U/DQoN
CkkgdGhpbmsgSSdkIGxpa2UgdG8gdGFrZSB0aGVtIGludG8gbXkgdHJlZSBhbmQgdGhlbiBoYXZl
IHlvdSBwdWxsIHRoZW0NCmludG8gdGhlIEFDUEkgdHJlZS4NCg0KLVRvbnkNCg==
