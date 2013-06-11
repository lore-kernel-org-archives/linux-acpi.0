From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] ACPI / APEI: fix error return code in einj_init()
Date: Tue, 11 Jun 2013 23:04:51 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F2DA79B4D@ORSMSX106.amr.corp.intel.com>
References: <CAPgLHd-uB=hWRNCgoUhzFzsjQiPj1cuedUk0ttu1g7UXAx=3=Q@mail.gmail.com>
 <20130605025927.GD27550@gchen.bj.intel.com>
 <4984765.hSvoDJCYAH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15291 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551Ab3FKXFO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Jun 2013 19:05:14 -0400
In-Reply-To: <4984765.hSvoDJCYAH@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Chen Gong <gong.chen@linux.intel.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, "lenb@kernel.org" <lenb@kernel.org>, "yongjun_wei@trendmicro.com.cn" <yongjun_wei@trendmicro.com.cn>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

PiBRdWV1ZWQgdXAgZm9yIDMuMTEuDQoNCkknZCBpbmRlcGVuZGVudGx5IHF1ZXVlZCB0aGlzIGFu
ZCBhIGNvdXBsZSBvZiBvdGhlciBFSU5KIGZpeGVzIGZyb20gQ2hlbiBHb25nDQppbiBteSBSQVMg
dHJlZSBhbmQgdHJpZWQgdG8gdGVtcHQgSW5nbyB0byBwdWxsIHRoZW0gZm9yIDMuMTEgKHNpbmNl
IHRoaXMgd2FzIHRoZQ0Kcm91dGUgdGhhdCB3ZSdkIHVzZWQgZm9yIEVJTkogc3R1ZmYgaW4gdGhl
IHBhc3QpLg0KDQpJZiB5b3Ugd2FudCB0aGVtLCB0aGVuIHBsZWFzZSBwdWxsIHdoYXQgSW5nbyBp
cyBpZ25vcmluZy4NCg0KSGVyZSdzIHRoZSBlLW1haWwgd2l0aCB0aGUgcGxlYXNlIHB1bGwgZGV0
YWlsczoNCg0KaHR0cDovL21hcmMuaW5mby8/bD1saW51eC1rZXJuZWwmbT0xMzcwNjIxNDcwMTI5
NzMmdz0yDQoNCi1Ub255DQoNCg0KDQoNCg==
