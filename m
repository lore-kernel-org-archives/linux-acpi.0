From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: need debugging help
Date: Sun, 13 Jul 2003 18:01:55 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E97026@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C349A3.84C6A714"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Chander Kant <ck-cFQ2QR18kktMdczFR1vadtBPR1lH4CV8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C349A3.84C6A714
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> From: Chander Kant [mailto:ck-cFQ2QR18kktMdczFR1vadtBPR1lH4CV8@public.gmane.org]=20
> Unfortunately I don't have a way of changing the System BIOS. Can you=20
> please provide a link to the patch you mention below, and any=20
> instructions=20
> on how to apply it.

This is already in 2.4.22-pre4 and later but if your version doesn't
have it, here it is.

just cd to the toplevel linux src directory, and "cat relaxed.diff
|patch -p1".

Regards -- Andy

>=20
> thanks
>=20
> At 05:04 PM 13/07/2003 -0700, Grover, Andrew wrote:
> >Hi, sorry for the delay.
> >
> >So do you have the ability to change your systems' BIOS? If=20
> so it is an
> >easy fix. If not, then there is a Relaced AML patch to=20
> workaround this
> >issue, but the ideal situation would be to fix the firmware.
> >
> >Regards -- Andy
> >
> > > -----Original Message-----
> > > From: Chander Kant [mailto:ck-cFQ2QR18kktMdczFR1vadtBPR1lH4CV8@public.gmane.org]
> > > Sent: Tuesday, July 01, 2003 5:13 PM
> > > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > Cc: Grover, Andrew; ck-cFQ2QR18kktMdczFR1vadtBPR1lH4CV8@public.gmane.org
> > > Subject: need debugging help
> > >
> > >
> > >
> > > Thanks Andrew. I am moving the discussion to the acpi-devel list:
> > >
> > > All,
> > >
> > > I am attaching the output of "iasl -d dsdt" (in zipped format).
> > >
> > > Please let me know if we can do anything on this system to
> > > get rid of the problem mentioned below.
> > >
> > > Thanks,
> > > Chander
> > >
> > >
> > > "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote ..
> > > > > When we bring up a recent Linux kernel (2.4.20) with ACPI
> > > > > patch on our laptop. We get following error messages
> > > > > continously from the kernel:
> > > > >
> > > > > Jul  2 04:31:16 localhost kernel:     ACPI-1103: *** Error:
> > > > > Method execution failed [\_SB_.PCI0.SBRG.EC0_._Q1E] (Node
> > > > > c33b1380), AE_AML_REGION_LIMIT
> > > > >
> > > > > Besides filling up the log files, and making the console
> > > > > windows, I think it is also hampering ACPI functionality to
> > > > > work, as I do not see and battery file in the /proc/acpi
> > > directory.
> > > > >
> > > > > I have seen other folks in user groups and lists getting
> > > > > these errors, but so far I have not seen a good response as
> > > > > far as a fix or workaround.
> > > >
> > > > It's most likely an AML error. This particular error is not
> > > uncommon.
> > > >
> > > > Do you have the ASL for this machine? If not, get iasl from
> > > >
> > > http://developer.intel.com/technology/iapc/acp>=20
> i/downloads.htm and
> >feed
> > > > your DSDT into it (from /proc/acpi/dsdt). with the -d
> > > option. Then, go
> > > > take a look at the _Q1E method.
> > > >
> > > >
> > >
>=20

------_=_NextPart_001_01C349A3.84C6A714
Content-Type: application/octet-stream;
	name="relaxed.diff"
Content-Transfer-Encoding: base64
Content-Description: relaxed.diff
Content-Disposition: attachment;
	filename="relaxed.diff"

