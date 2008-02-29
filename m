From: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: 100% C0 with 2.6.25-rc
Date: Fri, 29 Feb 2008 10:24:32 -0800
Message-ID: <20080229182432.GA28660@linux-os.sc.intel.com>
References: <47BD600F.9090502@willies.info> <200802211733.54759.rjw@sisk.pl> <47BEF0A6.9000405@willies.info> <B5B0CFF685D7DF46A05CF1678CFB42ED20E00658@orsmsx423.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:63306 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756890AbYB2ScF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Feb 2008 13:32:05 -0500
Content-Disposition: inline
In-Reply-To: <B5B0CFF685D7DF46A05CF1678CFB42ED20E00658@orsmsx423.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jan Willies <jan@willies.info>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Feb 22, 2008 at 09:03:55AM -0800, Pallipadi, Venkatesh wrote:
> =20
>=20
> >-----Original Message-----
> >From: Jan Willies [mailto:jan@willies.info]=20
> >Sent: Friday, February 22, 2008 7:56 AM
> >To: Rafael J. Wysocki
> >Cc: linux-acpi@vger.kernel.org; Ingo Molnar; LKML; Thomas=20
> >Gleixner; Pallipadi, Venkatesh
> >Subject: Re: 100% C0 with 2.6.25-rc
> >
> >Rafael J. Wysocki wrote:
> >> On Thursday, 21 of February 2008, Jan Willies wrote:
> >>> Since 2.6.25-rc1 I have a lot of wakeups/s (=E2=89=88134191,4) an=
d=20
> >spend 100% in C0.
> >>> It worked fine with 2.6.24 and commandline nolapic. Without=20
> >nolapic I had 80k
> >>> wakeups/s after some time, but not right from the start like now.=
 =20
> >>=20
> >> We have a regression from 2.6.24, apparently interrupts-related.
> >
> >After a lot of bisecting I've found the bad commit:=20
> >
> >9b12e18cdc1553de62d931e73443c806347cd974 is first bad commit
> >commit 9b12e18cdc1553de62d931e73443c806347cd974
> >Author: venkatesh.pallipadi@intel.com <venkatesh.pallipadi@intel.com=
>
> >Date:   Thu Jan 31 17:35:05 2008 -0800
> >
> >    ACPI: cpuidle: Support C1 idle time accounting
> >   =20
> >    Show C1 idle time in /sysfs cpuidle interface. C1 idle time may =
not
> >    be entirely accurate in all cases. It includes the time spent
> >    in the interrupt handler after wakeup with "hlt" based C1.=20
> >But, it will
> >    be accurate with "mwait" based C1.
> >
> >
> >Reverting the commit brings my laptop back to C2.
> >
>=20
> Thanks for the bisect info. I will look at the bad side effects that =
patch
> may be having and I should have a patch for you to test later today..=
=2E.
>=20

Jan replied later on this issue that he is not able to reproduce this p=
roblem
any more. Looking at the above, I could see a potential problem where
menu governor may get confused by the C-state residency time from poll
idle or C1 idle, where this timing info is not accurate. This inaccurac=
y is
due to interrupts being handled before we account for C-state exit.

Patch below fixes this and is needed regardless of the issue pointed ou=
t by
Jan Willies here. But, I am suspecting that the patch will also fix the
problem reported by Jan.

Do not mark TIME_VALID for CO poll state.
Mark C1 time as valid only with mwait (CSTATE_FFH) entry method.

This makes governors use the timing information only when it is correct=
 and
eliminates any wrong policy decisions that may result from invalid timi=
ng
information.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.git/drivers/acpi/processor_idle.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.git.orig/drivers/acpi/processor_idle.c	2008-02-15 02:18:1=
4.000000000 -0800
+++ linux-2.6.git/drivers/acpi/processor_idle.c	2008-02-26 07:02:30.000=
000000 -0800
@@ -1686,7 +1686,9 @@
 		switch (cx->type) {
 			case ACPI_STATE_C1:
 			state->flags |=3D CPUIDLE_FLAG_SHALLOW;
-			state->flags |=3D CPUIDLE_FLAG_TIME_VALID;
+			if (cx->entry_method =3D=3D ACPI_CSTATE_FFH)
+				state->flags |=3D CPUIDLE_FLAG_TIME_VALID;
+
 			state->enter =3D acpi_idle_enter_c1;
 			dev->safe_state =3D state;
 			break;
Index: linux-2.6.git/drivers/cpuidle/cpuidle.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.git.orig/drivers/cpuidle/cpuidle.c	2008-02-15 02:18:14.00=
0000000 -0800
+++ linux-2.6.git/drivers/cpuidle/cpuidle.c	2008-02-22 03:59:01.0000000=
00 -0800
@@ -224,7 +224,7 @@
 	state->exit_latency =3D 0;
 	state->target_residency =3D 0;
 	state->power_usage =3D -1;
-	state->flags =3D CPUIDLE_FLAG_POLL | CPUIDLE_FLAG_TIME_VALID;
+	state->flags =3D CPUIDLE_FLAG_POLL;
 	state->enter =3D poll_idle;
 }
 #else
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
