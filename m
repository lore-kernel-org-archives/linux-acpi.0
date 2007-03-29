From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 1/5] ACPI: ibm-acpi: rename driver to
	thinkpad-acpi
Date: Thu, 29 Mar 2007 01:58:40 -0300
Message-ID: <11751443241622-git-send-email-hmh@hmh.eng.br>
References: <11751443243976-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11751443243976-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Rename the ibm-acpi driver to thinkpad-acpi.  ThinkPads are not even made
by IBM anymore, so it is high time to rename the driver...

The name thinkpad-acpi was used sometime ago by a thinkpad-specific hotkey
driver by Erik Rigtorp, around the 2.6.8-2.6.10 time frame.  The driver
apparently never got merged into mainline (it did make some trips through
-mm).  ibm-acpi was merged soon after, making its debut in 2.6.10.

The reuse of the thinkpad-acpi name shouldn't be a problem as far as user
confusion goes, as Erik's thinkpad-acpi apparently didn't get widespread
use in the Linux ThinkPad community and most hits for thinkpad-acpi in
google point to ibm-acpi anyway.

Erik, if you read this, please consider the reuse of the thinkpad-acpi name
as a compliment to your effort to make ThinkPads more useful to all of us.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/{ibm-acpi.txt => thinkpad-acpi.txt} |    0 
 drivers/misc/Makefile                             |    2 +-
 drivers/misc/{ibm_acpi.c => thinkpad_acpi.c}      |    2 +-
 drivers/misc/{ibm_acpi.h => thinkpad_acpi.h}      |    0 
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/{ibm-acpi.txt => thinkpad-acpi.txt} (100%)
 rename drivers/misc/{ibm_acpi.c => thinkpad_acpi.c} (100%)
 rename drivers/misc/{ibm_acpi.h => thinkpad_acpi.h} (100%)

diff --git a/Documentation/ibm-acpi.txt b/Documentation/thinkpad-acpi.txt
similarity index 100%
rename from Documentation/ibm-acpi.txt
rename to Documentation/thinkpad-acpi.txt
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 848b398..ebf4ff2 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -12,4 +12,4 @@ obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
 obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
 obj-$(CONFIG_SGI_IOC4)		+= ioc4.o
 obj-$(CONFIG_SONY_LAPTOP)	+= sony-laptop.o
-obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
+obj-$(CONFIG_ACPI_IBM)		+= thinkpad_acpi.o
diff --git a/drivers/misc/ibm_acpi.c b/drivers/misc/thinkpad_acpi.c
similarity index 100%
rename from drivers/misc/ibm_acpi.c
rename to drivers/misc/thinkpad_acpi.c
index ae03b8f..2836516 100644
--- a/drivers/misc/ibm_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -79,7 +79,7 @@
  *  2004-08-09	0.1	initial release, support for X series
  */
 
-#include "ibm_acpi.h"
+#include "thinkpad_acpi.h"
 
 MODULE_AUTHOR("Borislav Deianov, Henrique de Moraes Holschuh");
 MODULE_DESCRIPTION(IBM_DESC);
diff --git a/drivers/misc/ibm_acpi.h b/drivers/misc/thinkpad_acpi.h
similarity index 100%
rename from drivers/misc/ibm_acpi.h
rename to drivers/misc/thinkpad_acpi.h
-- 
1.5.0.3


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
