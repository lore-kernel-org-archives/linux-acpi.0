From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 2/3] x86/acpi: take rsdp address for boot
 params if available
Date: Tue, 28 Nov 2017 11:30:15 +0100
Message-ID: <072e88ef-dd61-8b7d-026a-5966b13ffed9@suse.com>
References: <20171128094400.25955-1-jgross@suse.com>
 <20171128094400.25955-3-jgross@suse.com>
 <20171128101834.fmiqygqpfh6wxrvv@MacBook-Pro-de-Roger.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <20171128101834.fmiqygqpfh6wxrvv@MacBook-Pro-de-Roger.local>
Content-Language: en-US
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: corbet@lwn.net, x86@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, tglx@linutronix.de, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

T24gMjgvMTEvMTcgMTE6MTgsIFJvZ2VyIFBhdSBNb25uw6kgd3JvdGU6Cj4gT24gVHVlLCBOb3Yg
MjgsIDIwMTcgYXQgMTA6NDM6NTlBTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToKPj4gSW4g
Y2FzZSB0aGUgcnNkcCBhZGRyZXNzIGluIHN0cnVjdCBib290X3BhcmFtcyBpcyBzcGVjaWZpZWQg
ZG9uJ3QgdHJ5Cj4+IHRvIGZpbmQgdGhlIHRhYmxlIGJ5IHNlYXJjaGluZywgYnV0IHRha2UgdGhl
IGFkZHJlc3MgZGlyZWN0bHkgYXMgc2V0Cj4+IGJ5IHRoZSBib290IGxvYWRlci4KPj4KPj4gU2ln
bmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPgo+PiAtLS0KPj4gIGRy
aXZlcnMvYWNwaS9vc2wuYyB8IDggKysrKysrKysKPj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9vc2wuYyBiL2RyaXZlcnMv
YWNwaS9vc2wuYwo+PiBpbmRleCAzYmI0NmNiMjRhOTkuLjNiMjVlMmFkN2Q3NSAxMDA2NDQKPj4g
LS0tIGEvZHJpdmVycy9hY3BpL29zbC5jCj4+ICsrKyBiL2RyaXZlcnMvYWNwaS9vc2wuYwo+PiBA
QCAtNDUsNiArNDUsMTAgQEAKPj4gICNpbmNsdWRlIDxsaW51eC91YWNjZXNzLmg+Cj4+ICAjaW5j
bHVkZSA8bGludXgvaW8tNjQtbm9uYXRvbWljLWxvLWhpLmg+Cj4+ICAKPj4gKyNpZmRlZiBDT05G
SUdfWDg2Cj4+ICsjaW5jbHVkZSA8YXNtL3NldHVwLmg+Cj4+ICsjZW5kaWYKPj4gKwo+PiAgI2lu
Y2x1ZGUgImludGVybmFsLmgiCj4+ICAKPj4gICNkZWZpbmUgX0NPTVBPTkVOVAkJQUNQSV9PU19T
RVJWSUNFUwo+PiBAQCAtMTk1LDYgKzE5OSwxMCBAQCBhY3BpX3BoeXNpY2FsX2FkZHJlc3MgX19p
bml0IGFjcGlfb3NfZ2V0X3Jvb3RfcG9pbnRlcih2b2lkKQo+PiAgCWlmIChhY3BpX3JzZHApCj4+
ICAJCXJldHVybiBhY3BpX3JzZHA7Cj4+ICAjZW5kaWYKPj4gKyNpZmRlZiBDT05GSUdfWDg2Cj4+
ICsJaWYgKGJvb3RfcGFyYW1zLmhkci5hY3BpX3JzZHBfYWRkcikKPj4gKwkJcmV0dXJuIGJvb3Rf
cGFyYW1zLmhkci5hY3BpX3JzZHBfYWRkcjsKPj4gKyNlbmRpZgo+IAo+IEknbSBzdHJ1Z2dsaW5n
IHRvIGZpZ3VyZSBvdXQgaG93IHdhcyBQVkggZ2V0dGluZyB0aGUgUlNEUCBwcmV2aW91c2x5LAo+
IGJlY2F1c2UgdGhhdCBzaG91bGQgYmUgcmVtb3ZlZCBub3cgdGhhdCBpdCdzIGluIHRoZSB6ZXJv
LXBhZ2UuCgpJIGRvbid0IHRoaW5rIGl0IHNob3VsZCBiZSByZW1vdmVkLCBiZWNhdXNlIHRoaXMg
d2FzIHRoZSBsZWdhY3kgY2FzZQooc2VhcmNoaW5nIHRocm91Z2ggbWVtb3J5KS4gSXQgd2FzIHB1
cmUgbHVjayB0aGF0IFhlbiBwdXQgaXQgYXQgdGhlCnJpZ2h0IGxvY2F0aW9uLgoKCkp1ZXJnZW4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZl
bCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnCmh0dHBzOi8vbGlz
dHMueGVucHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby94ZW4tZGV2ZWw=
