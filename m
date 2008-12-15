From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: suspend/resume fails on second attempt in LNXVIDEO:00
Date: Mon, 15 Dec 2008 20:52:17 +0000 (UTC)
Message-ID: <gi6g21$bnf$8@ger.gmane.org>
References: <gi247o$iog$1@ger.gmane.org> <494694F8.6080004@gmail.com>
	<gi65ol$bnf$7@ger.gmane.org> <200812152119.35228.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:60349 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850AbYLOUw1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Dec 2008 15:52:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LCKQT-0000M5-EI
	for linux-acpi@vger.kernel.org; Mon, 15 Dec 2008 20:52:25 +0000
Received: from d193-213-184.home3.cgocable.net ([67.193.213.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2008 20:52:25 +0000
Received: from brian by d193-213-184.home3.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 15 Dec 2008 20:52:25 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2008 21:19:34 +0100, Rafael J. Wysocki wrote:
> Does it also happen in the minimal configuration (ie. with
> init=/bin/bash)?

Now, that's an interesting result.  Using the above, pm-suspend does 
suspend fine and hitting the flashing power button will resume fine with 
the exception of the screen is still black.  That is backlight problems 
isn't it?  I can see by disk light activity though that it's actually 
still alive though.

b.


