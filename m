From: Len Brown <lenb@kernel.org>
Subject: Re: 100% C0 with 2.6.25-rc
Date: Wed, 26 Mar 2008 00:58:41 -0400
Message-ID: <200803260058.41503.lenb@kernel.org>
References: <47BD600F.9090502@willies.info> <B5B0CFF685D7DF46A05CF1678CFB42ED20E00658@orsmsx423.amr.corp.intel.com> <20080229182432.GA28660@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34066 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbYCZE7b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 00:59:31 -0400
In-Reply-To: <20080229182432.GA28660@linux-os.sc.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Jan Willies <jan@willies.info>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

applied.

thanks,
-len

On Friday 29 February 2008, Venki Pallipadi wrote:
> On Fri, Feb 22, 2008 at 09:03:55AM -0800, Pallipadi, Venkatesh wrote:
> > =20
> >=20
> > >-----Original Message-----
> > >From: Jan Willies [mailto:jan@willies.info]=20
> > >Sent: Friday, February 22, 2008 7:56 AM
> > >To: Rafael J. Wysocki
> > >Cc: linux-acpi@vger.kernel.org; Ingo Molnar; LKML; Thomas=20
> > >Gleixner; Pallipadi, Venkatesh
> > >Subject: Re: 100% C0 with 2.6.25-rc
> > >
> > >Rafael J. Wysocki wrote:
> > >> On Thursday, 21 of February 2008, Jan Willies wrote:
> > >>> Since 2.6.25-rc1 I have a lot of wakeups/s (=E2=89=88134191,4) =
and=20
> > >spend 100% in C0.
> > >>> It worked fine with 2.6.24 and commandline nolapic. Without=20
> > >nolapic I had 80k
> > >>> wakeups/s after some time, but not right from the start like no=
w. =20
> > >>=20
> > >> We have a regression from 2.6.24, apparently interrupts-related.
> > >
> > >After a lot of bisecting I've found the bad commit:=20
> > >
> > >9b12e18cdc1553de62d931e73443c806347cd974 is first bad commit
> > >commit 9b12e18cdc1553de62d931e73443c806347cd974
> > >Author: venkatesh.pallipadi@intel.com <venkatesh.pallipadi@intel.c=
om>
> > >Date:   Thu Jan 31 17:35:05 2008 -0800
> > >
> > >    ACPI: cpuidle: Support C1 idle time accounting
> > >   =20
> > >    Show C1 idle time in /sysfs cpuidle interface. C1 idle time ma=
y not
> > >    be entirely accurate in all cases. It includes the time spent
> > >    in the interrupt handler after wakeup with "hlt" based C1.=20
> > >But, it will
> > >    be accurate with "mwait" based C1.
> > >
> > >
> > >Reverting the commit brings my laptop back to C2.
> > >
> >=20
> > Thanks for the bisect info. I will look at the bad side effects tha=
t patch
> > may be having and I should have a patch for you to test later today=
=2E...
> >=20
>=20
> Jan replied later on this issue that he is not able to reproduce this=
 problem
> any more. Looking at the above, I could see a potential problem where
> menu governor may get confused by the C-state residency time from pol=
l
> idle or C1 idle, where this timing info is not accurate. This inaccur=
acy is
> due to interrupts being handled before we account for C-state exit.
>=20
> Patch below fixes this and is needed regardless of the issue pointed =
out by
> Jan Willies here. But, I am suspecting that the patch will also fix t=
he
> problem reported by Jan.
>=20
> Do not mark TIME_VALID for CO poll state.
> Mark C1 time as valid only with mwait (CSTATE_FFH) entry method.
>=20
> This makes governors use the timing information only when it is corre=
ct and
> eliminates any wrong policy decisions that may result from invalid ti=
ming
> information.
>=20
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
>=20
> Index: linux-2.6.git/drivers/acpi/processor_idle.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.git.orig/drivers/acpi/processor_idle.c	2008-02-15 02:18=
:14.000000000 -0800
> +++ linux-2.6.git/drivers/acpi/processor_idle.c	2008-02-26 07:02:30.0=
00000000 -0800
> @@ -1686,7 +1686,9 @@
>  		switch (cx->type) {
>  			case ACPI_STATE_C1:
>  			state->flags |=3D CPUIDLE_FLAG_SHALLOW;
> -			state->flags |=3D CPUIDLE_FLAG_TIME_VALID;
> +			if (cx->entry_method =3D=3D ACPI_CSTATE_FFH)
> +				state->flags |=3D CPUIDLE_FLAG_TIME_VALID;
> +
>  			state->enter =3D acpi_idle_enter_c1;
>  			dev->safe_state =3D state;
>  			break;
> Index: linux-2.6.git/drivers/cpuidle/cpuidle.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.git.orig/drivers/cpuidle/cpuidle.c	2008-02-15 02:18:14.=
000000000 -0800
> +++ linux-2.6.git/drivers/cpuidle/cpuidle.c	2008-02-22 03:59:01.00000=
0000 -0800
> @@ -224,7 +224,7 @@
>  	state->exit_latency =3D 0;
>  	state->target_residency =3D 0;
>  	state->power_usage =3D -1;
> -	state->flags =3D CPUIDLE_FLAG_POLL | CPUIDLE_FLAG_TIME_VALID;
> +	state->flags =3D CPUIDLE_FLAG_POLL;
>  	state->enter =3D poll_idle;
>  }
>  #else
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
