From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 17/20] ACPI: thinkpad-acpi: silence _sta
	warning
Date: Tue,  8 Jan 2008 13:02:54 -0200
Message-ID: <1199804577-32017-18-git-send-email-hmh@hmh.eng.br>
References: <1199804577-32017-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1199804577-32017-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Pritt Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

When both CONFIG_THINKPAD_ACPI_DOCK and CONFIG_THINKPAD_ACPI_BAY are
undefined, _sta is not used and that causes a gcc warning.  Fix it
(and I think this is a regression, I am pretty sure I fixed this once
before, sorry about that).

Issue reported by: Pritt Laes.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Pritt Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 049ec42..e18f1e1 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -414,6 +414,7 @@ static int acpi_ec_write(int i, u8 v)
 	return 1;
 }
 
+#if defined(CONFIG_THINKPAD_ACPI_DOCK) || defined(CONFIG_THINKPAD_ACPI_BAY)
 static int _sta(acpi_handle handle)
 {
 	int status;
@@ -423,6 +424,7 @@ static int _sta(acpi_handle handle)
 
 	return status;
 }
+#endif
 
 static int issue_thinkpad_cmos_command(int cmos_cmd)
 {
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
