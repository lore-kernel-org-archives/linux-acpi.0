From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Run-time PM idea (was: Re: [linux-pm] [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Mon, 8 Jun 2009 15:39:19 +0200
Message-ID: <200906081539.20459.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org> <20090608131159.GA15100@srcf.ucam.org> <20090608132235.GC13214@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:36501 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545AbZFHNif (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jun 2009 09:38:35 -0400
In-Reply-To: <20090608132235.GC13214@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

Am Montag, 8. Juni 2009 15:22:35 schrieb Ingo Molnar:

> What will the 'user space policy' bit do what the kernel cannot?
>
> If you mean the user has to configure something manually - that wont
> really happen in practice. We are happy if they know where to put
> those USB sticks in ;-)

User space need not be the user. Currently user space doesn't tell
the kernel how much functionality it needs. open/close give a binary
opposition which badly maps onto the graduated capabilities devices
have.

For example do you really need every key pressed while the screen saver
is running or is it enough for the keyboard to be able to generate a wakeup
event?

	Regards
		Oliver

