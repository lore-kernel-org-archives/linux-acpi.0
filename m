From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Asynchronous suspend/resume - test results
Date: Mon, 21 Dec 2009 15:54:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912211551580.2643-100000@iolanthe.rowland.org>
References: <200912212136.12665.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56023 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757152AbZLUUyh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2009 15:54:37 -0500
In-Reply-To: <200912212136.12665.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, 21 Dec 2009, Rafael J. Wysocki wrote:

> Do you think it's a good idea to mark all SCSI devices as async?  Well, for
> testing it probably is, but I doubt in general.

That would be a good question to post on Linux-SCSI.

In most respects it's probably okay.  But some people with large disk
farms might not like it if their drives should suddenly start to spin
up (with a correspondingly large power draw) all at the same time.

Alan Stern

