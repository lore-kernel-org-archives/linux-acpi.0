From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC] acpi: Fix unprotected smp_processor_id() in acpi_processor_cst_has_changed()
Date: Tue, 28 Feb 2012 11:43:20 +0530
Message-ID: <4F4C7080.2090200@linux.vnet.ibm.com>
References: <20120223205805.GA31838@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:34515 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233Ab2B1GNo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Feb 2012 01:13:44 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 28 Feb 2012 06:11:11 +1000
In-Reply-To: <20120223205805.GA31838@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: deepthi@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org

On 02/24/2012 02:28 AM, Paul E. McKenney wrote:

> The acpi_processor_cst_has_changed() function is invoked from a
> CPU_ONLINE or CPU_DEAD function, which might well execute on CPU 0
> even though the CPU being hotplugged is some other CPU.  In addition,
> acpi_processor_cst_has_changed() invokes smp_processor_id() without
> protection, resulting in splats when onlining CPUs.
> 
> This commit therefore changes the smp_processor_id() to pr->id, as is
> used elsewhere in the code, for example, in acpi_processor_add().
> 
> This works for me, but I don't claim to understand ACPI.
> 
> Signed-off-by: Paul E. McKenney <paul.mckenney@linaro.org>
>


This looks like the right fix to me, observing the disparity between what
the comment says (and hence what was intended) vs what the code originally
did.

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 0e8e2de..9e57b06 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1159,8 +1159,7 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
>  	 * to make the code that updates C-States be called once.
>  	 */
> 
> -	if (smp_processor_id() == 0 &&
> -			cpuidle_get_driver() == &acpi_idle_driver) {
> +	if (pr->id == 0 && cpuidle_get_driver() == &acpi_idle_driver) {
> 
>  		cpuidle_pause_and_lock();
>  		/* Protect against cpu-hotplug */
> 

 
Regards,
Srivatsa S. Bhat

