From: "Paul Hampson" <Paul.Hampson-PqpLGJdN2WoAvxtiuMwx3w@public.gmane.org>
Subject: ACPI features of non-core devices... Who's job is it?
Date: Fri, 9 May 2003 14:58:22 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <NCBBKBIPALMINMCIOENFGEDDEJAA.Paul.Hampson@Pobox.Com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

First question is about Video devices... Who's job is it
to expose ACPI features to the user. In particular, I'm
talking about the ACPI features that set the output port
on the video device... Should the video driver
(XFree86/fb/whatever) be exposing that through some API
call, or is this a job for something in /proc/acpi? Or are
they only supposed to be exposed by the Fn+F5 key on
the keyboard??

Second question is related. My Toshiba Satellite Pro 4600
has an LPC SMCIrCC device built in. It's in the ACPI DSDT
with the ID EisaId ("SMCF010"), and when the system starts
it's unconfigured. (I tested this by making an ACPI module
that puts it in /proc/acpi and used acpi_get_resources or
whatever the call's called to enumerate it's resources.)
_Should_ the ACPI subsytem be initialising it, or should
the smc-ircc driver be doing so?

Anyway, I tried to use the acpi_set_resources call to
initialise the device with some fixed settings, and it
doesn't fail but it still ends up all 0'd out. If anyone's
interested in seeing the source, I'd be happy for the help,
since my only other method of getting the IR port online is
to poke values into the PCI config space and the SMCIrCC's
config space.

If you want to see the DSDT, it's posted at
http://acpi.sourceforge.net/dsdt/view.php?id=3D12

--
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Paul "TBBle" Hampson
Bubblesworth Pty Ltd (ABN: 51 095 284 361)
Paul.Hampson-N+r8tC8gUV4AvxtiuMwx3w@public.gmane.org

The Creation of the Universe was made
possible by a grant from Texas Instruments.
	-- PBS
---------------------------------------------------------
Random signature generator 3.0 by Paul "TBBle" Hampson
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
