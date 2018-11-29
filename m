From: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: 4.20.0-rc3 nouveau/Quadro P2000 Mobile: runpm causing
 ACPI errors, lockups
Date: Wed, 28 Nov 2018 20:29:04 -0500
Message-ID: <20181128202728-mutt-send-email-mst@kernel.org>
References: <20181126221005-mutt-send-email-mst@kernel.org>
 <20181127093650.GP2296@lahna.fi.intel.com>
 <20181127212550-mutt-send-email-mst@kernel.org>
 <20181128110857.GW2296@lahna.fi.intel.com>
 <20181128093527-mutt-send-email-mst@kernel.org>
 <20181128155544.GD2296@lahna.fi.intel.com>
 <20181128111312-mutt-send-email-mst@kernel.org>
 <CACO55tuzDgTb2g_ebhm7+A=UjEEDoM09-b5X_7fkznkFjJGiag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACO55tuzDgTb2g_ebhm7+A=UjEEDoM09-b5X_7fkznkFjJGiag-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Karol Herbst <kherbst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: nouveau <nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

T24gVGh1LCBOb3YgMjksIDIwMTggYXQgMTI6MjE6MzFBTSArMDEwMCwgS2Fyb2wgSGVyYnN0IHdy
b3RlOgo+IHRoaXMgd2FzIGFscmVhZHkgZGVidWdnZWQgYW5kIHRoZXJlIGlzIG5vIHBvaW50IGlu
IHNlYXJjaGluZyBpbnNpZGUKPiB0aGUgRmlybXdhcmUuIEl0J3Mgbm90IGEgZmlybXdhcmUgYnVn
IG9yIGFueXRoaW5nLgo+IAo+IFRoZSBwcm9wZXIgZml4IGlzIHRvIGRvIHNvbWV0aGluZyBpbnNp
ZGUgTm91dmVhdSBzbyB0aGF0IHdlIGRvbid0Cj4gdXBzZXQgdGhlIGRldmljZSBhbmQgYmVpbmcg
YWJsZSB0byBydW50aW1lIHJlc3VtZSBpdCBhZ2Fpbi4KPiAKPiBUaGUgaW5pdGlhbCB0aGluZyB3
ZSBkbyBpbnNpZGUgTm91dmVhdSB0byBjYXVzZSB0aG9zZSBpc3N1ZXMgaXMgdG8gcnVuCj4gdGhh
dCBzbyBjYWxsZWQgIkRFVklOSVQiIHNjcmlwdCBpbnNpZGUgdGhlIHZiaW9zIHRvIGluaXRpYWxp
emUgdGhlCj4gR1BVLCBwcm9ibGVtIGlzLCBpdCBjaGFuZ2VzIHNvbWV0aGluZyBvbiB0aGUgUENJ
ZSBjb25maWd1cmF0aW9uIHNvCj4gdGhhdCB0aGUgR1BVIGlzbid0IGFibGUgdG8gcnVudGltZSBy
ZXN1bWUgYW55bW9yZS4gSSBhbSBpbiBjb250YWN0Cj4gd2l0aCBOdmlkaWEgYWJvdXQgdGhhdCBp
c3N1ZSBhbmQgaG9wZWZ1bGx5IHdlIGdldCB0aGUgcHJvcGVyIGFuc3dlcnMuCj4gV2hlbiBJIHdh
cyBkaWdnaW5nIGludG8gdGhhdCBteXNlbGYgSSB3YXMgYWJsZSB0byBtYWtlIHRoZSBzaXR1YXRp
b24KPiBtb3JlIHN0YWJsZSBieSBzZXR0aW5nIHRoZSBQQ0lFIGxpbmsgc3BlZWQgdG8gdGhlIGJv
b3QgZGVmYXVsdHMsIGJ1dAo+IHRoYXQgd2FzIHN0aWxsIHByZXR0eSB1bnN0YWJsZS4KPiAKPiBB
bnl3YXksIGJlY2F1c2UgdGhlIGJpbmFyeSBkcml2ZXIgZmFpbHMgaGVyZSBhcyB3ZWxsICh0aHJv
dWdoCj4gYnVtYmxlYmVlIGFuZCBzbyBvbikgdGhlcmUgaXNuJ3QgbXVjaCBvZiByZXZlcnNlIGVu
Z2luZWVyaW5nIHdlIGNhbiBkbwo+IGJlc2lkZXMgZ3Vlc3NpbmcgYW5kIHRyeWluZyBpdCBvbiBs
aXRlcmFsbHkgZXZlcnkgaGFyZHdhcmUgdW50aWwgaXQKPiB3b3Jrcy4KPiAKPiBXZSBhbHNvIGhh
dmUgYW4gdXBzdHJlYW0gYnVnIGZvciB0aGlzIGlzc3VlOgo+IGh0dHBzOi8vYnVnemlsbGEua2Vy
bmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTU2MzQxCgpJZiB5b3UgbGlrZSBJIGNhbiBwcm9iYWJs
eSBkdW1wIHRoZSBwY2llIHJlZ2lzdGVycyBvbiBjYXJkCmFuZC9vciB0aGUgcGNpZSBwb3J0IHVu
ZGVyIHdpbmRvd3MuIFRoZSBjYXJkIHdvcmtzIHRoZXJlIDopCkxldCBtZSBrbm93LgoKLS0gCk1T
VApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpOb3V2ZWF1
IG1haWxpbmcgbGlzdApOb3V2ZWF1QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL25vdXZlYXUK
