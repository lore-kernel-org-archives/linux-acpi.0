From: Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Subject: Re: [PATCH RFCv2 1/6] mm/memory_hotplug: make remove_memory() take
 the device_hotplug_lock
Date: Thu, 30 Aug 2018 19:35:48 +0000
Message-ID: <46a0119b-da16-0203-a8c2-d127738517f4@microsoft.com>
References: <20180821104418.12710-1-david@redhat.com>
 <20180821104418.12710-2-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821104418.12710-2-david@redhat.com>
Content-Language: en-US
Content-ID: <DCFCA70729284F4B88E5C6C04E0B640A@namprd21.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Rashmica Gupta <rashmica.g@gmail.com>, Michael Neuling <mikey@neuling.org>, Balbir Singh <bsingharora@gmail.com>, Nathan Fontenot <nfont@linux.vnet.ibm.com>, John Allen <jallen@linux.vnet.ibm.com>A
List-Id: linux-acpi@vger.kernel.org

PiArDQo+ICt2b2lkIF9fcmVmIHJlbW92ZV9tZW1vcnkoaW50IG5pZCwgdTY0IHN0YXJ0LCB1NjQg
c2l6ZSkNCg0KUmVtb3ZlIF9fcmVmLCBvdGhlcndpc2UgbG9va3MgZ29vZDoNCg0KUmV2aWV3ZWQt
Ynk6IFBhdmVsIFRhdGFzaGluIDxwYXZlbC50YXRhc2hpbkBtaWNyb3NvZnQuY29tPg0KDQo+ICt7
DQo+ICsJbG9ja19kZXZpY2VfaG90cGx1ZygpOw0KPiArCV9fcmVtb3ZlX21lbW9yeShuaWQsIHN0
YXJ0LCBzaXplKTsNCj4gKwl1bmxvY2tfZGV2aWNlX2hvdHBsdWcoKTsNCj4gK30NCj4gIEVYUE9S
VF9TWU1CT0xfR1BMKHJlbW92ZV9tZW1vcnkpOw0KPiAgI2VuZGlmIC8qIENPTkZJR19NRU1PUllf
SE9UUkVNT1ZFICovDQo+IA==
