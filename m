From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC] mm/memory_hotplug: Introduce memory block types
Date: Thu, 4 Oct 2018 17:45:13 +0200
Message-ID: <14992b68-5402-9168-0050-b3c6ac4a8c90@redhat.com>
References: <20181001084038.GD18290@dhcp22.suse.cz>
 <d54a8509-725f-f771-72f0-15a9d93e8a49@redhat.com>
 <20181002134734.GT18290@dhcp22.suse.cz>
 <98fb8d65-b641-2225-f842-8804c6f79a06@redhat.com>
 <8736tndubn.fsf@vitty.brq.redhat.com> <20181003134444.GH4714@dhcp22.suse.cz>
 <87zhvvcf3b.fsf@vitty.brq.redhat.com>
 <49456818-238e-2d95-9df6-d1934e9c8b53@linux.intel.com>
 <87tvm3cd5w.fsf@vitty.brq.redhat.com>
 <06a35970-e478-18f8-eae6-4022925a5192@redhat.com>
 <20181004061938.GB22173@dhcp22.suse.cz>
 <efd50413-4be4-06c4-5ef0-711fdf05db71@redhat.com>
 <20181004172807.1eef3a6b@kitsune.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181004172807.1eef3a6b@kitsune.suse.cz>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Rashmica Gupta <rashmica.g@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Michael Neuling <mikey@neuling.org>, Stephen Hemminger <sthemmin@microsoft.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Vitaly Kuznetsov <vkuznets@redhat.com>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, Rob Herring <robh@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>, linux-s390@v
List-Id: linux-acpi@vger.kernel.org

T24gMDQvMTAvMjAxOCAxNzoyOCwgTWljaGFsIFN1Y2jDoW5layB3cm90ZToKPiBPbiBUaHUsIDQg
T2N0IDIwMTggMTA6MTM6NDggKzAyMDAKPiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4gCj4gb2ssIHNvIHdoYXQgaXMgdGhlIHByb2JsZW0gaGVyZT8KPiAKPiBI
YW5kbGluZyB0aGUgaG90cGx1ZyBpbiB1c2Vyc3BhY2UgdGhyb3VnaCB1ZGV2IG1heSBiZSBzdWJv
cHRpbWFsIGFuZAo+IGtlcm5lbCBoYW5kbGluZyBtaWdodCBiZSBmYXN0ZXIgYnV0IHRoYXQncyBv
cnRob2dvbmFsIHRvIHRoZSBwcm9ibGVtIGF0Cj4gaGFuZC4KClllcywgdGhhdCBvbmUgdG8gc29s
dmUgaXMgYSBkaWZmZXJlbnQgc3RvcnkuCgo+IAo+IFRoZSBzdGF0ZSBvZiB0aGUgYXJ0IGlzIHRv
IGRldGVybWluZSB3aGF0IHRvIGRvIHdpdGggaG90cGx1Z2dlZCBtZW1vcnkKPiBpbiB1c2Vyc3Bh
Y2UgYmFzZWQgb24gcGxhdGZvcm0gYW5kIHZpcnR1YWxpemF0aW9uIHR5cGUuCgpFeGFjdGx5LgoK
PiAKPiBDaGFuZ2luZyB0aGUgZGVmYXVsdCB0byBkZXBlbmQgb24gdGhlIGRyaXZlciB0aGF0IGFk
ZGVkIHRoZSBtZW1vcnkKPiByYXRoZXIgdGhhbiBwbGF0Zm9ybSB0eXBlIHNob3VsZCBzb2x2ZSB0
aGUgaXNzdWUgb2YgVk1zIGdyb3dpbmcKPiBkaWZmZXJlbnQgdHlwZXMgb2YgbWVtb3J5IGRldmlj
ZSBlbXVsYXRpb24uCgpZZXMsIG15IG9yaWdpbmFsIHByb3Bvc2FsICh0aGlzIHBhdGNoKSB3YXMg
dG8gaGFuZGxlIGl0IGluIHRoZSBrZXJuZWwKZm9yIGtub3duIHR5cGVzLiBCdXQgYXMgd2UgbGVh
cm5lZCwgdGhlcmUgbWlnaHQgYmUgc29tZSB1c2UgY2FzZXMgdGhhdAptaWdodCBzdGlsbCByZXF1
aXJlIHRvIG1ha2UgYSBkZWNpc2lvbiBpbiB1c2VyIHNwYWNlLgoKU28gcHJvdmlkaW5nIHRoZSB1
c2VyIHNwYWNlIGVpdGhlciB3aXRoIHNvbWUgdHlwZSBoaW50IChhdXRvLW9ubGluZSB2cy4Kc3Rh
bmRieSkgb3IgdGhlIGRyaXZlciB0aGF0IGFkZGVkIGl0IChzeXN0ZW0gdnMuIGh5cGVyLXYgLi4u
KSB3b3VsZApzb2x2ZSB0aGUgaXNzdWUuCgo+IAo+IEFtIEkgbWlzc2luZyBzb21ldGhpbmc/Cj4g
CgpObywgdGhhdCdzIGl0LiBUaGFua3MhCgo+IFRoYW5rcwo+IAo+IE1pY2hhbAo+IAoKCi0tIAoK
VGhhbmtzLAoKRGF2aWQgLyBkaGlsZGVuYgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkZXZlbCBtYWlsaW5nIGxpc3QKZGV2ZWxAbGludXhkcml2ZXJwcm9q
ZWN0Lm9yZwpodHRwOi8vZHJpdmVyZGV2LmxpbnV4ZHJpdmVycHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcml2ZXJkZXYtZGV2ZWwK
