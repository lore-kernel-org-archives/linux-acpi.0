From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Kdump broken in ACPI initialization upon reading SCI_EN bit
Date: Thu, 19 Oct 2006 16:14:05 -0400
Message-ID: <20061019201405.GA15078@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:10178 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946435AbWJSURl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Oct 2006 16:17:41 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9JKHerm024805
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2006 16:17:40 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k9JKHeiW284340
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2006 16:17:40 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k9JKHeuh007647
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2006 16:17:40 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Fastboot mailing list <fastboot@lists.osdl.org>

Hi,

On one of my machines (Intel Xeon 2.00GHz), Kdump is broken. Second
kernel hangs during boot during ACPI initialization. I am
using 2.6.19-rc2.

It basically hangs when it tries to read from hardware whether system
is already in ACPI mode or not. It tries to read SCI_ENABLE bit from
PM1 control register.

Interestingly this phenomenon is observed only if the code is running 
on a non-boot cpu (cpu id is not zero). I system crashes on cpu 0 and
second kernel is booting on cpu 0 then everything is fine.

Following is the code sequence.

  acpi_early_init()
   acpi_enable_subsystem()
     acpi_hw_get_mode
       acpi_hw_get_register
	  acpi_hw_register_read
	    acpi_hw_low_level_read
		acpi_os_read_port()

In acpi_os_read_port() it tries to read port 0x804 (inw()) and then it hangs.

Any idea what's happening? Are there any dependencies of this port being
read by a boot cpu only? Any suggestions how can I debug further?

Thanks
Vivek
