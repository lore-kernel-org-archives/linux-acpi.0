From: Eric Anderson <anderse@hpl.hp.com>
Subject: Proper way to enable ACPI_DEBUGGER; debugging lack of ac online/offline updates
Date: Fri, 4 Aug 2006 17:22:27 -0700
Message-ID: <17619.58563.987172.727039@cello.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gundega.hpl.hp.com ([192.6.19.190]:57571 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1422671AbWHEAWg
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Aug 2006 20:22:36 -0400
Received: from cello.hpl.hp.com (cello.hpl.hp.com [15.4.89.103])
	by gundega.hpl.hp.com (8.13.7/8.13.7/HPL-PA Relay) with ESMTP id k750MSOU007101
	for <linux-acpi@vger.kernel.org>; Fri, 4 Aug 2006 17:22:28 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I've been trying to figure out what is going wrong with Linux ACPI
support on the HP nw9440.  One of the problems that I've had is that
when the AC adapter is removed, the acpi status doesn't get updated.
I have discovered that if I boot with 2.6.14, wait for it to hang, and
then reboot with 2.6.17.7, I have functional notification of the AC
adapter state changes.

I'm attempting to work out what the difference is between these two
runs, and I have found a first difference that in the non-working
case, acpi_ex_opcode_2A_0T_0R is called which queues a deferred
execution, and prints out the message "bus_get_device: No context for
object [...]".  In the working case, that path is never executed.

I'm trying to figure out what the difference is between the AML that
gets executed along the two paths, and near as I can tell, if I could
enable ACPI_DEBUGGER, I would get the trace of executed AML, and I
could start working out what is going wrong.  However, I can't find
any kernel config option to enable ACPI_DEBUGGER, and all of my google
searches around that haven't found anything that describes how it
should work, nor has wandering around the acpi4linux wiki, other
acpi4linux web pages, nor the mailing list archives.

I therefore have three questions: 
  a) what is the proper way to enable ACPI_DEBUGGER option
  b) will it print out a trace of executed AML as I'm expecting
  c) is there some other debugging path that I should be trying to get
     this to work?

Thanks, please CC me directly as I'm not subscribed to the linux-acpi
mailing list.
	-Eric

