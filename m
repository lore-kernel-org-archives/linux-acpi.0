From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-pm] Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Tue, 9 Jun 2009 09:31:37 +0200
Message-ID: <200906090931.37626.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0906081626120.13888-100000@netrider.rowland.org> <200906082331.58933.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:43494 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbZFIHat convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jun 2009 03:30:49 -0400
In-Reply-To: <200906082331.58933.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Am Montag, 8. Juni 2009 23:31:58 schrieb Rafael J. Wysocki:
> If ->autosuspend() fails, the device power state may be known, but th=
e core
> can't be sure if the device is active. =A0This information is availab=
le to
> the driver and/or the bus type, which should change the status to wha=
tever
> is appropriate.

That is quite confusing. You'd better define error returns.
One that would mean that the suspension has failed but the device is
unaffected, and another one that means that the device is in an
undefined state now.

> > The scheme doesn't include any mechanism for communicating runtime
> > power information up the device tree. =A0When a device is autosuspe=
nded,
> > its parent's driver should be told so that the driver can consider
> > autosuspending the parent.
>
> I thought the bus type's ->autosuspend() callback could take care of =
this.

That can't work because you have to operate between busses.

> > Likewise, if we want to autoresume a device below an autosuspended
> > parent, the parent should be autoresumed first. =A0Did you want to =
make the
> > bus subsystem responsible for all of this?
>
> Yes, that was the idea.

That is an important point. Can some subsytems operate with a parent st=
ill
suspended?

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
