From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 18:05:52 +0200
Message-ID: <200906111805.53388.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0906111120260.3040-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:48439 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbZFKQFD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2009 12:05:03 -0400
In-Reply-To: <Pine.LNX.4.44L0.0906111120260.3040-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Am Donnerstag, 11. Juni 2009 17:22:06 schrieb Alan Stern:
> > > Okay, I'll agree to that. =A0It should be made clear that a devic=
e which
> > > is "suspended" according to this definition is not necessarily in=
 a
> > > low-power state. =A0For example, before powering down the link to=
 a disk
> > > drive you might want the drive's suspend method to flush the driv=
e's
> > > cache, but it wouldn't have to spin the drive down.
> >
> > This precludes handling busses that have low power states that are
> > left automatically. If such links are stacked the management of
> > acceptable latencies cannot be left to the busses.
> > An actual example are the link states of USB 3.0
>
> I don't understand. =A0Can you explain more fully?

I am talking about the U1 and U2 feature of USB 3.0.

Or abstractly any power saving state that does autoresume in hardware.
In these cases you know that you can enter a powersaving state that
will add X latency.

In terms of user space API we'll probably add a way for user space
to specify how much latency may be added for power management's sake.
If busses are stacked the "latency budget" has to be handled at core le=
vel.
If furthermore states that allow IO but with additional latency are ign=
ored,
the budget will be calculated wrongly.

	Regards
		Oliver


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
