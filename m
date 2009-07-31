From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] ACPI: bind workqueues to CPU 0 to avoid SMI corruption
Date: Fri, 31 Jul 2009 16:47:39 -0600
Message-ID: <200907311647.39902.bjorn.helgaas@hp.com>
References: <20090729215425.23674.80263.stgit@bob.kio> <1248915599.2670.151.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17]:3845 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbZGaWrm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 18:47:42 -0400
In-Reply-To: <1248915599.2670.151.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wednesday 29 July 2009 06:59:59 pm Zhang Rui wrote:
> On Thu, 2009-07-30 at 05:54 +0800, Bjorn Helgaas wrote:
> > On some machines, a software-initiated SMI causes corruption unless the
> > SMI runs on CPU 0.  An SMI can be initiated by any AML, but typically it's
> > done in GPE-related methods that are run via workqueues, so we can avoid
> > the known corruption cases by binding the workqueues to CPU 0.
> > 
> > References:
> >     http://bugzilla.kernel.org/show_bug.cgi?id=13751
> >     https://bugs.launchpad.net/bugs/157171
> >     https://bugs.launchpad.net/bugs/157691
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Acked-by: Zhang Rui <rui.zhang@intel.com>

In addition to the reports above, I think it's likely this patch
will fix the problems reported below:

  http://bugzilla.kernel.org/show_bug.cgi?id=13412
  http://bugzilla.kernel.org/show_bug.cgi?id=11259
  http://bugzilla.kernel.org/show_bug.cgi?id=12328
  http://bugzilla.kernel.org/show_bug.cgi?id=12106

I think we should consider this patch for 2.6.31.

(Rafael, 13751 is on your "2.6.29 -> 2.6.30" regression list.
I actually think it's been around much longer than that, but
there seem to be many things that affect whether it manifests.)

Bjorn

> > ---
> >  drivers/acpi/osl.c |   25 +++++++++++++++++++++++++
> >  1 files changed, 25 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > index 7167071..5691f16 100644
> > --- a/drivers/acpi/osl.c
> > +++ b/drivers/acpi/osl.c
> > @@ -189,11 +189,36 @@ acpi_status __init acpi_os_initialize(void)
> >  	return AE_OK;
> >  }
> >  
> > +static void bind_to_cpu0(struct work_struct *work)
> > +{
> > +	set_cpus_allowed(current, cpumask_of_cpu(0));
> > +	kfree(work);
> > +}
> > +
> > +static void bind_workqueue(struct workqueue_struct *wq)
> > +{
> > +	struct work_struct *work;
> > +
> > +	work = kzalloc(sizeof(struct work_struct), GFP_KERNEL);
> > +	INIT_WORK(work, bind_to_cpu0);
> > +	queue_work(wq, work);
> > +}
> > +
> >  acpi_status acpi_os_initialize1(void)
> >  {
> > +	/*
> > +	 * On some machines, a software-initiated SMI causes corruption unless
> > +	 * the SMI runs on CPU 0.  An SMI can be initiated by any AML, but
> > +	 * typically it's done in GPE-related methods that are run via
> > +	 * workqueues, so we can avoid the known corruption cases by binding
> > +	 * the workqueues to CPU 0.
> > +	 */
> >  	kacpid_wq = create_singlethread_workqueue("kacpid");
> > +	bind_workqueue(kacpid_wq);
> >  	kacpi_notify_wq = create_singlethread_workqueue("kacpi_notify");
> > +	bind_workqueue(kacpi_notify_wq);
> >  	kacpi_hotplug_wq = create_singlethread_workqueue("kacpi_hotplug");
> > +	bind_workqueue(kacpi_hotplug_wq);
> >  	BUG_ON(!kacpid_wq);
> >  	BUG_ON(!kacpi_notify_wq);
> >  	BUG_ON(!kacpi_hotplug_wq);
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


