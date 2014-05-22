From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: what is the sysfs entry for the battery?
Date: Thu, 22 May 2014 08:44:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1405220841400.3739@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:55656 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbaEVNSW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 May 2014 09:18:22 -0400
Received: from [99.240.204.5] (port=45060 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1WnSP0-0003T5-Nq
	for linux-acpi@vger.kernel.org; Thu, 22 May 2014 08:47:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


  currently doing a bit of cleanup to drivers/acpi/Kconfig, and one
reads this:

config ACPI_BATTERY
        tristate "Battery"
        depends on X86
        select POWER_SUPPLY
        default y
        help
          This driver adds support for battery information through
          /proc/acpi/battery. If you have a mobile system with a battery,
          say Y.

  naturally, the reference to /proc/acpi/battery is a bit outdated, so
i wanted to update that line -- is the current reference to the
battery now /sys/class/power_supply/, and probably called "BAT0"? or
am i misreading that? thanks.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
