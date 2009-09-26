From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [GIT PATCH] backlight event support enhancements
Date: Sat, 26 Sep 2009 16:55:27 -0300
Message-ID: <20090926195527.GB15339@khazad-dum.debian.net>
References: <1253468688-4933-1-git-send-email-hmh@hmh.eng.br>
 <1253490102.564.3.camel@ted>
 <20090921122859.GC1136@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49173 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750795AbZIZTz1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Sep 2009 15:55:27 -0400
Content-Disposition: inline
In-Reply-To: <20090921122859.GC1136@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Mon, 21 Sep 2009, Henrique de Moraes Holschuh wrote:
> > I'm going to try and get the event patches in this merge window if I
> > can. I'm going to have intermittent internet access for a few days but I
> > will send a pull request for the backlight tree over that time period. 
> > 
> > Whats the timeframe for acpi-test merging?
> 
> acpi-test usually merges late, and the patchset with the prerequisites for
> patch 2/2 are not even merged in acpi-test yet.

Well, they got merged early :-)  The patches are all in mainline already, so
the thinkpad-acpi dependencies have been taken care of.

Can you please merge patch 2/2 through the backlight tree?  It can go in
toghether with Matthew's patches.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
