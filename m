From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 23:05:48 +0200
Message-ID: <200906112305.49232.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0906111433110.4875-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:54925 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbZFKVFA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2009 17:05:00 -0400
In-Reply-To: <Pine.LNX.4.44L0.0906111433110.4875-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Am Donnerstag, 11. Juni 2009 20:36:30 schrieb Alan Stern:
> > Or abstractly any power saving state that does autoresume in hardwa=
re.
> > In these cases you know that you can enter a powersaving state that
> > will add X latency.
> >
> > In terms of user space API we'll probably add a way for user space
> > to specify how much latency may be added for power management's sak=
e.
> > If busses are stacked the "latency budget" has to be handled at cor=
e
> > level. If furthermore states that allow IO but with additional late=
ncy
> > are ignored, the budget will be calculated wrongly.
>
> Okay, fine. =A0What does this have to do with Rafael's work? =A0Why d=
oes
> setting the status to RPM_SUSPENDED even when a device is not in a
> low-power state preclude handling buses that automatically change the=
ir
> power state?

=46or these cases the tree constraint does not apply.
I think there are devices who can be suspended while children are activ=
e
and devices which can not be. This is an attribute of the device and sh=
ould
be evaluated by the core.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
