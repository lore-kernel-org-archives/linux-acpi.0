From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re:
 [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Sat, 13 Jun 2009 14:08:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906131404160.25619-100000@netrider.rowland.org>
References: <200906130106.58464.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:45598 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754434AbZFMSIH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2009 14:08:07 -0400
In-Reply-To: <200906130106.58464.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oliver@neukum.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sat, 13 Jun 2009, Rafael J. Wysocki wrote:

> So, the conclusion seems to be that we should break the recurrence
> at the point we find an already active device or a device with no parent and
> let the driver(s) handle the more complicated cases.  Is this correct?

That's right.

> BTW, is __device_release_driver() the right place for blocking the run-time PM
> temporarily during remove?

It is.  And for submitting a delayed autosuspend request afterward; we
may as well try to suspend devices that don't have drivers.

Alan Stern

