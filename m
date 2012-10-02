From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] cpuidle - support multiple drivers
Date: Tue, 02 Oct 2012 14:27:17 +0200
Message-ID: <506ADDA5.3010905@linaro.org>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org>
	<201209300007.49771.rjw@sisk.pl> <50687497.9040205@linaro.org>
	<3723306.GAm1cPlZaP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <3723306.GAm1cPlZaP-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

T24gMTAvMDIvMjAxMiAwNDowOCBBTSwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6Cj4gT24gU3Vu
ZGF5IDMwIG9mIFNlcHRlbWJlciAyMDEyIDE4OjM0OjMxIERhbmllbCBMZXpjYW5vIHdyb3RlOgo+
PiBPbiAwOS8zMC8yMDEyIDEyOjA3IEFNLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToKPj4+IE9u
IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMjksIDIwMTIsIERhbmllbCBMZXpjYW5vIHdyb3RlOgo+Pj4+
IE9uIDA5LzI5LzIwMTIgMTE6NDEgQU0sIEZyYW5jZXNjbyBMYXZyYSB3cm90ZToKPj4+Pj4gSGks
Cj4+Pj4gSGkgRnJhbmNlc2NvLAo+Pj4+Cj4+Pj4gdGhhbmtzIGZvciByZXZpZXdpbmcgdGhlIHBh
dGNoLgo+Pj4+Cj4+Pj4+PiAgc3RhdGljIHNzaXplX3Qgc2hvd19jdXJyZW50X2RyaXZlcihzdHJ1
Y3QgZGV2aWNlICpkZXYsCj4+Pj4+PiAgCQkJCSAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICph
dHRyLAo+Pj4+Pj4gIAkJCQkgICBjaGFyICpidWYpCj4+Pj4+PiAgewo+Pj4+Pj4gLQlzc2l6ZV90
IHJldDsKPj4+Pj4+IC0Jc3RydWN0IGNwdWlkbGVfZHJpdmVyICpjcHVpZGxlX2RyaXZlciA9IGNw
dWlkbGVfZ2V0X2RyaXZlcigpOwo+Pj4+Pj4gKwlzdHJ1Y3QgY2JhcmcgY2JhcmcgPSB7IC5idWYg
PSBidWYgfTsKPj4+Pj4gY2JhcmcuY291bnQgc2hvdWxkIGJlIGluaXRpYWxpemVkIHRvIDAuCj4+
Pj4gQWN0dWFsbHksIHdpdGggdGhpcyBpbml0aWFsaXphdGlvbiwgYWxsIHRoZSBmaWVsZHMgd2ls
bCBiZSBpbml0aWFsaXplZAo+Pj4+IHRvIDAsIGV4Y2VwdCAnYnVmJy4KPj4+IEhvd2V2ZXIsIGl0
IHdvdWxkIGJlIGdvb2QgdG8gaW5pdGlhbGl6ZSBjb3VudCBleHBsaWNpdGx5IHNvIGFzIHRvIHNo
b3cKPj4+IHRoYXQgd2UgY2FyZSBhYm91dCB0aGUgaW5pdGlhbCB2YWx1ZSBvZiBpdC4KPj4KPj4g
T2ssIEkgd2lsbCBjaGFuZ2UgdGhhdCBpbiBhIFYyLgo+Pgo+PiBSYWZhZWwsIHlvdSdyZSByaWdo
dCwgdGhpcyBhcHByb2FjaCBtYWtlcyBtb3JlIHNlbnNlIElNTy4KPiAKPiBXZWxsLCBJJ20gZ2xh
ZCB0aGF0IHlvdSBhZ3JlZS4gOi0pCj4gCj4gSSdtIHNvcnJ5IEkgaGF2ZW4ndCBwb3N0ZWQgYW55
IGNvbW1lbnRzIGFib3V0IHRoZSBsYXRlc3Qgc2VyaWVzLAo+IEknbGwgZG8gbXkgYmVzdCB0byBy
ZXZpZXcgaXQgbGF0ZXIgdGhpcyB3ZWVrLgoKT2ssIGNvb2wuIFRoYW5rcyEKCkkgZ3Vlc3MgaXQg
aXMgdG9vIGxhdGUgdG8gaGF2ZSB0aGlzIG1hdGVyaWFsIGZvciB2My43LCByaWdodCA/CgogIC0t
IERhbmllbAoKLS0gCiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIgT3Bl
biBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93
d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfAo8aHR0cDovL3R3aXR0ZXIu
Y29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJv
LWJsb2cvPiBCbG9nCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGluYXJvLWRldiBtYWlsaW5nIGxpc3QKbGluYXJvLWRldkBsaXN0cy5saW5hcm8ub3Jn
Cmh0dHA6Ly9saXN0cy5saW5hcm8ub3JnL21haWxtYW4vbGlzdGluZm8vbGluYXJvLWRldgo=
