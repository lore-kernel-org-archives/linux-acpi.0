From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/5] ia64 ioremap, DMI, EFI system table
Date: Thu, 19 Jan 2006 13:10:57 -0700
Message-ID: <200601191310.57303.bjorn.helgaas@hp.com>
References: <20060104221627.GA26064@lists.us.dell.com> <200601181029.46352.bjorn.helgaas@hp.com> <20060118181116.GA5537@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-admin@lists.sourceforge.net>
In-Reply-To: <20060118181116.GA5537@lists.us.dell.com>
Content-Disposition: inline
Sender: openipmi-developer-admin@lists.sourceforge.net
Errors-To: openipmi-developer-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openipmi-developer>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-ia64@vger.kernel.org, ak@suse.de, openipmi-developer@lists.sourceforge.net, akpm@osdl.org, "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

OK, here's a set of patches to (hopefully) clean up this area
a bit:

1  Simplify efi_mem_attribute_range() so I can use it both for
   /dev/mem validation and ioremap() attribute checking.

2  Make ia64 ioremap() check memory attributes, so it works for
   plain memory that only supports write-back access, as well as
   for MMIO space that only supports uncacheable access.

3  DMI ioremaps too much space, which makes it fail on machines
   where the SMBIOS table is near the end of a memory region.

4  Keep EFI table addresses as physical, not virtual.  The SMBIOS
   address was physical on x86 but virtual on ia64, which broke
   dmi_scan_machine().

5  Use smarter ioremap() implementation to remove some cruft in
   acpi_os_{read,write,map}_memory().  This one's just an optional
   cleanup; I don't think it fixes any bugs.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
