From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [PATCH][4/4] Add NUMA node handling to the container driver
Date: Fri, 24 Sep 2004 13:44:49 +0900
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <20040924134449.7d4041f3.tokunaga.keiich@jp.fujitsu.com>
References: <20040920092520.A14208@unix-os.sc.intel.com>
 <20040920094719.H14208@unix-os.sc.intel.com>
 <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
 <20040924013642.00003b08.tokunaga.keiich@jp.fujitsu.com>
 <41534989.3070001@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ia64-owner@vger.kernel.org>
In-reply-to: <41534989.3070001@kolumbus.fi>
To: Mika Penttil_ <mika.penttila@kolumbus.fi>
Cc: tokunaga.keiich@jp.fujitsu.com, anil.s.keshavamurthy@intel.com, len.brown@intel.com, acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

> Keiichiro Tokunaga wrote:
> 
> >Name: container_for_numa.patch
> >Status: Tested on 2.6.9-rc2
> >Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
> >Description:
> >Add NUMA node handling to the container driver.
> >
> >Thanks,
> >Keiichiro Tokunaga
> >---
> >@@ -198,6 +208,7 @@ container_device_add(struct acpi_device 
> > 	if (acpi_bus_add(device, pdev, handle, ACPI_BUS_TYPE_DEVICE)) {
> > 		return_VALUE(-ENODEV);
> > 	}
> >+	container_numa_add((*device)->handle);
> >  
> >
> Maybe that should be :
> 
> container_numa_add(phandle);
>  
> instead? Device is the child at this point.

Thanks for looking!

A container's handle needs to be passed to the function here.
The (*device)->handle is the handle.  So there is no problem.
The phandle is just used for acpi_bus_add().

Thanks,
Keiichiro Tokunaga
