From: Ryan May <rmay@ou.edu>
Subject: HP dv2125nr suspend to ram problems
Date: Wed, 10 Oct 2007 11:31:24 -0500
Message-ID: <470CFE5C.20006@ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rossby.metr.ou.edu ([129.15.192.80]:3744 "EHLO
	rossby.metr.ou.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072AbXJJQbb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 12:31:31 -0400
Received: from [10.197.12.171] ([10.197.12.171])
	by rossby.metr.ou.edu (8.12.9p2/8.12.9) with ESMTP id l9AGVTYN020401
	for <linux-acpi@vger.kernel.org>; Wed, 10 Oct 2007 11:31:29 -0500 (CDT)
	(envelope-from rmay@ou.edu)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Can anyone here help me figure out my problems with suspend to ram on my
laptop?

My system is an HP dv2125nr laptop, which is an AMD64 system with an
integrated nVidia graphics chipset and a Broadcom 4311 based wireless
chip.  The system is running Gentoo linux.

The problem is that suspend to ram has become very flaky on my laptop.
It used to be much more reliable on my laptop about 6 months ago (I'd
say 2.6.18 was the kernel I was running then.)  Now when I suspend
(using gnome-power-manager 2.18.3), 1 of 4 things happens (with
approximately equal likelihood):

1) System reboots itself
2) Kernel panic (blinking caps lock)
3) Complete hang (w/o blinking caps lock)
4) Suspends fine

When the system manages to suspend, resume works great.  This is
occurring for me even now on 2.6.22 (Gentoo patchset r8)  Because this
is an intermittent problem, testing different kernel configs and
versions has been difficult, since STR working once does not guarantee
that the problem is solved.

I'd appreciate any help, even if it's just ways that I can see what's
going on and where it's failing.

Thanks in advance.

Ryan

-- 
Ryan May
Graduate Research Assistant
School of Meteorology
University of Oklahoma
