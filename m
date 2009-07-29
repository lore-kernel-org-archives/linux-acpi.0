From: "Yu, Ke" <ke.yu@intel.com>
Subject: RE: [Xen-devel] [PATCH][pvops_dom0][2/4] Introduce the external
 control operation interface for domain0 ACPI parser
Date: Wed, 29 Jul 2009 14:20:01 +0800
Message-ID: <4D05DB80B95B23498C72C700BD6C2E0B315D65B6@pdsmsx502.ccr.corp.intel.com>
References: <4D05DB80B95B23498C72C700BD6C2E0B315D64CC@pdsmsx502.ccr.corp.intel.com>
 <E87738D94A6AD54789B5B8D1BAEB06CC5C744C68C2@azsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_4D05DB80B95B23498C72C700BD6C2E0B315D65B6pdsmsx502ccrcor_"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:10668 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058AbZG2GVI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jul 2009 02:21:08 -0400
In-Reply-To: <E87738D94A6AD54789B5B8D1BAEB06CC5C744C68C2@azsmsx503.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, "Tian, Kevin" <kevin.tian@intel.com>

--_002_4D05DB80B95B23498C72C700BD6C2E0B315D65B6pdsmsx502ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<Brown, Len> Wrote:
>
>So the xen hypervizor is responsible for power management decisions,
>but it doesn't know how to talk to the power management
>controls in the platform?
>
>Why is that a good idea?

Your question is reasonable. there is also debate here before. People discu=
ss if it is possible to add acpica stuff to xen hypervisor and let xen cont=
rol the acpi completely. Unfortunately, this will lead dilemma here, i.e. s=
ome devices are controlled by dom0 and also need acpi info, e.g. battery, t=
hermal, etc. and pci hotplug in dom0 is another example. Tian Kevin has det=
ail description on this issue in the attached mail.

On the other hand, the dom0 acpica approach has other benefit, i.e. current=
 linux acpica stuff is pretty mature and has numerous bug fix. Leveraging a=
cpica in linux kernel is more practical.

So I would like to say it is a practical idea rather than a good idea.

>
>Does somebody expect all this dom0 stuff to really live
>in the upstream linux kernel source tree?

There are lots of discussion on the dom0 stuff acceptance, and I did not se=
e decision yet. Anyway, I would like to make this patch as clean as possibl=
e, so that it can benefit both xen and kernel.

>
>I'd like the patch better if you
>
>s/extcntl/xen/ to make it clear why this code exists --
>or is there an expected "external control" other than Xen?
>
>-Len

Ok, I can try this. BTW, besides this naming change, do you have other comm=
ent on the code? So that I can make it more clean.

Best Regards
Ke

--_002_4D05DB80B95B23498C72C700BD6C2E0B315D65B6pdsmsx502ccrcor_
Content-Type: text/plain; name="RE Xen-devel Re PATCH RFC x86acpi don't
 ignore IO APICsjustbecause there's no local APIC.txt"
Content-Description: RE Xen-devel Re PATCH RFC x86acpi don't ignore IO
 APICsjustbecause there's no local APIC.txt
Content-Disposition: attachment; filename="RE Xen-devel Re PATCH RFC x86acpi
 don't ignore IO APICsjustbecause there's no local APIC.txt"; size=3485;
	creation-date="Wed, 29 Jul 2009 13:23:15 GMT";
	modification-date="Wed, 29 Jul 2009 13:23:15 GMT"
Content-Transfer-Encoding: base64

