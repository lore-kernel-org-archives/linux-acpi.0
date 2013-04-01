From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Mon, 01 Apr 2013 09:53:36 +0800
Message-ID: <5158E8A0.3050904@intel.com>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36904 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754589Ab3DABwU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 31 Mar 2013 21:52:20 -0400
In-Reply-To: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>

On 02/12/2013 12:21 AM, Seth Forshee wrote:
> The AML implementation for brightness control on several ThinkPads
> contains a workaround to meet a Windows 8 requirement of 101 brightness
> levels [1]. The implementation is flawed, as only 16 of the brighness
> values reported by _BCL affect a change in brightness. _BCM silently
> discards the rest of the values. Disabling Windows 8 compatibility on
> these machines reverts them to the old behavior, making _BCL only report
> the 16 brightness levels which actually work. Add a quirk to do this
> along with a dmi callback to disable Win8 compatibility.

If we disable the _BQC(i.e. set cap._BQC=0) for these systems, will the
problem go away? If so, I think perhaps we can put these systems into a
_BQC quirk table and set cap._BQC=0 for them.

Thanks,
Aaron

> 
> [1] http://msdn.microsoft.com/en-us/library/windows/hardware/jj128256.aspx
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=51231
> BugLink: http://bugs.launchpad.net/bugs/1098216
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> ---
> 
> This has been discussed previously at [2], however the description of
> the problem there is incorrect. _BCM simply discards any value written
> that isn't one of the brightness levels returned by _BCL for non-Win8
> systems; it does not do any rounding.
> 
> This patch quirks six machines that have been confirmed to have this
> problem, but there may be others. I looked for some way to do this other
> than quirking for individual models, but unfortunately I couldn't find
> any other criteria which worked.
> 
> Thanks,
> Seth
> 
> [2] http://comments.gmane.org/gmane.linux.acpi.devel/58398
> 
> 
>  drivers/acpi/blacklist.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index cb96296..6c242ed 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -193,6 +193,13 @@ static int __init dmi_disable_osi_win7(const struct dmi_system_id *d)
>  	return 0;
>  }
>  
> +static int __init dmi_disable_osi_win8(const struct dmi_system_id *d)
> +{
> +	printk(KERN_NOTICE PREFIX "DMI detected: %s\n", d->ident);
> +	acpi_osi_setup("!Windows 2012");
> +	return 0;
> +}
> +
>  static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>  	{
>  	.callback = dmi_disable_osi_vista,
> @@ -269,6 +276,61 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>  	},
>  
>  	/*
> +	 * The following Lenovo models have a broken workaround in the
> +	 * acpi_video backlight implementation to meet the Windows 8
> +	 * requirement of 101 backlight levels. Reverting to pre-Win8
> +	 * behavior fixes the problem.
> +	 */
> +	{
> +	.callback = dmi_disable_osi_win8,
> +	.ident = "Lenovo ThinkPad L430",
> +	.matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L430"),
> +		},
> +	},
> +	{
> +	.callback = dmi_disable_osi_win8,
> +	.ident = "Lenovo ThinkPad T430s",
> +	.matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T430s"),
> +		},
> +	},
> +	{
> +	.callback = dmi_disable_osi_win8,
> +	.ident = "Lenovo ThinkPad T530",
> +	.matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T530"),
> +		},
> +	},
> +	{
> +	.callback = dmi_disable_osi_win8,
> +	.ident = "Lenovo ThinkPad W530",
> +	.matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W530"),
> +		},
> +	},
> +	{
> +	.callback = dmi_disable_osi_win8,
> +	.ident = "Lenovo ThinkPad X1 Carbon",
> +	.matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X1 Carbon"),
> +		},
> +	},
> +	{
> +	.callback = dmi_disable_osi_win8,
> +	.ident = "Lenovo ThinkPad X230",
> +	.matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X230"),
> +		},
> +	},
> +
> +	/*
>  	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
>  	 * Linux ignores it, except for the machines enumerated below.
>  	 */
> 

