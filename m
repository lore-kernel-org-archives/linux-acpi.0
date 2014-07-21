From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [RFC PATCH 2/3] x86, MCE: Avoid potential deadlock in MCE
 context
Date: Mon, 21 Jul 2014 22:03:04 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F32871435@ORSMSX114.amr.corp.intel.com>
References: <1405478082-30757-1-git-send-email-gong.chen@linux.intel.com>
 <1405478082-30757-3-git-send-email-gong.chen@linux.intel.com>
 <20140721084737.GA10016@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F32870C55@ORSMSX114.amr.corp.intel.com>
 <20140721214116.GC11555@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20140721214116.GC11555@pd.tnic>
Content-Language: en-US
Sender: owner-linux-mm@kvack.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>
List-Id: linux-acpi@vger.kernel.org

PiBBbmQgZHJvcCBhbGwgdGhlIGhvbWVncm93biBvdGhlciBzdHVmZiBsaWtlIG1jZV9yaW5nIGFu
ZCBhbGw/DQoNCm1jZV9yaW5nIHNob3VsZCBiZSBlYXN5IC4uLiB0aGUgIm1jZSIgc3RydWN0dXJl
IGhhcyB0aGUgYWRkcmVzcw0KZnJvbSB3aGljaCB3ZSBjYW4gZWFzaWx5IGdldCB0aGUgcGZuIHRv
IHBhc3MgaW50byB0aGUgYWN0aW9uLW9wdGlvbmFsDQpyZWNvdmVyeSBwYXRoLiAgT25seSB0aGlu
ZyBtaXNzaW5nIGlzIGEgZGlyZWN0IGluZGljYXRpb24gdGhhdCB0aGlzIG1jZQ0KZG9lcyBjb250
YWluIGFuIEFPIGVycm9yIHRoYXQgbmVlZHMgdG8gYmUgcHJvY2Vzc2VkLiBXZSBjb3VsZA0KcmUt
aW52b2tlIG1jZV9zZXZlcml0eSgpIHRvIGZpZ3VyZSBpdCBvdXQgYWdhaW4gLSBvciBqdXN0IGFk
ZCBhIGZsYWcNCnNvbWV3aGVyZS4NCg0KTm90IHNvIHN1cmUgYWJvdXQgbWNlX2luZm8uIFRoaXMg
b25lIHBhc3NlcyBmcm9tIHRoZQ0KTUNFIGNvbnRleHQgdG8gdGhlIHNhbWUgdGFzayB3aGVuIHdl
IGNhdGNoIGl0IGluIHByb2Nlc3MNCmNvbnRleHQgKHNldF90aHJlYWRfZmxhZyhNQ0VfTk9USUZZ
KSkuICBCYWNrIHdoZW4gSSB3YXMgcHVzaGluZw0KdGhpcyBjb2RlIGl0LCBJIHJlYWxseSB3YW50
ZWQgdG8ganVzdCBhZGQgYSBmaWVsZCB0byB0aGUgdGhyZWFkX2luZm8NCnN0cnVjdHVyZSB0byBo
b2xkIHRoZSBhZGRyZXNzIC4uLiBiZWNhdXNlIHRoaXMgcmVhbGx5IGlzIHNvbWUNCmluZm9ybWF0
aW9uIHRoYXQgYmVsb25ncyB0byB0aGUgdGhyZWFkLiBCdXQgSSB3YXMgdW5hYmxlIHRvDQpjb252
aW5jZSBwZW9wbGUgYmFjayB0aGVuLiAgV2UgbXVzdCBiZSBhYmxlIHRvIGZpbmQgdGhlDQpwYWdl
IGZyYW1lIHdoZW4gd2UgYXJyaXZlIGluIG1jZV9ub3RpZnlfcHJvY2VzcygpLiBTbyB3ZQ0KY2Fu
J3Qgc3Rhc2ggaXQgaW4gc29tZSBsaW1pdGVkIHNpemUgcG9vbCBvZiAibWNlIiBzdHJ1Y3R1cmVz
IHRoYXQNCm1pZ2h0IGRlY2lkZSB0byBqdXN0IGRyb3AgdGhpcyBvbmUuDQoNCi1Ub255DQoNCg==

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
