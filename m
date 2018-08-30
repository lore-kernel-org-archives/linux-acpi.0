From: Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Subject: Re: [PATCH RFCv2 0/6] mm: online/offline_pages called w.o.
 mem_hotplug_lock
Date: Thu, 30 Aug 2018 15:54:30 +0000
Message-ID: <b9eb96e7-3846-1aaa-d257-895ca142b1ef@microsoft.com>
References: <20180821104418.12710-1-david@redhat.com>
 <37ea507e-b16d-ae8d-4da8-128b621869f2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <37ea507e-b16d-ae8d-4da8-128b621869f2@redhat.com>
Content-Language: en-US
Content-ID: <C3DB3B11124F444D8932C0F350E2E1D9@namprd21.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Andrew Morton <akpm@linux-foundation.org>, Balbir Singh <bsingharora@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, John Allen <jallen@linux.vnet.ibm.com>, Jonathan
List-Id: linux-acpi@vger.kernel.org

DQoNCk9uIDgvMzAvMTggODozMSBBTSwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+IE9uIDIx
LjA4LjIwMTggMTI6NDQsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPj4gVGhpcyBpcyB0aGUg
c2FtZSBhcHByb2FjaCBhcyBpbiB0aGUgZmlyc3QgUkZDLCBidXQgdGhpcyB0aW1lIHdpdGhvdXQN
Cj4+IGV4cG9ydGluZyBkZXZpY2VfaG90cGx1Z19sb2NrIChyZXF1ZXN0ZWQgYnkgR3JlZykgYW5k
IHdpdGggc29tZSBtb3JlDQo+PiBkZXRhaWxzIGFuZCBkb2N1bWVudGF0aW9uIHJlZ2FyZGluZyBs
b2NraW5nLiBUZXN0ZWQgb25seSBvbiB4ODYgc28gZmFyLg0KPj4NCj4gDQo+IEknbGwgYmUgb24g
dmFjYXRpb24gZm9yIHR3byB3ZWVrcyBzdGFydGluZyBvbiBTYXR1cmRheS4gSWYgdGhlcmUgYXJl
IG5vDQo+IGNvbW1lbnRzIEknbGwgc2VuZCB0aGlzIGFzICFSRkMgb25jZSBJIHJldHVybi4NCj4N
CkkgYW0gc3R1ZHlpbmcgdGhpcyBzZXJpZXMsIHdpbGwgc2VuZCBteSBjb21tZW50cyBsYXRlciB0
b2RheS4NCg0KUGF2ZWw=
