From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH][2.4] acpi S5 poweroff fix
Date: Mon, 12 May 2003 16:35:13 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F842722F6@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C31861.67E470A4"
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
To: willy tarreau <wtarreau-Qt13gs6zZMY@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C31861.67E470A4
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

To keep the consistency of the code,  below patch could be a better =
solution.

Thanks,
Luming

-----Original Message-----
From: willy tarreau [mailto:wtarreau-Qt13gs6zZMY@public.gmane.org]
Sent: 2003?4?30? 2:15
To: Grover, Andrew
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] [PATCH][2.4] acpi S5 poweroff fix


Hello Andy,

since I have this new laptop (sony vaio pcg-fx705), ACPI has never =
allowed
me to shutdown correctly. It always hangs and I have to maintain the =
power
button pressed to power off, whatever the version of your acpi patch I =
was
using. Today, I had a bit of free time, so I investigated into the code =
and
finally fixed the problem :-)

Basically, two unrelated things :
1) I noticed that "echo 5 >/proc/acpi/sleep" would oops, so I manually =
copied
   the oops and discovered that acpi_restore_state_mem() crashed, trying =
to
   affet 'pmd' a NULL value. Then I realized that it was because on this =
path,
   acpi_save_state_mem() was never called in S5. I first thought this =
was
   intentional because S5 is not expected to return, but reading through =
the
   code, I found a conflict such as "if (state < 5) { ... if (state !=3D =
5) ..."
   so I was sure that the first one should have included 5, and I =
changed the
   '<' to '<=3D' so that acpi_save_state_mem() is now called.
   It still didn't work, and I noticed that in acpi_suspend(), the call =
to
   acpi_system_suspend() is expected to do the right job and certainly =
not to
   return. But acpi_system_suspend() does nothing if called with =
state=3D5 !
   So I added the check for ACPI_STATE_S5 at the same level as _S1 =
because it
   semt right to me.
   =3D> with these 2 changes, echoing 5 in /proc/acpi/sleep now turns my =
notebook
   OFF !!!
   =3D> I diffed original (20030424) and my changes and put them in the =
first
      attached patch.

2) The sad thing is that even after that, neither Alt-SysRq-O nor halt =
would
   power off. I saw that acpi_poweroff() was a simpler than the code =
path
   executed from acpi_suspend(5). I tried to duplicate part of the code, =
but
   no lock. I think I missed some bits. So I did it far simpler : now
   acpi_poweroff() only calls acpi_suspend(ACPI_STATE_S5) and everything =
works
   fine !  =3D> hence the second patch, still against 20030424.

Although I'm not sure that the second case affects everybody, because it =
might
be caused by side-effects, but from what I've understood from the code, =
I'm
pretty sure that nobody can power off by echoing 5 to /proc/acpi/sleep !

Here are the two patches, please review them and apply them if you agree =
!

Cheers,
Willy (happy with a notebook that powers down for the first time in =
months !)


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en fran=E7ais !
Yahoo! Mail : http://fr.mail.yahoo.com

------_=_NextPart_001_01C31861.67E470A4
Content-Type: application/octet-stream;
	name="s5oops.diff"
Content-Transfer-Encoding: base64
Content-Description: s5oops.diff
Content-Disposition: attachment;
	filename="s5oops.diff"

ZGlmZiAtQnJ1IDEvZHJpdmVycy9hY3BpL3N5c3RlbS5jIDIvZHJpdmVycy9hY3BpL3N5c3RlbS5j
DQotLS0gMS9kcml2ZXJzL2FjcGkvc3lzdGVtLmMJMjAwMy0wMy0yOCAxNDo0NDozNS4wMDAwMDAw
MDAgKzA4MDANCisrKyAyL2RyaXZlcnMvYWNwaS9zeXN0ZW0uYwkyMDAzLTAzLTMxIDA5OjQ3OjM4
LjAwMDAwMDAwMCArMDgwMA0KQEAgLTExMyw2ICsxMjgsMTAgQEANCiAJaWYgKHN0YXRlICE9IEFD
UElfU1RBVEVfUzEgJiYgc3RhdGUgIT0gQUNQSV9TVEFURV9TNSkNCiAJCXJldHVybiBBRV9FUlJP
UjsNCiANCisJaWYoc3RhdGUgPT0gQUNQSV9TVEFURV9TNSl7DQorCQlhY3BpX3Bvd2VyX29mZigp
Ow0KKwkJcmV0dXJuOw0KKwl9DQogCWFjcGlfZW50ZXJfc2xlZXBfc3RhdGVfcHJlcChzdGF0ZSk7
DQogDQogCS8qIGRpc2FibGUgaW50ZXJydXB0cyBhbmQgZmx1c2ggY2FjaGVzICovDQo=

------_=_NextPart_001_01C31861.67E470A4--


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
