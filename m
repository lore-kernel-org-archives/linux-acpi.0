From: Valentin Priescu <valentin@rosedu.org>
Subject: ACPI SSDT tables
Date: Fri, 02 Mar 2012 13:44:09 +0100
Message-ID: <4F50C099.2060603@rosedu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45119 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757661Ab2CBMoO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Mar 2012 07:44:14 -0500
Received: by bkcik5 with SMTP id ik5so1418946bkc.19
        for <linux-acpi@vger.kernel.org>; Fri, 02 Mar 2012 04:44:13 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>

Hello,

I'm trying to get the processor P states from the ACPI driver but 
unfortunately the _PSS objects are not listed in the ACPI namespace. 
This is because some SSDT tables are not loaded. I checked the linux 
code and it seams that an SSDT table is loaded when a device is detected 
in a PCI slot, through PCI hotplug driver (it gets the SSDT header using 
SAL calls).
However, I'm working on a different kernel which doesn't have this 
feature(SAL) and I'm wondering if there is another way to get the 
address of SSDT tables for each CPU, so that I can load them into the 
ACPI namespace. Any idea is appreciated.

Best regards,
--
Valentin Priescu.
