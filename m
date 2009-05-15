From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [linux-pm] [RFC] why do we need run disk sync before entering
	S3
Date: Thu, 14 May 2009 22:00:56 -0300
Message-ID: <20090515010055.GB21718@khazad-dum.debian.net>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org> <200905131616.27334.rjw@sisk.pl> <20090514094249.GG6417@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36119 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752714AbZEOBA5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 May 2009 21:00:57 -0400
Content-Disposition: inline
In-Reply-To: <20090514094249.GG6417@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Thu, 14 May 2009, Pavel Machek wrote:
> But remember there are even in-kernel s2ram triggers, for example on
> zaurus when battery goes critical.

Are there?  I am quite interested on this!

Are they safe on x86?

thinkpad-acpi receives some critical alarms from the firmware, for which the
recommended action by the vendor is to go into S3 immediately.  There is
also one which requires S4 as the recommended damage control measure.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
