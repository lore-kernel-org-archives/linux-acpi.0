From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 2.6] (1/5) move _PCT and _PSS access to
	drivers/acpi/processor.c
Date: 31 Jan 2004 00:41:55 -0500
Sender: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
Message-ID: <1075527715.2448.19.camel@dhcppc4>
References: <20040129105846.GA5372@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
In-Reply-To: <20040129105846.GA5372@dominikbrodowski.de>
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

On Thu, 2004-01-29 at 05:58, Dominik Brodowski wrote:
> Applies on top of acpi-2.6.{1,2}-test
> 
> Move the _PSS and _PCT access to drivers/acpi/processor.c so that it can be
> used by various low-level drivers (centrino, acpi-io, powernow-k{7,8}, ...)
> 
>  arch/i386/kernel/cpu/cpufreq/acpi.c |  209 ----------------------------------
>  drivers/acpi/processor.c            |  217 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 217 insertions(+), 209 deletions(-)
> 
> diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c linux/arch/i386/kernel/cpu/cpufreq/acpi.c
> --- linux-original/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-01-18 13:12:13.820288392 +0100
> +++ linux/arch/i386/kernel/cpu/cpufreq/acpi.c	2004-01-18 13:48:30.386400048 +0100
> @@ -55,179 +55,6 @@
>  static struct acpi_processor_performance	*performance[NR_CPUS];
>  
> 
> -static int 
> -acpi_processor_get_performance_control (
> -	struct acpi_processor_performance *perf)
> -{
> -	int			result = 0;
> -	acpi_status		status = 0;
> -	struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> -	union acpi_object	*pct = NULL;
> -	union acpi_object	obj = {0};
> -	struct acpi_pct_register *reg = NULL;
> -
> -	ACPI_FUNCTION_TRACE("acpi_processor_get_performance_control");
> -
> -	status = acpi_evaluate_object(perf->pr->handle, "_PCT", NULL, &buffer);
> -	if(ACPI_FAILURE(status)) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PCT\n"));
> -		return_VALUE(-ENODEV);
> -	}
> -
> -	pct = (union acpi_object *) buffer.pointer;
> -	if (!pct || (pct->type != ACPI_TYPE_PACKAGE) 
> -		|| (pct->package.count != 2)) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PCT data\n"));
> -		result = -EFAULT;
> -		goto end;
> -	}
> -
> -	/*
> -	 * control_register
> -	 */
> -
> -	obj = pct->package.elements[0];
> -
> -	if ((obj.type != ACPI_TYPE_BUFFER) 
> -		|| (obj.buffer.length < sizeof(struct acpi_pct_register)) 
> -		|| (obj.buffer.pointer == NULL)) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
> -			"Invalid _PCT data (control_register)\n"));
> -		result = -EFAULT;
> -		goto end;
> -	}
> -
> -	reg = (struct acpi_pct_register *) (obj.buffer.pointer);
> -
> -	if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> -			"Unsupported address space [%d] (control_register)\n",
> -			(u32) reg->space_id));
> -		result = -EFAULT;
> -		goto end;
> -	}
> -
> -	perf->control_register = (u16) reg->address;
> -	perf->control_register_bit_width = reg->bit_width;
> -	/*
> -	 * status_register
> -	 */
> -
> -	obj = pct->package.elements[1];
> -
> -	if ((obj.type != ACPI_TYPE_BUFFER) 
> -		|| (obj.buffer.length < sizeof(struct acpi_pct_register)) 
> -		|| (obj.buffer.pointer == NULL)) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
> -			"Invalid _PCT data (status_register)\n"));
> -		result = -EFAULT;
> -		goto end;
> -	}
> -
> -	reg = (struct acpi_pct_register *) (obj.buffer.pointer);
> -
> -	if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> -			"Unsupported address space [%d] (status_register)\n",
> -			(u32) reg->space_id));
> -		result = -EFAULT;
> -		goto end;
> -	}
> -
> -	perf->status_register = (u16) reg->address;
> -	perf->status_register_bit_width = reg->bit_width;
> -
> -	ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
> -		"control_register[0x%04x] status_register[0x%04x]\n",
> -		perf->control_register,
> -		perf->status_register));
> -
> -end:
> -	acpi_os_free(buffer.pointer);
> -
> -	return_VALUE(result);
> -}
> -
> -
> -static int 
> -acpi_processor_get_performance_states (
> -	struct acpi_processor_performance *	perf)
> -{
> -	int			result = 0;
> -	acpi_status		status = AE_OK;
> -	struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> -	struct acpi_buffer	format = {sizeof("NNNNNN"), "NNNNNN"};
> -	struct acpi_buffer	state = {0, NULL};
> -	union acpi_object 	*pss = NULL;
> -	int			i = 0;
> -
> -	ACPI_FUNCTION_TRACE("acpi_processor_get_performance_states");
> -
> -	status = acpi_evaluate_object(perf->pr->handle, "_PSS", NULL, &buffer);
> -	if(ACPI_FAILURE(status)) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PSS\n"));
> -		return_VALUE(-ENODEV);
> -	}
> -
> -	pss = (union acpi_object *) buffer.pointer;
> -	if (!pss || (pss->type != ACPI_TYPE_PACKAGE)) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSS data\n"));
> -		result = -EFAULT;
> -		goto end;
> -	}
> -
> -	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d performance states\n", 
> -		pss->package.count));
> -
> -	if (pss->package.count > ACPI_PROCESSOR_MAX_PERFORMANCE) {
> -		perf->state_count = ACPI_PROCESSOR_MAX_PERFORMANCE;
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
> -			"Limiting number of states to max (%d)\n", 
> -			ACPI_PROCESSOR_MAX_PERFORMANCE));
> -	}
> -	else
> -		perf->state_count = pss->package.count;
> -
> -	for (i = 0; i < perf->state_count; i++) {
> -
> -		struct acpi_processor_px *px = &(perf->states[i]);
> -
> -		state.length = sizeof(struct acpi_processor_px);
> -		state.pointer = px;
> -
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Extracting state %d\n", i));
> -
> -		status = acpi_extract_package(&(pss->package.elements[i]), 
> -			&format, &state);
> -		if (ACPI_FAILURE(status)) {
> -			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSS data\n"));
> -			result = -EFAULT;
> -			goto end;
> -		}
> -
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
> -			"State [%d]: core_frequency[%d] power[%d] transition_latency[%d] bus_master_latency[%d] control[0x%x] status[0x%x]\n",
> -			i, 
> -			(u32) px->core_frequency, 
> -			(u32) px->power, 
> -			(u32) px->transition_latency, 
> -			(u32) px->bus_master_latency,
> -			(u32) px->control, 
> -			(u32) px->status));
> -
> -		if (!px->core_frequency) {
> -			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "core_frequency is 0\n"));
> -			result = -EFAULT;
> -			goto end;
> -		}
> -	}
> -
> -end:
> -	acpi_os_free(buffer.pointer);
> -
> -	return_VALUE(result);
> -}
> -
>  static int
>  acpi_processor_write_port(
>  	u16	port,
> @@ -567,38 +394,6 @@
>  
> 
>  static int
> -acpi_processor_get_performance_info (
> -	struct acpi_processor_performance	*perf)
> -{
> -	int			result = 0;
> -	acpi_status		status = AE_OK;
> -	acpi_handle		handle = NULL;
> -
> -	ACPI_FUNCTION_TRACE("acpi_processor_get_performance_info");
> -
> -	if (!perf || !perf->pr || !perf->pr->handle)
> -		return_VALUE(-EINVAL);
> -
> -	status = acpi_get_handle(perf->pr->handle, "_PCT", &handle);
> -	if (ACPI_FAILURE(status)) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
> -			"ACPI-based processor performance control unavailable\n"));
> -		return_VALUE(-ENODEV);
> -	}
> -
> -	result = acpi_processor_get_performance_control(perf);
> -	if (result)
> -		return_VALUE(result);
> -
> -	result = acpi_processor_get_performance_states(perf);
> -	if (result)
> -		return_VALUE(result);
> -
> -	return_VALUE(0);
> -}
> -
> -
> -static int
>  acpi_cpufreq_cpu_init (
>  	struct cpufreq_policy   *policy)
>  {
> @@ -620,10 +415,6 @@
>  	if (result)
>  		goto err_free;
>  
> -	result = acpi_processor_get_performance_info(perf);
> -	if (result)
> -		goto err_unreg;
> -
>  	/* capability check */
>  	if (perf->state_count <= 1)
>  		goto err_unreg;
> diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
> --- linux-original/drivers/acpi/processor.c	2004-01-18 13:12:13.822288088 +0100
> +++ linux/drivers/acpi/processor.c	2004-01-18 13:48:21.036821400 +0100
> @@ -855,6 +855,217 @@
>  	acpi_processor_ppc_is_init = 0;
>  }
>  
> +/*
> + * when registering a cpufreq driver with this ACPI processor driver, the
> + * _PCT and _PSS structures are read out and written into struct
> + * acpi_processor_performance.
> + */
> +
> +static int 
> +acpi_processor_get_performance_control (
> +	struct acpi_processor *pr)
> +{
> +	int			result = 0;
> +	acpi_status		status = 0;
> +	struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +	union acpi_object	*pct = NULL;
> +	union acpi_object	obj = {0};
> +	struct acpi_pct_register *reg = NULL;
> +
> +	ACPI_FUNCTION_TRACE("acpi_processor_get_performance_control");
> +
> +	status = acpi_evaluate_object(pr->handle, "_PCT", NULL, &buffer);
> +	if(ACPI_FAILURE(status)) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PCT\n"));
> +		return_VALUE(-ENODEV);
> +	}
> +
> +	pct = (union acpi_object *) buffer.pointer;
> +	if (!pct || (pct->type != ACPI_TYPE_PACKAGE) 
> +		|| (pct->package.count != 2)) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PCT data\n"));
> +		result = -EFAULT;
> +		goto end;
> +	}
> +
> +	/*
> +	 * control_register
> +	 */
> +
> +	obj = pct->package.elements[0];
> +
> +	if ((obj.type != ACPI_TYPE_BUFFER) 
> +		|| (obj.buffer.length < sizeof(struct acpi_pct_register)) 
> +		|| (obj.buffer.pointer == NULL)) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
> +			"Invalid _PCT data (control_register)\n"));
> +		result = -EFAULT;
> +		goto end;
> +	}
> +
> +	reg = (struct acpi_pct_register *) (obj.buffer.pointer);
> +
> +	if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> +			"Unsupported address space [%d] (control_register)\n",
> +			(u32) reg->space_id));
> +		result = -EFAULT;
> +		goto end;
> +	}
> +
> +	pr->performance->control_register = (u16) reg->address;
> +	pr->performance->control_register_bit_width = reg->bit_width;
> +	/*
> +	 * status_register
> +	 */
> +
> +	obj = pct->package.elements[1];
> +
> +	if ((obj.type != ACPI_TYPE_BUFFER) 
> +		|| (obj.buffer.length < sizeof(struct acpi_pct_register)) 
> +		|| (obj.buffer.pointer == NULL)) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
> +			"Invalid _PCT data (status_register)\n"));
> +		result = -EFAULT;
> +		goto end;
> +	}
> +
> +	reg = (struct acpi_pct_register *) (obj.buffer.pointer);
> +
> +	if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> +			"Unsupported address space [%d] (status_register)\n",
> +			(u32) reg->space_id));
> +		result = -EFAULT;
> +		goto end;
> +	}
> +
> +	pr->performance->status_register = (u16) reg->address;
> +	pr->performance->status_register_bit_width = reg->bit_width;
> +
> +	ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
> +		"control_register[0x%04x] status_register[0x%04x]\n",
> +		pr->performance->control_register,
> +		pr->performance->status_register));
> +
> +end:
> +	acpi_os_free(buffer.pointer);
> +
> +	return_VALUE(result);
> +}
> +
> +
> +static int 
> +acpi_processor_get_performance_states (
> +	struct acpi_processor	*pr)
> +{
> +	int			result = 0;
> +	acpi_status		status = AE_OK;
> +	struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +	struct acpi_buffer	format = {sizeof("NNNNNN"), "NNNNNN"};
> +	struct acpi_buffer	state = {0, NULL};
> +	union acpi_object 	*pss = NULL;
> +	int			i = 0;
> +
> +	ACPI_FUNCTION_TRACE("acpi_processor_get_performance_states");
> +
> +	status = acpi_evaluate_object(pr->handle, "_PSS", NULL, &buffer);
> +	if(ACPI_FAILURE(status)) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PSS\n"));
> +		return_VALUE(-ENODEV);
> +	}
> +
> +	pss = (union acpi_object *) buffer.pointer;
> +	if (!pss || (pss->type != ACPI_TYPE_PACKAGE)) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSS data\n"));
> +		result = -EFAULT;
> +		goto end;
> +	}
> +
> +	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d performance states\n", 
> +		pss->package.count));
> +
> +	if (pss->package.count > ACPI_PROCESSOR_MAX_PERFORMANCE) {
> +		pr->performance->state_count = ACPI_PROCESSOR_MAX_PERFORMANCE;
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
> +			"Limiting number of states to max (%d)\n", 
> +			ACPI_PROCESSOR_MAX_PERFORMANCE));
> +	}
> +	else
> +		pr->performance->state_count = pss->package.count;
> +
> +	for (i = 0; i < pr->performance->state_count; i++) {
> +
> +		struct acpi_processor_px *px = &(pr->performance->states[i]);
> +
> +		state.length = sizeof(struct acpi_processor_px);
> +		state.pointer = px;
> +
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Extracting state %d\n", i));
> +
> +		status = acpi_extract_package(&(pss->package.elements[i]), 
> +			&format, &state);
> +		if (ACPI_FAILURE(status)) {
> +			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSS data\n"));
> +			result = -EFAULT;
> +			goto end;
> +		}
> +
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
> +			"State [%d]: core_frequency[%d] power[%d] transition_latency[%d] bus_master_latency[%d] control[0x%x] status[0x%x]\n",
> +			i, 
> +			(u32) px->core_frequency, 
> +			(u32) px->power, 
> +			(u32) px->transition_latency, 
> +			(u32) px->bus_master_latency,
> +			(u32) px->control, 
> +			(u32) px->status));
> +
> +		if (!px->core_frequency) {
> +			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "core_frequency is 0\n"));
> +			result = -EFAULT;
> +			goto end;
> +		}
> +	}
> +
> +end:
> +	acpi_os_free(buffer.pointer);
> +
> +	return_VALUE(result);
> +}
> +
> +
> +static int
> +acpi_processor_get_performance_info (
> +	struct acpi_processor	*pr)
> +{
> +	int			result = 0;
> +	acpi_status		status = AE_OK;
> +	acpi_handle		handle = NULL;
> +
> +	ACPI_FUNCTION_TRACE("acpi_processor_get_performance_info");
> +
> +	if (!pr || !pr->performance || !pr->handle)
> +		return_VALUE(-EINVAL);
> +
> +	status = acpi_get_handle(pr->handle, "_PCT", &handle);
> +	if (ACPI_FAILURE(status)) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
> +			"ACPI-based processor performance control unavailable\n"));
> +		return_VALUE(-ENODEV);
> +	}
> +
> +	result = acpi_processor_get_performance_control(pr);
> +	if (result)
> +		return_VALUE(result);
> +
> +	result = acpi_processor_get_performance_states(pr);
> +	if (result)
> +		return_VALUE(result);
> +
> +	return_VALUE(0);
> +}
> +
>  
>  int 
>  acpi_processor_register_performance (
> @@ -884,6 +1095,12 @@
>  	pr->performance = performance;
>  	performance->pr = pr;
>  
> +	if (acpi_processor_get_performance_info(pr)) {
> +		pr->performance = NULL;
> +		up(&performance_sem);
> +		return_VALUE(-EIO);
> +	}
> +
>  	up(&performance_sem);
>  	return_VALUE(0);
>  }
