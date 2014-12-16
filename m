From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH 2/4] ACPICA: don't release ACPI_MTX_TABLES in acpi_tb_install_standard_table
Date: Tue, 16 Dec 2014 18:12:31 +0200
Message-ID: <1418746353-3481-3-git-send-email-octavian.purdila@intel.com>
References: <1418746353-3481-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418746353-3481-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, lee.jones@linaro.org, rjw@rjwysocki.net
Cc: johan@kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, heikki.krogerus@intel.com, mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPI_MTX_TABLES is taken and released by the callers of
acpi_tb_install_standard_table so releasing it in the function itself
is causing the following error if the table is reloaded:

ACPI Error: Mutex [0x2] is not acquired, cannot release (20141107/utmutex-321)
Call Trace:
  [<ffffffff81b0bd48>] dump_stack+0x4f/0x7b
  [<ffffffff81546bf5>] acpi_ut_release_mutex+0x47/0x67
  [<ffffffff81544357>] acpi_load_table+0x73/0xcb

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/acpi/acpica/tbinstal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 755b90c..c0b39f3 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -346,7 +346,6 @@ acpi_tb_install_standard_table(acpi_physical_address address,
 				 */
 				acpi_tb_uninstall_table(&new_table_desc);
 				*table_index = i;
-				(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 				return_ACPI_STATUS(AE_OK);
 			}
 		}
-- 
1.9.1
