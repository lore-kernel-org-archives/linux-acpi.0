From: Jeff Long <long@ku.edu>
Subject: DMI info
Date: Thu, 25 Sep 2008 16:37:30 -0500
Message-ID: <48DC049A.5020204@ku.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa-csf.nat.ku.edu ([129.237.28.4]:33578 "EHLO griffon.cc.ku.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752164AbYIYWUO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Sep 2008 18:20:14 -0400
Received: from griffon.cc.ku.edu (localhost.localdomain [127.0.0.1])
	by griffon.cc.ku.edu (8.14.2/8.14.2) with ESMTP id m8PLbU5j005114
	for <linux-acpi@vger.kernel.org>; Thu, 25 Sep 2008 16:37:31 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
	I booted a new kernel today and dmesg says:

ACPI: EC: Look up EC in DSDT
ACPI: BIOS _OSI(Linux) query ignored
ACPI: DMI System Vendor: Dell Inc.
ACPI: DMI Product Name: OptiPlex GX280
ACPI: DMI Product Version:
ACPI: DMI Board Name: 0FG114
ACPI: DMI BIOS Vendor: Dell Inc.
ACPI: DMI BIOS Date: 03/03/2006
ACPI: Please send DMI info above to linux-acpi@vger.kernel.org

So am sending as requested.  In case this helps at all:

[long@griffon cgi-bin]$ uname -a
Linux griffon 2.6.26.3-14.fc8 #1 SMP Wed Sep 3 03:40:05 EDT 2008 i686 
i686 i386 GNU/Linux
