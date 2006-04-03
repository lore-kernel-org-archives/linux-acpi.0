From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [patch 22/26] acpi memory hotplug cannot manage _CRS with
 plural resoureces
Date: Mon, 3 Apr 2006 09:26:48 +0900
Message-ID: <20060403092648.1b6932f5.kamezawa.hiroyu@jp.fujitsu.com>
References: <CFF307C98FEABE47A452B27C06B85BB6123DDB@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:10185 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932147AbWDCAZG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 2 Apr 2006 20:25:06 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6123DDB@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com

On Sat, 1 Apr 2006 22:38:09 -0500
"Brown, Len" <len.brown@intel.com> wrote:

> KAMEZAWA,
> 
> please udpate to use kmalloc/kfree directly instead
> of acpi_os_allocate/acpi_os_free.  The later are
> intended only for inside the core (and have already been
> delted by another patch in the works:-)
> 
> thanks,
> -Len 

Hi,
This is update. (against 2.6.16-mm2)

BTW, For freeing buffer.pointer (returned by acpi_get_object_info etc.),
should I also use kfree() ?

-Kame
===
change acpi_os_alloc to kmalloc/kfree

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-mm2/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.16-mm2.orig/drivers/acpi/acpi_memhotplug.c
+++ linux-2.6.16-mm2/drivers/acpi/acpi_memhotplug.c
@@ -108,11 +108,10 @@ acpi_memory_get_resource(struct acpi_res
 		}
 	}
 
-	new = acpi_os_allocate(sizeof(struct acpi_memory_info));
+	new = kzalloc(sizeof(struct acpi_memory_info), GFP_KERNEL);
 	if (!new)
 		return AE_ERROR;
 
-	memset(new, 0, sizeof(*new));
 	INIT_LIST_HEAD(&new->list);
 	new->caching = address64.info.mem.caching;
 	new->write_protect = address64.info.mem.write_protect;
@@ -136,7 +135,7 @@ acpi_memory_get_device_resources(struct 
 				     acpi_memory_get_resource, mem_device);
 	if (ACPI_FAILURE(status)) {
 		list_for_each_entry_safe(info, n, &mem_device->res_list, list)
-			acpi_os_free(info);
+			kfree(info);
 		return_VALUE(-EINVAL);
 	}
 
@@ -313,7 +312,7 @@ static int acpi_memory_disable_device(st
 			if (result)
 				return_VALUE(result);
 		}
-		acpi_os_free(info);
+		kfree(info);
 	}
 
 	/* Power-off and eject the device */

