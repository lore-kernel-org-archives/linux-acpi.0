From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-pm] [patch update 2 fix] PM: Introduce core framework for run-time PM of I/O devices
Date: Mon, 22 Jun 2009 10:15:41 +0200
Message-ID: <200906221015.42805.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0906192141380.4003-100000@netrider.rowland.org> <Pine.LNX.4.44L0.0906201010590.12994-100000@netrider.rowland.org> <aec7e5c30906212320v3e3e991fyd028d005675f1e25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:37398 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbZFVIPk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2009 04:15:40 -0400
In-Reply-To: <aec7e5c30906212320v3e3e991fyd028d005675f1e25@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

Am Montag, 22. Juni 2009 08:20:43 schrieb Magnus Damm:
> I'd like to call pm_request_suspend() from interrupt context. I don't
> depend on it, but being able to perform runtime suspend directly from
> the ISR would be convenient from a device driver POV. I'm not sure if
> that should result in bus/device ->runtime_suspend() calls from
> interrupt context though.
>
> In my case the bus specific code for ->runtime_suspend() may just
> decrease the usage count of the powerdomain but refrain from calling
> the device ->runtime_suspend() callbacks until all devices in the
> powerdomain have been suspended. The bus/device runtime suspend
> callbacks do not need to be executed from interrupt context. Just
> noting that the device is idle is enough at interrupt time. This could
> be handled by generic code IMO.

>From practical experience doing USB power management I can tell
you that requesting suspension from interrupt makes things a lot
easier for driver writers.

	Regards
		Oliver

