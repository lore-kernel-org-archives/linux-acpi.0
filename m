From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: acpi_memhotplug.c: don't allow to eject the memory device if it
 is being used
Date: Mon, 5 Nov 2012 21:11:33 +0300
Message-ID: <20121105181133.GA21846@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:32642 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061Ab2KESL7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Nov 2012 13:11:59 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: wency@cn.fujitsu.com
Cc: linux-acpi@vger.kernel.org

Hello Wen Congyang,

The patch 306859f13dc1: "acpi_memhotplug.c: don't allow to eject the
memory device if it is being used" from Nov 3, 2012, leads to the
following Smatch warning:
drivers/acpi/acpi_memhotplug.c:367 acpi_memory_remove_memory()
	 warn: inconsistent returns mutex:&mem_device->list_lock:
	locked (357,361) unlocked (367)

   341  static int acpi_memory_remove_memory(struct acpi_memory_device *mem_device)
   342  {
   343          int result;
   344          struct acpi_memory_info *info, *n;
   345  
   346          mutex_lock(&mem_device->list_lock);
   347          list_for_each_entry_safe(info, n, &mem_device->res_list, list) {
   348                  if (info->failed)
   349                          /* The kernel does not use this memory block */
   350                          continue;
   351  
   352                  if (!info->enabled)
   353                          /*
   354                           * The kernel uses this memory block, but it may be not
   355                           * managed by us.
   356                           */
   357                          return -EBUSY;
                                ^^^^^^^^^^^^^
   358  
   359                  result = remove_memory(info->start_addr, info->length);
   360                  if (result)
   361                          return result;
                                ^^^^^^^^^^^^^^
Unlock before returning?

   362                  list_del(&info->list);
   363                  kfree(info);
   364          }
   365          mutex_unlock(&mem_device->list_lock);
   366  
   367          return 0;
   368  }




regards,
dan carpenter

