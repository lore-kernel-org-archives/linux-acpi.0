From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Sun, 6 Jan 2008 23:24:14 +0100
Message-ID: <200801062324.15960.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0801061710140.19222-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33785 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758189AbYAFWWC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Jan 2008 17:22:02 -0500
In-Reply-To: <Pine.LNX.4.44L0.0801061710140.19222-100000@netrider.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Sunday, 6 of January 2008, Alan Stern wrote:
> On Sun, 6 Jan 2008, Rafael J. Wysocki wrote:
> 
> > On Sunday, 6 of January 2008, Alan Stern wrote:
> 
> > Still, shouldn't we fail the removal of the device apart from giving the
> > warning?
> 
> We can't.  device_del() can't fail -- it returns void.  Besides, how 
> can a driver hope to deal with an unregistration failure?

Well, right.

Still, our present approach doesn't seem to be correct overall.  For example,
I think we should prevent a suspend from happening while a device is being
removed.

Rafael
