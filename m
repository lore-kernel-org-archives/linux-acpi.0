From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] [RFC] Patch [1/2] for acpi_memhotplug.c
Date: Thu, 22 Jun 2006 10:58:54 +0900
Message-ID: <20060622105854.18fa1f16.kamezawa.hiroyu@jp.fujitsu.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:39400 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030491AbWFVB5Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jun 2006 21:57:16 -0400
In-Reply-To: <1150940220.10001.11.camel@keithlap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kmannth@us.ibm.com
Cc: prarit@redhat.com, linux-acpi@vger.kernel.org, lhms-devel@lists.sourceforge.net, robert.moore@intel.com, darnok@us.ibm.com

On Wed, 21 Jun 2006 18:37:00 -0700
keith mannthey <kmannth@us.ibm.com> wrote:

> > in acpi_bus_driver_init()
> > - driver->ops.add() is called or not
> > - what it retruns
> 
> It is called.  But that is not the whole story.  
> In acpi_bus_driver_init it calls driver->ops.add(device). This ops.add
> is not acpi_memory_device_add.  I do get not any printks that I would
> expect from acpi_memory_device_add.   
> 
> If I print out in acpi_bus_driver_init
>  printk(" device_add() about %s\n",acpi_device_name(device));
>  result = driver->ops.add(device);
> 
Good Catch :)

Then, could you print driver name ? like this
==
printk("Call Add driver for name %s/class %s/id %s\n",driver->name,driver->class,driver->id);
==


> Maybe I am picking the wrong driver from list_for_each_safe(node, next, &acpi_bus_drivers) 
> in acpi_bus_find_driver?
> 
looks so...BTW, your acpi_memhotplug driver is a module or built-in ?

-Kame

