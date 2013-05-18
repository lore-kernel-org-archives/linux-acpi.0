From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: REGRESSION: 3.10-rc1: Dell Latitude e6410 hangs within 3 seconds
Date: Sat, 18 May 2013 16:06:51 -0700
Message-ID: <20130518230651.GC4006@linux.vnet.ibm.com>
References: <5192363E.7040204@broadcom.com>
 <1396357.SFbZsj3Bmy@vostro.rjw.lan>
 <5192A0DE.90209@broadcom.com>
 <519697CC.1070308@broadcom.com>
 <20130518014724.GA4006@linux.vnet.ibm.com>
 <51972A51.40106@broadcom.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:34671 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab3ERXG5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 May 2013 19:06:57 -0400
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Sat, 18 May 2013 17:06:56 -0600
Content-Disposition: inline
In-Reply-To: <51972A51.40106@broadcom.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Paul E. McKenney" <paul.mckenney@linaro.org>

On Sat, May 18, 2013 at 09:14:25AM +0200, Arend van Spriel wrote:
> On 05/18/13 03:47, Paul E. McKenney wrote:
> >On Fri, May 17, 2013 at 10:49:16PM +0200, Arend van Spriel wrote:
> >>On 05/14/2013 10:38 PM, Arend van Spriel wrote:
> >>>On 05/14/2013 10:34 PM, Rafael J. Wysocki wrote:
> >>>>On Tuesday, May 14, 2013 03:03:58 PM Arend van Spriel wrote:
> >>>>>Laptop hangs pretty soon after booting. Workaround for me was to=
 turn
> >>>>>off ACPI on kernel command line, ie. acpi=3Doff
> >>>>>
> >>>>>Attached is my kernel configuration.
> >>>>
> >>>>Well, I have no idea what may be the source of this.
> >>>
> >>>Me neither.
> >>>
> >>>>Any chance to bisect?
> >>>
> >>>can try. Rebuilding kernels can be a drag :-p
> >>>
> >>>Regards,
> >>>Arend
> >>
> >>Hi Rafael,
> >>
> >>The bisect result found commit c0f4dfd4f as culprit. I also verifie=
d
> >>that the merge into Linus' tree introduced the issue upstream, ie.
> >>6c24499 works and 1f889ec does not. I tried to revert the commit,
> >>but that was a bit risky (conflict to resolve) and did not give me =
a
> >>stable kernel. The only thing that works is selecting acpi=3Doff. I
> >>tried also nohz=3Doff but that resulted in /init failure.
> >>
> >>Regards,
> >>Arend
> >>
> >>---8<--------------------------------------------------------------=
--
> >>
> >>commit 1f889ec62c3f0d8913f3c32f9aff2a1e15099346
> >>   Merge: 6c24499 8fcfae3
> >>
> >>   commit 8fcfae31719c0a6c03f2cf63f815b46d378d8be4
> >>     Merge: d02a9a8 6d87669
> >>
> >>     commit 6d87669357936bffa1e8fea7a4e7743e76905736
> >>       Merge: 3f944ad 81e5949 910ee45
> >>
> >>       commit c0f4dfd4f90f1667d234d21f15153ea09a2eaa66
> >>       Author: Paul E. McKenney<paul.mckenney@linaro.org>
> >>       Date:   Fri Dec 28 11:30:36 2012 -0800
> >>
> >>           rcu: Make RCU_FAST_NO_HZ take advantage of numbered call=
backs
> >>
> >>           Because RCU callbacks are now associated with the number
> >>           of the grace period that they must wait for, CPUs can no=
w
> >>           take advance callbacks corresponding to grace periods th=
at
> >>           ended while a given CPU was in dyntick-idle mode. This
> >>           eliminates the need to try forcing the RCU state machine
> >>           while entering idle, thus reducing the CPU intensiveness
> >>           of RCU_FAST_NO_HZ, which should increase its energy
> >>           efficiency.
> >>
> >>       Signed-off-by: Paul E. McKenney<paul.mckenney@linaro.org>
> >>       Signed-off-by: Paul E. McKenney<paulmck@linux.vnet.ibm.com>
> >
> >Hello, Arend,
> >
> >Thank you for tracking this down!  Could you please try out the foll=
owing
> >patch?
>=20
> Thanks, Paul
>=20
> That did the trick. Made me bumping into another regression in the
> driver I am maintaining so more fun to do :-)
>=20
> Looking at the commit message I guess it is already in some tree.
> Otherwise I would have said: "You may add
>=20
> Tested-by: Arend van Spriel <arend@broadcom.com>"

Thank you for trying it out, and glad that it worked for you!

And I did already send the pull request.  But if I need to re-send it,
I will update to add your Tested-by.

							Thanx, Paul

> >--------------------------------------------------------------------=
----
> >
> >rcu: Fix comparison sense in rcu_needs_cpu()
> >
> >Commit c0f4dfd4f (rcu: Make RCU_FAST_NO_HZ take advantage of numbere=
d
> >callbacks) introduced a bug that can result in excessively long grac=
e
> >periods.  This bug reverse the senes of the "if" statement checking
>=20
> Oh, there is a typo in the commit message: sense iso senes.
>=20
> >for lazy callbacks, so that RCU takes a lazy approach when there are
> >in fact non-lazy callbacks.  This can result in excessive boot, susp=
end,
> >and resume times.
> >
> >This commit therefore fixes the sense of this "if" statement.
> >
> >Reported-by: Borislav Petkov<bp@alien8.de>
> >Reported-by: Bj=F8rn Mork<bjorn@mork.no>
> >Reported-by: Joerg Roedel<joro@8bytes.org>
> >Signed-off-by: Paul E. McKenney<paulmck@linux.vnet.ibm.com>
> >Tested-by: Bj=F8rn Mork<bjorn@mork.no>
> >Tested-by: Joerg Roedel<joro@8bytes.org>
>=20
> Gr. AvS
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
