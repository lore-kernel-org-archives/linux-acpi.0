From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v3 3/4] resource: Export insert_resource and remove_resource
Date: Wed,  9 Mar 2016 12:47:05 -0700
Message-ID: <1457552826-13987-3-git-send-email-toshi.kani@hpe.com>
References: <1457552826-13987-1-git-send-email-toshi.kani@hpe.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457552826-13987-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org, bp@suse.de, dan.j.williams@intel.com, rjw@rjwysocki.net, akpm@linux-foundation.org
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

insert_resource() and remove_resouce() are called by producers
of resources, such as FW modules and bus drivers.  These modules
may be implemented as loadable modules.

Export insert_resource() and remove_resouce() so that they can
be called from such modules.

link: https://lkml.org/lkml/2016/3/8/872
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 kernel/resource.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/resource.c b/kernel/resource.c
index effb6ee..2e78ead 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -866,6 +866,7 @@ int insert_resource(struct resource *parent, struct resource *new)
 	conflict = insert_resource_conflict(parent, new);
 	return conflict ? -EBUSY : 0;
 }
+EXPORT_SYMBOL_GPL(insert_resource);
 
 /**
  * insert_resource_expand_to_fit - Insert a resource into the resource tree
@@ -925,6 +926,7 @@ int remove_resource(struct resource *old)
 	write_unlock(&resource_lock);
 	return retval;
 }
+EXPORT_SYMBOL_GPL(remove_resource);
 
 static int __adjust_resource(struct resource *res, resource_size_t start,
 				resource_size_t size)
