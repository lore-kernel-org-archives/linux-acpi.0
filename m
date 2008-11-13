From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: ACPICA Release 20081031 linuxized patch set
Date: Thu, 13 Nov 2008 15:13:30 +0800
Message-ID: <1226560410.30025.175.camel@minggr.sh.intel.com>
References: <1226555956.30025.150.camel@minggr.sh.intel.com>
	 <1226556783.30025.154.camel@minggr.sh.intel.com>
	 <alpine.LFD.2.00.0811130147180.21141@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59652 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbYKMHPN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Nov 2008 02:15:13 -0500
In-Reply-To: <alpine.LFD.2.00.0811130147180.21141@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, acpi <acpi@linux.intel.com>

On Thu, 2008-11-13 at 14:54 +0800, Len Brown wrote:
> 
> > [PATCH 01/18] ACPICA: Fix several warnings under gcc 4 compiler
> > [PATCH 02/18] ACPICA: Update FACS waking vector interfaces
> > [PATCH 03/18] ACPICA: Fix possible memory leak on error in parser
> > [PATCH 04/18] ACPICA: Optimize execution of AML While loops
> > [PATCH 05/18] ACPICA: Add a mechanism to escape infinite AML While() loops
> > [PATCH 06/18] ACPICA: Update debug output for IndexField I/O
> > [PATCH 07/18] ACPICA: Fix namestring for the SystemCMOS address space
> > [PATCH 08/18] ACPICA: Emit warning if two FACS or DSDT tables found in the FADT
> > [PATCH 09/18] ACPICA: Add global pointer for FACS table to simplify FACS access
> > [PATCH 10/18] ACPICA: Reformat comments, no functional changes
> > [PATCH 11/18] ACPICA: Add support to externally execute _OSI method
> > [PATCH 12/18] ACPICA: Remove references to obsolete ACPI_DUMP_APP
> > [PATCH 13/18] ACPICA: Fix to allow aliases within ASL namepaths
> > [PATCH 14/18] ACPICA: Allow multiple backslash prefix in namepaths
> > [PATCH 15/18] ACPICA: Allow _WAK method to return an Integer
> > [PATCH 16/18] ACPICA: Add Buffer->String conversion for predefined methods
> > [PATCH 17/18] ACPICA: Consolidate method arg count validation code
> > [PATCH 18/18] ACPICA: Enhance implicit return mechanism
> 
> checkpatch.pl wasn't happy about the 80 column errors, or
> the unnecessary {}'s in statements like this:
> 
> if (foo) {
> 	bar;
> 	}
> 
> I think the construct above is actually good programming practice
> when the simple statement is a macro.  However, if it really is
> a simple statment, such as return, I agree with checkpatch.pl.
> 
> re: 80 colmns
> I usually let them go if it makes the code easier to read.
> howver, block comments w/ sufficient width really should
> not need to violate the 80 column limit.
> 
> no, i don't advocate you fix these things in the acpica->linux
> translation process; as we want to make that as automated
> as possible and fixing style things by hand only makes it harder later.
> 
> but more importantly it looks like we have a double free:

I didn't find these warnings in my cantiga box.
Would you please attach your .config file?

Lin Ming

> 
> ACPI Warning (utdelete-0420): Large Reference Count (6B6B) in object 
> ffff88007c991b58 [20080926]
> ACPI Warning (utdelete-0420): Large Reference Count (6B6B) in object 
> ffff88007c991df8 [20080926]
> ACPI Warning (utdelete-0420): Large Reference Count (6B6C) in object 
> ffff88007c991b58 [20080926]
> ACPI Warning (utdelete-0420): Large Reference Count (6B6C) in object 
> ffff88007c991df8 [20080926]
> Slab corruption: Acpi-Operand start=ffff88007c991b58, len=72
> Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
> Last user: [<ffffffff80390463>](acpi_os_release_object+0x9/0xd)
> 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6d 6b 6b 6b 6b 6b
> Prev obj: start=ffff88007c991af8, len=72
> Redzone: 0xd84156c5635688c0/0xd84156c5635688c0.
> Last user: 
> [<ffffffff803b0174>](acpi_ut_allocate_object_desc_dbg+0x3c/0xb3)
> 000: 00 00 00 00 00 00 00 00 0e 03 01 00 04 00 00 00
> 010: 78 83 17 7b 00 88 ff ff 06 00 00 00 00 00 00 00
> Next obj: start=ffff88007c991bb8, len=72
> Redzone: 0xd84156c5635688c0/0xd84156c5635688c0.
> Last user: 
> [<ffffffff803b0174>](acpi_ut_allocate_object_desc_dbg+0x3c/0xb3)
> 000: 00 00 00 00 00 00 00 00 0e 01 03 00 00 00 00 00
> 010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Slab corruption: Acpi-Operand start=ffff88007c991df8, len=72
> Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
> Last user: [<ffffffff80390463>](acpi_os_release_object+0x9/0xd)
> 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6d 6b 6b 6b 6b 6b
> Prev obj: start=ffff88007c991d98, len=72
> Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
> Last user: [<ffffffff80390463>](acpi_os_release_object+0x9/0xd)
> 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Next obj: start=ffff88007c991e58, len=72
> Redzone: 0x9f911029d74e35b/0x9f911029d74e35b.
> Last user: [<0000000000000000>](0x0)
> 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> ACPI Warning (utdelete-0420): Large Reference Count (6B6B) in object 
> ffff88007c991b58 [20080926]
> ACPI Warning (utdelete-0420): Large Reference Count (6B6B) in object 
> ffff88007c991df8 [20080926]
> ACPI Warning (utdelete-0420): Large Reference Count (6B6A) in object 
> ffff88007c991b58 [20080926]
> ACPI Warning (utdelete-0420): Large Reference Count (6B6A) in object 
> ffff88007c991df8 [20080926]
> ACPI Warning (utdelete-0420): Large Reference Count (6B6B) in object 
> ffff88007c991b58 [20080926]
> ACPI Warning (utdelete-0420): Large Reference Count (6B6B) in object 
> ffff88007c991df8 [20080926]
> 

