From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 78/95] ACPICA: Namespace: remove address node from global list after method termination
Date: Tue,  7 May 2019 01:38:07 -0400
Message-ID: <20190507053826.31622-78-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Erik Schmauss <erik.schmauss@intel.com>, Michael J Gruber <mjg@fedoraproject.org>, Bob Moore <robert.moore@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sasha Levin <alexander.levin@microsoft.com>, linux-acpi@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

From: Erik Schmauss <erik.schmauss@intel.com>

[ Upstream commit c5781ffbbd4f742a58263458145fe7f0ac01d9e0 ]

ACPICA commit b233720031a480abd438f2e9c643080929d144c3

ASL operation_regions declare a range of addresses that it uses. In a
perfect world, the range of addresses should be used exclusively by
the AML interpreter. The OS can use this information to decide which
drivers to load so that the AML interpreter and device drivers use
different regions of memory.

During table load, the address information is added to a global
address range list. Each node in this list contains an address range
as well as a namespace node of the operation_region. This list is
deleted at ACPI shutdown.

Unfortunately, ASL operation_regions can be declared inside of control
methods. Although this is not recommended, modern firmware contains
such code. New module level code changes unintentionally removed the
functionality of adding and removing nodes to the global address
range list.

A few months ago, support for adding addresses has been re-
implemented. However, the removal of the address range list was
missed and resulted in some systems to crash due to the address list
containing bogus namespace nodes from operation_regions declared in
control methods. In order to fix the crash, this change removes
dynamic operation_regions after control method termination.

Link: https://github.com/acpica/acpica/commit/b2337200
Link: https://bugzilla.kernel.org/show_bug.cgi?id=202475
Fixes: 4abb951b73ff ("ACPICA: AML interpreter: add region addresses in global list during initialization")
Reported-by: Michael J Gruber <mjg@fedoraproject.org>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/acpica/nsobject.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index 707b2aa501e1..099be6424255 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -222,6 +222,10 @@ void acpi_ns_detach_object(struct acpi_namespace_node *node)
 		}
 	}
 
+	if (obj_desc->common.type == ACPI_TYPE_REGION) {
+		acpi_ut_remove_address_range(obj_desc->region.space_id, node);
+	}
+
 	/* Clear the Node entry in all cases */
 
 	node->object = NULL;
-- 
2.20.1
