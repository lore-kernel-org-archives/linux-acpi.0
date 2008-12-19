From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend/resume fails on second attempt in LNXVIDEO:00
Date: Fri, 19 Dec 2008 18:33:10 +0100
Message-ID: <200812191833.10979.rjw@sisk.pl>
References: <gi247o$iog$1@ger.gmane.org> <gicjac$m5f$11@ger.gmane.org> <gieo1h$u78$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46109 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553AbYLSRd1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2008 12:33:27 -0500
In-Reply-To: <gieo1h$u78$1@ger.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, 19 of December 2008, Brian J. Murrell wrote:
> On Thu, 18 Dec 2008 04:24:44 +0000, Brian J. Murrell wrote:
> 
> > 
> > OK.  I've done my s2ram experiments and go no better than with pm-utils/
> > kernel mode suspend (where first suspend/resume works, second suspend
> > works, but second resume hangs the machine).  Here's the full array of
> > suggestions on http://en.opensuse.org/S2ram and their results:
> 
> Just wondering if any of this experimentation is likely to help me or is 
> this just a loser of a laptop that will be more trouble that it's worth 
> trying to get to suspend?  I can take it back to the store still.  Maybe 
> I should and try a different one?
> 
> Or does it seem like there still might be a relatively easy fix for this 
> problem, which would be nice given that it was a pretty good deal (or was 
> it?).  :-)

You're not the only person having a problem like this and unfortunately it's
not easy to debug.  I don't know of any fixes available.

Thanks,
Rafael
