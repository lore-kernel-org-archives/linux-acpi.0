From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI:avoid printing the error message that processor
	device is not present
Date: Mon, 15 Oct 2007 09:19:46 +0800
Message-ID: <1192411186.7521.6.camel@yakui_zhao.sh.intel.com>
References: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com>
	 <200710092343.40843.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49658 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbXJOBMQ (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Sun, 14 Oct 2007 21:12:16 -0400
In-Reply-To: <200710092343.40843.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

On Tue, 2007-10-09 at 23:43 -0400, Len Brown wrote:
> On Sunday 07 October 2007 23:35, Zhao Yakui wrote:
> > Subject: ACPI: avoid printing the info that processor device is not present
> > From: Zhao Yakui  <yakui.zhao@intel.com>
> > 
> > Four processors are defined in the DSDT table, which means that quad-core cpu
> > is supported. But dual-core cpu is installed on the system. In the
> > initialization OS will check whether the defined processor exists. If it 
> > doesn't exist, it will print the info that processor device is not present.
> > The above error message has no effect on the system but it will mislead us.
> > So it is unnecessary to print the error message when disabling acpi debug.
> 
> SuSE ships with ACPI_DEBUG enabled by default.
> Can we get smarter about this -- say by checking against
> the processors that we expect to be present?
The error info depends on the two following conditions : 
    1. ACPI_DEBUG is enabled
    2. boot option of acpi.debug_level=0x10 
If Only ACPI_DEBUG is enabled, the dmesg won't print the error info. 



> thanks,
> -Len
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=8630
> > 
> > Signed-off-by: Zhao Yakui  <yakui.zhao@intel.com>
> > ---
> >  drivers/acpi/processor_core.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > Index: linux-2.6.23-rc7/drivers/acpi/processor_core.c
> > ===================================================================
> > --- linux-2.6.23-rc7.orig/drivers/acpi/processor_core.c
> > +++ linux-2.6.23-rc7/drivers/acpi/processor_core.c
> > @@ -813,7 +813,9 @@ static int is_processor_present(acpi_han
> >  
> >  	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
> >  	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT)) {
> > -		ACPI_EXCEPTION((AE_INFO, status, "Processor Device is not present"));
> > +		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> > +			"%s :Processor Device is not present",
> > +			acpi_format_exception(status)));
> >  		return 0;
> >  	}
> >  	return 1;
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
