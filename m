From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH 21/31] drivers/power: Make static
Date: Tue, 09 Dec 2008 22:41:07 +0100
Message-ID: <493EE5F3.8090002@gmail.com>
References: <493EA286.7080500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755297AbYLIVlj@vger.kernel.org>
In-Reply-To: <493EA286.7080500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: astarikovskiy@suse.de
Cc: linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Sparse asked whether these could be static.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 drivers/power/olpc_battery.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/power/olpc_battery.c b/drivers/power/olpc_battery.c
index 5fbca26..a9fd570 100644
--- a/drivers/power/olpc_battery.c
+++ b/drivers/power/olpc_battery.c
@@ -379,7 +379,7 @@ static struct power_supply olpc_bat = {
 	.use_for_apm = 1,
 };
 
-void olpc_battery_trigger_uevent(unsigned long cause)
+static void olpc_battery_trigger_uevent(unsigned long cause)
 {
 	if (cause & EC_SCI_SRC_ACPWR)
 		kobject_uevent(&olpc_ac.dev->kobj, KOBJ_CHANGE);
