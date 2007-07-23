From: helgaas@ldl.fc.hp.com
Subject: [patch 04/17] PNP: Lindent interface.c
Date: Mon, 23 Jul 2007 15:28:01 -0600
Message-ID: <20070723213241.146605860@ldl.fc.hp.com>
References: <20070723212757.122218147@ldl.fc.hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:52730 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756324AbXGWVdJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 17:33:09 -0400
Content-Disposition: inline; filename=pnp-format-interface
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

Run through Lindent, no functional change.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work2/drivers/pnp/interface.c
===================================================================
--- work2.orig/drivers/pnp/interface.c	2007-07-20 15:42:09.000000000 -0600
+++ work2/drivers/pnp/interface.c	2007-07-20 15:42:58.000000000 -0600
@@ -3,7 +3,6 @@
  *
  * Some code, especially possible resource dumping is based on isapnp_proc.c (c) Jaroslav Kysela <perex@suse.cz>
  * Copyright 2002 Adam Belay <ambx1@neo.rr.com>
- *
  */
 
 #include <linux/pnp.h>
@@ -29,7 +28,7 @@
 
 typedef struct pnp_info_buffer pnp_info_buffer_t;
 
-static int pnp_printf(pnp_info_buffer_t * buffer, char *fmt,...)
+static int pnp_printf(pnp_info_buffer_t * buffer, char *fmt, ...)
 {
 	va_list args;
 	int res;
@@ -48,14 +47,18 @@
 	return res;
 }
 
-static void pnp_print_port(pnp_info_buffer_t *buffer, char *space, struct pnp_port *port)
+static void pnp_print_port(pnp_info_buffer_t * buffer, char *space,
+			   struct pnp_port *port)
 {
-	pnp_printf(buffer, "%sport 0x%x-0x%x, align 0x%x, size 0x%x, %i-bit address decoding\n",
-			space, port->min, port->max, port->align ? (port->align-1) : 0, port->size,
-			port->flags & PNP_PORT_FLAG_16BITADDR ? 16 : 10);
+	pnp_printf(buffer,
+		   "%sport 0x%x-0x%x, align 0x%x, size 0x%x, %i-bit address decoding\n",
+		   space, port->min, port->max,
+		   port->align ? (port->align - 1) : 0, port->size,
+		   port->flags & PNP_PORT_FLAG_16BITADDR ? 16 : 10);
 }
 
-static void pnp_print_irq(pnp_info_buffer_t *buffer, char *space, struct pnp_irq *irq)
+static void pnp_print_irq(pnp_info_buffer_t * buffer, char *space,
+			  struct pnp_irq *irq)
 {
 	int first = 1, i;
 
@@ -85,14 +88,15 @@
 	pnp_printf(buffer, "\n");
 }
 
