From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: suspend/resume fails on second attempt in LNXVIDEO:00
Date: Tue, 16 Dec 2008 18:07:15 +0000 (UTC)
Message-ID: <gi8qoj$m5f$7@ger.gmane.org>
References: <gi247o$iog$1@ger.gmane.org> <200812161625.37318.rjw@sisk.pl>
	<gi8jf1$m5f$5@ger.gmane.org> <200812161713.08451.rjw@sisk.pl>
	<20081216163746.GA9478@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:38960 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbYLPSH0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Dec 2008 13:07:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LCeKI-0002bb-DN
	for linux-acpi@vger.kernel.org; Tue, 16 Dec 2008 18:07:22 +0000
Received: from d193-213-184.home3.cgocable.net ([67.193.213.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 16 Dec 2008 18:07:22 +0000
Received: from brian by d193-213-184.home3.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 16 Dec 2008 18:07:22 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2008 16:37:46 +0000, Matthew Garrett wrote:
> 
> I seem to be missing the original message, but: no, s2ram doesn't exist
> in Ubuntu because pm-utils handles that role.

Well, that's *their* argument but lots of people think otherwise.  There 
appears to be no shortage of people for whom pm-utils does NOT work yet 
s2ram does.  https://bugs.launchpad.net/ubuntu/+source/uswsusp/+bug/134238

There is also indication earlier in this thread that it may work for me 
where pm-utils is not working.

b.


