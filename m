From: mike <mike-acpilist@tiedyenetworks.com>
Subject: SuperMicro X7DBE ACPI boot messages question
Date: Tue, 12 Jan 2010 21:17:51 -0800
Message-ID: <hijl1v$r49$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:33850 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482Ab0AMFUI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jan 2010 00:20:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NUveH-000134-Er
	for linux-acpi@vger.kernel.org; Wed, 13 Jan 2010 06:20:05 +0100
Received: from c-24-130-127-45.hsd1.ca.comcast.net ([24.130.127.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 13 Jan 2010 06:20:05 +0100
Received: from mike-acpilist by c-24-130-127-45.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Wed, 13 Jan 2010 06:20:05 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I have a Supermicro X7DBE system. When it boots, the kernel dmesg output 
gives me:

ACPI: DSDT cff60068 0445A (v01  Intel BLAKFORD 06040000 MSFT 03000001)
ACPI: FACS cff65fc0 00040
ACPI: APIC cff64536 000C8 (v01 PTLTD  ? APIC   06040000  LTP 00000000)
ACPI: MCFG cff645fe 0003C (v01 PTLTD    MCFG   06040000  LTP 00000000)


	The '? APIC' line confuses me and I don't know what this means nor do I 
see anywhere it is documented what it means. The machine does work, but 
I have an odd problem with virtualbox and it's own apic handling when 
running on this machine and I am trying to run down wether the above is 
an actual problem on the host, or if it's a red herring. Does anyone 
have an idea what this could actually mean?

Mike-

