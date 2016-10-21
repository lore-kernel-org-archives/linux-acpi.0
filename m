From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: arm64: fix compile apci tools fail for arm64
Date: Fri, 21 Oct 2016 19:40:20 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A256F1E@SHSMSX101.ccr.corp.intel.com>
References: <1476402698-40963-1-git-send-email-xieyisheng1@huawei.com>
 <1AE640813FDE7649BE1B193DEA596E886A253666@SHSMSX101.ccr.corp.intel.com>
 <696226b1-7024-a4d6-8bea-ddbf6d08a564@huawei.com>
 <1AE640813FDE7649BE1B193DEA596E886A253FBF@SHSMSX101.ccr.corp.intel.com>
 <c88b5433-fbf0-1a15-11b2-b47c1872d48d@huawei.com>
 <1AE640813FDE7649BE1B193DEA596E886A256324@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
        boundary="_002_1AE640813FDE7649BE1B193DEA596E886A256F1ESHSMSX101ccrcor_"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:47627 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932277AbcJUTk0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Oct 2016 15:40:26 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A256324@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, Yisheng Xie <xieyisheng1@huawei.com>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "wmiles@sgl.com" <wmiles@sgl.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "guohanjun@huawei.com" <guohanjun@huawei.com>, "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>

--_002_1AE640813FDE7649BE1B193DEA596E886A256F1ESHSMSX101ccrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I generated a solution with tools/power/acpi makefiles.
Please give it a try.
Sorry for the hackish build includes.

Thanks and best regards
Lv

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kern=
el.org] On Behalf Of Zheng,
> Lv
> Subject: RE: [PATCH] ACPICA: arm64: fix compile apci tools fail for arm64
>=20
> Hi,
>=20
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.ke=
rnel.org] On Behalf Of
> Yisheng
> > Xie
> > Subject: Re: [PATCH] ACPICA: arm64: fix compile apci tools fail for arm=
64
> >
> > Hi,
> >
> > On 2016/10/19 6:07, Zheng, Lv wrote:
> > > Hi,
> > >
> > > I'm not sure what you mean.
> > > I mean you need ACPI_USE_SYSTEM_INTTYPES in case s64 has already been=
 defined in that environment.
> > > Are you sure s64 should be defined for your environment?
> > >
> > s64 is not defined in my build environment but in kernel code.
>=20
> Yes, in-kernel ACPICA applications trickily reused this to get it compile=
d in kernel source tree with
> minimal porting effort.
> And it is working on x86.
>=20
> >
> > > IMO, s64 is kernel space specific, while you are compiling user space=
 tools.
> > > It looks to me like there is something wrong with ARM kernel's asm/ty=
pes.h.
> > >
> > >> I listed in change log. And I also have tried that way.
> > >> However, it still have many other errors.(I am sorry to not have lis=
ted all of them.)
> > >>
> > >> From the following log, you can see, all of the conflict type is fro=
m signal.h.
> > >> And maybe this patch is a better way to fix these compile error, wit=
hout too much
> > >> change of code.
> > >>
> > >> Are you sure that it will cause order problem when build ACPICA on o=
ther build
> > >> environment, for it only effect aarch64.
> > >
> > > I'm not sure what this is.
> > > How did you get this?
> > > Were you compiling kernel acpi tools or compiling the kernel itself?
> > >
> > It's about compiling kernel acpi tools.
> >
> > > For tool compilation, are you sure you have correctly configured your=
 cross-compilation
> environment?
> > Maybe it is not my cross-compilation environment problem, for your also=
 can reproduce it,
> > as your said in another email, right?
>=20
> Yes, I reproduced it.
> By commenting out <signal.h> inclusion from acenv.h.
> Tools can be built by aarch64-linux-gnu tool chain downloaded from linaro=
.
>=20
> However this is still not the root cause, IMO.
>=20
> Thanks
> Lv
>=20
> >
> > > Will you see problems in compiling ACPICA applications from:
> > > https://github.com/acpica/acpica
> > >
> >
> > > Thanks
> > > Lv
> > >
> > > .
> > >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--_002_1AE640813FDE7649BE1B193DEA596E886A256F1ESHSMSX101ccrcor_
Content-Type: application/octet-stream; name="lv-tools1.patch"
Content-Description: lv-tools1.patch
Content-Disposition: attachment; filename="lv-tools1.patch"; size=3305;
	creation-date="Sat, 22 Oct 2016 02:37:18 GMT";
	modification-date="Sat, 22 Oct 2016 02:37:18 GMT"
Content-Transfer-Encoding: base64

