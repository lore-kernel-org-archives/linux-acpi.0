From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 1/4] ACPI: Add acpi_pr_<level>() interfaces
Date: Wed, 18 Jul 2012 16:26:26 -0600
Message-ID: <1342650386.3010.55.camel@misato.fc.hp.com>
References: <1342644027-19559-1-git-send-email-toshi.kani@hp.com>
	 <1342644027-19559-2-git-send-email-toshi.kani@hp.com>
	 <1342648771.5138.37.camel@lorien2>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:47738 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab2GRWbJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2012 18:31:09 -0400
In-Reply-To: <1342648771.5138.37.camel@lorien2>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: shuah.khan@hp.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, liuj97@gmail.com, srivatsa.bhat@linux.vnet.ibm.com, prarit@redhat.com, imammedo@redhat.com, vijaymohan.pandarathil@hp.com, shuahkhan@gmail.com

On Wed, 2012-07-18 at 15:59 -0600, Shuah Khan wrote:
> On Wed, 2012-07-18 at 14:40 -0600, Toshi Kani wrote:
> > This patch introduces acpi_pr_<level>(), where <level> is a message
> > level such as err/warn/info, to support improved logging messages
> > for ACPI, esp. in hotplug operations.  acpi_pr_<level>() appends
> > "ACPI" prefix and ACPI object path to the messages.  This improves
> > diagnostics in hotplug operations since it identifies an object that
> > caused an issue in a log file.
> > 
> > acpi_pr_<level>() takes acpi_handle as an argument, which is passed
> > to ACPI hotplug notify handlers from the ACPI CA.  Therefore, it is
> > always available unlike other kernel objects, such as device.
> > 
> > For example, the statement below
> >   acpi_pr_err(handle, "Device don't exist, dropping EJECT\n");
> > logs an error message like this:
> >   ACPI: \_SB_.SCK4.CPU4: Device don't exist, dropping EJECT
> > 
> > Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> > ---
> >  drivers/acpi/utils.c    |   32 ++++++++++++++++++++++++++++++++
> >  include/acpi/acpi_bus.h |   18 ++++++++++++++++++
> >  2 files changed, 50 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> > index 3e87c9c..4097266 100644
> > --- a/drivers/acpi/utils.c
> > +++ b/drivers/acpi/utils.c
> > @@ -454,3 +454,35 @@ acpi_evaluate_hotplug_ost(acpi_handle handle, u32 source_event,
> >  #endif
> >  }
> >  EXPORT_SYMBOL(acpi_evaluate_hotplug_ost);
> > +
> > +/**
> > + * acpi_printk: Print messages with ACPI prefix and object path
> > + *
> > + * This function is intended to be called through acpi_pr_<level> macros.
> > + */
> > +void
> > +acpi_printk(const char *level, acpi_handle handle, const char *fmt, ...)
> > +{
> > +	struct va_format vaf;
> > +	va_list args;
> > +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER};
> > +	char *path;
> > +	acpi_status ret;
> > +
> > +	va_start(args, fmt);
> > +
> > +	vaf.fmt = fmt;
> > +	vaf.va = &args;
> > +
> > +	ret = acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
> 
> One big problem I see with this approach is now each acpi_printk() will
> result in a call to acpi_get_name() which will invoke several ACPI
> calls, including a call to acpi_ut_initialize_buffer() which allocates
> buffer. Is this really warranted? What is the performance impact of this
> change?

Hi Shuah,

This interface is intended to be used by acpi_pr_<level>(), which is
used for error, warning, debugging, etc.  It is not intended to be used
in any performance path.

Thanks,
-Toshi


> 
> -- Shuah
> 
> 


