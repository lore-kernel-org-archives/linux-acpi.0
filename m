From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI Extensions for Display Adapters
Date: Fri, 23 Jan 2004 17:35:00 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8A41@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Volunteers?
Karol, this make sense to you?

Thanks,
-Len

-----Original Message-----
From: acpi-bugzilla-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-bugzilla-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of
bugme-daemon-3NddpPZAyC0@public.gmane.org
Sent: Friday, January 23, 2004 5:31 PM
To: acpi-bugzilla-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI-bugzilla] [Bug 1944] New: ACPI Extensions for Display
Adapters


http://bugme.osdl.org/show_bug.cgi?id=3D1944

           Summary: ACPI Extensions for Display Adapters
    Kernel Version: 2.6.0-test10
            Status: NEW
          Severity: normal
             Owner: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
         Submitter: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
                CC: acpi-bugzilla-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org


Systems containing a built-in display adapter are requred to implement
the ACPI Extensions for Display Adapters. -- ACPI Spec 2.0c appendix B.=20
=20
These extensions involved brightness control, device switching,
and power state support.=20
=20
Currently, some of these features are implemented in the asus_extras
and toshiba_extras drivers.  A generic drivers/acpi/video.c driver
should be created to support these features on all=20
vendors platforms.  When it is available, that functionality should be
removed from the asus and toshiba specific drivers.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
acpi-bugzilla mailing list
acpi-bugzilla-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-bugzilla


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
