From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: Ping: [PATCH] xen/ACPI: don't upload Px/Cx data for
 disabled processors
Date: Wed, 15 Aug 2018 17:41:48 -0400
Message-ID: <2cd98495-6077-d6d9-647f-71238c3cf68a@oracle.com>
References: <5B30C13F02000078001CD68D@prv1-mh.provo.novell.com>
 <5B73C70202000078001DE1A2@prv1-mh.provo.novell.com>
 <CAJZ5v0gO1qsj6fqYHJfodwQugSSFbRO5zCjyA9cpN=z1RW49vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <CAJZ5v0gO1qsj6fqYHJfodwQugSSFbRO5zCjyA9cpN=z1RW49vw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, JBeulich@suse.com
Cc: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gMDgvMTUvMjAxOCAwMzo1NSBBTSwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6Cj4gT24gV2Vk
LCBBdWcgMTUsIDIwMTggYXQgODo0NCBBTSBKYW4gQmV1bGljaCA8SkJldWxpY2hAc3VzZS5jb20+
IHdyb3RlOgo+Pj4+PiBPbiAyNS4wNi4xOCBhdCAxMjoxNywgIHdyb3RlOgo+Pj4gVGhpcyBpcyB1
bm5lY2Vzc2FyeSBhbmQgdHJpZ2dlcnMgYSB3YXJuaW5nIGluIHRoZSBoeXBlcnZpc29yLgo+Pj4K
Pj4+IE9mdGVuIHN5c3RlbXMgaGF2ZSBtb3JlIHByb2Nlc3NvciBlbnRyaWVzIGluIHRoZWlyIEFD
UEkgdGFibGVzIHRoYW4gYXJlCj4+PiBhY3R1YWxseSBpbnN0YWxsZWQvYWN0aXZlLiBUaGUgQUNQ
SV9TVEFfREVWSUNFX1BSRVNFTlQgYml0IGNhbm5vdCBiZQo+Pj4gcmVsaWFibHkgdXNlZCwgYnV0
IHRoZSBBQ1BJX01BRFRfRU5BQkxFRCBiaXQgY2FuLiBJbiBvcmRlciB0byBub3QKPj4+IGludHJv
ZHVjZSBuZXcgZnVuY3Rpb25zIGluIHRoZSBtYWluIEFDUEkgcHJvY2Vzc29yIGRyaXZlciBjb2Rl
LCBzaW1wbHkKPj4+IHVzZSBhY3BpX2dldF9waHlzX2lkKCksIHdoaWNoIGRvZXMgbW9yZSB0aGFu
IHdlIG5lZWQsIGJ1dCB3aGljaCBjaGVja3MKPj4+IHRoZSBNQURUIGVuYWJsZWQgYml0IGluIHRo
ZSBwcm9jZXNzLiBBbnkgQ1BVIGZvciB3aGljaCB3ZSBjYW4ndAo+Pj4gZGV0ZXJtaW5lIHRoZSBB
UElDIElEIGlzIHVubGlrZWx5IHRvIHdvcmsgcHJvcGVybHkgYW55d2F5LCBzbyB0aGUgZXh0cmEK
Pj4+IGNoZWNrcyBkb25lIGJ5IGFjcGlfZ2V0X3BoeXNfaWQoKSBzaG91bGQgZG8gbm8gaGFybS4K
Pj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBKYW4gQmV1bGljaCA8amJldWxpY2hAc3VzZS5jb20+Cj4+
PiAtLS0KPj4+ICBkcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2NvcmUuYyAgICB8ICAgIDEgKwo+Pj4g
IGRyaXZlcnMveGVuL3hlbi1hY3BpLXByb2Nlc3Nvci5jIHwgICAgNiArKysrKysKPj4+ICAyIGZp
bGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+PiBXaXRoIErDvHJnZW4ncyBSLWIgaW4gcGxh
Y2UsIG1heSBJIGFzayBmb3IgYW4gYWNrIGZvciB0aGUgcHJvY2Vzc29yX2NvcmUuYwo+PiBjaGFu
Z2UsIG9yIC0gaW4gY2FzZSB5b3UgZGlzbGlrZSB0aGUgbmV3IGV4cG9ydCAtIGFuIGFsdGVybmF0
aXZlIHN1Z2dlc3Rpb24/Cj4gSXQgaXMgZmluZSB0byBleHBvcnQgaXQgSU1PLiAgSWYgeW91IG5l
ZWQgbXkgQUNLIGZvciB0aGF0LCBwbGVhc2UgZmVlbAo+IGZyZWUgdG8gYWRkIGl0IHRvIHRoZSBw
YXRjaC4KCgpBcHBsaWVkIHRvIGZvci1saW51cy00LjE5LgoKLWJvcmlzCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpYZW4tZGV2ZWwgbWFpbGluZyBsaXN0
Clhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZwpodHRwczovL2xpc3RzLnhlbnByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8veGVuLWRldmVs
