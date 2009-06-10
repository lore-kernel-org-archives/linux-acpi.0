From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Wed, 10 Jun 2009 23:38:34 +0200
Message-ID: <200906102338.35183.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0906082233490.19072-100000@netrider.rowland.org> <200906101620.26559.oliver@neukum.org> <200906102127.57136.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:50812 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757559AbZFJVhs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2009 17:37:48 -0400
In-Reply-To: <200906102127.57136.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Am Mittwoch, 10. Juni 2009 21:27:56 schrieb Rafael J. Wysocki:
> > What happens if the parent's parent is also suspended? It seems to =
me
> > that you must code this recursively.
>
> Hmm, I thought I did.
>
> [Looks]
>
> pm_request_resume(dev) will call pm_request_resume(dev->parent), if
> necessary, and that will call pm_request_resume(dev->parent->parent) =
and so
> on. =A0Each of them will queue a work item and the one for the topmos=
t parent
> will be queued first. =A0So, the resume requests for all parents will=
 be
> executed before the one for the device, due to the fact that the work=
queue
> is singlethread.

Sneaky, I overlooked that.

> Well, there is a bug related to it, namely pm_autosuspend() may chang=
e the
> status to RPM_SUSPENDED after pm_request_resume() has changed it to
> RPM_WAKE, that needs fixing.

Ok, maybe this is related. You recurse if the parent isn't in RPM_ACTIV=
E.
But that is not enough. You must ensure that all the nodes higher up st=
ay
in RPM_ACTIVE. It seems to me that you must go up until you find an
active node (or the root) and put it a blocked state.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
