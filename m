From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 17:06:16 +0200
Message-ID: <200906111706.16848.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0906111041020.3040-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:56941 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762060AbZFKPF2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2009 11:05:28 -0400
In-Reply-To: <Pine.LNX.4.44L0.0906111041020.3040-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Am Donnerstag, 11. Juni 2009 16:52:03 schrieb Alan Stern:
> > Under this definition all devices behind an inactive link are suspe=
nded,
> > because they can't do any I/O. =A0Which appears to makes sense, bec=
ause
> > their drivers have to be notified before the link is suspended and =
the
> > link has to be turned on for the devices to be able to communicate =
with
> > the CPU and RAM.
> >
> > If this definition is adopted, then it's quite clear that the devic=
e can
> > only be suspended if all of its children are suspended and it's alw=
ays
> > necessary to resume the parent of a device in order to resume the d=
evice
> > itself.
>
> Okay, I'll agree to that. =A0It should be made clear that a device wh=
ich
> is "suspended" according to this definition is not necessarily in a
> low-power state. =A0For example, before powering down the link to a d=
isk
> drive you might want the drive's suspend method to flush the drive's
> cache, but it wouldn't have to spin the drive down.

This precludes handling busses that have low power states that are
left automatically. If such links are stacked the management of accepta=
ble
latencies cannot be left to the busses.
An actual example are the link states of USB 3.0

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
