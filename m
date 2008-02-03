From: matthieu castet <castet.matthieu@free.fr>
Subject: suspend to ram problem
Date: Sun, 03 Feb 2008 14:37:29 +0100
Message-ID: <47A5C399.7010405@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from postfix2-g20.free.fr ([212.27.60.43]:46459 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbYBCNjc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Feb 2008 08:39:32 -0500
Received: from smtp2-g19.free.fr (smtp2-g19.free.fr [212.27.42.28])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 1FB5422F2B91
	for <linux-acpi@vger.kernel.org>; Sun,  3 Feb 2008 12:38:53 +0100 (CET)
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 9902D12B724
	for <linux-acpi@vger.kernel.org>; Sun,  3 Feb 2008 14:37:29 +0100 (CET)
Received: from [192.168.0.3] (cac94-1-81-57-151-96.fbx.proxad.net [81.57.151.96])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 74B9312B713
	for <linux-acpi@vger.kernel.org>; Sun,  3 Feb 2008 14:37:29 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I am trying to make work suspend to ram on a MSI MS-6380E with a 2.6.23 
kernel.

Standby mode works.
S2ram suspend seems to work : the computer turn off and I can wake up it 
with the keyboard.

But when the computer wakeup, I see the video card POST on the screen, 
but after that the computer hangs : black screen, no working numlock.

I tried to compile PM_TRACE, but it give no result. So this means the 
resume hang very early.

What can I do to debug this ?


Thanks

Matthieu
