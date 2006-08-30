From: newhren <colimit@gmail.com>
Subject: Re: DSDT on Averatec 1050
Date: Wed, 30 Aug 2006 19:07:26 +0000 (UTC)
Message-ID: <loom.20060830T210051-499@post.gmane.org>
References: <44635E8A.406@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:36551 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751334AbWH3TH7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Aug 2006 15:07:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GIVPZ-0002i4-A4
	for linux-acpi@vger.kernel.org; Wed, 30 Aug 2006 21:07:41 +0200
Received: from ip68-1-168-140.ri.ri.cox.net ([68.1.168.140])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 30 Aug 2006 21:07:41 +0200
Received: from colimit by ip68-1-168-140.ri.ri.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 30 Aug 2006 21:07:41 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Paul Wagner <paul_spam <at> gmx.at> writes:

> 
> Hi Folks,
> 
> tried to get Linux (Slackware 10.1 with Kernel 2.6.13) to run on my 
> Averatec 1050. Unfortunately, ACPI doesn't work as supposed: No thermal 
> zones, no fan, no CPU temperature, kernel error messages (see below).
>

Hi, Paul

I also recently faced the same problem when trying to compile DSDT for
Averatec 1020. I fixed all the errors (unfortunately, before I found
this thread). The patched DSDT is posted at
http://acpi.sourceforge.net/dsdt/view.php?id=667 . For the record, can
you also post your original raw (non-decompiled) DSDT for av1050 there?



