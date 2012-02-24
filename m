From: "Jan Beulich" <JBeulich@suse.com>
Subject: ACPI: consistently use should_use_kmap()
Date: Fri, 24 Feb 2012 11:41:53 +0000
Message-ID: <4F47859102000078000749F4@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:34079 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab2BXLl4 convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:3:1>);
	Fri, 24 Feb 2012 06:41:56 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: myron.stowe@redhat.com, linux-acpi@vger.kernel.org

... so that acpi_unmap()'s behavior gets in sync with acpi_map()'s.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: Myron Stowe <myron.stowe@redhat.com>

---
 drivers/acpi/osl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 3.3-rc4/drivers/acpi/osl.c
+++ 3.3-rc4-acpi-use-should_use_kmap/drivers/acpi/osl.c
@@ -347,7 +347,7 @@ static void acpi_unmap(acpi_physical_add
 	unsigned long pfn;
 
 	pfn = pg_off >> PAGE_SHIFT;
-	if (page_is_ram(pfn))
+	if (should_use_kmap(pfn))
 		kunmap(pfn_to_page(pfn));
 	else
 		iounmap(vaddr);



