From: Bart Verwilst <verwilst-InCIlvFuQC0@public.gmane.org>
Subject: Re: acpi=on -> black screen instead of bootup
Date: Sun, 20 Jun 2004 02:11:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200406200211.39759.verwilst@pyxa.org>
References: <200406172059.05501.verwilst@pyxa.org> <200406200031.14309.verwilst@pyxa.org> <1087686525.7713.5.camel@localhost>
Reply-To: verwilst-InCIlvFuQC0@public.gmane.org
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1087686525.7713.5.camel-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 20 June 2004 01:08, Wesley T Allen wrote:
|| >
|| > Hello!
|| >
|| > Anybody knows why exactly this is happening? Maybe a solution? :)
||
|| I have a pavilion laptop as well, ACPI in HP Laptops is a MESS.
||
|| I do have a workaround, though.
||
|| try sending nolapic to the kernel and see if it boots ok.  This is what
|| finally got acpi working for me...
||
|| Wes

Hi!

Thanks for your reply, but it didn't help.. These are the combo's i tried:

"nolapic noapic acpi=3Don" and "nolapic acpi=3Don"

<snip>
Checking if this processor honours the WP bit even in supervisor mode... OK
Calibrating delay loop...
<hang>

"noapic acpi=3Don" and "acpi=3Don"

<snip>
ACPI: subsystem revision 20040326
Looking for DSDT in initrd... Not Found!
ACPI: IRQ9 SCI: level Trigger.
<hang>

I hope this helps somebody?

( Formerly my screen went just blank because i used the framebuffer, and it=
=20
didn't had time to initialize before the hangup.. Booting with framebuffer=
=20
disabled showed me this output..)

Thanks a lot!

Bart Verwilst
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA1NY7tp3m+MfS4dcRAnkIAJ4oWGck9bv/SOhuxkOQ+x76L6tubwCcCWOq
/komzMOoMn+UThc9GEf9yk8=3D
=3DnBUK
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
