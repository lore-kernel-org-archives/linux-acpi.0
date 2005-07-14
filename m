From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.6.13-rc3 ACPI regression and hang on x86-64
Date: Thu, 14 Jul 2005 15:23:52 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30040CF75E@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mikael Pettersson <mikpe-gJWeRRR3xd2zQB+pC5nmwQ@public.gmane.org>, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>acpi_ec-0217 [04] acpi_ec_leave_burst_mo: ------->status fail
>
>on the console, and then the machine is hung hard.

2.6.13-rc3 x86_64 failed, but=20
2.6.13-rc2 x86_64 worked

And both of these revisions in the i386 kernel still work?

>+evxfevnt-0203 [07] acpi_enable_event     : Could not enable
power_button
>event
>+ evxface-0157 [06] acpi_install_fixed_eve: Could not enable fixed
event.
>+acpi_button-0224 [05] acpi_button_add       : Error installing notify
>handler
>+ACPI: Power Button (CM) [PWRB]


We're toast at this point, even before the EC message.

Looks like this failure was reported here
http://bugzilla.kernel.org/show_bug.cgi?id=3D4534
and is assigned to Luming.

Is it possible for you to test the latest ACPI patch?
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/
2.6.13/

Also, it would be good to confirm the same failure exists with
CONFIG_ACPI_DEBUG=3Dn.

thanks,
-Len



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
