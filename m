From: keith mannthey <kmannth@us.ibm.com>
Subject: Re: [Lhms-devel] [RFC] Patch [1/2] for acpi_memhotplug.c
Date: Wed, 21 Jun 2006 20:55:02 -0700
Message-ID: <1150948503.10001.60.camel@keithlap>
References: <971FCB6690CD0E4898387DBF7552B90E0378BEE7@orsmsx403.amr.corp.intel.com>
	 <437F1766.8090705@jp.fujitsu.com> <1150853300.5873.49.camel@keithlap>
	 <20060621114334.1b954854.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150863525.7865.6.camel@keithlap>
	 <20060621194832.37124aae.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150915426.5830.21.camel@keithlap> <1150932228.9235.6.camel@keithlap>
	 <20060622091336.be46e7a6.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150940220.10001.11.camel@keithlap>
	 <20060622105854.18fa1f16.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150942799.10001.30.camel@keithlap>
	 <20060622121356.6326e4a2.kamezawa.hiroyu@jp.fujitsu.com>
Reply-To: kmannth@us.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-31QgqO2qTnXj0x7N3d2O"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:19653 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751292AbWFVDzL
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jun 2006 23:55:11 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5M3tAfL032215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 23:55:10 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5M3tLAQ104664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 21:55:21 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5M3t987002990
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 21:55:10 -0600
In-Reply-To: <20060622121356.6326e4a2.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Prarit Bhargava--redhat <prarit@redhat.com>, linux acpi <linux-acpi@vger.kernel.org>, konrad <darnok@us.ibm.com>, robert.moore@intel.com, lhms-devel <lhms-devel@lists.sourceforge.net>


--=-31QgqO2qTnXj0x7N3d2O
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2006-06-22 at 12:13 +0900, KAMEZAWA Hiroyuki wrote:
> On Wed, 21 Jun 2006 19:19:58 -0700
> keith mannthey <kmannth@us.ibm.com> wrote:
> > > Good Catch :)
> > > 
> > > Then, could you print driver name ? like this
> > > ==
> > > printk("Call Add driver for name %s/class %s/id %s\n",driver->name,driver->class,driver->id);
> > > ==
> > 
> > Good idea!
> > During the hot add I see. 
> > Call Add driver for name motherboard/class /id PNP0C01
> > 
> > That is the wrong driver for sure. 
> 
> Hmm....curious..but no idead..
> Then, could try this ? 

I am trying to make the motherboard driver fail with it looks for
resources and finds node.  The motherboard add function alway returns
AE_OK which is why the algorithm fails. See attached patch it allows the
hot-add event to happen. 

With the event happening and I see 

Call Add driver for name Hotplug Mem Driver/class memory/id PNP0C80
acpi-memhotplug: device_add() called
acpi-memhotplug: kmalloc mem_device success
acpi-memhotplug: read CRS success

But then 

On node -1 totalpages: 0

How do I tell if my event has the right _PXM data or what ever is
needed?

Signed-off-by:  Keith Mannthey <kmannth@us.ibm.com>

--=-31QgqO2qTnXj0x7N3d2O
Content-Disposition: attachment; filename=patch-acpi-motherboard-v1.patch
Content-Type: text/x-patch; name=patch-acpi-motherboard-v1.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.17-rc6-mm2-orig/drivers/acpi/motherboard.c	2006-06-21 23:35:26.000000000 -0400
+++ linux-2.6.17-rc6-mm2/drivers/acpi/motherboard.c	2006-06-21 23:04:44.000000000 -0400
@@ -86,6 +86,7 @@
 		}
 	} else {
 		/* Memory mapped IO? */
+		 return -EINVAL;
 	}
 
 	if (requested_res)
@@ -95,12 +96,14 @@
 
 static int acpi_motherboard_add(struct acpi_device *device)
 {
+	acpi_status status;
 	if (!device)
 		return -EINVAL;
-	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
 			    acpi_reserve_io_ranges, NULL);
 
-	return 0;
+	return status;
 }
 
 static struct acpi_driver acpi_motherboard_driver1 = {

--=-31QgqO2qTnXj0x7N3d2O--

