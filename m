From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH]: ACPI: Add the module param check for
	processor.max_cstate
Date: Fri, 24 Apr 2009 11:30:27 +0800
Message-ID: <1240543827.3651.70.camel@localhost.localdomain>
References: <1240539912.3651.68.camel@localhost.localdomain>
	 <alpine.LFD.2.00.0904232323410.15843@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38198 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbZDXD3z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Apr 2009 23:29:55 -0400
In-Reply-To: <alpine.LFD.2.00.0904232323410.15843@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2009-04-24 at 11:24 +0800, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> Subject: [PATCH] ACPI: prevent processor.max_cstate=0 boot crash
> 
> As processor.max_cstate is an init-time-only modparam,
> sanity checking it at init-time is sufficient.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=13142
This is also OK. And it is easier.

Thanks.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/processor_idle.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 6fe1214..436127e 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1037,6 +1037,9 @@ static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
>  		dev->states[i].desc[0] = '\0';
>  	}
>  
> +	if (max_cstate == 0)
> +		max_cstate = 1;
> +
>  	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++) {
>  		cx = &pr->power.states[i];
>  		state = &dev->states[count];

