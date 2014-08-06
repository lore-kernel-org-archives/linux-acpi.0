From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/Processor: Add CPU_STARTING_FROZEN check in the acpi_cpu_soft_notify()
Date: Wed, 06 Aug 2014 03:30:21 +0200
Message-ID: <2440957.I2MrVyXYIg@vostro.rjw.lan>
References: <1406798426-16483-1-git-send-email-tianyu.lan@intel.com> <1560513.OlLhy0HTTU@vostro.rjw.lan> <53DB00C2.2040500@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49952 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755168AbaHFBLl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Aug 2014 21:11:41 -0400
In-Reply-To: <53DB00C2.2040500@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>

On Friday, August 01, 2014 10:51:46 AM Lan Tianyu wrote:
> On 2014=E5=B9=B408=E6=9C=8801=E6=97=A5 05:20, Rafael J. Wysocki wrote=
:
> > On Thursday, July 31, 2014 05:20:26 PM Lan Tianyu wrote:
> >> The callback of CPU_STARTING event can't sleep and so acpi_cpu_sof=
t_notify()
> >> return directly when CPU_STARTING event is triggered. But cpu hotp=
lug also
> >> happens during S2RAM. The action will become CPU_STARTING_FROZEN. =
This
> >> patch is to fix missing check the frozen event.

OK

What's the impact of the bug you're fixing?  Do we sleep when we should=
n't?

In particular, are there any bugs reported that are related to it?

> >> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> >=20
> > There is work to restructure the handling of CPU_TASKS_FROZEN under=
 way
> > and Chen Gong is driving it.  That's likely to conflict with the la=
st
> > two patches from you.  Can you please coordinate with Gong?
>=20
> Hi Rafael:
>=20
> Thanks for reminder. I just checked Chen Gong's patchset "Gloabl CPU
> Hot-plug flag _FROZEN Clean up". There is no conflict between our
> patches. Gong's patch is to remove the following macro.
>=20
> CPU_ONLINE_FROZEN
> CPU_UP_PREPARE_FROZEN
> CPU_UP_CANCELED_FROZEN
> CPU_DOWN_PREPARE_FROZEN
> CPU_DOWN_FAILED_FROZEN
> CPU_DEAD_FROZEN
> CPU_DYING_FROZEN
> CPU_STARTING_FROZEN
>=20
> CPU_TASKS_FROZEN is still available and the CPU events during S2RAM
> are still (CPU_xxx | CPU_TASKS_FROZEN).

OK

> BTW, this is a bug fix from my opinion and it should be backported to
> stable tree.

We'll see.


> >> ---
> >>  drivers/acpi/processor_driver.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/proces=
sor_driver.c
> >> index 4fcbd67..66e2249 100644
> >> --- a/drivers/acpi/processor_driver.c
> >> +++ b/drivers/acpi/processor_driver.c
> >> @@ -125,7 +125,7 @@ static int acpi_cpu_soft_notify(struct notifie=
r_block *nfb,
> >>  	 * CPU_STARTING and CPU_DYING must not sleep. Return here since
> >>  	 * acpi_bus_get_device() may sleep.
> >>  	 */
> >> -	if (action =3D=3D CPU_STARTING || action =3D=3D CPU_DYING)
> >> +	if ((action & ~CPU_TASKS_FROZEN) =3D=3D CPU_STARTING || action =3D=
=3D CPU_DYING)
> >>  		return NOTIFY_DONE;
> >> =20
> >>  	if (!pr || acpi_bus_get_device(pr->handle, &device))
> >>
> >=20
>=20
>=20
>=20

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
