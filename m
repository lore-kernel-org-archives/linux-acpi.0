From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Fwd: [patch] ACPI: fix cpufreq regression
Date: Wed, 17 Jan 2007 12:25:22 -0200
Message-ID: <20070117142522.GA6245@khazad-dum.debian.net>
References: <200701162213.14875.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:52115 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932371AbXAQOZe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Jan 2007 09:25:34 -0500
Content-Disposition: inline
In-Reply-To: <200701162213.14875.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Tue, 16 Jan 2007, Len Brown wrote:
> nobody else with a T60 noticed this since November?

It might be a good idea to Cc linux-thinkpad@linux-thinkpad.org when asking
such questions, as it will reach a lot of thinkpad power users that run
Linux.  I know a number of people subscribe to both linux-acpi and
linux-thinkpad (including me), so there is some cross-polination, but
still...

The *60 thinkpad owners have had a few bad months lately, as they are either
hitting Lenovo bugs, or Lenovo is uncovering kernel bugs.  E.g. the ACPI
video for 2.6.19 (the one with fubar constants for the ACPI video events)
and earlier will "have issues" with the newer thinkpad BIOSes and hang many
thinkpads if you try to increase brightness (the buggy version of video.c
will instead try to switch output ports, which doesn't work easily on all
thinkpads, and hardlock a running X server).  This is fixed in 2.6.20-rc.

OTOH, there are reports that the new BIOSes have removed functionality from
the DSDT that allowed multiple cores to work in different clock speeds, so
people may have overlooked the bug Ingo worked around...

If you'd like, I can try to act as a liason between linux-acpi and
linux-thinkpad, and ask your question there.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
