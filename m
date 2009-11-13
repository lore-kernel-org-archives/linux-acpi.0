From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: 64-bit DMA problems with BCM4312 using b43
Date: Fri, 13 Nov 2009 11:21:18 -0600
Message-ID: <4AFD958E.1000303@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:48852 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887AbZKMRVe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2009 12:21:34 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, bcm43xx devel <Bcm43xx-dev@lists.berlios.de>, Michael Buesch <mb@bu3sch.de>, =?ISO-8859-1?Q?G=E1bor_Stefanik?= <netrolller.3d@gmail.com>

A number of users are experiencing DMA descriptor or data errors using 64-bit
DMA with the Broadcom BCM4312 wireless device. After careful review and a
rewrite of the DMA code in the driver, we have not been able to fix the problem,
but we have determined the following:

(1) The problem is much more likely to occur on netbook systems. Several of the
developers have this card in regular notebook systems. None of us have the
problem. Several brand/model combinations are affected including Dell Inspiron
910 and Acer Aspire One A150. Linus has also reported the same symptoms with a
Core 2 ULV CPU. One of our devs questions if the deep-sleep support in the CPU
is a problem. It is also believed that affected systems have a Phoenix BIOS.

(2) If CONFIG_ACPI_PROCESSOR is not set on affected systems, the error rate is
much lower.

(3) When a DMA descriptor error occurs, a dump of the descriptors does not
reveal any obvious problems.

(4) Once the problem occurs, resetting of the device does not restore proper
operations. It is not a transient error.

Support for this device was not enabled in mainline until 2.6.32-rc2.

I do not know enough about either the ACPI or DMA code to begin debugging in
either of those regions. Any suggestions on debugging strategies, or links to
similar problems would be appreciated.

Thanks,

Larry

