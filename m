From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [patch] swsusp2 should execute _WAK on resume
Date: Tue, 8 Mar 2005 09:52:17 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90ECAC424@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Kristoffer Sjoberg <kristoffer.sjoberg-lzmg0B5VUhvLoDKTGw+V6w@public.gmane.org>, Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>     ACPI-0405: *** Error: Handler for [EmbeddedControl] returned =
AE_TIME

The EC driver is timing out.


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Kristoffer Sjoberg
> Sent: Tuesday, March 08, 2005 8:35 AM
> To: Lorenzo Colitti; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] [patch] swsusp2 should execute _WAK on resume
>=20
> Hi,
>=20
> Just after resume, this following message is shown in my dmesg. I have
> the patch below applied. Does anyone know why a method would return
> AE_TIME?
>=20
>     ACPI-0405: *** Error: Handler for [EmbeddedControl] returned =
AE_TIME
>     ACPI-1138: *** Error: Method execution failed
> [\_SB_.C044.C057.C0E7.C12F] (Node c17efb80), AE_TIME
>     ACPI-1138: *** Error: Method execution failed [\_SB_.C12F] (Node
> c17f4500), AE_TIME
>     ACPI-1138: *** Error: Method execution failed [\_SB_.C137._BST] =
(Node
> c17f4440), AE_TIME
>=20
> Thanks,
>=20
> Krristoffer Sj=F6berg
> Netstar AB
>=20
> On m=E5n, 2005-03-07 at 15:41 +0100, Lorenzo Colitti wrote:
> > Hi,
> >
> > [CCing ACPI-devel in case someone wants to comment]
> >
> > Using swsusp2 2.1.8 on a vanilla 2.6.11 kernel (but I have been =
seeing
> > this since v2.1 on 2.6.9), my laptop (HP nc6000) doesn't generate =
any
> > ACPI thermal events after resume. This means the fans only come on
> > (screaming) if the CPU reaches 85 =B0C or so, which is not very =
healthy.
> >
> > This is due to the fact that unlike swsusp and S3, swsusp2 does not =
call
> > the ACPI _WAK method, which the ACPI spec says should be called when =
the
> > machine comes out of a sleep state. If I hack swsusp2 so that it =
calls
> > the _WAK method on resume, the fans work correctly after resume.
> >
> > I do this via the attached hack, but I don't know much about the
> > workings of swsusp2, so I don't know if it's the right approach. It =
does
> > work for me though, and even if the details of the patch aren't =
right,
> > based on my reading of the ACPI spec I think this should be done.
> >
> > Comments? Is it fit to apply to the swsusp2 tree?
> >
> >
> > Cheers,
> > Lorenzo
> >
> > P.S. I have been using swsusp2 since v2.1 for 2.6.9, and it works =
like a
> > charm. A big thank you to the people that made it possible. :)
> > plain text document attachment (patch-swsusp2-acpiwakeonresume.diff)
> > diff -u linux-2.6.11/kernel/power/suspend2_core/suspend.c =
linux-2.6.11-
> patched/kernel/power/suspend2_core/suspend.c
> > --- linux-2.6.11/kernel/power/suspend2_core/suspend.c	2005-03-07
> 15:17:31.000000000 +0100
> > +++ linux-2.6.11-patched/kernel/power/suspend2_core/suspend.c	=
2005-03-
> 07 15:18:47.000000000 +0100
> > @@ -404,6 +404,10 @@
> >   * Called From     : do_suspend2_lowlevel
> >   */
> >
> > +#ifdef CONFIG_ACPI
> > +extern u32 acpi_leave_sleep_state (u8 sleep_state);
> > +#endif
> > +
> >  static void do_suspend2_resume_2(void)
> >  {
> >  	set_suspend_state(SUSPEND_NOW_RESUMING);
> > @@ -433,6 +437,11 @@
> >  	suspend_checksum_print_differences();
> >
> >  	prepare_status(0, 0, "Cleaning up...");
> > +
> > +#ifdef CONFIG_ACPI
> > +	if (suspend_powerdown_method)
> > +		acpi_leave_sleep_state(suspend_powerdown_method);
> > +#endif
> >  }
> >
> >  /*


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
