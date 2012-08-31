From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/5][RFC] Use per cpuidle_device states
Date: Fri, 31 Aug 2012 23:19:15 +0200
Message-ID: <50412A53.1070109@linaro.org>
References: <1343213162-8064-1-git-send-email-daniel.lezcano@linaro.org>
	<20120727112845.GI12034@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20120727112845.GI12034-Rysk9IDjsxmJz7etNGeUX8VPkgjIgRvpAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

T24gMDcvMjcvMjAxMiAwMToyOCBQTSwgUGV0ZXIgRGUgU2NocmlqdmVyIHdyb3RlOgo+IE9uIFdl
ZCwgSnVsIDI1LCAyMDEyIGF0IDEyOjQ1OjU3UE0gKzAyMDAsIERhbmllbCBMZXpjYW5vIHdyb3Rl
Ogo+PiBTaW5jZSBjb21taXQgNDZiY2ZhZDdhODE5YmQxN2FjNGU4MzFiMDQ0MDUxNTJkNTk3ODRh
YiwKPj4gICAgICAgICBjcHVpZGxlOiBTaW5nbGUvR2xvYmFsIHJlZ2lzdHJhdGlvbiBvZiBpZGxl
IHN0YXRlcwo+Pgo+PiB3ZSBoYXZlIGEgc2luZ2xlIHJlZ2lzdHJhdGlvbiBmb3IgdGhlIGNwdWlk
bGUgc3RhdGVzIHdoaWNoIG1ha2VzCj4+IHNlbnNlLiBCdXQgbm93IHR3byBuZXcgYXJjaGl0ZWN0
dXJlcyBhcmUgY29taW5nOiB0ZWdyYTMgYW5kIGJpZy5MSVRUTEUuCj4+Cj4+IFRoZXNlIGFyY2hp
dGVjdHVyZXMgaGF2ZSBkaWZmZXJlbnQgY3B1cyB3aXRoIGRpZmZlcmVudCBjYXJhY3RlcmlzdGlj
cwo+PiBmb3IgcG93ZXIgc2F2aW5nLiBIaWdoIGxvYWQgPT4gcG93ZXJmdWxsIHByb2Nlc3NvcnMs
IGlkbGUgPT4gc21hbGwgcHJvY2Vzc29ycy4KPj4KPj4gVGhhdCBpbXBsaWVzIGRpZmZlcmVudCBj
cHUgbGF0ZW5jaWVzLgo+Pgo+PiBUaGlzIHBhdGNoc2V0IHByZXNlbnQgYSBzaW1wbGUgd2F5IHRv
IGtlZXAgdGhlIGN1cnJlbnQgYmVoYXZpb3IgYXMgaW50cm9kdWNlZAo+PiBieSBEZWVwdGhpIHdp
dGhvdXQgYnJlYWtpbmcgdGhlIGRyaXZlcnMgYW5kIGFkZCB0aGUgcG9zc2liaWxpdHkgdG8gc3Bl
Y2lmeSBhCj4+IHBlciBjcHUgc3RhdGVzLgo+Pgo+IExvb2tzIGdvb2QhIEkgd2lsbCBkbyBzb21l
IHRlc3RzIHdpdGggdGhpcyBuZXh0IHdlZWsuCgpIaSBQZXRlciwKCnNoYWxsIEkgY29uc2lkZXIg
YWRkaW5nIHlvdXIgYWNrZWQtYnkgPwoKRGlkIHlvdSBoYXZlIHRpbWUgdG8gdGVzdCB0aGUgcGF0
Y2hzZXQgPwoKVGhhbmtzCi0tIERhbmllbAoKLS0gCiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4g
TGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cg
TGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sg
fAo8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3
LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBCbG9nCgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbmFyby1kZXYgbWFpbGluZyBsaXN0CmxpbmFyby1k
ZXZAbGlzdHMubGluYXJvLm9yZwpodHRwOi8vbGlzdHMubGluYXJvLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbmFyby1kZXYK
