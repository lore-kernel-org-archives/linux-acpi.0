From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: need debugging help
Date: Mon, 14 Jul 2003 11:49:12 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EE89@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Chander Kant <ck-cFQ2QR18kktMdczFR1vadtBPR1lH4CV8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Alan Cox [mailto:alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org]=20
> BTW Andrew - do you think we can also safely fix up the
>=20
> 	Load a variable with itself when its undefined being load 0
>=20
> 	Implied returns stuff
>=20
> with the same kind of option ?

Look, I'm sure you know I hate compatibility hacks. Slippery slope, and
here we start slipping down it. The only reason I can bring bear the
opregion bounds hack is because it's extremely localized (and BTW it
went to Marcelo through you, not me, although now that it's there it
would be very rude for me to remove it.)

Bob looked at how hard it would be to implement an implicit return
workaround and it was very ugly. If you or whoever originally wrote the
relaxed AML patch wanted to give it a shot then great.

Len Brown is working on improving the blacklist to use DMI and BIOS
date. If the machines who need these things have older BIOSes then I
would love it if we could say no ACPI for them and keep things clean for
more recent machines.

Regards -- Andy


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
