From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/5] ACPI processor: Avoid WARN message on processor driver removal
Date: Tue, 17 Jan 2012 15:58:49 +0100
Message-ID: <201201171558.49411.trenn@suse.de>
References: <1321569421-46220-1-git-send-email-trenn@suse.de> <1321569421-46220-3-git-send-email-trenn@suse.de> <4F15554F.8040900@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60454 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753763Ab2AQO6v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 09:58:51 -0500
In-Reply-To: <4F15554F.8040900@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, deepthi@linux.vnet.ibm.com

On Tuesday, January 17, 2012 12:02:39 PM Len Brown wrote:
> On 11/17/2011 05:36 PM, Thomas Renninger wrote:
> 
> > Only unregister acpi_idle driver if acpi_idle driver got
> > registered.
> > 
> > Also add a static acpi_idle_active variable for easy and nicer
> > checking whether acpi_idle_driver is active (as suggested by
> > Bjorn).
> > 
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > CC: Len Brown <lenb@kernel.org>
> > CC: linux-acpi@vger.kernel.org
> > CC: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/acpi/processor_driver.c |   11 +++++++----
> >  1 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> > index 3a4fc0c..790623f 100644
> > --- a/drivers/acpi/processor_driver.c
> > +++ b/drivers/acpi/processor_driver.c
> > @@ -110,6 +110,7 @@ static struct cpuidle_driver acpi_idle_driver = {
> >  	.name =		"acpi_idle",
> >  	.owner =	THIS_MODULE,
> >  };
> > +static int acpi_idle_active;
> >  
> >  #define INSTALL_NOTIFY_HANDLER		1
> >  #define UNINSTALL_NOTIFY_HANDLER	2
> > @@ -508,8 +509,7 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
> >  	acpi_processor_get_throttling_info(pr);
> >  	acpi_processor_get_limit_info(pr);
> >  
> > -
> > -	if (cpuidle_get_driver() == &acpi_idle_driver)
> > +	if (acpi_idle_active)
> >  		acpi_processor_power_init(pr, device);
> 
> 
> I think the old cold reads better than the new code,
> since I don't have to guess what "acpi_idle_active" means...
> 
> Perhaps you can use the existing mechanism where
> it is missing to guard the unregister and re-fresh?
With commit 46bcfad7a819bd17ac4e831b04405152d59784ab
Author: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date:   Fri Oct 28 16:20:42 2011 +0530

    cpuidle: Single/Global registration of idle states

the offending unregistering line is not needed anymore at all
and a new patch would look similar to:
@@ -846,7 +848,8 @@ static void __exit acpi_processor_exit(void)
 
        acpi_bus_unregister_driver(&acpi_processor_driver);
 
-       cpuidle_unregister_driver(&acpi_idle_driver);
 
        return;
 }

I'll send something with Deepthi in CC to double check.

   Thomas