ZGlmZiAtTnJ1IGEvZHJpdmVycy9hY3BpL0NvbmZpZy5pbiBiL2RyaXZlcnMvYWNwaS9Db25maWcu
aW4KLS0tIGEvZHJpdmVycy9hY3BpL0NvbmZpZy5pbglTdW4gSnVsIDEzIDE3OjU3OjU0IDIwMDMK
KysrIGIvZHJpdmVycy9hY3BpL0NvbmZpZy5pbglTdW4gSnVsIDEzIDE3OjU3OjU0IDIwMDMKQEAg
LTM3LDYgKzM3LDcgQEAKICAgICAgIHRyaXN0YXRlICAgICAnICBBU1VTIExhcHRvcCBFeHRyYXMn
ICBDT05GSUdfQUNQSV9BU1VTCiAgICAgICB0cmlzdGF0ZSAgICAgJyAgVG9zaGliYSBMYXB0b3Ag
RXh0cmFzJwlDT05GSUdfQUNQSV9UT1NISUJBCiAgICAgICBib29sICAgICAgICAgJyAgRGVidWcg
U3RhdGVtZW50cycJQ09ORklHX0FDUElfREVCVUcKKyAgICAgIGJvb2wgICAgICAgICAnICBSZWxh
eGVkIEFNTCBDaGVja2luZycJQ09ORklHX0FDUElfUkVMQVhFRF9BTUwKICAgICBmaQogICBmaQog
CmRpZmYgLU5ydSBhL2RyaXZlcnMvYWNwaS9leGVjdXRlci9leGZsZGlvLmMgYi9kcml2ZXJzL2Fj
cGkvZXhlY3V0ZXIvZXhmbGRpby5jCi0tLSBhL2RyaXZlcnMvYWNwaS9leGVjdXRlci9leGZsZGlv
LmMJU3VuIEp1bCAxMyAxNzo1Nzo1NCAyMDAzCisrKyBiL2RyaXZlcnMvYWNwaS9leGVjdXRlci9l
eGZsZGlvLmMJU3VuIEp1bCAxMyAxNzo1Nzo1NCAyMDAzCkBAIC0xMzksNyArMTM5LDQxIEBACiAJ
CQlmaWVsZF9kYXR1bV9ieXRlX29mZnNldCwgb2JqX2Rlc2MtPmNvbW1vbl9maWVsZC5hY2Nlc3Nf
Ynl0ZV93aWR0aCwKIAkJCXJnbl9kZXNjLT5yZWdpb24ubm9kZS0+bmFtZS5hc2NpaSwgcmduX2Rl
c2MtPnJlZ2lvbi5sZW5ndGgpKTsKIAotCQlyZXR1cm5fQUNQSV9TVEFUVVMgKEFFX0FNTF9SRUdJ
T05fTElNSVQpOworCQkjaWZkZWYgQ09ORklHX0FDUElfUkVMQVhFRF9BTUwKKwkJeworCQkJLyoK
KwkJCSAqIEFsbG93IGFjY2VzcyB0byB0aGUgZmllbGQgaWYgaXQgaXMgd2l0aGluIHRoZSByZWdp
b24gc2l6ZQorCQkJICogcm91bmRlZCB1cCB0byBhIG11bHRpcGxlIG9mIHRoZSBhY2Nlc3MgYnl0
ZSB3aWR0aC4gIFRoaXMKKwkJCSAqIG92ZXJjb21lcyAib2ZmLWJ5LW9uZSIgcHJvZ3JhbW1pbmcg
ZXJyb3JzIGluIHRoZSBBTUwgb2Z0ZW4KKwkJCSAqIGZvdW5kIGluIFRvc2hpYmEgbGFwdG9wcy4g
IFRoZXNlIGVycm9ycyB3ZXJlIGFsbG93ZWQgYnkKKwkJCSAqIHRoZSBNaWNyb3NvZnQgQVNMIGNv
bXBpbGVyLgorCQkJICovCisJCQl1MzIgcm91bmRlZF9sZW5ndGggPSBBQ1BJX1JPVU5EX1VQKHJn
bl9kZXNjLT5yZWdpb24ubGVuZ3RoLAorCQkJCQkJCQkJb2JqX2Rlc2MtPmNvbW1vbl9maWVsZC5h
Y2Nlc3NfYnl0ZV93aWR0aCk7CisKKwkJCWlmIChyb3VuZGVkX2xlbmd0aCA8IChvYmpfZGVzYy0+
Y29tbW9uX2ZpZWxkLmJhc2VfYnl0ZV9vZmZzZXQKKwkJCQkJCSsgZmllbGRfZGF0dW1fYnl0ZV9v
ZmZzZXQKKwkJCQkJCSsgb2JqX2Rlc2MtPmNvbW1vbl9maWVsZC5hY2Nlc3NfYnl0ZV93aWR0aCkp
IHsKKwkJCQlyZXR1cm5fQUNQSV9TVEFUVVMgKEFFX0FNTF9SRUdJT05fTElNSVQpOworCQkJfSBl
bHNlIHsKKwkJCQlzdGF0aWMgaW50CXdhcm5fb25jZSA9IDE7CisJCQkJaWYgKHdhcm5fb25jZSkg
eworCQkJCQkvLyBDb3VsZCBhbHNvIGFzc29jaWF0ZSBhIGZsYWcgd2l0aCBlYWNoIGZpZWxkLCBh
bmQKKwkJCQkJLy8gd2FybiBvbmNlIGZvciBlYWNoIGZpZWxkLgorCQkJCQlBQ1BJX1JFUE9SVF9X
QVJOSU5HKCgKKwkJCQkJCSJUaGUgQUNQSSBBTUwgaW4geW91ciBjb21wdXRlciBjb250YWlucyBl
cnJvcnMsICIKKwkJCQkJCSJwbGVhc2UgbmFnIHRoZSBtYW51ZmFjdHVyZXIgdG8gY29ycmVjdCBp
dC5cbiIpKTsKKwkJCQkJQUNQSV9SRVBPUlRfV0FSTklORygoCisJCQkJCQkiQWxsb3dpbmcgcmVs
YXhlZCBhY2Nlc3MgdG8gZmllbGRzOyAiCisJCQkJCQkidHVybiBvbiBDT05GSUdfQUNQSV9ERUJV
RyBmb3IgZGV0YWlscy5cbiIpKTsKKwkJCQkJd2Fybl9vbmNlID0gMDsKKwkJCQl9CisJCQkJcmV0
dXJuX0FDUElfU1RBVFVTIChBRV9PSyk7CisJCQl9CisJCX0KKwkJI2Vsc2UKKwkJCXJldHVybl9B
Q1BJX1NUQVRVUyAoQUVfQU1MX1JFR0lPTl9MSU1JVCk7CisJCSNlbmRpZgogCX0KIAogCXJldHVy
bl9BQ1BJX1NUQVRVUyAoQUVfT0spOwo=

------_=_NextPart_001_01C349A3.84C6A714--


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
