From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/Processor: Add CPU_STARTING_FROZEN check in the acpi_cpu_soft_notify()
Date: Wed, 06 Aug 2014 21:11:59 +0200
Message-ID: <1764446.983W79QKlC@vostro.rjw.lan>
References: <1406798426-16483-1-git-send-email-tianyu.lan@intel.com> <2440957.I2MrVyXYIg@vostro.rjw.lan> <53E19AAD.4070308@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49162 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752989AbaHFSxS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Aug 2014 14:53:18 -0400
In-Reply-To: <53E19AAD.4070308@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>

On Wednesday, August 06, 2014 11:02:05 AM Lan Tianyu wrote:
> On 2014=E5=B9=B408=E6=9C=8806=E6=97=A5 09:30, Rafael J. Wysocki wrote=
:
> > On Friday, August 01, 2014 10:51:46 AM Lan Tianyu wrote:
> >> On 2014=E5=B9=B408=E6=9C=8801=E6=97=A5 05:20, Rafael J. Wysocki wr=
ote:
> >>> On Thursday, July 31, 2014 05:20:26 PM Lan Tianyu wrote:
> >>>> The callback of CPU_STARTING event can't sleep and so acpi_cpu_s=
oft_notify()
> >>>> return directly when CPU_STARTING event is triggered. But cpu ho=
tplug also
> >>>> happens during S2RAM. The action will become CPU_STARTING_FROZEN=
=2E This
> >>>> patch is to fix missing check the frozen event.
> >=20
> > OK
> >=20
> > What's the impact of the bug you're fixing?  Do we sleep when we sh=
ouldn't?
> >=20
> > In particular, are there any bugs reported that are related to it?
>=20
> So far, there is such bug report. I found the issue when test my patc=
h
> of parallel non-boot cpu up with resuming device for S2RAM. Because
> original code will wait all cpu up and then do other resume task, the
> semaphore of ACPICA can always be get in the cpu notify callback and =
it
> will not fall in the sleep. It's different situation for paralleling
> non-boot cpu. The lock will be held by other threads and fall into
> sleep. Further thinking, this may not cause bug in the old kernel and=
 it
> isn't needed by stable tree but the code should consider cpu frozen e=
vent.

OK, so we don't need to propagate this to -stable I'd say.

I'll queue it up for the second 3.17 pull request.

Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