RnJvbTogTHYgWmhlbmcgPGx2LnpoZW5nQGludGVsLmNvbT4KU3ViamVjdDogW1BBVENIXSB0b29s
cy9wb3dlci9hY3BpOiBSZW1vdmUgZGlyZWN0IGtlcm5lbCBzb3VyY2UgaW5jbHVkZSByZWZlcmVu
Y2UKCkFDUElDQSB0b29scyB0cmlja2lseSB1c2VzIGludGVnZXIgdHlwZXMsIGFuZCB0cmlja2ls
eSBpbmNsdWRlcyBrZXJuZWwKaW5jbHVkZSBkaXJlY3RvcnkgZGlyZWN0bHksIHdoaWNoIGJyZWFr
cyB0b29scyBidWlsZCBmb3Igc29tZSBjcm9zcwpjb21waWxlcnMuIFRoaXMgcGF0Y2ggZml4ZXMg
dGhpcyBidWlsZCBpc3N1ZS4KClJlcG9ydGVkLWJ5OiBZaXNoZW5nIFhpZSA8eGlleWlzaGVuZzFA
aHVhd2VpLmNvbT4KU2lnbmVkLW9mZi1ieTogTHYgWmhlbmcgPGx2LnpoZW5nQGludGVsLmNvbT4K
LS0tCkluZGV4OiBsaW51eC1hY3BpY2EvdG9vbHMvcG93ZXIvYWNwaS9NYWtlZmlsZQo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Ci0tLSBsaW51eC1hY3BpY2Eub3JpZy90b29scy9wb3dlci9hY3BpL01ha2VmaWxlCisrKyBs
aW51eC1hY3BpY2EvdG9vbHMvcG93ZXIvYWNwaS9NYWtlZmlsZQpAQCAtMTEsMTEgKzExLDE3IEBA
CiBpbmNsdWRlIC4uLy4uL3NjcmlwdHMvTWFrZWZpbGUuaW5jbHVkZQogCiBhbGw6IGFjcGlkYmcg
YWNwaWR1bXAgZWMKLWNsZWFuOiBhY3BpZGJnX2NsZWFuIGFjcGlkdW1wX2NsZWFuIGVjX2NsZWFu
CitjbGVhbjogYWNwaWRiZ19jbGVhbiBhY3BpZHVtcF9jbGVhbiBpbmNsdWRlX2NsZWFuIGVjX2Ns
ZWFuCiBpbnN0YWxsOiBhY3BpZGJnX2luc3RhbGwgYWNwaWR1bXBfaW5zdGFsbCBlY19pbnN0YWxs
CiB1bmluc3RhbGw6IGFjcGlkYmdfdW5pbnN0YWxsIGFjcGlkdW1wX3VuaW5zdGFsbCBlY191bmlu
c3RhbGwKK2luY2x1ZGUvYWNwaToKKwlta2RpciAtcCBpbmNsdWRlCisJbG4gLXMgLi4vLi4vLi4v
Li4vaW5jbHVkZS9hY3BpIGluY2x1ZGUvYWNwaQoraW5jbHVkZV9jbGVhbjoKKwlybSAtZiBpbmNs
dWRlL2FjcGkKKwlybSAtcmYgaW5jbHVkZQogCi1hY3BpZGJnIGFjcGlkdW1wIGVjOiBGT1JDRQor
YWNwaWRiZyBhY3BpZHVtcCBlYzogaW5jbHVkZS9hY3BpIEZPUkNFCiAJJChjYWxsIGRlc2NlbmQs
dG9vbHMvJEAsYWxsKQogYWNwaWRiZ19jbGVhbiBhY3BpZHVtcF9jbGVhbiBlY19jbGVhbjoKIAkk
KGNhbGwgZGVzY2VuZCx0b29scy8kKEA6X2NsZWFuPSksY2xlYW4pCkluZGV4OiBsaW51eC1hY3Bp
Y2EvdG9vbHMvcG93ZXIvYWNwaS90b29scy9hY3BpZGJnL01ha2VmaWxlCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0t
IGxpbnV4LWFjcGljYS5vcmlnL3Rvb2xzL3Bvd2VyL2FjcGkvdG9vbHMvYWNwaWRiZy9NYWtlZmls
ZQorKysgbGludXgtYWNwaWNhL3Rvb2xzL3Bvd2VyL2FjcGkvdG9vbHMvYWNwaWRiZy9NYWtlZmls
ZQpAQCAtMTksNyArMTksNyBAQCB2cGF0aCAlLmMgXAogQ0ZMQUdTICs9IC1EQUNQSV9BUFBMSUNB
VElPTiAtREFDUElfU0lOR0xFX1RIUkVBRCAtREFDUElfREVCVUdHRVJcCiAJLUkuXAogCS1JLi4v
Li4vLi4vLi4vLi4vZHJpdmVycy9hY3BpL2FjcGljYVwKLQktSS4uLy4uLy4uLy4uLy4uL2luY2x1
ZGUKKwktSS4uLy4uL2luY2x1ZGUKIExERkxBR1MgKz0gLWxwdGhyZWFkCiBUT09MX09CSlMgPSBc
CiAJYWNwaWRiZy5vCkluZGV4OiBsaW51eC1hY3BpY2EvdG9vbHMvcG93ZXIvYWNwaS90b29scy9h
Y3BpZGJnL2FjcGlkYmcuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC1hY3BpY2Eub3JpZy90b29scy9w
b3dlci9hY3BpL3Rvb2xzL2FjcGlkYmcvYWNwaWRiZy5jCisrKyBsaW51eC1hY3BpY2EvdG9vbHMv
cG93ZXIvYWNwaS90b29scy9hY3BpZGJnL2FjcGlkYmcuYwpAQCAtMTIsMTAgKzEyLDE2IEBACiAj
aW5jbHVkZSA8YWNwaS9hY3BpLmg+CiAKIC8qIEhlYWRlcnMgbm90IGluY2x1ZGVkIGJ5IGluY2x1
ZGUvYWNwaS9wbGF0Zm9ybS9hY2xpbnV4LmggKi8KKyNpbmNsdWRlIDx1bmlzdGQuaD4KKyNpbmNs
dWRlIDxzdGRpby5oPgorI2luY2x1ZGUgPHN0ZGxpYi5oPgorI2luY2x1ZGUgPHN0cmluZy5oPgor
I2luY2x1ZGUgPGVycm9yLmg+CiAjaW5jbHVkZSA8c3RkYm9vbC5oPgogI2luY2x1ZGUgPGZjbnRs
Lmg+CiAjaW5jbHVkZSA8YXNzZXJ0Lmg+Ci0jaW5jbHVkZSA8bGludXgvY2lyY19idWYuaD4KKyNp
bmNsdWRlIDxzeXMvc2VsZWN0Lmg+CisjaW5jbHVkZSAiLi4vLi4vLi4vLi4vLi4vaW5jbHVkZS9s
aW51eC9jaXJjX2J1Zi5oIgogCiAjZGVmaW5lIEFDUElfQU1MX0ZJTEUJCSIvc3lzL2tlcm5lbC9k
ZWJ1Zy9hY3BpL2FjcGlkYmciCiAjZGVmaW5lIEFDUElfQU1MX1NFQ19USUNLCTEKSW5kZXg6IGxp
bnV4LWFjcGljYS90b29scy9wb3dlci9hY3BpL3Rvb2xzL2FjcGlkdW1wL01ha2VmaWxlCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KLS0tIGxpbnV4LWFjcGljYS5vcmlnL3Rvb2xzL3Bvd2VyL2FjcGkvdG9vbHMvYWNwaWR1
bXAvTWFrZWZpbGUKKysrIGxpbnV4LWFjcGljYS90b29scy9wb3dlci9hY3BpL3Rvb2xzL2FjcGlk
dW1wL01ha2VmaWxlCkBAIC0yMSw3ICsyMSw3IEBAIHZwYXRoICUuYyBcCiAJLi4vLi4vb3Nfc3Bl
Y2lmaWMvc2VydmljZV9sYXllcnMKIENGTEFHUyArPSAtREFDUElfRFVNUF9BUFAgLUkuXAogCS1J
Li4vLi4vLi4vLi4vLi4vZHJpdmVycy9hY3BpL2FjcGljYVwKLQktSS4uLy4uLy4uLy4uLy4uL2lu
Y2x1ZGUKKwktSS4uLy4uL2luY2x1ZGUKIFRPT0xfT0JKUyA9IFwKIAlhcGR1bXAub1wKIAlhcGZp
bGVzLm9cCkluZGV4OiBsaW51eC1hY3BpY2EvaW5jbHVkZS9hY3BpL3BsYXRmb3JtL2FjbGludXgu
aAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09Ci0tLSBsaW51eC1hY3BpY2Eub3JpZy9pbmNsdWRlL2FjcGkvcGxhdGZvcm0v
YWNsaW51eC5oCisrKyBsaW51eC1hY3BpY2EvaW5jbHVkZS9hY3BpL3BsYXRmb3JtL2FjbGludXgu
aApAQCAtMTkxLDYgKzE5MSw5IEBACiAjaWZuZGVmIF9faW5pdAogI2RlZmluZSBfX2luaXQKICNl
bmRpZgorI2lmbmRlZiBfX2lvbWVtCisjZGVmaW5lIF9faW9tZW0KKyNlbmRpZgogCiAvKiBIb3N0
LWRlcGVuZGVudCB0eXBlcyBhbmQgZGVmaW5lcyBmb3IgdXNlci1zcGFjZSBBQ1BJQ0EgKi8KIAo=

--_002_1AE640813FDE7649BE1B193DEA596E886A256F1ESHSMSX101ccrcor_--
