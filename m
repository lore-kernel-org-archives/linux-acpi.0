From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Can't poweroff anymore.
Date: Sat, 6 Mar 2004 10:58:54 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0403061054120.1146@frog.athome>
References: <20040304180301.GA1754@conectiva.com.br>
 <Pine.LNX.4.58.0403050113230.3779@frog.athome>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811592-2132083550-1078567134=:1146"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0403050113230.3779-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime-oOUblnuQwHKola3qYQ6TW/IULO3mGbRi9nwVQlTi/Pw@public.gmane.org for more info.

---1463811592-2132083550-1078567134=:1146
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by post.webmailer.de id i26A2BKE014269

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut List,
I have good feedback from Flavio, that my patch works for him too.
As I do not understand what my patch does, may someone with more knowledg=
e
comment on it.

Thanks hartwig

On Fri, 5 Mar 2004 hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> Salut Flavio,
> ok. we are changed to
> http://bugme.osdl.org/show_bug.cgi?id=3D2109 by Len.
>
> I tested the patch with 2.4.25 and 2.4.26-pre1. I just had a quick look=
 at
> 2.6.3. There the patch applys cleanly, but I did not check, if it
> compiles, and fix the regression for 2.6.
>
> BTW, can anyone have a look, if this patch is a good thing, and comment=
 on
> it? I did not follow why the regression patch (i.e. v1.23 of hwsleep.c)
> was introduced in the first place - just a quick comment please.
>
> On Thu, 4 Mar 2004, Flavio Bruno Leitner wrote:
> > My notebook is an Acer TravelMate 630 and until 2.6.2-rc2
> > poweroff works well, but upgrading to bitkeeper of
> > 2004/01/27 (have many acpi changesets) it can't poweroff
> > anymore and show this message:
> > "acpi_power_off called"
> > "hwsleep-0265 [44] acpi_enter_sleep_state: Entering sleep state [S5].=
"
>
> Cheers
>   hartwig felger
>
> Hartwig Felger informatics
>
> - --
> 1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
> Key fingerprint =3D FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
> For the pulic keys, please visit my page.

Gru=DF
  hartwig felger

Hartwig Felger informatics

- --=20
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint =3D FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFASaDi9bBoTzOf1pMRAiGIAKCJqzr4WFIxWfpma1lZs0m4x27OqACfXspR
PGleemqCs3vSnwC39085Qu8=3D
=3D4Qrs
-----END PGP SIGNATURE-----
---1463811592-2132083550-1078567134=:1146
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="hwsleep.c2-patch"
Content-ID: <Pine.LNX.4.58.0403061058530.1146-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Content-Description: 
Content-Disposition: attachment; filename="hwsleep.c2-patch"
Content-Transfer-Encoding: BASE64

LS0tIGxpbnV4L2RyaXZlcnMvYWNwaS9oYXJkd2FyZS9od3NsZWVwLmMub3Jp
ZwkyMDA0LTAzLTA0IDIzOjEwOjQxLjAwMDAwMDAwMCArMDEwMA0KKysrIGxp
bnV4L2RyaXZlcnMvYWNwaS9oYXJkd2FyZS9od3NsZWVwLmMJMjAwNC0wMy0w
NCAyMzoxMTo1OC4wMDAwMDAwMDAgKzAxMDANCkBAIC0yNDksNiArMjQ5LDEx
IEBADQogCQlpZiAoQUNQSV9GQUlMVVJFIChzdGF0dXMpKSB7DQogCQkJcmV0
dXJuX0FDUElfU1RBVFVTIChzdGF0dXMpOw0KIAkJfQ0KKwl9IGVsc2Ugew0K
KwkJc3RhdHVzID0gYWNwaV9od19jbGVhcl9hY3BpX3N0YXR1cyAoQUNQSV9N
VFhfRE9fTk9UX0xPQ0spOw0KKwkJaWYgKEFDUElfRkFJTFVSRSAoc3RhdHVz
KSkgew0KKwkJCXJldHVybl9BQ1BJX1NUQVRVUyAoc3RhdHVzKTsNCisJCX0N
CiAJfQ0KIA0KIAlzdGF0dXMgPSBhY3BpX2h3X2Rpc2FibGVfbm9uX3dha2V1
cF9ncGVzICgpOw0K

---1463811592-2132083550-1078567134=:1146--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
