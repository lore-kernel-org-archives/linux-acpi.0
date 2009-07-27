From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 6/12] drivers/platform/x86: Correct redundant test
Date: Mon, 27 Jul 2009 18:14:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0907271813490.2682@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753273AbZG0QTe@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jwoithe@physics.adelaide.edu.au, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

device and acpi_driver_data(device) were tested just a few lines above.

A simplified version of the semantic match that finds this problem is as
follows: (http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@r exists@
local idexpression x;
expression E;
@@

if (x == NULL || ...) { ... when forall
   return ...; }
... when != \(x=E\|x--\|x++\|--x\|++x\|x-=E\|x+=E\|x|=E\|x&=E\|&x\)
(
*x == NULL
|
*x != NULL
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/platform/x86/fujitsu-laptop.c          |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 218b9a1..5306901 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -745,9 +745,6 @@ static int acpi_fujitsu_remove(struct acpi_device *device, int type)
 
 	fujitsu = acpi_driver_data(device);
 
-	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
-
 	fujitsu->acpi_handle = NULL;
 
 	return 0;
