From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: suspend/resume fails on second attempt in LNXVIDEO:00
Date: Tue, 16 Dec 2008 02:34:11 +0000 (UTC)
Message-ID: <gi7433$m5f$1@ger.gmane.org>
References: <gi247o$iog$1@ger.gmane.org> <200812152119.35228.rjw@sisk.pl>
	<gi6g21$bnf$8@ger.gmane.org> <200812160002.43427.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:48106 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443AbYLPCe0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Dec 2008 21:34:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LCPlM-0003ps-Vx
	for linux-acpi@vger.kernel.org; Tue, 16 Dec 2008 02:34:21 +0000
Received: from d193-213-184.home3.cgocable.net ([67.193.213.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 16 Dec 2008 02:34:20 +0000
Received: from brian by d193-213-184.home3.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 16 Dec 2008 02:34:20 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2008 00:02:43 +0100, Rafael J. Wysocki wrote:
> 
> No, most probably your graphics adapter is not handled correctly in this
> case, because it needs some special user space quirks, which are done by
> hald that is not running.

Hrm.  OK.
 
> You can try to use the s2ram binary (http://en.opensuse.org/s2ram) to
> work around this issue.

That sounds like I am setting for something less than optimal.  Is that 
the case?  Why would I want to use what I've been trying to get working 
rather than s2ram?  Maybe put another way, why isn't everyone using s2ram?

Ultimately I'm going to want to be able to suspend as well as hibernate, 
for whatever that's worth.

> Anyway, if you suspend for the second time from this state, does it
> resume?

No.  It fails just as miserably.  :-(

b.


