From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: CONFIG_NO_HZ + CONFIG_CPU_IDLE freeze the system (Was Re: [PATCH]
	acpi : remove power from acpi_processor_cx structure)
Date: Tue, 11 Sep 2012 23:27:53 +0200
Message-ID: <504FACD9.4020108@linaro.org>
References: <1343164349-28550-1-git-send-email-daniel.lezcano@linaro.org>
	<201209062204.11288.rjw@sisk.pl> <50490920.9070204@linaro.org>
	<201209062318.42874.rjw@sisk.pl> <504A02BD.4000805@linaro.org>
	<504A2D73.3010702@linaro.org> <504A68A0.7010907@linaro.org>
	<504E1FE5.6090502@linaro.org> <504E4343.5070004@linaro.org>
	<504E8372.20904@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <504E8372.20904-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, xen-devel-GuqFBffKawuULHF6PoxzQEEOCMrvLtNR@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frederic Weisbecker <fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

T24gMDkvMTEvMjAxMiAwMjoxOCBBTSwgSm9obiBTdHVsdHogd3JvdGU6Cj4gT24gMDkvMTAvMjAx
MiAxMjo0NSBQTSwgRGFuaWVsIExlemNhbm8gd3JvdGU6Cj4+IE9uIDA5LzEwLzIwMTIgMDc6MTQg
UE0sIEpvaG4gU3R1bHR6IHdyb3RlOgo+Pj4gSW4gdGhlIG1lYW50aW1lLCBJJ2xsIHRyeSB0byBy
ZXByb2R1Y2Ugb24gbXkgVDYxLiBJZiB5b3UgY291bGQgc2VuZCBtZQo+Pj4geW91ciAuY29uZmln
LCBJJ2QgYXBwcmVjaWF0ZSBpdC4KPj4gaHR0cDovL3Bhc3RlYmluLmNvbS9xU3hxZmRESwo+Pgo+
PiBUaGUgaGVhZGVyIG9mIHRoZSBjb25maWcgZmlsZSBzaG93cyBmb3IgYSB2My41LXJjNyBiZWNh
dXNlIGl0IGlzIHRoZQo+PiByZXN1bHQgb2YgdGhlIGdpdC1iaXNlY3QuIElmIHlvdSBrZWVwIHRo
aXMgY29uZmlnIGZpbGUgZm9yIHRoZSBsYXRlc3QKPj4ga2VybmVsIHRoYXQgc2hvdWxkIHJlcHJv
ZHVjZSB0aGUgcHJvYmxlbS4KPj4KPj4gTGV0IG1lIGtub3cgaWYgeW91IHdlcmUgYWJsZSB0byBy
ZXByb2R1Y2UgdGhlIHByb2JsZW0uCj4gR3JlYXQhIFdpdGggdGhpcyBJIHdhcyBhYmxlIHRvIHF1
aWNrbHkgcmVwcm9kdWNlIHRoZSBwcm9ibGVtIGFuZCBJIHRoaW5rCj4gSSBoYXZlIGEgZml4Lgo+
IAo+IFdvdWxkIHlvdSBtaW5kIHRlc3RpbmcgdGhlIGZvbGxvd2luZyBwYXRjaD8gSXQgc2VlbXMg
dG8gcmVzb2x2ZSB0aGUKPiBpc3N1ZSwgYnV0IEkndmUgbm90IHlldCBydW4gaXQgdGhyb3VnaCBt
eSB0ZXN0IHN1aXRlIHRvIG1ha2Ugc3VyZSBpdAo+IGRpZG4ndCBicmVhayBhbnl0aGluZyBlbHNl
Lgo+IAo+IElmIGJvdGggeW91ciBhbmQgbXkgdGVzdGluZyBjb21lcyBiYWNrIG9rLCBJJ2xsIHN1
Ym1pdCBpdCB0byBUaG9tYXMuCgpTb3VuZHMgbGlrZSB0aGlzIHNvbHZlcyB0aGUgcHJvYmxlbS4g
V2l0aG91dCBlbm91Z2ggYmFja2dyb3VuZCBvbiB0aW1lcnMKaW4gZ2VuZXJhbCwgSSBkb24ndCBo
YXZlIGFuIG9waW5pb24gYWJvdXQgdGhlIHBhdGNoIGl0c2VsZiBidXQgSSBjYW4KY29uZmlybSB0
aGUgaXNzdWUgaXMgbm8gbG9uZ2VyIG9jY3VycmluZy4KClRoYW5rcwogIC0tIERhbmllbAoKLS0g
CiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29m
dHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJvb2su
Y29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfAo8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFy
b29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBCbG9n
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGluYXJv
LWRldiBtYWlsaW5nIGxpc3QKbGluYXJvLWRldkBsaXN0cy5saW5hcm8ub3JnCmh0dHA6Ly9saXN0
cy5saW5hcm8ub3JnL21haWxtYW4vbGlzdGluZm8vbGluYXJvLWRldgo=
