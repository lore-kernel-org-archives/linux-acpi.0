From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH] ACPI: ibm_acpi: allow clean removal
Date: Mon, 18 Dec 2006 14:53:33 -0300
Message-ID: <20061218175332.8826.95334.stgit@thorin.khazad-dum.debian.net>
References: <20061218175207.8826.25057.stgit@thorin.khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20061218175207.8826.25057.stgit-H32KNTuDSMjdPi8JTuvWk31TOOPCyuNQ5NbjCUgZEJk@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Alexey Starikovskiy <alexey_y_starikovskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Allow clean removal by setting notify_installed in the right place.

Alexey Starikovskiy <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

 drivers/acpi/ibm_acpi.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 003a987..719a320 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1805,7 +1805,7 @@ static int __init setup_notify(struct ibm_struct *ibm)
 		       ibm->name, status);
 		return -ENODEV;
 	}
-
+	ibm->notify_installed = 1;
 	return 0;
 }
 
@@ -1882,7 +1882,6 @@ static int __init ibm_init(struct ibm_struct *ibm)
 		ret = setup_notify(ibm);
 		if (ret < 0)
 			return ret;
-		ibm->notify_installed = 1;
 	}
 
 	return 0;


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
