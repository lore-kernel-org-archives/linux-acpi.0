From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Thinkpad X200s
Date: Sat, 28 Nov 2009 10:07:11 -0200
Message-ID: <20091128120711.GA17894@khazad-dum.debian.net>
References: <4B0FB618.7020204@collabora.co.uk>
 <20091127221134.GC21775@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:59105 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753140AbZK1MHH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Nov 2009 07:07:07 -0500
Content-Disposition: inline
In-Reply-To: <20091127221134.GC21775@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ian Molton <ian.molton@collabora.co.uk>
Cc: linux-acpi@vger.kernel.org

On Fri, 27 Nov 2009, Henrique de Moraes Holschuh wrote:
> On Fri, 27 Nov 2009, Ian Molton wrote:
> > The problem seems to be the rfkill layer getting out of sync with ACPIs
> > idea of the hardware state.
> 
> Hmm... did rfkill drop the suspend/resume support perchance?

Yes, for persistent devices, which are thinkpad-acpi and eeepc-laptop.
I even ack'd the change that caused this regression, because I didn't
pay enough attention to the last lines of the patch. ARGH!

This can be worked-around by thinkpad-acpi with a few lines of extra
code, or fixed in rfkill removing two lines of code, which would allow
us to remove more LOC from eeepc-laptop as well, as they'd become
redundant.

It is a regression from 2.6.30, so it will have to go to stable anyway.
This means it is best to waste a few days checking with the others if it
would be better fixed in rfkill or thinkpad-acpi, and then get it in
2.6.32 and 2.6.31 through stable.

I will handle it, either way.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
