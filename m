From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Ping: [PATCH] xen/ACPI: don't upload Px/Cx data for
 disabled processors
Date: Wed, 15 Aug 2018 09:55:00 +0200
Message-ID: <CAJZ5v0gO1qsj6fqYHJfodwQugSSFbRO5zCjyA9cpN=z1RW49vw@mail.gmail.com>
References: <5B30C13F02000078001CD68D@prv1-mh.provo.novell.com>
 <5B73C70202000078001DE1A2@prv1-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <5B73C70202000078001DE1A2@prv1-mh.provo.novell.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: JBeulich@suse.com
Cc: Juergen Gross <jgross@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gV2VkLCBBdWcgMTUsIDIwMTggYXQgODo0NCBBTSBKYW4gQmV1bGljaCA8SkJldWxpY2hAc3Vz
ZS5jb20+IHdyb3RlOgo+Cj4gPj4+IE9uIDI1LjA2LjE4IGF0IDEyOjE3LCAgd3JvdGU6Cj4gPiBU
aGlzIGlzIHVubmVjZXNzYXJ5IGFuZCB0cmlnZ2VycyBhIHdhcm5pbmcgaW4gdGhlIGh5cGVydmlz
b3IuCj4gPgo+ID4gT2Z0ZW4gc3lzdGVtcyBoYXZlIG1vcmUgcHJvY2Vzc29yIGVudHJpZXMgaW4g
dGhlaXIgQUNQSSB0YWJsZXMgdGhhbiBhcmUKPiA+IGFjdHVhbGx5IGluc3RhbGxlZC9hY3RpdmUu
IFRoZSBBQ1BJX1NUQV9ERVZJQ0VfUFJFU0VOVCBiaXQgY2Fubm90IGJlCj4gPiByZWxpYWJseSB1
c2VkLCBidXQgdGhlIEFDUElfTUFEVF9FTkFCTEVEIGJpdCBjYW4uIEluIG9yZGVyIHRvIG5vdAo+
ID4gaW50cm9kdWNlIG5ldyBmdW5jdGlvbnMgaW4gdGhlIG1haW4gQUNQSSBwcm9jZXNzb3IgZHJp
dmVyIGNvZGUsIHNpbXBseQo+ID4gdXNlIGFjcGlfZ2V0X3BoeXNfaWQoKSwgd2hpY2ggZG9lcyBt
b3JlIHRoYW4gd2UgbmVlZCwgYnV0IHdoaWNoIGNoZWNrcwo+ID4gdGhlIE1BRFQgZW5hYmxlZCBi
aXQgaW4gdGhlIHByb2Nlc3MuIEFueSBDUFUgZm9yIHdoaWNoIHdlIGNhbid0Cj4gPiBkZXRlcm1p
bmUgdGhlIEFQSUMgSUQgaXMgdW5saWtlbHkgdG8gd29yayBwcm9wZXJseSBhbnl3YXksIHNvIHRo
ZSBleHRyYQo+ID4gY2hlY2tzIGRvbmUgYnkgYWNwaV9nZXRfcGh5c19pZCgpIHNob3VsZCBkbyBu
byBoYXJtLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEphbiBCZXVsaWNoIDxqYmV1bGljaEBzdXNl
LmNvbT4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvYWNwaS9wcm9jZXNzb3JfY29yZS5jICAgIHwgICAg
MSArCj4gPiAgZHJpdmVycy94ZW4veGVuLWFjcGktcHJvY2Vzc29yLmMgfCAgICA2ICsrKysrKwo+
ID4gIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCj4KPiBXaXRoIErDvHJnZW4ncyBS
LWIgaW4gcGxhY2UsIG1heSBJIGFzayBmb3IgYW4gYWNrIGZvciB0aGUgcHJvY2Vzc29yX2NvcmUu
Ywo+IGNoYW5nZSwgb3IgLSBpbiBjYXNlIHlvdSBkaXNsaWtlIHRoZSBuZXcgZXhwb3J0IC0gYW4g
YWx0ZXJuYXRpdmUgc3VnZ2VzdGlvbj8KCkl0IGlzIGZpbmUgdG8gZXhwb3J0IGl0IElNTy4gIElm
IHlvdSBuZWVkIG15IEFDSyBmb3IgdGhhdCwgcGxlYXNlIGZlZWwKZnJlZSB0byBhZGQgaXQgdG8g
dGhlIHBhdGNoLgoKVGhhbmtzLApSYWZhZWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3Rz
LnhlbnByb2plY3Qub3JnCmh0dHBzOi8vbGlzdHMueGVucHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby94ZW4tZGV2ZWw=
