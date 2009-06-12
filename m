From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re:
 [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Fri, 12 Jun 2009 15:48:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906121547490.2862-100000@iolanthe.rowland.org>
References: <200906122109.35589.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36096 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1761966AbZFLTsb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jun 2009 15:48:31 -0400
In-Reply-To: <200906122109.35589.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oliver@neukum.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, 12 Jun 2009, Rafael J. Wysocki wrote:

> So, are you suggesting that the core should only check the "all children
> suspended" condition if special flag is set in dev_pm_info?

Or rather, check it only if the special flag _isn't_ set.

Alan Stern

