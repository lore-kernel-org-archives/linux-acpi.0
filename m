From: Shane Hansen <shane.hansen@inl.gov>
Subject: linux kernel 2.6.23+ can't restart
Date: Fri, 02 May 2008 11:50:00 -0600
Message-ID: <481B5448.6060202@inl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-out.inel.gov ([134.20.15.178]:1544 "EHLO inel.gov"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756647AbYEBQzW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 May 2008 12:55:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

May  2 11:45:18 [kernel] ACPI: DMI Product Version:
May  2 11:45:18 [kernel] ACPI: DMI Board Name: 0F9382
May  2 11:45:18 [kernel] ACPI: DMI BIOS Vendor: Dell Inc.
May  2 11:45:18 [kernel] ACPI: DMI BIOS Date: 12/13/2007

Since upgrading to the 2.6.23 / 2.6.24 kernels I can no longer "restart" 
my system.  I can "shutdown" ok, the machine powers off just fine.  
However when I try a "restart" the kernel goes through all the normal 
stuff and then hangs on the line that says "Restarting System".  I have 
to hold down the power button to power off the case...


Suggestions?

-- 
Shane Hansen
Cyber Security Research
Idaho National Laboratory
Work: 208-526-2793
Cell: 208-351-3668


