From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Shutdown on thermal HOT event if no userspace tool
 registered being able to do S4
Date: Thu, 01 Apr 2010 15:40:26 +0200
Message-ID: <1270129226.1767.12.camel@yio.site>
References: <4BB537F10200002300015C07@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:58335 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab0DANjA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Apr 2010 09:39:00 -0400
Received: by fxm27 with SMTP id 27so521459fxm.28
        for <linux-acpi@vger.kernel.org>; Thu, 01 Apr 2010 06:38:58 -0700 (PDT)
In-Reply-To: <4BB537F10200002300015C07@novprvlin0050.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: trenn@suse.de, rui.zhang@intel.com, hmacht@suse.de, rwysocki@suse.de, linux-acpi@vger.kernel.org

On Thu, 2010-04-01 at 07:18 -0600, Joey Lee wrote:
> =E6=96=BC =E4=BA=8C=EF=BC=8C2010-03-30 =E6=96=BC 17:31 +0100=EF=BC=8C=
Thomas Renninger =E6=8F=90=E5=88=B0=EF=BC=9A
> > On Tuesday 30 March 2010 18:12:40 Joey Lee wrote:
> > > =E6=96=BC =E4=BA=8C=EF=BC=8C2010-03-30 =E6=96=BC 10:23 +0100=EF=BC=
=8CThomas Renninger =E6=8F=90=E5=88=B0=EF=BC=9A
> > > > What userspace tools are candidates to implement this if this
> > > > makes sense?
> > >=20
> > > HAL + pm-util or DeviceKit-power might the candidates. But, if th=
ere
> > > have no those component in userland, what will acpi thermal modul=
e do?
> > > Direct shutdown?
> > > And, how can kernel space know userland can do this job well? Mig=
ht wait
> > > 10 seconds if system doesn't S4 or shutdown?
> > Yep, my idea is to e.g. provide:
> > /sys/class/thermal/S4_capable
> > By default you get:
> > cat /sys/class/thermal/S4_capable
> > 0
> > and the thermal driver will call the same shutdown method
> > if the hot thermal tp is reached as if the critical is reached.
> >=20
> > If pm-utils does:
> > echo 1 >/sys/class/thermal/S4_capable
> > it has to make sure it picks up acpi thermal hot event and initiate=
s
> > S4. If S4 fails for whatever reasons (no swap,
> > stroking some kernel drivers fails, unmounting file systems fails, =
=2E..),
> > it has to make sure to force a system shutdown (just call /sbin/pow=
eroff
> > the same way the kernel does currently with a critical thermal even=
t?).
> > Emergency shutdown is then out of kernels hand (as it is currently =
for HOT
> > anyway which is dangerous).

What would be the event source? pm-utils is not a process, it can't pic=
k
stuff up, I EXPECT, unless the kernel would fork a certain binary.

> > Hmm, this is acpi specific, possibly it should be a new dir here:
> > /sys/firmware/acpi/thermal/S4_capable
> > or something else?
> >=20
>=20
> Your idea looks good to me, but, the DeviceKit-power will rename to
> upower,

Yes, it did already a while ago.

> We are discussing about how to handle the situtation if BIOS ACPI did=
n't
> return the _CRT value, and even have _HOT value, if S4 fail, what can=
 we
> do on kernel space and userland.
>=20
> _CRT value is the shutdown critical temperature
> _HOT value is the critical temperature for sleep (entry to S4)
>=20
> Per ACPI spec:
> The platform vendor should define _HOT to be far enough below _CRT so=
 as
> to allow OSPM enough time to transition the system into the S4 sleepi=
ng
> state.
>=20
> Currently, there have a bit platform provider (OEM/ODM) only return t=
he
> _HOT, but didn't have _CRT value. But, if _HOT S4 fail, the system
> components might dangerous if there have no any hardware protected
> Mechanism.
>=20
> Thomas's idea is add a sysfs interface /sys/class/thermal/S4_capable =
for
> userland to tell kernel userland component (pm-util or upower?) alrea=
dy
> take the _HOT event and try to do S4.
>=20
> How do you think about this idea?

I'm not so sure, this sounds a bit like an ad-hoc interface for a prett=
y
specific problem. I would expect, it needs more integration than a
global sysfs flag that keeps its state even when no userland process is
taking care anymore.

The details should probably be discussed on a mailing list like
devkit-devel@lists.freedesktop.org and the people working on the
userspace integration side should comment on it.

Cheers,
Kay

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
