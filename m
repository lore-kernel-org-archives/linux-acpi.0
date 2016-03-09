From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v3 1/4] resource: Change __request_region to inherit from immediate parent
Date: Wed,  9 Mar 2016 12:47:03 -0700
Message-ID: <1457552826-13987-1-git-send-email-toshi.kani@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:34074 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933900AbcCISye (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Mar 2016 13:54:34 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mingo@kernel.org, bp@suse.de, dan.j.williams@intel.com, rjw@rjwysocki.net, akpm@linux-foundation.org
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>

__request_region() sets 'flags' of a new resource from @parent
as it inherits the parent's attribute.  When a target resource
has a conflict, this function inserts the new resource entry
under the conflicted entry by updating @parent.  In this case,
the new resource entry needs to inherit attribute from the updated
parent.  This conflict is a typical case since __request_region()
is used to allocate a new resource from a specific resource range.

For instance, request_mem_region() calls __request_region() with
@parent set to &iomem_resource, which is the root entry of the
whole iomem range.  When this request results in inserting a new
entry "DEV-A" under "BUS-1", "DEV-A" needs to inherit from the
immediate parent "BUS-1" as it holds specific attribute for the
range.

root (&iomem_resource)
 :
 + "BUS-1"
    + "DEV-A"

Change __request_region() to set 'flags' and 'desc' of a new entry
from the immediate parent.

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 kernel/resource.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 4d46605..5a56e8f 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1085,15 +1085,16 @@ struct resource * __request_region(struct resource *parent,
 	res->name = name;
 	res->start = start;
 	res->end = start + n - 1;
-	res->flags = resource_type(parent) | resource_ext_type(parent);
-	res->flags |= IORESOURCE_BUSY | flags;
-	res->desc = IORES_DESC_NONE;
 
 	write_lock(&resource_lock);
 
 	for (;;) {
 		struct resource *conflict;
 
+		res->flags = resource_type(parent) | resource_ext_type(parent);
+		res->flags |= IORESOURCE_BUSY | flags;
+		res->desc = parent->desc;
+
 		conflict = __request_resource(parent, res);
 		if (!conflict)
 			break;
