From: Andrew Morton <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] acpi: Add IBM R60E laptop to proc-idle blacklist
Date: Mon, 19 Jun 2006 20:33:33 -0700
Message-ID: <20060619203333.5e897ead.akpm@osdl.org>
References: <4491BC6B.5000704@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:36015 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965451AbWFTDdr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Jun 2006 23:33:47 -0400
In-Reply-To: <4491BC6B.5000704@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org

On Thu, 15 Jun 2006 13:00:43 -0700
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> [UBUNTU:acpi] Add IBM R60E laptop to proc-idle blacklist.
> 
> Reference: https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/38228
> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commit;h=ce5e62bc55056049d192c422b6032f6a406e0ba2
> 
> Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> ---
>  drivers/acpi/processor_idle.c |    3 +++
>  1 files changed, 3 insertions(+)
> 
> --- linux-2617-rc6g7.orig/drivers/acpi/processor_idle.c
> +++ linux-2617-rc6g7/drivers/acpi/processor_idle.c
> @@ -142,6 +142,9 @@ static struct dmi_system_id __cpuinitdat
>  	{ set_max_cstate, "IBM ThinkPad R40e", {
>  	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>  	  DMI_MATCH(DMI_BIOS_VERSION,"1SET68WW") }, (void*)1},
> +	{ set_max_cstate, "IBM ThinkPad R40e", {
> +	  DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
> +	  DMI_MATCH(DMI_BIOS_VERSION, "1SET70WW") }, (void*)1},
>  	{ set_max_cstate, "Medion 41700", {
>  	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
>  	  DMI_MATCH(DMI_BIOS_VERSION,"R01-A1J")}, (void *)1},
> 

It seems that every R40e in the world is in that table.

Can/should we wildcard it?  From my reading of dmi_check_system(), we can use
"" in place of the "1SET..." string and it'll dtrt?
