From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.6.0-test9 regression: panic on Fn+F7 hotkey
Date: Tue, 28 Oct 2003 16:14:56 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8D5FDBE@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C39D2B.92C4AA1C"
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
To: =?GB2312?B?U6imcmdpbyBNb250ZWlybyBCYXN0bw==?= <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C39D2B.92C4AA1C
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

Hi,

I missed non-ECDT situation. Try this one.=20

Thanks,
Shaohua


> -----Original Message-----
> From: S=A8=A6rgio Monteiro Basto [mailto:sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org]
> Sent: 2003=C4=EA10=D4=C228=C8=D5 14:23
> To: Li, Shaohua
> Cc: Karol Kozimor; acpi-devel
> Subject: RE: [ACPI] 2.6.0-test9 regression: panic on Fn+F7 hotkey
>=20
> Hi
> Pressing Fn+F7 doesnt seems to be in boot time.
> For me acpi_ec_gpe_query.patch in 2.4.23-pre8, hangs my laptop when I
> press lid button, after boot and after login after enter in X, after =
all
> things up.
>=20
> On Tue, 2003-10-28 at 02:30, Li, Shaohua wrote:
> > Hi,
> >   Which time did the panic occur? Boot time? Yes, I made the patch =
to
> fix some boot time errors.
> > But if boot is ok, the patch should not impact anything.
>=20
> but have a lot of impact.
> in my case, boots without problems.
>=20
> Please give me more info.
> >
> > Thanks,
> > Shaohua
> >
> >
> > > -----Original Message-----
> > > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> > > admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Karol Kozimor
> > > Sent: 2003=C4=EA10=D4=C228=C8=D5 1:08
> > > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > Subject: [ACPI] 2.6.0-test9 regression: panic on Fn+F7 hotkey
> > >
> > > Hi,
> > > Pressing Fn+F7 to turn the LCD on / off causes 2.6.0-test9 to =
panic.
> > > That's
> > > AFAIK the single event that causes such a behaviour, other keys =
work
> fine.
> > > Reverting the acpi_ec_gpe_query.patchi[1] fixes the issue and =
makes
> the
> > > kernel
> > > run fine.
> > >
> > > [1]:
> > >
> =
http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.4.=
2
> > > 2/20031017152411-acpi_ec_gpe_query.patch
> > >
> > > Best regards,
> > >
> > > --
> > > Karol 'sziwan' Kozimor
> > > sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
> > >
> > >
> > > -------------------------------------------------------
> > > This SF.net email is sponsored by: The SF.net Donation Program.
> > > Do you like what SourceForge.net is doing for the Open
> > > Source Community?  Make a contribution, and help us add new
> > > features and functionality. Click here: =
http://sourceforge.net/donate/
> > > _______________________________________________
> > > Acpi-devel mailing list
> > > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >
> >
> > -------------------------------------------------------
> > This SF.net email is sponsored by: The SF.net Donation Program.
> > Do you like what SourceForge.net is doing for the Open
> > Source Community?  Make a contribution, and help us add new
> > features and functionality. Click here: =
http://sourceforge.net/donate/
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> --
> S=A8=A6rgioMB
> email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
>=20
> Who gives me one shell, give me everything.


------_=_NextPart_001_01C39D2B.92C4AA1C
Content-Type: application/octet-stream;
	name="ec_gpe.patch2"
Content-Transfer-Encoding: base64
Content-Description: ec_gpe.patch2
Content-Disposition: attachment;
	filename="ec_gpe.patch2"

