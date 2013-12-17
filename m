From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 05/11] drivers: acpi: Include appropriate header file in
 utstate.c
Date: Tue, 17 Dec 2013 14:51:55 +0530
Message-ID: <c8f6f6fbcd7de593a726d091f5d0f6a245f6e0f7.1387271324.git.rashika.kheria@gmail.com>
References: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c676af6619fc5a84208740bfc7edcf56bb78ed4e.1387271324.git.rashika.kheria@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, josh@joshtriplett.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

Include appropriate header file acutils.h in acpica/utstate.c because
function acpi_ut_create_pkg_state_and_push() has its prototype declarat=
ion
in acutils.h. Also, encloses the function in acpica/utstate.c in ifdef
condition of ACPI_FUTURE_USAGE.

This eliminates the following warning in utstate.c:
drivers/acpi/acpica/utstate.c:64:1: warning: no previous prototype for =
=E2=80=98acpi_ut_create_pkg_state_and_push=E2=80=99 [-Wmissing-prototyp=
es]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/acpi/acpica/utstate.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/utstate.c b/drivers/acpi/acpica/utstat=
e.c
index 03c4c2f..0920d23 100644
--- a/drivers/acpi/acpica/utstate.c
+++ b/drivers/acpi/acpica/utstate.c
@@ -43,6 +43,7 @@
=20
 #include <acpi/acpi.h>
 #include "accommon.h"
+#include "acutils.h"
=20
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utstate")
@@ -60,6 +61,7 @@ ACPI_MODULE_NAME("utstate")
  * DESCRIPTION: Create a new state and push it
  *
  *********************************************************************=
*********/
+#ifdef  ACPI_FUTURE_USAGE
 acpi_status
 acpi_ut_create_pkg_state_and_push(void *internal_object,
 				  void *external_object,
@@ -79,6 +81,7 @@ acpi_ut_create_pkg_state_and_push(void *internal_obje=
ct,
 	acpi_ut_push_generic_state(state_list, state);
 	return (AE_OK);
 }
+#endif
=20
 /*********************************************************************=
**********
  *
--=20
1.7.9.5
