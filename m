From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 2.6] (4/5) add _PDC support
Date: 31 Jan 2004 00:46:24 -0500
Sender: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
Message-ID: <1075527984.2456.28.camel@dhcppc4>
References: <20040129105900.GD5372@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
In-Reply-To: <20040129105900.GD5372@dominikbrodowski.de>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

Accepted into ACPI test trees
http://linux-acpi.bkbits.net/linux-acpi-test-2.6.1
http://linux-acpi.bkbits.net/linux-acpi-test-2.6.2

This means it will be pulled into AKPM's 2.6 mm tree on the next update,
and is in the test queue for early 2.6.3.

thanks Dominik,
-Len

On Thu, 2004-01-29 at 05:59, Dominik Brodowski wrote:
> Add support for _PDC to the ACPI processor "Performance States library" 
> (perflib). If this field is empty, a bogus entry is passed to the _PDC
> method so that the default (io) access is returned again. This patch
> is partly based on David Moore's patch to
> arch/i386/kernel/cpu/cpufreq/acpi.c, sent to the cpufreq mailing list on
> June 24th, 2003.
> 
>  drivers/acpi/processor.c |   33 +++++++++++++++++++++++++++++++++
>  include/acpi/processor.h |    6 ++++++
>  2 files changed, 39 insertions(+)
> 
> diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
> --- linux-original/drivers/acpi/processor.c	2004-01-18 19:13:09.000000000 +0100
> +++ linux/drivers/acpi/processor.c	2004-01-28 22:25:32.000000000 +0100
> @@ -862,6 +862,33 @@
>   * acpi_processor_performance.
>   */
>  
> +static int acpi_processor_set_pdc (struct acpi_processor *pr)
> +{
> +	acpi_status             status = AE_OK;
> +	u32			arg0_buf[3];
> +	union acpi_object	arg0 = {ACPI_TYPE_BUFFER};
> +	struct acpi_object_list no_object = {1, &arg0};
> +	struct acpi_object_list *pdc;
> +
> +	ACPI_FUNCTION_TRACE("acpi_processor_set_pdc");
> +	
> +	arg0.buffer.length = 12;
> +	arg0.buffer.pointer = (u8 *) arg0_buf;
> +	arg0_buf[0] = ACPI_PDC_REVISION_ID;
> +	arg0_buf[1] = 0;
> +	arg0_buf[2] = 0;
> +
> +	pdc = (pr->performance->pdc) ? pr->performance->pdc : &no_object;
> +
> +	status = acpi_evaluate_object(pr->handle, "_PDC", pdc, NULL);
> +
> +	if ((ACPI_FAILURE(status)) && (pr->performance->pdc))
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Error evaluating _PDC, using legacy perf. control...\n"));
> +
> +	return_VALUE(status);
> +}
> +
> +
>  static int 
>  acpi_processor_get_performance_control (
>  	struct acpi_processor *pr)
> @@ -1029,6 +1056,8 @@
>  		return_VALUE(-ENODEV);
>  	}
>  
> +	acpi_processor_set_pdc(pr);
> +
>  	result = acpi_processor_get_performance_control(pr);
>  	if (result)
>  		return_VALUE(result);
> @@ -1037,6 +1066,10 @@
>  	if (result)
>  		return_VALUE(result);
>  
> +	result = acpi_processor_get_platform_limit(pr);
> +	if (result)
> +		return_VALUE(result);
> +
>  	return_VALUE(0);
>  }
>  
> diff -ruN linux-original/include/acpi/processor.h linux/include/acpi/processor.h
> --- linux-original/include/acpi/processor.h	2004-01-18 19:13:09.000000000 +0100
> +++ linux/include/acpi/processor.h	2004-01-19 23:48:44.000000000 +0100
> @@ -67,6 +67,8 @@
>  	acpi_integer		status;			/* success indicator */
>  };
>  
> +#define ACPI_PDC_REVISION_ID                   0x1
> +
>  struct acpi_processor_performance {
>  	unsigned int		 state;
>  	unsigned int		 platform_limit;
> @@ -74,9 +76,13 @@
>  	struct acpi_pct_register status_register;
>  	unsigned int		 state_count;
>  	struct acpi_processor_px states[ACPI_PROCESSOR_MAX_PERFORMANCE];
> +
> +	/* the _PDC objects passed by the driver, if any */
> +	struct acpi_object_list *pdc;
>  };
>  
> 
> +
>  /* Throttling Control */
>  
>  struct acpi_processor_tx {
