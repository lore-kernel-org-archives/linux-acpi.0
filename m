From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: HP dv2125nr suspend to ram problems
Date: Fri, 12 Oct 2007 09:25:47 +0800
Message-ID: <823A93EED437D048963A3697DB0E35DEC9013E@pdsmsx414.ccr.corp.intel.com>
References: <470CFE5C.20006@ou.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:64407 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753869AbXJLB1L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Oct 2007 21:27:11 -0400
Content-class: urn:content-classes:message
In-Reply-To: <470CFE5C.20006@ou.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ryan May <rmay@ou.edu>, linux-acpi@vger.kernel.org

Hi, Ryan,

Please open a bug in
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
And attach the dmesg and lspci output. acpidump is needed as well.

Thanks,
Rui

-----Original Message-----
From: linux-acpi-owner@vger.kernel.org
[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Ryan May
Sent: Thursday, October 11, 2007 12:31 AM
To: linux-acpi@vger.kernel.org
Subject: HP dv2125nr suspend to ram problems

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
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
