From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: don't register acpi_pad driver if
	running as xen dom0
Date: Fri, 14 Oct 2016 00:00:08 +0200
Message-ID: <2390542.It4zVIG3Mc@vostro.rjw.lan>
References: <1476270705-16209-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1476270705-16209-1-git-send-email-jgross@suse.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org
List-Id: linux-acpi@vger.kernel.org

T24gV2VkbmVzZGF5LCBPY3RvYmVyIDEyLCAyMDE2IDAxOjExOjQ1IFBNIEp1ZXJnZW4gR3Jvc3Mg
d3JvdGU6Cj4gV2hlbiBydW5uaW5nIGFzIFhlbiBkb20wIGEgc3BlY2lhbCBwcm9jZXNzb3JfYWdn
cmVnYXRvciBkcml2ZXIgaXMKPiBuZWVkZWQuIERvbid0IHJlZ2lzdGVyIHRoZSBzdGFuZGFyZCBk
cml2ZXIgaW4gdGhpcyBjYXNlLgo+IAo+IFdpdGhvdXQgdGhhdCBjaGVjayBhbiBlcnJvciBtZXNz
YWdlOgo+IAo+ICJFcnJvcjogRHJpdmVyICdwcm9jZXNzb3JfYWdncmVnYXRvcicgaXMgYWxyZWFk
eSByZWdpc3RlcmVkLAo+IGFib3J0aW5nLi4uIgo+IAo+IHdpbGwgYmUgZGlzcGxheWVkLgo+IAo+
IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4KPiAtLS0KPiAg
ZHJpdmVycy9hY3BpL2FjcGlfcGFkLmMgfCA1ICsrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGlfcGFkLmMgYi9k
cml2ZXJzL2FjcGkvYWNwaV9wYWQuYwo+IGluZGV4IDhlYTgyMTEuLjFjM2JlMTIgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9hY3BpL2FjcGlfcGFkLmMKPiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaV9w
YWQuYwo+IEBAIC0yNiw2ICsyNiw3IEBACj4gICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+Cj4gICNp
bmNsdWRlIDxsaW51eC9hY3BpLmg+Cj4gICNpbmNsdWRlIDxhc20vbXdhaXQuaD4KPiArI2luY2x1
ZGUgPHhlbi94ZW4uaD4KPiAgCj4gICNkZWZpbmUgQUNQSV9QUk9DRVNTT1JfQUdHUkVHQVRPUl9D
TEFTUwkiYWNwaV9wYWQiCj4gICNkZWZpbmUgQUNQSV9QUk9DRVNTT1JfQUdHUkVHQVRPUl9ERVZJ
Q0VfTkFNRSAiUHJvY2Vzc29yIEFnZ3JlZ2F0b3IiCj4gQEAgLTQ3Nyw2ICs0NzgsMTAgQEAgc3Rh
dGljIHN0cnVjdCBhY3BpX2RyaXZlciBhY3BpX3BhZF9kcml2ZXIgPSB7Cj4gIAo+ICBzdGF0aWMg
aW50IF9faW5pdCBhY3BpX3BhZF9pbml0KHZvaWQpCj4gIHsKPiArCS8qIFhlbiBhY3BpIHBhZCBp
cyByZXNwb25zaWJsZSB3aGVuIHJ1bm5pbmcgYXMgWGVuIERvbTAuICovCj4gKwlpZiAoeGVuX2lu
aXRpYWxfZG9tYWluKCkpCj4gKwkJcmV0dXJuIC1FTk9ERVY7Cj4gKwo+ICAJcG93ZXJfc2F2aW5n
X213YWl0X2luaXQoKTsKPiAgCWlmIChwb3dlcl9zYXZpbmdfbXdhaXRfZWF4ID09IDApCj4gIAkJ
cmV0dXJuIC1FSU5WQUw7Cj4gCgpBcHBsaWVkLgoKVGhhbmtzLApSYWZhZWwKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpYZW4tZGV2ZWwgbWFpbGluZyBs
aXN0Clhlbi1kZXZlbEBsaXN0cy54ZW4ub3JnCmh0dHBzOi8vbGlzdHMueGVuLm9yZy94ZW4tZGV2
ZWwK
