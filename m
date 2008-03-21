From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [patch 2.6.25-rc6 3/7] pci_choose_state() cleanup
 and fixes
Date: Thu, 20 Mar 2008 20:55:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803202053270.11234-100000@netrider.rowland.org>
References: <200803210122.44188.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:4645 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751290AbYCUAzn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Mar 2008 20:55:43 -0400
In-Reply-To: <200803210122.44188.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Brownell <david-b@pacbell.net>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org

On Fri, 21 Mar 2008, Rafael J. Wysocki wrote:

> The original code executed platform_pci_choose_state() first, if defined, and
> if that succeeded, it just returned the result.  You put
> platform_pci_choose_state() under the switch(). :-)

For FREEZE and QUIESCE, is there ever any reason to leave D0?  These 
calls are documented as not requiring (and not desiring!) any change in 
power level.

> Consequently, the 'state' argument would simply be unnecessary (and in fact
> it's ignored if platform_pci_choose_state() is defined).

It should not be ignored, for the reason given above.

Alan Stern

