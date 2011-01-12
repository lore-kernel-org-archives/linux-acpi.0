From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] x86/e820: fix build when ACPI is disabled
Date: Wed, 12 Jan 2011 12:20:14 -0800
Message-ID: <20110112122014.2d8455d7.randy.dunlap@oracle.com>
References: <20110112141822.c29314c4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20110112141822.c29314c4.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix build error when CONFIG_ACPI is not enabled:

arch/x86/kernel/e820.c:734: error:implicit declaration of function 'suspend_nvs_register'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 include/linux/acpi.h |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-next-20110112.orig/include/linux/acpi.h
+++ linux-next-20110112/include/linux/acpi.h
@@ -360,5 +360,10 @@ static inline int acpi_table_parse(char 
 {
 	return -1;
 }
+
+static inline int suspend_nvs_register(unsigned long a, unsigned long b)
+{
+	return 0;
+}
 #endif	/* !CONFIG_ACPI */
 #endif	/*_LINUX_ACPI_H*/
