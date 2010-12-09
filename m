From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/6] ACPICA: Implicit notify support
Date: Thu, 9 Dec 2010 23:30:43 +0100
Message-ID: <201012092330.43478.rjw@sisk.pl>
References: <1291651138.2197.86.camel@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42049 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752614Ab0LIWb3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Dec 2010 17:31:29 -0500
In-Reply-To: <1291651138.2197.86.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

On Monday, December 06, 2010, Lin Ming wrote:
> This feature provides an automatic device notification for wake devices
> when a wakeup GPE occurs and there is no corresponding GPE method or
> handler. Rather than ignoring such a GPE, an implicit AML Notify
> operation is performed on the parent device object.
> This feature is not part of the ACPI specification and is provided for
> Windows compatibility only. 
> 
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>

This patch does two things at a time, while only one is mentioned in the
changelog.  The second one is that you change the local variable in
acpi_ev_asynch_execute_gpe_method() back into a pointer:

...
>  
>  static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
>  {
> -	struct acpi_gpe_event_info *gpe_event_info = (void *)context;
> +	struct acpi_gpe_event_info *gpe_event_info = context;
>  	acpi_status status;
> -	struct acpi_gpe_event_info local_gpe_event_info;
> +	struct acpi_gpe_event_info *local_gpe_event_info;
>  	struct acpi_evaluate_info *info;
>  
>  	ACPI_FUNCTION_TRACE(ev_asynch_execute_gpe_method);
>  
> +	/* Allocate a local GPE block */
> +
> +	local_gpe_event_info =
> +	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_gpe_event_info));
> +	if (!local_gpe_event_info) {
> +		ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY, "while handling a GPE"));
> +		return_VOID;
> +	}
> +
>  	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
>  	if (ACPI_FAILURE(status)) {
>  		return_VOID;
> @@ -468,7 +479,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
>  	 * Take a snapshot of the GPE info for this level - we copy the info to
>  	 * prevent a race condition with remove_handler/remove_block.
>  	 */
> -	ACPI_MEMCPY(&local_gpe_event_info, gpe_event_info,
> +	ACPI_MEMCPY(local_gpe_event_info, gpe_event_info,
>  		    sizeof(struct acpi_gpe_event_info));
> 

etc. and that should go into a separate patch.

I mean, first fix this local variable mess and _then_ introdiuce the new
feature.  Doing both in one step is guaranteed to confuse people.

Thanks,
Rafael
