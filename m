From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: \_PR\CPU\_INI not called during initialization
Date: Mon, 6 Oct 2003 11:15:33 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D3A3AA459175A44CB5326F26DA7A189C1C3DDA@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


_INI methods are only called on objects of type "Device", as per the
ACPI specification.
Bob


-----Original Message-----
From: Nate Lawson [mailto:nate-Y6VGUYTwhu0@public.gmane.org]=20
Sent: Monday, October 06, 2003 9:47 AM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Moore, Robert
Subject: \_PR\CPU\_INI not called during initialization

My laptop has two performance states I have been using, however, I get a
0
when I read the mhz and mW associated with each state.  When running
with
debug =3D ACPI_LV_INIT, I noticed that the processor's _INI method is =
not
called and this is what fills out the Px info.  Is this something you'll
add to ACPICA or should I be handling that myself?

   http://root.org/~nate/acpi/ibm-acpidump.asl.gz

-Nate


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
