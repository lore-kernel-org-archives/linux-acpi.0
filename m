From: "Tim Stadelmann" <t.stadelmann1-JAjqph6Yjy8XSZKaUYBEcQ@public.gmane.org>
Subject: ACPI on Dell Latitude C600
Date: Wed, 21 Jan 2004 17:04:45 -0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <003e01c3e040$ab873700$03f101a3@physics.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Dear all,

I've recently experimented with getting ACPI sleep states to work on my Dell
Latitude C600 (BIOS revision A21) using a 2.6.0 kernel and the latest
appropriate patch from acpi4linux.

With a minimal amount of kernel driver modules loaded, both S1 and S3 almost
work, with one interesting problem:

The computer displays messages indicating it is going into the appropriate
sleep state, then switches off most peripherals *except* for the screen and
backlight.  Pressing the power button causes it to resume, but now the
screen is switched *off* during this process.  Changing the virtual console
to the one used for X11 causes the X server to switch the screen back on and
the computer appears to be working properly afterwards.

The entries in the system log do not give any indication that something is
going wrong.

I wondered whether you might find this information helpful or have any idea
where the problem stems from...  Please do not hesitate to contact me for
more information if required, I'm quite keen to help makeing ACPI work
better, as I think poor power management support is one of the main things
holding Linux back at the moment.


                Regards,

                Tim Stadelmann



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
