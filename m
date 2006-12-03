From: Andrew Morton <akpm@osdl.org>
Subject: Re: Possible bug in ACPI
Date: Sat, 2 Dec 2006 19:26:32 -0800
Message-ID: <20061202192632.d1815e5f.akpm@osdl.org>
References: <20060919214724.GB2073@panelnet.cz>
	<20061109140416.db12bcbe.akpm@osdl.org>
	<20061202205140.GA12447@panelnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:44682 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1759496AbWLCC0X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Dec 2006 21:26:23 -0500
In-Reply-To: <20061202205140.GA12447@panelnet.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dalibor Straka <dast@panelnet.cz>
Cc: jikos@jikos.cz, linux-acpi@vger.kernel.org

We appear to have a fatal memory leak in ACPI.  It's a shame this was
known about in the -rc series but not fixed then.

Dalibor, please raise a full and new report at bugzilla.kernel.org.

> On Sat, 2 Dec 2006 21:51:40 +0100 Dalibor Straka <dast@panelnet.cz> wrote:
> On Thu, Nov 09, 2006 at 02:04:16PM -0800, Andrew Morton wrote:
> > 
> > If this bug is still present in 2.6.19-rc5 could you please raise a report
> > at bugzilla.kernel.org?
> > 
> > Thanks.
> > 
> > On Tue, 19 Sep 2006 23:47:24 +0200
> > Dalibor Straka <dast@panelnet.cz> wrote:
> > 
> > > Hello,
> > > 
> > > I am often running out of memory. It looks like an ACPI code is guilty:
> > > dast@lili:~$ grep -i acpi /proc/slabinfo 
> > > Acpi-Operand        3076   3127     64   59    1 : tunables  120   60 8 : slabdata     53     53      0
> > > Acpi-ParseExt         16     59     64   59    1 : tunables  120   60 8 : slabdata      1      1      0
> > > Acpi-Parse            76     92     40   92    1 : tunables  120   60 8 : slabdata      1      1      0
> > > Acpi-State        1644960 1644960     80   48    1 : tunables  120   60 8 : slabdata  34270  34270      0
> > > Acpi-Namespace      1177   1232     32  112    1 : tunables  120   60 8 : slabdata     11     11      0
> > > dast@lili:~$ free
> > > Mem:        899280     892472       6808          0      82212 77936
> > > -/+ buffers/cache:     732324     166956
> > > Swap:      2634620     243052    2404568
> > > dast@lili:~$ uname -a
> > > Linux lili 2.6.18-rc7 #1 SMP Sun Sep 17 15:01:00 CEST 2006 x86_64
> > > 
> > > 
> > > Actualy the Acpi-State's memory is increasing slowly in minutes:
> > > Acpi-State         16176  16176     80   48    1 : tunables  120   60 8 : slabdata    337    337      0
> > > Acpi-State         18816  18816     80   48    1 : tunables  120   60 8 : slabdata    392    392      0
> > > Acpi-State         19200  19200     80   48    1 : tunables  120   60 8 : slabdata    400    400      0
> > > Acpi-State         20160  20160     80   48    1 : tunables  120   60 8 : slabdata    420    420      0
> > > 
> > > I am not familiar with kernel sources, but i can do c pretty well.
> > > BTW: Bios says i have 1024MB, but kernel sees 899MB :-?. The system is
> > > pure HP nx6325. It happens with all the recent kernels .18-rc* .17.* and
> > > debian's distribution 2.6.17-1-amd64-k8-smp.
> > > 
> > > Please Cc: to me, I read lkml only when I have a good mood.
> 
> 
> Hello,
> 
> the bug is present again in 2.6.19 but not in 19-rc5 and not in 19-rc6.
> The only thing changed in drivers/acpi/ is osl.c and procesor_perflib.c.
> --- ./processor_perflib.c       2006-09-20 05:42:06.000000000 +0200
> +++ /usr/src/linux-2.6.19/drivers/acpi/processor_perflib.c
> 2006-12-01 00:34:06.000000000 +0100
> @@ -83,10 +83,8 @@
>                 goto out;
>  
>         ppc = (unsigned int)pr->performance_platform_limit;
> -       if (!ppc)
> -               goto out;
>  
> -       if (ppc > pr->performance->state_count)
> +       if (ppc >= pr->performance->state_count)
>                 goto out;
>  
>         cpufreq_verify_within_limits(policy, 0,
> --- osl.c	2006-12-02 21:40:57.000000000 +0100
> +++ /usr/src/linux-2.6.19-rc6/drivers/acpi/osl.c	2006-11-18 13:38:01.000000000 +0100
> @@ -73,6 +73,7 @@
>  static acpi_osd_handler acpi_irq_handler;
>  static void *acpi_irq_context;
>  static struct workqueue_struct *kacpid_wq;
> +static struct workqueue_struct *kacpi_notify_wq;
>  
>  acpi_status acpi_os_initialize(void)
>  {
> @@ -91,8 +92,9 @@
>  		return AE_NULL_ENTRY;
>  	}
>  	kacpid_wq = create_singlethread_workqueue("kacpid");
> +	kacpi_notify_wq = create_singlethread_workqueue("kacpi_notify");
>  	BUG_ON(!kacpid_wq);
> -
> +	BUG_ON(!kacpi_notify_wq);
>  	return AE_OK;
>  }
>  
> @@ -104,7 +106,7 @@
>  	}
>  
>  	destroy_workqueue(kacpid_wq);
> -	destroy_workqueue(kacpid_notify_wq);
> +	destroy_workqueue(kacpi_notify_wq);
>  
>  	return AE_OK;
>  }
> @@ -567,10 +569,7 @@
>  
>  static void acpi_os_execute_deferred(void *context)
>  {
> -	struct acpi_os_dpc *dpc = NULL;
> -
> -
> -	dpc = (struct acpi_os_dpc *)context;
> +	struct acpi_os_dpc *dpc = (struct acpi_os_dpc *)context;
>  	if (!dpc) {
>  		printk(KERN_ERR PREFIX "Invalid (NULL) context\n");
>  		return;
> @@ -605,14 +604,12 @@
>  	struct acpi_os_dpc *dpc;
>  	struct work_struct *task;
>  
> -	ACPI_FUNCTION_TRACE("os_queue_for_execution");
> -
>  	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
>  			  "Scheduling function [%p(%p)] for deferred execution.\n",
>  			  function, context));
>  
>  	if (!function)
> -		return_ACPI_STATUS(AE_BAD_PARAMETER);
> +		return AE_BAD_PARAMETER;
>  
>  	/*
>  	 * Allocate/initialize DPC structure.  Note that this memory will be
> @@ -625,26 +622,20 @@
>  	 * from the same memory.
>  	 */
>  
> -	dpc =
> -	    kmalloc(sizeof(struct acpi_os_dpc) + sizeof(struct work_struct),
> -		    GFP_ATOMIC);
> +	dpc = kmalloc(sizeof(struct acpi_os_dpc) +
> +			sizeof(struct work_struct), GFP_ATOMIC);
>  	if (!dpc)
> -		return_ACPI_STATUS(AE_NO_MEMORY);
> -
> +		return AE_NO_MEMORY;
>  	dpc->function = function;
>  	dpc->context = context;
> -
>  	task = (void *)(dpc + 1);
>  	INIT_WORK(task, acpi_os_execute_deferred, (void *)dpc);
> -
> -	if (!queue_work(kacpid_wq, task)) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> -				  "Call to queue_work() failed.\n"));
> -		kfree(dpc);
> +	if (!queue_work((type == OSL_NOTIFY_HANDLER)?
> +			kacpi_notify_wq : kacpid_wq, task)) {
>  		status = AE_ERROR;
> +		kfree(dpc);
>  	}
> -
> -	return_ACPI_STATUS(status);
> +	return status;
>  }
>  
>  EXPORT_SYMBOL(acpi_os_execute);
