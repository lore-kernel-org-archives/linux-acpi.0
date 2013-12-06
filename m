From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI / blacklist: disable Win8 mode for ThinkPad X201
 and Latitude E6230
Date: Fri, 06 Dec 2013 14:18:41 +0800
Message-ID: <52A16C41.9020203@intel.com>
References: <52A15F72.1050408@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47414 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051Ab3LFGSz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Dec 2013 01:18:55 -0500
In-Reply-To: <52A15F72.1050408@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Jeffery To <jeffery.to@gmail.com>, Wouter Depypere <wouter.depypere@ugent.be>, Len Brown <lenb@kernel.org>

Forgot to CC Len Brown, sorry.

-Aaron

On 12/06/2013 01:24 PM, Aaron Lu wrote:
> Both ThinkPad X201 and Latitude E6230 have problems under Win8 mode,
> so blacklist Win8 mode for them.
> 
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=60697
> Reported-and-tested-by: Jeffery To <jeffery.to@gmail.com>
> Reported-and-tested-by: Wouter Depypere <wouter.depypere@ugent.be>
> Cc: 3.8 and above <stable@vger.kernel.org>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>  drivers/acpi/blacklist.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index 05ee8f61bfb5..97a8e395f72e 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -324,6 +324,32 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>  	},
>  
>  	/*
> +	 * The bluetooth functionality is unconditionally enabled
> +	 * after a S3 cycle on Thinkpad X201 under Win8 mode.
> +	 */
> +	{
> +	.callback = dmi_disable_osi_win8,
> +	.ident = "ThinkPad X201",
> +	.matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201"),
> +		},
> +	},
> +
> +	/*
> +	 * The hardware switch for enable/disable wifi on
> +	 * Dell Latitude E6230 is broken under Win8 mode.
> +	 */
> +	{
> +	.callback = dmi_disable_osi_win8,
> +	.ident = "Dell Latitude E6230",
> +	.matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		     DMI_MATCH(DMI_PRODUCT_NAME, "Latitude E6230"),
> +		},
> +	},
> +
> +	/*
>  	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
>  	 * Linux ignores it, except for the machines enumerated below.
>  	 */
> 

