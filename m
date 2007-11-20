From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend/hibernation patches for 2.6.25
Date: Wed, 21 Nov 2007 00:59:53 +0100
Message-ID: <200711210059.54210.rjw@sisk.pl>
References: <200711192332.15078.rjw@sisk.pl> <200711200141.06595.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46342 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755644AbXKTXmF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Nov 2007 18:42:05 -0500
In-Reply-To: <200711200141.06595.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Adrian Bunk <bunk@kernel.org>

On Tuesday, 20 of November 2007, Len Brown wrote:
> thanks for re-sending, Rafael.
> 
> I've created a new "suspend" branch -- currently
> rooted on Linus' latest.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git suspend
> 
> I've re-based the older hibernate patches onto
> the new branch, and added the batch you just sent.
> 
> Note that the suspend branch is included in my test branch,
> which akpm pulls into -mm.

Thanks for all that!

I'm now seeing the suspend branch on gitweb, but when I do

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6

I get a repository with only one branch which is "test" and indeed
.git/refs/heads contains this one only.  What should I do to get the suspend
branch (and the others) too with git clone (or git fetch)?

Rafael
