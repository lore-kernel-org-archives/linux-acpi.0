From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [GIT PATCH] backlight event support enhancements
Date: Sun, 27 Sep 2009 00:35:09 +0100
Message-ID: <1254008109.7598.63.camel@ted>
References: <1253468688-4933-1-git-send-email-hmh@hmh.eng.br>
	 <1253490102.564.3.camel@ted> <20090921122859.GC1136@khazad-dum.debian.net>
	 <20090926195527.GB15339@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dan.rpsys.net ([93.97.175.187]:62674 "EHLO dan.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbZIZXfj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Sep 2009 19:35:39 -0400
In-Reply-To: <20090926195527.GB15339@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Sat, 2009-09-26 at 16:55 -0300, Henrique de Moraes Holschuh wrote:
> On Mon, 21 Sep 2009, Henrique de Moraes Holschuh wrote:
> > > I'm going to try and get the event patches in this merge window if I
> > > can. I'm going to have intermittent internet access for a few days but I
> > > will send a pull request for the backlight tree over that time period. 
> > > 
> > > Whats the timeframe for acpi-test merging?
> > 
> > acpi-test usually merges late, and the patchset with the prerequisites for
> > patch 2/2 are not even merged in acpi-test yet.
> 
> Well, they got merged early :-)  The patches are all in mainline already, so
> the thinkpad-acpi dependencies have been taken care of.
> 
> Can you please merge patch 2/2 through the backlight tree?  It can go in
> toghether with Matthew's patches.

Matthew's patches and your 1/2 patch are in. I'll queue 2/2 in the tree
now I know the other parts are there.

Cheers,

Richard
-- 
Richard Purdie
Intel Open Source Technology Centre

