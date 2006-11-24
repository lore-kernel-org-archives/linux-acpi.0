From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH] ACPI: ibm-acpi: do not use / in driver
	names
Date: Fri, 24 Nov 2006 12:37:56 -0200
Message-ID: <20061124143756.GD2287@khazad-dum.debian.net>
References: <1158916460.11985.45.camel@localhost.localdomain>
	<200611222307.26536.len.brown@intel.com>
	<1164257655.5461.96.camel@localhost.localdomain>
	<200611232338.06895.len.brown@intel.com>
	<1164348080.5768.32.camel@localhost.localdomain>
	<20061124110701.GA2287@khazad-dum.debian.net>
	<20061124143349.GC2287@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20061124143349.GC2287-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-acpi@vger" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

ACPI: ibm-acpi: do not use / in driver names

ibm-acpi uses sub-device names like ibm/hotkey, which get in the way of
a sysfs conversion.  Fix it to use ibm_hotkey instead.  Thanks to Zhang
Rui for noticing this.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---

 drivers/acpi/ibm_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 9658253..9baae34 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1854,7 +1854,7 @@ static int __init register_driver(struct
 	}
 
 	memset(ibm->driver, 0, sizeof(struct acpi_driver));
-	sprintf(ibm->driver->name, "%s/%s", IBM_NAME, ibm->name);
+	sprintf(ibm->driver->name, "%s_%s", IBM_NAME, ibm->name);
 	ibm->driver->ids = ibm->hid;
 	ibm->driver->ops.add = &ibm_device_add;
 
-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
