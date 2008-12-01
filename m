From: Zhao Yakui <yakui.zhao@intel.com>
Subject: the issue about the bogus ECDT table
Date: Mon, 01 Dec 2008 16:12:57 +0800
Message-ID: <1228119177.4035.186.camel@yakui_zhao.sh.intel.com>
References: <1227689447.4053.5.camel@yakui_zhao.sh.intel.com>
	 <492DAB8B.30409@gmail.com>
	 <1227749343.4053.32.camel@yakui_zhao.sh.intel.com>
	 <492E6B70.9010006@suse.de>
	 <1227841044.4035.70.camel@yakui_zhao.sh.intel.com>
	 <492FA6F5.7070105@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26606 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbYLAIFi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Dec 2008 03:05:38 -0500
In-Reply-To: <492FA6F5.7070105@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

Hi, Alexey
    Now the patch in comment #20 of http://bugzilla.kernel.org/show_bug.cgi?id=11880 is
already added to Linux test tree.
    The laptops of bug 11880, 12116 can be fixed by the patch. In this patch if the ECDT Data 
I/O address is the same as the EC Command I/O address, the EC device will be parsed from
the DSDT table. Of course it is correct.
    In fact the root cause of this issue is that incorrect ECDT table is provided on the 
broken laptops. For example:
    The ECDT Command I/O data address is zero. (Incorrect)
    The ECDT Data I/O address is zero. (Incorrect)
    The GPE number is zero (Incorrect)
    The EC namepath is incorrect (Incorrect)
   
    At the same time there exists other bug about the bogus ECDT table. For example: Bug8709,
9399. On the two laptops of bug8709, 9399 the EC Command/Data IO address defined in ECDT table
is exchanged, which brings that EC can't work well in the upstream kernel. Now the problem 
still exists.
    
    Although the error of bug9399 is different with that in bug11880, they have the same issue
that the bogus ECDT table is provided. So the generic solution is that when there exists the ECDT
table OS still parses the EC device in DSDT table and compare it with that defined in ECDT table.
If they are different, the BIOS bug is reported and the device parsed in DSDT is initialized.
The following info will be compared.
    a. EC Data I/O address
    b. EC Command I/O address
    c. EC GPE number
  
   
   I use the KVM to verify this issue on windows. Windows still can work well even when bogus ECDT
table is defined. The EC GPE number is obtained from DSDT table and the I/O resource is obtained from
the DSDT table. The following types of bogus ECDT table are tested on windows:
    a. zero ECDT table (the info in ECDT table is all zero)
    b. exchanged EC data/command I/O address
    c. incorrect GPE number in ECDT table(the address is correct)
    d. incorrect EC I/O resource( The EC data I/O address is correct. But the EC command I/O address is
incorrect)

   At the same time there is another interesting issue on windows.(This is also done using KVM).
   There exists the _INI object under the scope of EC device. And the ECDT table is also provided(The ECDT table
is correct)
   On windows the EC _INI object is evaluated before the EC device is initialized. But On Linux the EC _INI 
object is evaluated after EC device is initialized.
   From the test it seems that the EC initial flowchart on Linux is different with that on windows. 
   
Thanks.
   
Best regards.
   yakui

    
   
    
   
    
    

