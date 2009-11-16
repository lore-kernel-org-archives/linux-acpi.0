From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] acpi: get_bios_limit static inline when CPU_FREQ=n
Date: Mon, 16 Nov 2009 15:32:37 -0800
Message-ID: <20091116153237.95f2e42d.randy.dunlap@oracle.com>
References: <20091116181453.b42247cf.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20091116181453.b42247cf.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, lenb@kernel.org, akpm <akpm@linux-foundation.org>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

For CONFIG_CPU_FREQ=n, make acpi_processor_get_bios_limit()
static inline so that multiple source files that use this
header file do not create multiple definitions of the function.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 include/acpi/processor.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20091113.orig/include/acpi/processor.h
+++ linux-next-20091113/include/acpi/processor.h
@@ -318,7 +318,7 @@ static inline int acpi_processor_ppc_has
 	}
 	return 0;
 }
-int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
+static inline int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
 {
 	return -ENODEV;
 }