RnJvbToJeGVuLWRldmVsLWJvdW5jZXNAbGlzdHMueGVuc291cmNlLmNvbSBvbiBiZWhhbGYgb2Yg
VGlhbiwgS2V2aW4gDQpba2V2aW4udGlhbkBpbnRlbC5jb21dDQpTZW50OgkyMDA5xOo21MIyMMjV
0MfG2sH5IDE2OjU4DQpUbzoJRXJpYyBXLiBCaWVkZXJtYW47IEtlaXIgRnJhc2VyDQpDYzoJSmVy
ZW15IEZpdHpoYXJkaW5nZTsgWGVuLWRldmVsOyB0aGUgYXJjaC94ODYgbWFpbnRhaW5lcnM7IExp
bnV4IA0KS2VybmVsIE1haWxpbmcgTGlzdDsgSW5nbyBNb2xuYXI7IE5ha2FqaW1hLCBKdW47IEgu
IFBldGVyCUFudmluOyANClRob21hcyBHbGVpeG5lcjsgTGVuIEJyb3duDQpTdWJqZWN0OglSRTog
W1hlbi1kZXZlbF0gUmU6IFtQQVRDSCBSRkNdIHg4Ni9hY3BpOiBkb24ndCBpZ25vcmUgSS9PIEFQ
SUNzDQoJanVzdAliZWNhdXNlIHRoZXJlJ3Mgbm8gbG9jYWwgQVBJQw0KQXR0YWNobWVudHM6CUFU
VDAwMDAxLnR4dA0KDQo+RnJvbTogRXJpYyBXLiBCaWVkZXJtYW4NCj5TZW50OiAyMDA5xOo21MIy
MMjVIDE2OjIyDQo+DQo+S2VpciBGcmFzZXIgPGtlaXIuZnJhc2VyQGV1LmNpdHJpeC5jb20+IHdy
aXRlczoNCj4NCj4+IE9uIDIwLzA2LzIwMDkgMDA6NDQsICJOYWthamltYSwgSnVuIiA8anVuLm5h
a2FqaW1hQGludGVsLmNvbT4gd3JvdGU6DQo+Pg0KPj4+PiBJIGFzc3VtZSB0aGF0IHB1dHRpbmcg
QU1MIGludG8gWGVuIGhhcyBiZWVuIGNvbnNpZGVyZWQsIGJ1dCBJIGRvbid0DQo+Pj4+IGFueXRo
aW5nIGFib3V0IHRob3NlIGRlbGliZXJhdGlvbnMuICBLZWlyPyBKdW4/DQo+Pj4+IA0KPj4+IA0K
Pj4+IFllcywgaXQgd2FzIG9uZSBvZiB0aGUgb3B0aW9ucyB5ZWFycyBhZ28uIFdlIGRpZCBub3Qg
ZG8gDQo+dGhhdCBiZWNhdXNlIExpbnV4IGFuZA0KPj4+IFNvbGFyaXMgKGFzIGRvbTApIGFscmVh
ZHkgaGFkIHRoZSBBTUwgaW50ZXJwcmV0ZXIgYW5kIGl0J3MgDQo+b3ZlcmtpbGwgYW5kDQo+Pj4g
cmVkdW5kYW50IHRvIGhhdmUgc3VjaCBhIGxhcmdlIGNvbXBvbmVudCBpbiB0aGUgWGVuIA0KPmh5
cGVydmlzb3IuIFNpbmNlIHRoZQ0KPj4+IGh5cGVydmlzb3IgZG9lcyBtb3N0IG9mIHRoZSBwb3dl
ciBtYW5hZ2VtZW50IChpLmUuIFAsIEMsIA0KPlMtc3RhdGUsIGV0Yy4pDQo+Pj4gZ2V0dGluZyB0
aGUgaW5mbyBmcm9tIGRvbTAgdG9kYXksIHdlIG1pZ2h0IHdhbnQgdG8gDQo+cmVjb25zaWRlciB0
aGUgb3B0aW9uLg0KPj4NCj4+IFllcywgd2UgY291bGQgcmVjb25zaWRlci4gSG93ZXZlciBpcyB0
aGVyZSBhbnkgc3R1ZmYgdGhhdCANCj5kb20wIHJlbWFpbnMNCj4+IHJlc3BvbnNpYmxlIGZvciAo
ZS5nLiwgUENJIG1hbmFnZW1lbnQsIGFuZCB0aGVyZWZvcmUgUENJIA0KPmhvdHBsdWcpIHdoZXJl
IGl0DQo+PiB3b3VsZCBjb250aW51ZSB0byBuZWVkIHRvIGJlIE9TUE0sIGludGVycHJldGluZyBj
ZXJ0YWluIEFNTCANCj5vYmplY3RzPyBJbg0KPj4gZ2VuZXJhbCBob3cgc2FmZSB3b3VsZCBpdCBi
ZSB0byBoYXZlIHR3byBsYXllcmVkIGVudGl0aWVzIA0KPmJvdGggcGxheWluZyBhdA0KPj4gYmVp
bmcgT1NQTT8NCj4NCj5TaG9ydCBvZiBydW5uaW5nIHRoZSBvZGRiYWxsIGFjcGkgYmFzZWQgZHJp
dmVycy4gIEknbSBub3QgZmFtaWxpYXIgd2l0aA0KPmFueSBhY3BpIGluIHRoZSBwY2kgbWFuYWdl
bWVudC4NCj4NCg0KUENJZSBob3RwbHVnIGlzIGRlZmluZWQgd2VsbCBieSBpdHMgb3duIEJVUyBz
cGVjLiBCdXQgY29udmVudGlvbmFsDQpQQ0kgaG90cGx1ZyBpcyBpbXBsZW1lbnRlZCBhbGwga2lu
ZHMgb2Ygc3RyYW5nZSB0aGluZ3MuIFNvbWUgaXMNCnRocm91Z2ggQUNQSSwgYW5kIHRodXMgYnkg
bW92aW5nIEFDUEkgaW50byBYZW4sIGEgbmV3ICd2aXJ0dWFsJyBob3RwbHVnDQphcmNoaXRlY3R1
cmUgaGFzIHRvIGJlIGludHJvZHVjZWQgaW50byBkb20wIExpbnV4LiBPciBYZW4gbmVlZHMgdG8g
DQplbXVsYXRlIHNvbWUga25vd24gaW50ZXJmYWNlIGJ1dCBhcyBzYWlkIHRoZXJlJ3Mgbm8gY29t
bW9uIHN0YW5kYXJkDQpmb3IgUENJIGhvdHBsdWcuIFdoYXQncyB3b3JzZSBpcyB0aGUgZG9ja2lu
ZyBzdGF0aW9uIHN1cHBvcnQgd2hpY2ggDQpjb250YWlucyBkaXZlcnNlIGxlZ2FjeSBkZXZpY2Vz
LiBIb3cgWGVuIHBhc3MgdGhvc2UgbGVnYWN5IGRldmljZSANCmhvdHBsdWcgZXZlbnRzIGludG8g
ZG9tMCBMaW51eCBiZWNvbWUgYW5vdGhlciBncmF5IGFyZWEgc3VmZmVyaW5nIGZyb20gDQpzYW1l
IHF1ZXN0aW9uIGxpa2Ugd2hldGhlciBJT0FQSUMgbmVlZHMgdG8gYmUgY2hhbmdlZCBmb3IgWGVu
Li4uDQoNCkFib3ZlIGNvbWVzIGZyb20gdGhlIGV4Y2x1c2l2ZSBhc3N1bXB0aW9uIHRoYXQgQUNQ
SSBpcyByZW1vdmVkDQpmcm9tIGRvbTAgYnkgbW92aW5nIGludG8gWGVuLg0KDQpBbm90aGVyIGNo
b2ljZSBpcyB0byBoYXZlIHR3byBsYXllcmVkIEFDUEkgaW4gYm90aCBkb20wIGFuZCBYZW4NCndp
dGggZG9tMCdzIEFDUEkgdmlydHVhbGl6ZWQgYSBiaXQgYnkgWGVuLiBIb3dldmVyIGl0J3MgbWVz
c3kgYXMgDQpBQ1BJIGVuY29kZXMgbW9zdCBzdHVmZiBpbiBpdHMgb3duIEFNTCBlbmNvZGUgYXMg
YSBncmF5IGJveC4gDQpNYW55IEFDUEkgbWV0aG9kcyB0YWxrIHRvIGhhcmR3YXJlIGJpdHMgaW50
ZXJuYWxseSBldmVuIGJ5IGhhcmQgDQpjb2RlZCBJL08gcmVnaXN0ZXJzLiBZb3UgZG9uJ3Qga25v
dyB3aGV0aGVyIG9uZSBBQ1BJIGV2ZW50IA0Kc2hvdWxkIGJlIGhhbmRsZWQgYnkgWGVuIG9yIG5v
dCwgdW50aWwgc29tZSBBTUwgbWV0aG9kcyBoYXZlIA0KYmVlbiBldmFsdWF0ZWQgd2hpY2ggdGhl
biBtYXkgYWxyZWFkeSBjb25zdW1lIGFuZCBjaGFuZ2UgDQpzb21lIGRldmljZSBzdGF0ZXMgYW5k
IG5vdCByZXZlcnNpYmxlLiBUaGVuIFhlbiBoYXZlIHRvIGVtdWxhdGUgDQp0aG9zZSBzdGF0ZXMg
d2hlbiBpbmplY3RpbmcgYSB2aXJ0dWFsIEFDUEkgZXZlbnQgaW50byBkb20wIGFzIA0KZG9tMCBB
Q1BJIG1ldGhvZHMgbmVlZCB0byBjb25zdW1lIHNhbWUgc3RhdGVzLiBIb3dldmVyDQphdXRvbWF0
aWMgZ2VuZXJhdGluZyBlbXVsYXRpb24gY29kZSBmb3IgZGl2ZXJzZSBBQ1BJIGltcGxlbWVudGF0
aW9ucw0KdG8gbWUgaXMgZmFyIG1vcmUgY29tcGxleCB0aGFuIGFueSBkaXNjdXNzaW9uIGhlcmUu
IA0KDQpTbyB0aGUgcmVhbCB0cm91YmxlIGlzIEFDUEkgLCB3aGljaCBlbmNvZGUgYWxsIHBsYXRm
b3JtIGJpdHMgaWYgDQp0aGV5J3JlIG5vdCBpbmNsdWRlZCBpbiBhbnkgZXhpc3RpbmcgQlVTIHNw
ZWMsIHN1Y2ggYXMgcG93ZXIsIA0KdGhlcm1hbCwgcHJvY2Vzc29yLCBiYXR0ZXJ5LCBQQ0kgcm91
dGluZywgaG90cGx1ZywgRUMsIGV0Yy4gU29tZQ0KYXJlIG93bmVkIGJ5IGRvbTAgYW5kIHNvbWUg
YnkgWGVuLiBIb3dldmVyIEFDUEkncyBBTUwgZW5jb2RpbmcNCm1ha2VzIGF1dG9tYXRpYyBkaXZp
c2lvbiBiZXR3ZWVuIHR3byBjYXRlZ29yaWVzIHJlYWxseSBkaWZmaWN1bHQuDQoNClRoYW5rcywN
CktldmluDQo=

--_002_4D05DB80B95B23498C72C700BD6C2E0B315D65B6pdsmsx502ccrcor_--
