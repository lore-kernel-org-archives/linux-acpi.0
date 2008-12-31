From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Samsung R560 ACPI issues
Date: Wed, 31 Dec 2008 01:34:04 -0600
Message-ID: <495B206C.4020009@shaw.ca>
References: <20081210134125.243910@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:45087 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754902AbYLaHeQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 31 Dec 2008 02:34:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHvan-0005pQ-2y
	for linux-acpi@vger.kernel.org; Wed, 31 Dec 2008 07:34:13 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 31 Dec 2008 07:34:13 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 31 Dec 2008 07:34:13 +0000
In-Reply-To: <20081210134125.243910@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Torsten Schlabach wrote:
> Dear list!
> 
> There seem to be some problems with P8400 based laptops and ACPI when using 64 Bit kernels.
> 
> See for example:
> 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/272530
> 
> I have such a laptop. What can I do to help find and possibly fix the problem?
> 
> Regards,
> Torsten

Would be useful to narrow down what causes the problem.. It's reported 
that either mem=4096M or acpi=off is required. It would be useful to 
build a kernel that has some of the ACPI features (CPU frequency 
scaling, etc.) disabled and see if you can find out which part is 
causing the problem.

This does smell quite possibly like some kind of BIOS or platform bug, 
though. Obviously Vista 32-bit works, but who knows about 64-bit..

