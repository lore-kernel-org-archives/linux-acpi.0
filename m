From: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: ACPI for x-scale
Date: Mon, 09 May 2005 21:31:31 +0200
Message-ID: <427FBA93.1060309@kernelconcepts.de>
References: <6EF58BF68042DF4AA46A54994117D64F035A1C81@mercury.mtctech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <6EF58BF68042DF4AA46A54994117D64F035A1C81-x6Fv9fcoW1YgtwCHe4clqUEOCMrvLtNR@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Williams, Richard" <Richard.Williams-RyImI6ggfRp0+Iju73vM4UEOCMrvLtNR@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Williams, Richard wrote:
> Hi,
Hi!

> I'm a newbie to the ACPI world.
> Has anyone ported the Linux 2.6 kernel ACPI to the ARM processors -
> specifically an Intel X-scale, PXA-270 ?

ROTFL ;)
Sorry... couldn't resist...

> Is this appropriate for an embedded single board computer ?

No, it isn't.
It starts with the "problem" that the usual ARM/StrongARM/XScale device
do not own a BIOS as it is known on x86 PCs.

For most embedded platforms implementing huge systems like APM or ACPI
is simply a waste of time - you simply do it yourself in the specific
kernel you are using on your platform anyway.
IMHO ACPI and APM are used as a generic approach, i.e. for situation
where you do not know specifics of the system you are running on. Then
ACPI offers for example a method to suspend, resume or power throttle a
device (put to standby, suspend, ...).
The more complex systems became the more complex those sophisticated
system became with ACPI being its current culprit.

The current embedded Linux flavours all do power management to various
degrees by themselves, expecially using the current Linux device model
and power state siganlling, i.e. the device drivers have to do their own
power management.

Or to make it short: No, you do not want to implement ACPI for embedded
platforms.

> Thanks,
> Rich
CU
  nils faerber

- --
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCf7qTJXeIURG1qHgRAlZrAJ0cbKE2ZeckBf2o7qKHQyxAUDsGHwCfcip9
4+HZrQQfFW8BZW2/RjPK/F0=
=v0io
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
