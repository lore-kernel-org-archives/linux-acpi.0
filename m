From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: suspend/resume fails on second attempt in LNXVIDEO:00
Date: Thu, 18 Dec 2008 04:24:44 +0000 (UTC)
Message-ID: <gicjac$m5f$11@ger.gmane.org>
References: <gi247o$iog$1@ger.gmane.org> <200812152119.35228.rjw@sisk.pl>
	<gi6g21$bnf$8@ger.gmane.org> <200812160002.43427.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:43296 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbYLREYz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Dec 2008 23:24:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LDARQ-0007Q6-Co
	for linux-acpi@vger.kernel.org; Thu, 18 Dec 2008 04:24:52 +0000
Received: from d193-213-184.home3.cgocable.net ([67.193.213.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Thu, 18 Dec 2008 04:24:52 +0000
Received: from brian by d193-213-184.home3.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Thu, 18 Dec 2008 04:24:52 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2008 00:02:43 +0100, Rafael J. Wysocki wrote:
> 
> You can try to use the s2ram binary (http://en.opensuse.org/s2ram) to
> work around this issue.

OK.  I've done my s2ram experiments and go no better than with pm-utils/
kernel mode suspend (where first suspend/resume works, second suspend 
works, but second resume hangs the machine).  Here's the full array of 
suggestions on http://en.opensuse.org/S2ram and their results:

s2ram -f -a 3
 - hung on first resume

s2ram -f -a 2
 - restored first resume but no backlight
s2ram -f -a 1
 - hung on first resume

s2ram -f -p -m 
 - resumed first time but console font changed
 - hung on second resume

s2ram -f -p -s 
 - resumed first time but console font changed
 - hung on second resume

s2ram -f -m
 - restored first resume but no backlight

s2ram -f -s
 - resumed first time but console font changed
    - message "Function not supported?\nSwitching back to vt1"
 - hung on second resume

s2ram -f -p
 - resumed first time but console font changed
 - hung on second resume

s2ram -f -a 2 -m
 - restored first resume but no backlight

s2ram -f -a 2 -s
 - resumed first time but console font changed
    - message "Function not supported?\nSwitching back to vt1"

These were always booting with init=/bin/bash and removing all removable 
(i.e. unreferenced) modules.

Where I mention "console font changed" that means it reverted back to the 
font that it was in when it was booting the kernel.  You see, Ubuntu, at 
some point through boot actually change the font to be a "leaner" (i.e. 
not so "fat") font.  This is not to say that I am running on the console 
in a framebuffer (to the best of my knowledge).  I believe this font 
setting is being done with a "/usr/bin/consolechars" tool.

Anyway, thanx much for continuing to look into this.

Cheers,
b.


