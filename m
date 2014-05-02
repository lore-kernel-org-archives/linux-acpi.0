From: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v4 3/5] acpi_processor: do not mark present at boot but
 not onlined CPU as onlined
Date: Fri, 2 May 2014 13:32:19 +0200
Message-ID: <20140502133219.5de5c683@nial.usersys.redhat.com>
References: <1397488277-14865-1-git-send-email-imammedo@redhat.com>
	<1397488277-14865-4-git-send-email-imammedo@redhat.com>
	<1398893151.1789.46.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10802 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834AbaEBLcz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 2 May 2014 07:32:55 -0400
In-Reply-To: <1398893151.1789.46.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, bp@suse.de, paul.gortmaker@windriver.com, JBeulich@suse.com, prarit@redhat.com, drjones@redhat.com, riel@redhat.com, gong.chen@linux.intel.com, andi@firstfloor.org, lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org

On Wed, 30 Apr 2014 15:25:51 -0600
Toshi Kani <toshi.kani@hp.com> wrote:

> On Mon, 2014-04-14 at 17:11 +0200, Igor Mammedov wrote:
> > acpi_processor_add() assumes that present at boot CPUs
> > are always onlined, it is not so if a CPU failed to become
> > onlined. As result acpi_processor_add() will mark such CPU
> > device as onlined in sysfs and following attempts to
> > online/offline it using /sys/device/system/cpu/cpuX/online
> > attribute will fail.
> > 
> > Do not poke into device internals in acpi_processor_add()
> > and touch "struct device { .offline }" attribute, since
> > for CPUs onlined at boot it's set by:
> >   topology_init() -> arch_register_cpu() -> register_cpu()
> > before ACPI device tree is parsed, and for hotplugged
> > CPUs it's set when userspace onlines CPU via sysfs.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v2:
> >  - fix regression in v1 leading to NULL pointer dereference
> >    on CPU unplug, do not remove "pr->dev = dev;"
> > ---
> >  drivers/acpi/acpi_processor.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> > index c29c2c3..42d66f8 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c:q
> > @@ -404,7 +404,6 @@ static int acpi_processor_add(struct acpi_device *device,
> >  		goto err;
> >  
> >  	pr->dev = dev;
> > -	dev->offline = pr->flags.need_hotplug_init;
> 
> IIRC, this change was necessary to handle the case when maxcpus=X is
> specified at boot.  In this case, excessive CPU's dev->offline needs to
> be set to 1.  Can you verify this?
Option 'maxcpus' works just fine without and with this patch since a bit
earlier in acpi_processor_add() it exits in case of extra present CPUs:

#ifdef CONFIG_SMP
        if (pr->id >= setup_max_cpus && pr->id != 0)
                return 0;
#endif

and execution doesn't get to the point the patch touches.

The point is that acpi_processor_add() shouldn't touch
dev->offline at all and allow register_cpu() handle it.

> 
> Thanks,
> -Toshi
> 