-static void pnp_print_dma(pnp_info_buffer_t *buffer, char *space, struct pnp_dma *dma)
+static void pnp_print_dma(pnp_info_buffer_t * buffer, char *space,
+			  struct pnp_dma *dma)
 {
 	int first = 1, i;
 	char *s;
 
 	pnp_printf(buffer, "%sdma ", space);
 	for (i = 0; i < 8; i++)
-		if (dma->map & (1<<i)) {
+		if (dma->map & (1 << i)) {
 			if (!first) {
 				pnp_printf(buffer, ",");
 			} else {
@@ -136,12 +140,13 @@
 	pnp_printf(buffer, " %s\n", s);
 }
 
-static void pnp_print_mem(pnp_info_buffer_t *buffer, char *space, struct pnp_mem *mem)
+static void pnp_print_mem(pnp_info_buffer_t * buffer, char *space,
+			  struct pnp_mem *mem)
 {
 	char *s;
 
 	pnp_printf(buffer, "%sMemory 0x%x-0x%x, align 0x%x, size 0x%x",
-			space, mem->min, mem->max, mem->align, mem->size);
+		   space, mem->min, mem->max, mem->align, mem->size);
 	if (mem->flags & IORESOURCE_MEM_WRITEABLE)
 		pnp_printf(buffer, ", writeable");
 	if (mem->flags & IORESOURCE_MEM_CACHEABLE)
@@ -168,7 +173,7 @@
 	pnp_printf(buffer, ", %s\n", s);
 }
 
-static void pnp_print_option(pnp_info_buffer_t *buffer, char *space,
+static void pnp_print_option(pnp_info_buffer_t * buffer, char *space,
 			     struct pnp_option *option, int dep)
 {
 	char *s;
@@ -179,19 +184,19 @@
 
 	if (dep) {
 		switch (option->priority) {
-			case PNP_RES_PRIORITY_PREFERRED:
+		case PNP_RES_PRIORITY_PREFERRED:
 			s = "preferred";
 			break;
-			case PNP_RES_PRIORITY_ACCEPTABLE:
+		case PNP_RES_PRIORITY_ACCEPTABLE:
 			s = "acceptable";
 			break;
-			case PNP_RES_PRIORITY_FUNCTIONAL:
+		case PNP_RES_PRIORITY_FUNCTIONAL:
 			s = "functional";
 			break;
-			default:
+		default:
 			s = "invalid";
 		}
-		pnp_printf(buffer, "Dependent: %02i - Priority %s\n",dep, s);
+		pnp_printf(buffer, "Dependent: %02i - Priority %s\n", dep, s);
 	}
 
 	for (port = option->port; port; port = port->next)
@@ -204,16 +209,16 @@
 		pnp_print_mem(buffer, space, mem);
 }
 
-
-static ssize_t pnp_show_options(struct device *dmdev, struct device_attribute *attr, char *buf)
+static ssize_t pnp_show_options(struct device *dmdev,
+				struct device_attribute *attr, char *buf)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
-	struct pnp_option * independent = dev->independent;
-	struct pnp_option * dependent = dev->dependent;
+	struct pnp_option *independent = dev->independent;
+	struct pnp_option *dependent = dev->dependent;
 	int ret, dep = 1;
 
 	pnp_info_buffer_t *buffer = (pnp_info_buffer_t *)
-				 pnp_alloc(sizeof(pnp_info_buffer_t));
+	    pnp_alloc(sizeof(pnp_info_buffer_t));
 	if (!buffer)
 		return -ENOMEM;
 
@@ -223,7 +228,7 @@
 	if (independent)
 		pnp_print_option(buffer, "", independent, 0);
 
-	while (dependent){
+	while (dependent) {
 		pnp_print_option(buffer, "   ", dependent, dep);
 		dependent = dependent->next;
 		dep++;
@@ -233,10 +238,11 @@
 	return ret;
 }
 
-static DEVICE_ATTR(options,S_IRUGO,pnp_show_options,NULL);
-
+static DEVICE_ATTR(options, S_IRUGO, pnp_show_options, NULL);
 
-static ssize_t pnp_show_current_resources(struct device *dmdev, struct device_attribute *attr, char *buf)
+static ssize_t pnp_show_current_resources(struct device *dmdev,
+					  struct device_attribute *attr,
+					  char *buf)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
 	int i, ret;
@@ -252,52 +258,56 @@
 	buffer->buffer = buf;
 	buffer->curr = buffer->buffer;
 
-	pnp_printf(buffer,"state = ");
+	pnp_printf(buffer, "state = ");
 	if (dev->active)
-		pnp_printf(buffer,"active\n");
+		pnp_printf(buffer, "active\n");
 	else
-		pnp_printf(buffer,"disabled\n");
+		pnp_printf(buffer, "disabled\n");
 
 	for (i = 0; i < PNP_MAX_PORT; i++) {
 		if (pnp_port_valid(dev, i)) {
-			pnp_printf(buffer,"io");
+			pnp_printf(buffer, "io");
 			if (pnp_port_flags(dev, i) & IORESOURCE_DISABLED)
-				pnp_printf(buffer," disabled\n");
+				pnp_printf(buffer, " disabled\n");
 			else
-				pnp_printf(buffer," 0x%llx-0x%llx\n",
-					(unsigned long long)pnp_port_start(dev, i),
-					(unsigned long long)pnp_port_end(dev, i));
+				pnp_printf(buffer, " 0x%llx-0x%llx\n",
+					   (unsigned long long)
+					   pnp_port_start(dev, i),
+					   (unsigned long long)pnp_port_end(dev,
+									    i));
 		}
 	}
 	for (i = 0; i < PNP_MAX_MEM; i++) {
 		if (pnp_mem_valid(dev, i)) {
-			pnp_printf(buffer,"mem");
+			pnp_printf(buffer, "mem");
 			if (pnp_mem_flags(dev, i) & IORESOURCE_DISABLED)
-				pnp_printf(buffer," disabled\n");
+				pnp_printf(buffer, " disabled\n");
 			else
-				pnp_printf(buffer," 0x%llx-0x%llx\n",
-					(unsigned long long)pnp_mem_start(dev, i),
-					(unsigned long long)pnp_mem_end(dev, i));
+				pnp_printf(buffer, " 0x%llx-0x%llx\n",
+					   (unsigned long long)
+					   pnp_mem_start(dev, i),
+					   (unsigned long long)pnp_mem_end(dev,
+									   i));
 		}
 	}
 	for (i = 0; i < PNP_MAX_IRQ; i++) {
 		if (pnp_irq_valid(dev, i)) {
-			pnp_printf(buffer,"irq");
+			pnp_printf(buffer, "irq");
 			if (pnp_irq_flags(dev, i) & IORESOURCE_DISABLED)
-				pnp_printf(buffer," disabled\n");
+				pnp_printf(buffer, " disabled\n");
 			else
-				pnp_printf(buffer," %lld\n",
-					(unsigned long long)pnp_irq(dev, i));
+				pnp_printf(buffer, " %lld\n",
+					   (unsigned long long)pnp_irq(dev, i));
 		}
 	}
 	for (i = 0; i < PNP_MAX_DMA; i++) {
 		if (pnp_dma_valid(dev, i)) {
-			pnp_printf(buffer,"dma");
+			pnp_printf(buffer, "dma");
 			if (pnp_dma_flags(dev, i) & IORESOURCE_DISABLED)
-				pnp_printf(buffer," disabled\n");
+				pnp_printf(buffer, " disabled\n");
 			else
-				pnp_printf(buffer," %lld\n",
-					(unsigned long long)pnp_dma(dev, i));
+				pnp_printf(buffer, " %lld\n",
+					   (unsigned long long)pnp_dma(dev, i));
 		}
 	}
 	ret = (buffer->curr - buf);
@@ -308,55 +318,57 @@
 extern struct semaphore pnp_res_mutex;
 
 static ssize_t
-pnp_set_current_resources(struct device * dmdev, struct device_attribute *attr, const char * ubuf, size_t count)
+pnp_set_current_resources(struct device *dmdev, struct device_attribute *attr,
+			  const char *ubuf, size_t count)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
-	char	*buf = (void *)ubuf;
-	int	retval = 0;
+	char *buf = (void *)ubuf;
+	int retval = 0;
 
 	if (dev->status & PNP_ATTACHED) {
 		retval = -EBUSY;
-		pnp_info("Device %s cannot be configured because it is in use.", dev->dev.bus_id);
+		pnp_info("Device %s cannot be configured because it is in use.",
+			 dev->dev.bus_id);
 		goto done;
 	}
 
 	while (isspace(*buf))
 		++buf;
-	if (!strnicmp(buf,"disable",7)) {
+	if (!strnicmp(buf, "disable", 7)) {
 		retval = pnp_disable_dev(dev);
 		goto done;
 	}
-	if (!strnicmp(buf,"activate",8)) {
+	if (!strnicmp(buf, "activate", 8)) {
 		retval = pnp_activate_dev(dev);
 		goto done;
 	}
-	if (!strnicmp(buf,"fill",4)) {
+	if (!strnicmp(buf, "fill", 4)) {
 		if (dev->active)
 			goto done;
 		retval = pnp_auto_config_dev(dev);
 		goto done;
 	}
-	if (!strnicmp(buf,"auto",4)) {
+	if (!strnicmp(buf, "auto", 4)) {
 		if (dev->active)
 			goto done;
 		pnp_init_resource_table(&dev->res);
 		retval = pnp_auto_config_dev(dev);
 		goto done;
 	}
-	if (!strnicmp(buf,"clear",5)) {
+	if (!strnicmp(buf, "clear", 5)) {
 		if (dev->active)
 			goto done;
 		pnp_init_resource_table(&dev->res);
 		goto done;
 	}
-	if (!strnicmp(buf,"get",3)) {
+	if (!strnicmp(buf, "get", 3)) {
 		down(&pnp_res_mutex);
 		if (pnp_can_read(dev))
 			dev->protocol->get(dev, &dev->res);
 		up(&pnp_res_mutex);
 		goto done;
 	}
-	if (!strnicmp(buf,"set",3)) {
+	if (!strnicmp(buf, "set", 3)) {
 		int nport = 0, nmem = 0, nirq = 0, ndma = 0;
 		if (dev->active)
 			goto done;
@@ -366,65 +378,77 @@
 		while (1) {
 			while (isspace(*buf))
 				++buf;
-			if (!strnicmp(buf,"io",2)) {
+			if (!strnicmp(buf, "io", 2)) {
 				buf += 2;
 				while (isspace(*buf))
 					++buf;
-				dev->res.port_resource[nport].start = simple_strtoul(buf,&buf,0);
+				dev->res.port_resource[nport].start =
+				    simple_strtoul(buf, &buf, 0);
 				while (isspace(*buf))
 					++buf;
-				if(*buf == '-') {
+				if (*buf == '-') {
 					buf += 1;
 					while (isspace(*buf))
 						++buf;
-					dev->res.port_resource[nport].end = simple_strtoul(buf,&buf,0);
+					dev->res.port_resource[nport].end =
+					    simple_strtoul(buf, &buf, 0);
 				} else
-					dev->res.port_resource[nport].end = dev->res.port_resource[nport].start;
-				dev->res.port_resource[nport].flags = IORESOURCE_IO;
+					dev->res.port_resource[nport].end =
+					    dev->res.port_resource[nport].start;
+				dev->res.port_resource[nport].flags =
+				    IORESOURCE_IO;
 				nport++;
 				if (nport >= PNP_MAX_PORT)
 					break;
 				continue;
 			}
-			if (!strnicmp(buf,"mem",3)) {
+			if (!strnicmp(buf, "mem", 3)) {
 				buf += 3;
 				while (isspace(*buf))
 					++buf;
-				dev->res.mem_resource[nmem].start = simple_strtoul(buf,&buf,0);
+				dev->res.mem_resource[nmem].start =
+				    simple_strtoul(buf, &buf, 0);
 				while (isspace(*buf))
 					++buf;
-				if(*buf == '-') {
+				if (*buf == '-') {
 					buf += 1;
 					while (isspace(*buf))
 						++buf;
-					dev->res.mem_resource[nmem].end = simple_strtoul(buf,&buf,0);
+					dev->res.mem_resource[nmem].end =
+					    simple_strtoul(buf, &buf, 0);
 				} else
-					dev->res.mem_resource[nmem].end = dev->res.mem_resource[nmem].start;
-				dev->res.mem_resource[nmem].flags = IORESOURCE_MEM;
+					dev->res.mem_resource[nmem].end =
+					    dev->res.mem_resource[nmem].start;
+				dev->res.mem_resource[nmem].flags =
+				    IORESOURCE_MEM;
 				nmem++;
 				if (nmem >= PNP_MAX_MEM)
 					break;
 				continue;
 			}
-			if (!strnicmp(buf,"irq",3)) {
+			if (!strnicmp(buf, "irq", 3)) {
 				buf += 3;
 				while (isspace(*buf))
 					++buf;
 				dev->res.irq_resource[nirq].start =
-				dev->res.irq_resource[nirq].end = simple_strtoul(buf,&buf,0);
-				dev->res.irq_resource[nirq].flags = IORESOURCE_IRQ;
+				    dev->res.irq_resource[nirq].end =
+				    simple_strtoul(buf, &buf, 0);
+				dev->res.irq_resource[nirq].flags =
+				    IORESOURCE_IRQ;
 				nirq++;
 				if (nirq >= PNP_MAX_IRQ)
 					break;
 				continue;
 			}
-			if (!strnicmp(buf,"dma",3)) {
+			if (!strnicmp(buf, "dma", 3)) {
 				buf += 3;
 				while (isspace(*buf))
 					++buf;
 				dev->res.dma_resource[ndma].start =
-				dev->res.dma_resource[ndma].end = simple_strtoul(buf,&buf,0);
-				dev->res.dma_resource[ndma].flags = IORESOURCE_DMA;
+				    dev->res.dma_resource[ndma].end =
+				    simple_strtoul(buf, &buf, 0);
+				dev->res.dma_resource[ndma].flags =
+				    IORESOURCE_DMA;
 				ndma++;
 				if (ndma >= PNP_MAX_DMA)
 					break;
@@ -435,45 +459,49 @@
 		up(&pnp_res_mutex);
 		goto done;
 	}
- done:
+      done:
 	if (retval < 0)
 		return retval;
 	return count;
 }
 
-static DEVICE_ATTR(resources,S_IRUGO | S_IWUSR,
-		   pnp_show_current_resources,pnp_set_current_resources);
+static DEVICE_ATTR(resources, S_IRUGO | S_IWUSR,
+		   pnp_show_current_resources, pnp_set_current_resources);
 
-static ssize_t pnp_show_current_ids(struct device *dmdev, struct device_attribute *attr, char *buf)
+static ssize_t pnp_show_current_ids(struct device *dmdev,
+				    struct device_attribute *attr, char *buf)
 {
 	char *str = buf;
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
-	struct pnp_id * pos = dev->id;
+	struct pnp_id *pos = dev->id;
 
 	while (pos) {
-		str += sprintf(str,"%s\n", pos->id);
+		str += sprintf(str, "%s\n", pos->id);
 		pos = pos->next;
 	}
 	return (str - buf);
 }
 
-static DEVICE_ATTR(id,S_IRUGO,pnp_show_current_ids,NULL);
+static DEVICE_ATTR(id, S_IRUGO, pnp_show_current_ids, NULL);
 
 int pnp_interface_attach_device(struct pnp_dev *dev)
 {
-	int rc = device_create_file(&dev->dev,&dev_attr_options);
-	if (rc) goto err;
-	rc = device_create_file(&dev->dev,&dev_attr_resources);
-	if (rc) goto err_opt;
-	rc = device_create_file(&dev->dev,&dev_attr_id);
-	if (rc) goto err_res;
+	int rc = device_create_file(&dev->dev, &dev_attr_options);
+	if (rc)
+		goto err;
+	rc = device_create_file(&dev->dev, &dev_attr_resources);
+	if (rc)
+		goto err_opt;
+	rc = device_create_file(&dev->dev, &dev_attr_id);
+	if (rc)
+		goto err_res;
 
 	return 0;
 
-err_res:
-	device_remove_file(&dev->dev,&dev_attr_resources);
-err_opt:
-	device_remove_file(&dev->dev,&dev_attr_options);
-err:
+      err_res:
+	device_remove_file(&dev->dev, &dev_attr_resources);
+      err_opt:
+	device_remove_file(&dev->dev, &dev_attr_options);
+      err:
 	return rc;
 }

--
