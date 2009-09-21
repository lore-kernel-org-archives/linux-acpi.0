From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [GIT PATCH] backlight event support enhancements
Date: Mon, 21 Sep 2009 09:28:59 -0300
Message-ID: <20090921122859.GC1136@khazad-dum.debian.net>
References: <1253468688-4933-1-git-send-email-hmh@hmh.eng.br>
 <1253490102.564.3.camel@ted>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33466 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751386AbZIUM26 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Sep 2009 08:28:58 -0400
Content-Disposition: inline
In-Reply-To: <1253490102.564.3.camel@ted>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Mon, 21 Sep 2009, Richard Purdie wrote:
> On Sun, 2009-09-20 at 14:44 -0300, Henrique de Moraes Holschuh wrote:
> > This two-patch patchset adds poll() support to Matthew's backlight event
> > work, and also adds backlight event support for thinkpad-acpi.
> > 
> > The thinkpad-acpi changes depend on a patchset I just sent to Len Brown
> > for merging in acpi-test.
> > 
> > Is there any timeframe for the backlight event support to be sent to
> > mainline?
> 
> I'm going to try and get the event patches in this merge window if I
> can. I'm going to have intermittent internet access for a few days but I
> will send a pull request for the backlight tree over that time period. 
> 
> Whats the timeframe for acpi-test merging?

acpi-test usually merges late, and the patchset with the prerequisites for
patch 2/2 are not even merged in acpi-test yet.

If you are not going to merge late, it is best to let me handle patch 2/2
and I will submit it later when both sets of prerequisites are in
mainline...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
