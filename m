From: "Williams, Richard" <Richard.Williams-RyImI6ggfRp0+Iju73vM4UEOCMrvLtNR@public.gmane.org>
Subject: RE: ACPI for x-scale
Date: Mon, 9 May 2005 16:10:38 -0400
Message-ID: <6EF58BF68042DF4AA46A54994117D64F035A1D3B@mercury.mtctech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Nils Faerber resisted the easy flame target -)

Thanks, I suspected as much about the overkill of ACPI on an embedded
platform.

I had done some searching for ACPI on embedded and ARM forums, and had
found very little. Of course, the minute after I posted the question
here I found some discussion that matched what you say. Not applicable.

Nils, thanks for being gentle with me.

Rich




Williams, Richard wrote:
> Hi,
Hi!

> I'm a newbie to the ACPI world.
> Has anyone ported the Linux 2.6 kernel ACPI to the ARM processors -=20
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
4+HZrQQfFW8BZW2/RjPK/F0=3D
=3Dv0io
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
