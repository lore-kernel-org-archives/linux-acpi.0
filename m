From: Tomas Carnecky <tom@dbservice.com>
Subject: Regression in dock/ata driver
Date: Wed, 17 Dec 2008 03:13:16 +0100
Message-ID: <4948603C.5020602@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from office.neopsis.com ([78.46.209.98]:35514 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbYLQCrV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Dec 2008 21:47:21 -0500
Received: from [192.168.0.130] ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	for linux-acpi@vger.kernel.org;
	Wed, 17 Dec 2008 03:14:06 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi folks,

I'm here to report a regression in the dock or ata driver. I found the 
old thread where me and another affected user are discussing the bug: 
http://kerneltrap.org/mailarchive/linux-kernel/2008/9/1/3152964/thread
The bug was eventually fixed and my laptop worked fine for a while. Now 
I'm seeing the bug again.

The patch in this thread looks related:
http://kerneltrap.org/mailarchive/linux-kernel/2008/6/1/1996064/thread
I will test if commit 246dd412d31e4f5de1d43aa6422a325b785f36e4 or IOW 
v2.6.26-rc4-212-g246dd41 (which is the merge commit right after the 
patch from the thread was merged into linux-2.6) still has the bug and 
report back.

Attached is my current config for 2.6.28-rc8 (which is what I'm running 
right now).

I'd hate to bisect it, because you folks tend to change the kernel 
config often and then 'make oldconfig' asks lots of questions and I 
can't be sure that the new kernel will boot. So if you have an idea 
where the problem might me or even have a patch ready that I could test, 
that would be great.

tom

