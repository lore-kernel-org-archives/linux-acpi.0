From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [RFC] [Patch 0/2]  ACPI :two EC patches for Asus broken laptops
Date: Mon, 17 Nov 2008 14:48:49 +0800
Message-ID: <1226904529.4062.21.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5456 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502AbYKQGkl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Nov 2008 01:40:41 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, astarikovskiy@suse.de

Hi, All
 
    On some Asus laptops there exists the ECDT table. But unfortunately the info in 
ECDT table is incorrect. 
    For example: 
	On the laptops of bug 9399, 
		the incorrect Command/Status I/O Port
		Incorrect Data I/O port	
        On the laptops of bug 11880
		All the info in ECDT table is incorrect.(GPE number, EC namepath,
		Data I/O address, Command/Status I/O address)
    
    The following is the patch set that is to fix the above issue.
    Patch 01: compare EC device in DSDT table with that in ECDT table
           When ECDT table exists, the EC device parsed from DSDT table will be compared
with that in ECDT table. When they mismatch, the BIOS bug will be reported and the EC device
in DSDT table is initialized instead of that in ECDT table. 
    Patch 02: Delete the unused DMI check for Asus broken laptops
           After the patch 1 is shipped, the DMI check for Asus broken laptops are useless. So
the unused the DMI check is deleted.
    

Welcome the comments.


Best regards.
  Yakui