LS0tIGEvZHJpdmVycy9hY3BpL2VjLmMJMjAwMy0xMC0yOCAxNTo1ODo0NC4wMDAwMDAwMDAgKzA4
MDANCisrKyBiL2RyaXZlcnMvYWNwaS9lYy5jCTIwMDMtMTAtMjggMTY6MDU6MTcuMDAwMDAwMDAw
ICswODAwDQpAQCAtOTAsNiArOTAsMTQgQEANCiAvKiBFeHRlcm5hbCBpbnRlcmZhY2VzIHVzZSBm
aXJzdCBFQyBvbmx5LCBzbyByZW1lbWJlciAqLw0KIHN0YXRpYyBzdHJ1Y3QgYWNwaV9kZXZpY2Ug
KmZpcnN0X2VjOw0KIA0KKy8qDQorICogV2UgdXNlIGtlcm5lbCB0aHJlYWQgdG8gaGFuZGxlIGVj
J3MgZ3BlIHF1ZXJ5LCBzbyB0aGUgcXVlcnkgbWF5IGRlZmVyLg0KKyAqIFRoZSBxdWVyeSBuZWVk
IGEgY29udGV4dCwgd2hpY2ggY2FuIGJlIGZyZWVkIHdoZW4gd2UgcmVwbGFjZSBlY19lY2R0DQor
ICogd2l0aCBFQyBkZXZpY2UuIFNvIGRlZmVyZWQgcXVlcnkgbWF5IGhhdmUgYSB3cm9uZyBjb250
ZXh0Lg0KKyAqIFdlIHVzZSBhbiBpbmRpY2F0aW9uIHRvIGF2b2lkIGl0DQorICovDQorc3RhdGlj
IGludCBlY19kZXZpY2VfaW5pdCA9IDA7DQorDQogLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFRyYW5zYWN0aW9uIE1hbmFnZW1lbnQNCiAgICAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSAqLw0KQEAgLTM4OSw4ICszOTcsMTEgQEANCiANCiAJYWNwaV9kaXNhYmxl
X2dwZShOVUxMLCBlYy0+Z3BlX2JpdCwgQUNQSV9JU1IpOw0KIA0KLQlzdGF0dXMgPSBhY3BpX29z
X3F1ZXVlX2Zvcl9leGVjdXRpb24oT1NEX1BSSU9SSVRZX0dQRSwNCi0JCWFjcGlfZWNfZ3BlX3F1
ZXJ5LCBlYyk7DQorCWlmICghZWNfZGV2aWNlX2luaXQpDQorCQlhY3BpX2VjX2dwZV9xdWVyeShl
Yyk7IC8qIGRpcmVjdGx5IHF1ZXJ5IHdoZW4gZGV2aWNlIGRpZG4ndCBpbml0ICovDQorCWVsc2UN
CisJCXN0YXR1cyA9IGFjcGlfb3NfcXVldWVfZm9yX2V4ZWN1dGlvbihPU0RfUFJJT1JJVFlfR1BF
LA0KKwkJCWFjcGlfZWNfZ3BlX3F1ZXJ5LCBlYyk7DQogfQ0KIA0KIC8qIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQpAQCAtNTc0LDYgKzU4NSw3IEBADQogCXNwcmludGYoYWNwaV9kZXZpY2VfbmFtZShkZXZp
Y2UpLCAiJXMiLCBBQ1BJX0VDX0RFVklDRV9OQU1FKTsNCiAJc3ByaW50ZihhY3BpX2RldmljZV9j
bGFzcyhkZXZpY2UpLCAiJXMiLCBBQ1BJX0VDX0NMQVNTKTsNCiAJYWNwaV9kcml2ZXJfZGF0YShk
ZXZpY2UpID0gZWM7DQorCWVjX2RldmljZV9pbml0ID0gMTsNCiANCiAJLyogVXNlIHRoZSBnbG9i
YWwgbG9jayBmb3IgYWxsIEVDIHRyYW5zYWN0aW9ucz8gKi8NCiAJYWNwaV9ldmFsdWF0ZV9pbnRl
Z2VyKGVjLT5oYW5kbGUsICJfR0xLIiwgTlVMTCwgJmVjLT5nbG9iYWxfbG9jayk7DQpAQCAtNTgy
LDYgKzU5NCw3IEBADQogCSAgIHdlIG5vdyBoYXZlIHRoZSAqcmVhbCogRUMgaW5mbywgc28ga2ls
bCB0aGUgbWFrZXNoaWZ0IG9uZS4qLw0KIAlhY3BpX2V2YWx1YXRlX2ludGVnZXIoZWMtPmhhbmRs
ZSwgIl9VSUQiLCBOVUxMLCAmdWlkKTsNCiAJaWYgKGVjX2VjZHQgJiYgZWNfZWNkdC0+dWlkID09
IHVpZCkgew0KKwkJYWNwaV9kaXNhYmxlX2dwZShOVUxMLCBlY19lY2R0LT5ncGVfYml0LCBBQ1BJ
X05PVF9JU1IpOw0KIAkJYWNwaV9yZW1vdmVfYWRkcmVzc19zcGFjZV9oYW5kbGVyKEFDUElfUk9P
VF9PQkpFQ1QsDQogCQkJQUNQSV9BRFJfU1BBQ0VfRUMsICZhY3BpX2VjX3NwYWNlX2hhbmRsZXIp
Ow0KIAkNCg==

------_=_NextPart_001_01C39D2B.92C4AA1C--


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
