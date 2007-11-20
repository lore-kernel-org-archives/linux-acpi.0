From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/8] Suspend/hibernation patches for 2.6.25
Date: Tue, 20 Nov 2007 01:41:05 -0500
Message-ID: <200711200141.06595.lenb@kernel.org>
References: <200711192332.15078.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50907 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655AbXKTGly (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Nov 2007 01:41:54 -0500
In-Reply-To: <200711192332.15078.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Adrian Bunk <bunk@kernel.org>

thanks for re-sending, Rafael.

I've created a new "suspend" branch -- currently
rooted on Linus' latest.

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git suspend

I've re-based the older hibernate patches onto
the new branch, and added the batch you just sent.

Note that the suspend branch is included in my test branch,
which akpm pulls into -mm.

-Len

On Monday 19 November 2007 17:32, Rafael J. Wysocki wrote:
> Hi Len,
> 
> I've already sent all of the following patches to you, but you haven't picked
> them up yet, so here they go again in one pack (with missing ACKs added here
> and there).
> 
> I'm considering all of them as 2.6.25 material, so please add them to the
> suspend branch.
> 
> Thanks,
> Rafael
> 
