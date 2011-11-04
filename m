From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH] ACPI: Export FADT pm_profile integer value to userspace
Date: Fri, 4 Nov 2011 23:25:48 +0100
Message-ID: <201111042325.48583.rjw@sisk.pl>
References: <1320374026-4913-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51483 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754814Ab1KDWXO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Nov 2011 18:23:14 -0400
In-Reply-To: <1320374026-4913-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Len Brown (Intel)" <len.brown@intel.com>

On Friday, November 04, 2011, Thomas Renninger wrote:
> There are a lot userspace approaches to detect the usage of the
> platform (laptop, workstation, server, ...) and adjust kernel tunables
> accordingly (io/process scheduler, power management, ...).
> 
> These approaches need constant maintaining and are ugly to implement
> (detect PCMCIA controller -> laptop,
> does not work on recent systems anymore, ...)
> On ACPI systems there is an easy and reliable way (if implemented
> in BIOS and most recent platforms have this value set).
> -> export it to userspace.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: lenb@kernel.org

This is for Len, I guess?

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

Thanks,
Rafael


> ---
>  Documentation/ABI/stable/sysfs-acpi-pmprofile |   22 ++++++++++++++++++++++
>  drivers/acpi/sysfs.c                          |   14 +++++++++++++-
>  2 files changed, 35 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/ABI/stable/sysfs-acpi-pmprofile
> 
> diff --git a/Documentation/ABI/stable/sysfs-acpi-pmprofile b/Documentation/ABI/stable/sysfs-acpi-pmprofile
> new file mode 100644
> index 0000000..964c7a8
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-acpi-pmprofile
> @@ -0,0 +1,22 @@
> +What: 		/sys/firmware/acpi/pm_profile
> +Date:		03-Nov-2011
> +KernelVersion:	v3.2
> +Contact:	linux-acpi@vger.kernel.org
> +Description: 	The ACPI pm_profile sysfs interface exports the platform
> +		power management (and performance) requirement expectations
> +		as provided by BIOS. The integer value is directly passed as
> +		retrieved from the FADT ACPI table.
> +Values:         For possible values see ACPI specification:
> +		5.2.9 Fixed ACPI Description Table (FADT)
> +		Field: Preferred_PM_Profile
> +
> +		Currently these values are defined by spec:
> +		0 Unspecified
> +		1 Desktop
> +		2 Mobile
> +		3 Workstation
> +		4 Enterprise Server
> +		5 SOHO Server
> +		6 Appliance PC
> +		7 Performance Server
> +		>7 Reserved
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index c538d0e..9f66181 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -706,11 +706,23 @@ static void __exit interrupt_stats_exit(void)
>  	return;
>  }
>  
> +static ssize_t
> +acpi_show_profile(struct device *dev, struct device_attribute *attr,
> +		  char *buf)
> +{
> +	return sprintf(buf, "%d\n", acpi_gbl_FADT.preferred_profile);
> +}
> +
> +static const struct device_attribute pm_profile_attr =
> +	__ATTR(pm_profile, S_IRUGO, acpi_show_profile, NULL);
> +
>  int __init acpi_sysfs_init(void)
>  {
>  	int result;
>  
>  	result = acpi_tables_sysfs_init();
> -
> +	if (result)
> +		return result;
> +	result = sysfs_create_file(acpi_kobj, &pm_profile_attr.attr);
>  	return result;
>  }
> 

