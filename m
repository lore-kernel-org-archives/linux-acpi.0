From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: 2.6.22 regression: thermal trip points
Date: Fri, 03 Aug 2007 14:53:53 +0200
Message-ID: <46B32561.5070703@t-online.de>
References: <46B1988C.3090302@t-online.de> <200708021756.30776.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762022AbXHCMyW@vger.kernel.org>
In-Reply-To: <200708021756.30776.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, trenn@suse.de, pavel@ucw.cz, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Len Brown :
> =20
>
> Thanks for the sighting, Knut!
> This regression is dramatic when put in the terms of 50% performance =
hit!
> I guess the good news is that thermal throttling is doing the job
> we are asking it to:-)
>
>
>  =20
Thermal management by cpufreq is working really fine ;-)

My problems are definitely not related to a linux bug. All trip_points
are fixed, hardcoded in the system BIOS at address 0x000FF810.

Yes, I could hack  and flash a custom BIOS.

After reading a lot I think I even could fix the DSDT.

But all that would only be a solution for my system. The principal
question is, if that hook that allowed to override unreasonable
trip point definitions is too dangerous to be a part of the linux kerne=
l.

You and some others believed it should not be part of the kernel,
and so it was eliminated a while ago. Some people want it back,
either because
- they need it desperately to allow their machines healthy operation,
- they need it to restore performance of their machines, or
- they want a really quiet system.

Root should be allowed to smoke his system - ask him if he really
wants to do so, ask him to echo "Yes, it=B4s me who is guilty" to
some file prior to allow trip point changes, but do not eliminate
hooks useful for the management of buggy machines from our
kernel.

We do need writable trip points again. And, Thomas, some people
also need to raise the defaults.

cu,
 Knut
