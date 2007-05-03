From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: Do not use pm_ops
Date: Thu, 3 May 2007 11:52:38 +0200
Message-ID: <200705031152.38933.rjw@sisk.pl>
References: <200705022213.35831.rjw@sisk.pl> <200705031146.03358.rjw@sisk.pl> <1178185551.13233.85.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52725 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161158AbXECJsI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 May 2007 05:48:08 -0400
In-Reply-To: <1178185551.13233.85.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@cs.helsinki.fi>

On Thursday, 3 May 2007 11:45, Johannes Berg wrote:
> On Thu, 2007-05-03 at 11:46 +0200, Rafael J. Wysocki wrote:
> 
> > Well, BUG_ON() is extremely user-unfriendly, and it'd trigger even if the user
> > actually didn't intend to suspend at all.
> 
> Well, hibernation_set_ops is invoked whenever the user loads his ACPI
> module with S4 possible, and typically having a BUG_ON here will make
> the developers who wrote the code that calls hibernation_set_ops see it
> right away while they might miss the message.
> 
> I don't care much though, it just seems wasteful to have this string in
> there when it'll never be seen by anyone but the developers who create
> new hibernation_ops.

You're making the dangerous assumption that all patches get tested before
hitting users. ;-)

Greetings,
Rafael
