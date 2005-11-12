From: keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: [RFC][PATCH]  patch to fix acpi_memhotplug.c for my hardware
Date: Fri, 11 Nov 2005 21:03:45 -0800
Message-ID: <1131771825.20603.44.camel@knk>
References: <1131399845.6313.73.camel@knk>  <1131677135.20603.22.camel@knk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-UjMqJi/aCWIR3SPBD0oS"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1131677135.20603.22.camel@knk>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: external hotplug mem list <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-UjMqJi/aCWIR3SPBD0oS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello All,
  I have troubles with the current acpi hotplug memory handler.
acpi_memory_get_device fails for me (acpi_bus_get_device fails) and the
whole things falls apart.  I think this may be related to the
comment  /* TBD: Support fixed-feature devices */ in acpi_get_bus but it
is unclear to me.  

  My event comes a notifiy with a acpi memory range attached.  It is a
single event.  My hardware does not work with the current driver.  

  The attached patch is a simple workaround for my hardware from 2.6.14-
git7.  This patch works for me.  It creates the mem_device for the data
attached from the present event.  It is provided to start the
conversation of how it is best to fix this issue.  


Signed-off-by: Keith Mannthey 


-- 
keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>


--=-UjMqJi/aCWIR3SPBD0oS
Content-Disposition: attachment; filename=acpi_memfix_v1.patch
Content-Type: text/x-patch; name=acpi_memfix_v1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.14-bootsreg/drivers/acpi/acpi_memhotplug.c	2005-11-03 17:58:21.000000000 -0800
+++ linux-2.6.14/drivers/acpi/acpi_memhotplug.c	2005-11-11 20:44:33.000000000 -0800
@@ -110,6 +110,21 @@
 	return_VALUE(0);
 }
 
+static struct acpi_memory_device* 
+get_mem_resource_fixup(acpi_handle handle){
+	struct acpi_memory_device *mem_tmp = NULL;
+	
+	printk ("called keiths fixup handler\n");
+	
+	mem_tmp= kmalloc(sizeof(struct acpi_memory_device), GFP_KERNEL);
+
+	memset(mem_tmp,0, sizeof(struct acpi_memory_device));
+	mem_tmp->handle = handle;
+	acpi_memory_get_device_resources(mem_tmp);
+	return mem_tmp;
+}
+
+
 static int
 acpi_memory_get_device(acpi_handle handle,
 		       struct acpi_memory_device **mem_device)
@@ -147,14 +159,15 @@
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error in acpi_bus_add\n"));
 		return_VALUE(-EINVAL);
 	}
-
       end:
 	*mem_device = acpi_driver_data(device);
+
 	if (!(*mem_device)) {
-		printk(KERN_ERR "\n driver data not found");
-		return_VALUE(-ENODEV);
+		/* ok this is where I end up..... 	
+		 * I am making my own memory_device
+		 */
+		*mem_device = get_mem_resource_fixup(handle);	
 	}
-
 	return_VALUE(0);
 }
 

--=-UjMqJi/aCWIR3SPBD0oS--



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
