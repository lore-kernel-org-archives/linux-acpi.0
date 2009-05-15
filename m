From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: suspending machine from kernel (was Re: [linux-pm] [RFC] why
	do we need run disk sync before entering S3)
Date: Fri, 15 May 2009 18:15:17 -0300
Message-ID: <20090515211517.GB22906@khazad-dum.debian.net>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org> <200905131616.27334.rjw@sisk.pl> <20090514094249.GG6417@elf.ucw.cz> <20090515010055.GB21718@khazad-dum.debian.net> <20090515090843.GC32740@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42754 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751825AbZEOVPU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 May 2009 17:15:20 -0400
Content-Disposition: inline
In-Reply-To: <20090515090843.GC32740@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

On Fri, 15 May 2009, Pavel Machek wrote:
> > thinkpad-acpi receives some critical alarms from the firmware, for which the
> > recommended action by the vendor is to go into S3 immediately.  There is
> > also one which requires S4 as the recommended damage control measure.
> 
> While s2ram should always work on hardware that supports it (zaurus),
> S4 is more tricky. It needs swap to be configured, and userspace
> cooperation in uswsusp case.

Yeah, this really calls for issuing some sort of event to userspace that has
the "emergency" connotation, so that desktop enviromnents don't start doing
retarted things like asking the user stupid questions when the machine has
30 seconds left of battery juice, or got waken up from S3 due to a
critically hot thermal alarm.

> I guess sending signal to init would be right solution in that
> case. (ACPI already does that on overheat.)

I will look into this.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
