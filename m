From: Eric Paris <eparis@redhat.com>
Subject: linux-next acpi changes make vmware server unusable
Date: Wed, 04 Mar 2009 16:55:00 -0500
Message-ID: <1236203700.3569.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:58784 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754490AbZCDVyF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Mar 2009 16:54:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: robert.moore@intel.com, ming.m.lin@intel.com, len.brown@intel.com

I built a linux-next kernel yesterday and discovered that the free
vmware server 2 would start to boot the kernel and very quickly just
power off.  vmware gave some crap message about the MBR being wrong,
which obviously wasn't the case since grub started and the kernel
started booting.  Looking at the last line on the serial console for the
new kernel and the next line in a working kernel I knew the next output
was supposed to be in the ACPI code.  I bisected drivers/acpi and found
that d6c349993fc7c9dabf873796c4e82bb94544b3ce is first bad commit.

I have no idea what vmware is doing, or what we are doing, but before
that patch I was able to boot and after it, vmware just shuts itself
off.

-Eric


