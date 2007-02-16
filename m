From: Jon Dufresne <jdufresne@vision-gaming.com>
Subject: ACPI and power failure
Date: Fri, 16 Feb 2007 12:09:49 -0500
Message-ID: <45D5E55D.4000802@vision-gaming.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 70-46-58-66.atl.fdn.com ([70.46.58.66]:39635 "EHLO
	mailb.visiongamingtech.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1946017AbXBPR3L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Feb 2007 12:29:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailb.visiongamingtech.com (Postfix) with ESMTP id 38D2CF8400A
	for <linux-acpi@vger.kernel.org>; Fri, 16 Feb 2007 12:07:57 -0500 (EST)
Received: from mailb.visiongamingtech.com ([127.0.0.1])
 by localhost (mailb.visiongamingtech.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 25744-02 for <linux-acpi@vger.kernel.org>;
 Fri, 16 Feb 2007 12:07:54 -0500 (EST)
Received: from [172.16.8.161] (D61-jon-centos.visiongamingtech.com [172.16.8.161])
	by mailb.visiongamingtech.com (Postfix) with ESMTP id E3758F84001
	for <linux-acpi@vger.kernel.org>; Fri, 16 Feb 2007 12:07:53 -0500 (EST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Is there anything ACPI related that deals with a AC power fail in the 
system?

I am developing an embedded system that has very limited writes to a 
flash device, other than that all file systems are read only. I want to 
turn this device on and off with one main switch that will cut the AC 
power. Turning it on this way is not a problem. When I turn it off I am 
a bit worried that if in the middle of a write the r/w file system may 
be corrupted. I am curious if there is anything ACPI related that can 
detect an AC power fail and in the 1-5 ms before DC power is lost 
quickly do the bare essentials of house keeping to prevent fs corruption.

Any input on this would be helpful.

Thanks,
Jon
