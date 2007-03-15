From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH] ACPI: ibm-acpi: allow module to load when
	acpi notifiers can't be set (v2)
Date: Thu, 15 Mar 2007 16:15:06 -0300
Message-ID: <20070315191506.GA14394@khazad-dum.debian.net>
References: <20070315071019.GA22613@tuatara.stupidest.org>
	<20070315175113.GA6596@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070315175113.GA6596-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Chris Wedgwood <cw-LC2/xnR6T6k@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This patch allows for ibm-acpi to coexist (with diminished functionality) with
other drivers like ACPI_BAY.  ibm-acpi will simply disable the functions it is
not able to register ACPI notifiers for.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Chris Wedgwood <cw-LC2/xnR6T6k@public.gmane.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

 There was a minor problem in the first version of the patch, which I didn't
 notice when backporting from acpi-test.  This is a fixed version.  Sorry
 about this.

 Len, you can pull this patch from:
 git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
 branch for-upstream/acpi-release
 
 Please send it to Linus for merge in 2.6.21.
 
 It will clash with the patches in acpi-test that are waiting for 2.6.22.
 I will rediff those, and send you a pull request when this patch
 gets accepted in mainline.

 drivers/acpi/ibm_acpi.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 3690136..dc10966 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -2507,7 +2507,7 @@ static int __init setup_notify(struct ibm_struct *ibm)
 	ret = acpi_bus_get_device(*ibm->handle, &ibm->device);
 	if (ret < 0) {
 		printk(IBM_ERR "%s device not present\n", ibm->name);
-		return 0;
+		return -ENODEV;
 	}
 
 	acpi_driver_data(ibm->device) = ibm;
@@ -2516,8 +2516,13 @@ static int __init setup_notify(struct ibm_struct *ibm)
 	status = acpi_install_notify_handler(*ibm->handle, ibm->type,
 					     dispatch_notify, ibm);
 	if (ACPI_FAILURE(status)) {
-		printk(IBM_ERR "acpi_install_notify_handler(%s) failed: %d\n",
-		       ibm->name, status);
+		if (status == AE_ALREADY_EXISTS) {
+			printk(IBM_NOTICE "another device driver is already handling %s events\n",
+				ibm->name);
+		} else {
+			printk(IBM_ERR "acpi_install_notify_handler(%s) failed: %d\n",
+				ibm->name, status);
+		}
 		return -ENODEV;
 	}
 	ibm->notify_installed = 1;
@@ -2553,6 +2558,8 @@ static int __init register_driver(struct ibm_struct *ibm)
 	return ret;
 }
 
+static void ibm_exit(struct ibm_struct *ibm);
+
 static int __init ibm_init(struct ibm_struct *ibm)
 {
 	int ret;
@@ -2594,6 +2601,12 @@ static int __init ibm_init(struct ibm_struct *ibm)
 
 	if (ibm->notify) {
 		ret = setup_notify(ibm);
+		if (ret == -ENODEV) {
+			printk(IBM_NOTICE "disabling subdriver %s\n",
+				ibm->name);
+			ibm_exit(ibm);
+			return 0;
+		}
 		if (ret < 0)
 			return ret;
 	}
-- 
1.5.0.3

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
