From: NoZizzing OrDripping <nozizzingordripping-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Add CONFIG_ACPI_RELAXED_AML option
Date: Thu, 12 Dec 2002 20:48:09 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021213044809.14874.qmail@web14503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1719699026-1039754889=:14785"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--0-1719699026-1039754889=:14785
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The patch adds a new configuration option,
CONFIG_ACPI_RELAXED_AML.  When turned on,
the ACPI code will become forgiving of minor
errors in the AML code.

For this first cut, the patch and option will ignore
region size errors.  An off-by-one error is often
found in the AML shipped with Toshiba laptops,
even new models. This minor error prevents the
AC module from operating without this patch.

I urge the adoption of this patch (or something
similar) into the ACPI code.  This will make it
much easier to install and proliferate Linux on
a large category of laptops.

Rick Richardson
rickr-EySxSuIQeMUAvxtiuMwx3w@public.gmane.org
[Sorry, have to use my Yahoo account to post to this list)

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
--0-1719699026-1039754889=:14785
Content-Type: application/octet-stream; name="relaxed-aml.diff"
Content-Transfer-Encoding: base64
Content-Description: relaxed-aml.diff
Content-Disposition: attachment; filename="relaxed-aml.diff"

ZGlmZiAtdSAtciBsaW51eC0yLjQuMjArYWNwaS0yMDAyMTIwNS9Eb2N1bWVu
dGF0aW9uL0NvbmZpZ3VyZS5oZWxwIGxpbnV4LTIuNC4yMCthY3BpLTIwMDIx
MjA1K3JpY2svRG9jdW1lbnRhdGlvbi9Db25maWd1cmUuaGVscAotLS0gbGlu
dXgtMi40LjIwK2FjcGktMjAwMjEyMDUvRG9jdW1lbnRhdGlvbi9Db25maWd1
cmUuaGVscAkyMDAyLTEyLTEyIDE0OjI1OjE1LjAwMDAwMDAwMCAtMDYwMAor
KysgbGludXgtMi40LjIwK2FjcGktMjAwMjEyMDUrcmljay9Eb2N1bWVudGF0
aW9uL0NvbmZpZ3VyZS5oZWxwCTIwMDItMTItMTIgMTM6NDI6NDAuMDAwMDAw
MDAwIC0wNjAwCkBAIC0xODQwNiw2ICsxODQwNiwxNCBAQAogICBvZiB2ZXJi
b3NpdHkuIFNheWluZyBZIGVuYWJsZXMgdGhlc2Ugc3RhdGVtZW50cy4gVGhp
cyB3aWxsIGluY3JlYXNlCiAgIHlvdXIga2VybmVsIHNpemUgYnkgYXJvdW5k
IDUwSy4KIAorQUNQSSBSZWxheGVkIEFNTCBDaGVja2luZworQ09ORklHX0FD
UElfUkVMQVhFRF9BTUwKKyAgSWYgeW91IHNheSBgWScgaGVyZSwgdGhlIEFD
UEkgaW50ZXJwcmV0ZXIgd2lsbCByZWxheCBpdHMgY2hlY2tpbmcKKyAgZm9y
IHZhbGlkIEFNTCBhbmQgd2lsbCBpZ25vcmUgc29tZSBBTUwgbWlzdGFrZXMs
IHN1Y2ggYXMgb2ZmLWJ5LW9uZQorICBlcnJvcnMgaW4gcmVnaW9uIHNpemVz
LiAgU29tZSBsYXB0cHMgbWF5IHJlcXVpcmUgdGhpcyBvcHRpb24uICBJbgor
ICBwYXJ0aWN1bGFyLCBtYW55IFRvc2hpYmEgbGFwdG9wcyByZXF1aXJlIHRo
aXMgZm9yIGNvcnJlY3Qgb3BlcmF0aW9uCisgIG9mIHRoZSBBQyBtb2R1bGUu
CisKIEFDUEkgQnVzIE1hbmFnZXIKIENPTkZJR19BQ1BJX0JVU01HUgogICBU
aGUgQUNQSSBCdXMgTWFuYWdlciBlbnVtZXJhdGVzIGRldmljZXMgaW4gdGhl
IEFDUEkgbmFtZXNwYWNlLCBhbmQKZGlmZiAtdSAtciBsaW51eC0yLjQuMjAr
YWNwaS0yMDAyMTIwNS9kcml2ZXJzL2FjcGkvQ29uZmlnLmluIGxpbnV4LTIu
NC4yMCthY3BpLTIwMDIxMjA1K3JpY2svZHJpdmVycy9hY3BpL0NvbmZpZy5p
bgotLS0gbGludXgtMi40LjIwK2FjcGktMjAwMjEyMDUvZHJpdmVycy9hY3Bp
L0NvbmZpZy5pbgkyMDAyLTEyLTA3IDA4OjExOjI5LjAwMDAwMDAwMCAtMDYw
MAorKysgbGludXgtMi40LjIwK2FjcGktMjAwMjEyMDUrcmljay9kcml2ZXJz
L2FjcGkvQ29uZmlnLmluCTIwMDItMTItMTIgMTM6MzE6MjMuMDAwMDAwMDAw
IC0wNjAwCkBAIC0zNiw2ICszNiw3IEBACiAgICAgICBmaQogICAgICAgdHJp
c3RhdGUgICAgICcgIFRvc2hpYmEgTGFwdG9wIEV4dHJhcycJQ09ORklHX0FD
UElfVE9TSElCQQogICAgICAgYm9vbCAgICAgICAgICcgIERlYnVnIFN0YXRl
bWVudHMnCUNPTkZJR19BQ1BJX0RFQlVHCisgICAgICBib29sICAgICAgICAg
JyAgUmVsYXhlZCBBTUwgQ2hlY2tpbmcnCUNPTkZJR19BQ1BJX1JFTEFYRURf
QU1MCiAgICAgZmkKICAgZmkKIApkaWZmIC11IC1yIGxpbnV4LTIuNC4yMCth
Y3BpLTIwMDIxMjA1L2RyaXZlcnMvYWNwaS9leGVjdXRlci9leGZsZGlvLmMg
bGludXgtMi40LjIwK2FjcGktMjAwMjEyMDUrcmljay9kcml2ZXJzL2FjcGkv
ZXhlY3V0ZXIvZXhmbGRpby5jCi0tLSBsaW51eC0yLjQuMjArYWNwaS0yMDAy
MTIwNS9kcml2ZXJzL2FjcGkvZXhlY3V0ZXIvZXhmbGRpby5jCTIwMDItMTIt
MDcgMDg6MTE6MzAuMDAwMDAwMDAwIC0wNjAwCisrKyBsaW51eC0yLjQuMjAr
YWNwaS0yMDAyMTIwNStyaWNrL2RyaXZlcnMvYWNwaS9leGVjdXRlci9leGZs
ZGlvLmMJMjAwMi0xMi0xMiAxNDowNDo0OS4wMDAwMDAwMDAgLTA2MDAKQEAg
LTEyMSw3ICsxMjEsMTEgQEAKIAkJCWZpZWxkX2RhdHVtX2J5dGVfb2Zmc2V0
LCBvYmpfZGVzYy0+Y29tbW9uX2ZpZWxkLmFjY2Vzc19ieXRlX3dpZHRoLAog
CQkJcmduX2Rlc2MtPnJlZ2lvbi5ub2RlLT5uYW1lLmFzY2lpLCByZ25fZGVz
Yy0+cmVnaW9uLmxlbmd0aCkpOwogCi0JCXJldHVybl9BQ1BJX1NUQVRVUyAo
QUVfQU1MX1JFR0lPTl9MSU1JVCk7CisJCSNpZmRlZiBDT05GSUdfQUNQSV9S
RUxBWEVEX0FNTAorCQkJcmV0dXJuX0FDUElfU1RBVFVTIChBRV9PSyk7CisJ
CSNlbHNlCisJCQlyZXR1cm5fQUNQSV9TVEFUVVMgKEFFX0FNTF9SRUdJT05f
TElNSVQpOworCQkjZW5kaWYKIAl9CiAKIAlyZXR1cm5fQUNQSV9TVEFUVVMg
KEFFX09LKTsK

--0-1719699026-1039754889=:14785--


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
