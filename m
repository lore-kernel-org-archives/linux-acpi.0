From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: smpenum patch updated to 2.6.9-rc2
Date: Wed, 15 Sep 2004 14:17:32 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847077F835A@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C49B69.6A3A8663"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C49B69.6A3A8663
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> From: Stian Jordet [mailto:liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org]=20

Hi Stian thanks a lot!

> I have a Asus CUV266-DLS smp motherboard with Via Apollo Pro 266
> chipset. It has never booted with io-apic in non-ACPI mode, and still
> doesn't. I just want to let you know my experiences with your patch.
>=20
> 1) With ACPI enabled everything works as it always has (one ACPI bug,
> but that's another story)

great...

> 2) With acpi=3Doff and CONFIG_X86_MPS the boot hangs at "ENABLING IO-
> APIC's"

ok not a new bug...

> 3) With acpi=3Doff and !CONFIG_X86_MPS the boot hangs at =
"Uncompressing
> Linux... Ok, booting the kernel".

Fixed, please try the attached patch.

> 4) Without your patch and acpi=3Doff the boot hangs at:
>=20
> ENABLING IO-APIC IRQs
> Setting 2 in the phys_id_present_map
> ...changing IO-APIC Physical APIC ID to 2 ... ok.

ok great.

Thanks -- Regards -- Andy

------_=_NextPart_001_01C49B69.6A3A8663
Content-Type: application/octet-stream;
	name="smpenum.diff"
Content-Transfer-Encoding: base64
Content-Description: smpenum.diff
Content-Disposition: attachment;
	filename="smpenum.diff"

ZGlmZiAtTnJ1IGEvYXJjaC9pMzg2L2tlcm5lbC9hcGljLmMgYi9hcmNoL2kzODYva2VybmVsL2Fw
aWMuYwotLS0gYS9hcmNoL2kzODYva2VybmVsL2FwaWMuYwkyMDA0LTA5LTE1IDE0OjEzOjM2IC0w
NzowMAorKysgYi9hcmNoL2kzODYva2VybmVsL2FwaWMuYwkyMDA0LTA5LTE1IDE0OjEzOjM2IC0w
NzowMApAQCAtNjY2LDYgKzY2Niw3IEBACiBzdGF0aWMgaW50IF9faW5pdCBkZXRlY3RfaW5pdF9B
UElDICh2b2lkKQogewogCXUzMiBoLCBsLCBmZWF0dXJlczsKKwl1bnNpZ25lZCBsb25nIGxhcGlj
X2FkZHI7CiAJZXh0ZXJuIHZvaWQgZ2V0X2NwdV92ZW5kb3Ioc3RydWN0IGNwdWluZm9feDg2Kik7
CiAKIAkvKiBEaXNhYmxlZCBieSBETUkgc2NhbiBvciBrZXJuZWwgb3B0aW9uPyAqLwpAQCAtNzE3
LDEyICs3MTgsMTIgQEAKIAkJcmV0dXJuIC0xOwogCX0KIAlzZXRfYml0KFg4Nl9GRUFUVVJFX0FQ
SUMsIGJvb3RfY3B1X2RhdGEueDg2X2NhcGFiaWxpdHkpOwotCXNtcF9sYXBpY19hZGRyID0gQVBJ
Q19ERUZBVUxUX1BIWVNfQkFTRTsKKwlsYXBpY19hZGRyID0gQVBJQ19ERUZBVUxUX1BIWVNfQkFT
RTsKIAogCS8qIFRoZSBCSU9TIG1heSBoYXZlIHNldCB1cCB0aGUgQVBJQyBhdCBzb21lIG90aGVy
IGFkZHJlc3MgKi8KIAlyZG1zcihNU1JfSUEzMl9BUElDQkFTRSwgbCwgaCk7CiAJaWYgKGwgJiBN
U1JfSUEzMl9BUElDQkFTRV9FTkFCTEUpCi0JCXNtcF9sYXBpY19hZGRyID0gbCAmIE1TUl9JQTMy
X0FQSUNCQVNFX0JBU0U7CisJCWxhcGljX2FkZHIgPSBsICYgTVNSX0lBMzJfQVBJQ0JBU0VfQkFT
RTsKIAogCWlmIChubWlfd2F0Y2hkb2cgIT0gTk1JX05PTkUpCiAJCW5taV93YXRjaGRvZyA9IE5N
SV9MT0NBTF9BUElDOwpAQCAtNzMwLDYgKzczMSw4IEBACiAJYXBpY19wcmludGsoQVBJQ19WRVJC
T1NFLCAiRm91bmQgYW5kIGVuYWJsZWQgbG9jYWwgQVBJQyFcbiIpOwogCiAJYXBpY19wbV9hY3Rp
dmF0ZSgpOworCisJc21wX3NldF9sYXBpY19hZGRyZXNzKGxhcGljX2FkZHIpOwogCiAJcmV0dXJu
IDA7CiAKZGlmZiAtTnJ1IGEvYXJjaC9pMzg2L2tlcm5lbC9pb19hcGljLmMgYi9hcmNoL2kzODYv
a2VybmVsL2lvX2FwaWMuYwotLS0gYS9hcmNoL2kzODYva2VybmVsL2lvX2FwaWMuYwkyMDA0LTA5
LTE1IDE0OjEzOjM2IC0wNzowMAorKysgYi9hcmNoL2kzODYva2VybmVsL2lvX2FwaWMuYwkyMDA0
LTA5LTE1IDE0OjEzOjM2IC0wNzowMApAQCAtNzM1LDcgKzczNSw3IEBACiB7CiAJaW50IGlycTsK
IAotCWlmIChza2lwX2lvYXBpY19zZXR1cCA9PSAxKQorCWlmIChza2lwX2lvYXBpY19zZXR1cCA9
PSAxIHx8ICFucl9pb2FwaWNzKQogCQlyZXR1cm47CiAKIAlmb3IgKGlycSA9IDA7IGlycSA8IE5S
X0lSUVM7IGlycSsrKQo=

------_=_NextPart_001_01C49B69.6A3A8663--


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
