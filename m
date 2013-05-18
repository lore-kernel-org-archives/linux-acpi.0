From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: REGRESSION: 3.10-rc1: Dell Latitude e6410 hangs within 3 seconds
Date: Fri, 17 May 2013 18:47:25 -0700
Message-ID: <20130518014724.GA4006@linux.vnet.ibm.com>
References: <5192363E.7040204@broadcom.com>
 <1396357.SFbZsj3Bmy@vostro.rjw.lan>
 <5192A0DE.90209@broadcom.com>
 <519697CC.1070308@broadcom.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:37553 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab3ERBr3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 May 2013 21:47:29 -0400
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 17 May 2013 19:47:29 -0600
Content-Disposition: inline
In-Reply-To: <519697CC.1070308@broadcom.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Paul E. McKenney" <paul.mckenney@linaro.org>

On Fri, May 17, 2013 at 10:49:16PM +0200, Arend van Spriel wrote:
> On 05/14/2013 10:38 PM, Arend van Spriel wrote:
> >On 05/14/2013 10:34 PM, Rafael J. Wysocki wrote:
> >>On Tuesday, May 14, 2013 03:03:58 PM Arend van Spriel wrote:
> >>>Laptop hangs pretty soon after booting. Workaround for me was to t=
urn
> >>>off ACPI on kernel command line, ie. acpi=3Doff
> >>>
> >>>Attached is my kernel configuration.
> >>
> >>Well, I have no idea what may be the source of this.
> >
> >Me neither.
> >
> >>Any chance to bisect?
> >
> >can try. Rebuilding kernels can be a drag :-p
> >
> >Regards,
> >Arend
>=20
> Hi Rafael,
>=20
> The bisect result found commit c0f4dfd4f as culprit. I also verified
> that the merge into Linus' tree introduced the issue upstream, ie.
> 6c24499 works and 1f889ec does not. I tried to revert the commit,
> but that was a bit risky (conflict to resolve) and did not give me a
> stable kernel. The only thing that works is selecting acpi=3Doff. I
> tried also nohz=3Doff but that resulted in /init failure.
>=20
> Regards,
> Arend
>=20
> ---8<----------------------------------------------------------------
>=20
> commit 1f889ec62c3f0d8913f3c32f9aff2a1e15099346
>   Merge: 6c24499 8fcfae3
>=20
>   commit 8fcfae31719c0a6c03f2cf63f815b46d378d8be4
>     Merge: d02a9a8 6d87669
>=20
>     commit 6d87669357936bffa1e8fea7a4e7743e76905736
>       Merge: 3f944ad 81e5949 910ee45
>=20
>       commit c0f4dfd4f90f1667d234d21f15153ea09a2eaa66
>       Author: Paul E. McKenney <paul.mckenney@linaro.org>
>       Date:   Fri Dec 28 11:30:36 2012 -0800
>=20
>           rcu: Make RCU_FAST_NO_HZ take advantage of numbered callbac=
ks
>=20
>           Because RCU callbacks are now associated with the number
>           of the grace period that they must wait for, CPUs can now
>           take advance callbacks corresponding to grace periods that
>           ended while a given CPU was in dyntick-idle mode. This
>           eliminates the need to try forcing the RCU state machine
>           while entering idle, thus reducing the CPU intensiveness
>           of RCU_FAST_NO_HZ, which should increase its energy
>           efficiency.
>=20
>       Signed-off-by: Paul E. McKenney <paul.mckenney@linaro.org>
>       Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Hello, Arend,

Thank you for tracking this down!  Could you please try out the followi=
ng
patch?

							Thanx, Paul

-----------------------------------------------------------------------=
-

rcu: Fix comparison sense in rcu_needs_cpu()

Commit c0f4dfd4f (rcu: Make RCU_FAST_NO_HZ take advantage of numbered
callbacks) introduced a bug that can result in excessively long grace
periods.  This bug reverse the senes of the "if" statement checking
for lazy callbacks, so that RCU takes a lazy approach when there are
in fact non-lazy callbacks.  This can result in excessive boot, suspend=
,
and resume times.

This commit therefore fixes the sense of this "if" statement.

Reported-by: Borislav Petkov <bp@alien8.de>
Reported-by: Bj=F8rn Mork <bjorn@mork.no>
Reported-by: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Tested-by: Bj=F8rn Mork <bjorn@mork.no>
Tested-by: Joerg Roedel <joro@8bytes.org>

diff --git a/kernel/rcutree_plugin.h b/kernel/rcutree_plugin.h
index 170814d..6d939a6 100644
--- a/kernel/rcutree_plugin.h
+++ b/kernel/rcutree_plugin.h
@@ -1667,7 +1667,7 @@ int rcu_needs_cpu(int cpu, unsigned long *dj)
 	rdtp->last_accelerate =3D jiffies;
=20
 	/* Request timer delay depending on laziness, and round. */
-	if (rdtp->all_lazy) {
+	if (!rdtp->all_lazy) {
 		*dj =3D round_up(rcu_idle_gp_delay + jiffies,
 			       rcu_idle_gp_delay) - jiffies;
 	} else {

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
