From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] [RFC] Patch [1/2] for acpi_memhotplug.c
Date: Thu, 22 Jun 2006 12:13:56 +0900
Message-ID: <20060622121356.6326e4a2.kamezawa.hiroyu@jp.fujitsu.com>
References: <971FCB6690CD0E4898387DBF7552B90E0378BEE7@orsmsx403.amr.corp.intel.com>
	<437F1766.8090705@jp.fujitsu.com>
	<1150853300.5873.49.camel@keithlap>
	<20060621114334.1b954854.kamezawa.hiroyu@jp.fujitsu.com>
	<1150863525.7865.6.camel@keithlap>
	<20060621194832.37124aae.kamezawa.hiroyu@jp.fujitsu.com>
	<1150915426.5830.21.camel@keithlap>
	<1150932228.9235.6.camel@keithlap>
	<20060622091336.be46e7a6.kamezawa.hiroyu@jp.fujitsu.com>
	<1150940220.10001.11.camel@keithlap>
	<20060622105854.18fa1f16.kamezawa.hiroyu@jp.fujitsu.com>
	<1150942799.10001.30.camel@keithlap>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:7816 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030591AbWFVDLe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jun 2006 23:11:34 -0400
In-Reply-To: <1150942799.10001.30.camel@keithlap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kmannth@us.ibm.com
Cc: prarit@redhat.com, linux-acpi@vger.kernel.org, lhms-devel@lists.sourceforge.net, robert.moore@intel.com, darnok@us.ibm.com

On Wed, 21 Jun 2006 19:19:58 -0700
keith mannthey <kmannth@us.ibm.com> wrote:
> > Good Catch :)
> > 
> > Then, could you print driver name ? like this
> > ==
> > printk("Call Add driver for name %s/class %s/id %s\n",driver->name,driver->class,driver->id);
> > ==
> 
> Good idea!
> During the hot add I see. 
> Call Add driver for name motherboard/class /id PNP0C01
> 
> That is the wrong driver for sure. 

Hmm....curious..but no idead..
Then, could try this ? 

-Kame
==

Index: linux-2.6.17-rc6-mm2/drivers/acpi/scan.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/drivers/acpi/scan.c
+++ linux-2.6.17-rc6-mm2/drivers/acpi/scan.c
@@ -227,6 +227,20 @@ static int acpi_bus_get_power_flags(stru
 	return 0;
 }
 
+int acpi_print_all_ids(struct acpi_device *device)
+{
+	printk("check BusID%s/ HID%s/ UID%s",
+		acpi_device_bid(device),acpi_device_hid(device),
+		acpi_device_uid(device));
+	if (device->flags.compatible_ids) {
+		struct acpi_compatible_id_list *cid_list = device->pnp.cid_list;
+		int i;
+		for (i = 0; i < cid_list->count; i++)
+			printk("CID %s ",cid_list->id[i].value);
+	}
+	printk("\n");
+}
+
 int acpi_match_ids(struct acpi_device *device, char *ids)
 {
 	if (device->flags.hardware_id)
@@ -487,6 +501,8 @@ acpi_bus_driver_init(struct acpi_device 
 
 	if (!driver->ops.add)
 		return -ENOSYS;
+	printk("acpi_bus_driver_init() driver is %s\n", driver->name);
+	acpi_print_all_ids(device);
 
 	result = driver->ops.add(device);
 	if (result) {

