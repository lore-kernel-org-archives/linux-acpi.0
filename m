From: Holger Macht <hmacht@suse.de>
Subject: Re: Regression in dock/ata driver
Date: Thu, 18 Dec 2008 12:54:08 +0100
Message-ID: <1229601248.4402.3.camel@homac.suse>
References: <4948603C.5020602@dbservice.com>
Reply-To: hmacht@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:44759 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbYLRLyW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Dec 2008 06:54:22 -0500
In-Reply-To: <4948603C.5020602@dbservice.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
Cc: linux-acpi@vger.kernel.org

Am Mittwoch, den 17.12.2008, 03:13 +0100 schrieb Tomas Carnecky:
> Hi folks,
> 
> I'm here to report a regression in the dock or ata driver. I found the 
> old thread where me and another affected user are discussing the bug: 
> http://kerneltrap.org/mailarchive/linux-kernel/2008/9/1/3152964/thread
> The bug was eventually fixed and my laptop worked fine for a while. Now 
> I'm seeing the bug again.
> 
> The patch in this thread looks related:
> http://kerneltrap.org/mailarchive/linux-kernel/2008/6/1/1996064/thread
> I will test if commit 246dd412d31e4f5de1d43aa6422a325b785f36e4 or IOW 
> v2.6.26-rc4-212-g246dd41 (which is the merge commit right after the 
> patch from the thread was merged into linux-2.6) still has the bug and 
> report back.
> 
> Attached is my current config for 2.6.28-rc8 (which is what I'm running 
> right now).
> 
> I'd hate to bisect it, because you folks tend to change the kernel 
> config often and then 'make oldconfig' asks lots of questions and I 
> can't be sure that the new kernel will boot. So if you have an idea 
> where the problem might me or even have a patch ready that I could test, 
> that would be great.

There's is also http://bugzilla.kernel.org/show_bug.cgi?id=11703, which
seems to be heavily related. I think it's actually the same issue, just
that in this bug, there's only the bay drive which gets removed, not the
whole docking station (which shouldn't matter for libata's resume
functions).

I'll try to get my hands on a system where I can reproduce this to be
able to do sensible debuggin.

Regards,
 Holger 

