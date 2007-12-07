From: Stephan Seidl <stephan.seidl@tu-dresden.de>
Subject: ACPI power down problem
Date: Fri, 7 Dec 2007 02:18:52 +0100
Message-ID: <20071207011852.GA2827@sbase.snet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout1.zih.tu-dresden.de ([141.30.67.72]:44715 "EHLO
	mailout1.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751155AbXLGCE6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Dec 2007 21:04:58 -0500
Received: from rmc67-31.zih.tu-dresden.de ([141.30.67.31] helo=server-n)
	by mailout1.zih.tu-dresden.de with esmtp (Exim 4.63)
	(envelope-from <stephan.seidl@tu-dresden.de>)
	id 1J0SCM-0006a8-GT
	for linux-acpi@vger.kernel.org; Fri, 07 Dec 2007 02:40:16 +0100
Received: from sbase.snet (208.Red-83-61-91.dynamicIP.rima-tde.net [83.61.91.208])
	by server-n (Postfix) with ESMTP id 24B43100A08E
	for <linux-acpi@vger.kernel.org>; Fri,  7 Dec 2007 02:40:14 +0100 (CET)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
I would like to ask two questions, but firstly some history.
Normally Debian Sarge is running with the kernel 2.6.14.3 with several
patches and all works fine since Dec 2005. In Jul, 2006, I tried another
kernel, 2.6.17.4, again with several patches, and again all worked fine
with the exception of the fact that the machine did not switch off the
power on `/sbin/shutdown -t5 -h -P now'. So I rejected the kernel
2.6.17.4 hoping that the problems would disappear by itself with the time.
But, it did not.
In Aug 2007, Debian 4.0 r1 appeared with a kernel 2.6.18..., still
having the power down problem. Obviously, the problem has been introduced
between 2.6.14.3 and 2.6.17.4 and I am the only who has it. The concerning
board can be described by

  Award Medallion BIOS v6.0, An Energy Star Ally
  ASUS P4B ACPI BIOS Revision 1013 Beta 004
  Award Plug and Play BIOS Extension v1.0A

This week, to tackle the problem, I addionally applied the patches
in the attachment to have the console messages somewhat longer on the screen.
I got the same output with the two kernels, 2.6.14.3 and 2.6.17.4, namely

  Power down.
  acpi_power_off called
   hwsleep-0284 [01] enter_sleep_state     : Entering sleep state [S5]

whereat the line numer 0284 changed to 0283 for 2.6.17.4.
What in fact happens after the above has been seen for 20 seconds is that
the same machine switches off in case of 2.6.14.3, and wrongly reboots in
case of 2.6.17.4. Now the questions, firstly,
is that a kernel bug ? From my point of view, yes, it seems to be one.
Secondly, if I would more or less stupidly put the debugging into execution,
is there anyone who could guide me, because in the ACPI kernel environment,
I am mildly expressed blind.
Many thanks in advance
Stephan

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.14.3.PATCH4"

diff -crN -C 7 linux-2.6.14.3-ORG/drivers/acpi/hardware/hwsleep.c linux-2.6.14.3/drivers/acpi/hardware/hwsleep.c
*** linux-2.6.14.3-ORG/drivers/acpi/hardware/hwsleep.c	Thu Nov 24 23:10:21 2005
--- linux-2.6.14.3/drivers/acpi/hardware/hwsleep.c	Thu Dec  6 16:00:51 2007
***************
*** 279,292 ****
--- 279,300 ----
  				       ACPI_REGISTER_PM1_CONTROL, &PM1Acontrol);
  	if (ACPI_FAILURE(status)) {
  		return_ACPI_STATUS(status);
  	}
  	ACPI_DEBUG_PRINT((ACPI_DB_INIT,
  			  "Entering sleep state [S%d]\n", sleep_state));
  
+ 	{
+ 		volatile int n = 2000, m = 0, i, j, k;
+ 		for (i = 0; i < n; i++)
+ 			for (j = 0; j < n; j++)
+ 				for (k = 0; k < n; k++)
+ 					m = 1 - m;
+ 	}
+ 
  	/* Clear SLP_EN and SLP_TYP fields */
  
  	PM1Acontrol &= ~(sleep_type_reg_info->access_bit_mask |
  			 sleep_enable_reg_info->access_bit_mask);
  	PM1Bcontrol = PM1Acontrol;
  
  	/* Insert SLP_TYP bits */

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.17.4.PATCH4"

diff -crN -C 7 linux-2.6.17.4-ORG/drivers/acpi/hardware/hwsleep.c linux-2.6.17.4/drivers/acpi/sleep/hardware/hwsleep.c
*** linux-2.6.17.4-ORG/drivers/acpi/hardware/hwsleep.c	Thu Jul  6 22:02:28 2006
--- linux-2.6.17.4/drivers/acpi/hardware/hwsleep.c	Wed Dec  5 16:37:33 2007
***************
*** 278,291 ****
--- 278,299 ----
  				       ACPI_REGISTER_PM1_CONTROL, &PM1Acontrol);
  	if (ACPI_FAILURE(status)) {
  		return_ACPI_STATUS(status);
  	}
  	ACPI_DEBUG_PRINT((ACPI_DB_INIT,
  			  "Entering sleep state [S%d]\n", sleep_state));
  
+ 	{
+ 		volatile int n = 2000, m = 0, i, j, k;
+ 		for (i = 0; i < n; i++)
+ 			for (j = 0; j < n; j++)
+ 				for (k = 0; k < n; k++)
+ 					m = 1 - m;
+ 	}
+ 
  	/* Clear SLP_EN and SLP_TYP fields */
  
  	PM1Acontrol &= ~(sleep_type_reg_info->access_bit_mask |
  			 sleep_enable_reg_info->access_bit_mask);
  	PM1Bcontrol = PM1Acontrol;
  
  	/* Insert SLP_TYP bits */

--r5Pyd7+fXNt84Ff3--
