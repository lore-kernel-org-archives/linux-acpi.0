From: Michal 'vorner' Vaner <vorner@ucw.cz>
Subject: Problem with kernel commit 664d080c41463570b95717b5ad86e79dc1be0877
Date: Sun, 21 Sep 2008 19:35:06 +0200
Message-ID: <20080921173506.GA15741@tarantula.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51822 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbYIURfa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Sep 2008 13:35:30 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: hmacht@suse.de
Cc: linux-acpi@vger.kernel.org

Hello

Recently, I updated my kernel from 2.6.25 to latest .27 rc and found a
problem. I have a dell latitude D510 laptop with a media bay slot. If I
have any disk-like device inserted (CDRom or secondary disk) and remove
it, acpi starts generating ~250 interrupts per second (found out by
powertop) and kacpid and kacpid_notify start using all available CPU
time. It stops after any disk-like device is plugged back in, however,
inserting secondary battery does not help (which means replacing a
CDRom with a battery has the opposite than desired effect, making the
runtime shorter).

By bisecting the kernel sources, I identified it to the commit
664d080c41463570b95717b5ad86e79dc1be0877 (ACPI: Properly handle bay
devices in dock stations, from Linus's branch), which mentions you
as an author.

I would like to help to fix it, so if you need any information, I will
try to get them. Also, I have some experience in programming and trying
a development version of kernel is not a problem for me, but I did not
yet get into kernel development.

Thank you

PS: If responding to the list, please CC me, I'm not subscribed.

-- 
Michal 'vorner' Vaner
