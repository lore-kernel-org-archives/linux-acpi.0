From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ACPI: dock: Don't eval _STA on every show_docked sysfs
 read
Date: Tue, 27 Jan 2009 13:04:55 -0800
Message-ID: <20090127130455.2c1b0cd4.akpm@linux-foundation.org>
References: <1232450304.5286.4.camel@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34662 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753397AbZA0VFp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Jan 2009 16:05:45 -0500
In-Reply-To: <1232450304.5286.4.camel@homac.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: hmacht@suse.de
Cc: linux-acpi@vger.kernel.org, stable@kernel.org, lenb@kernel.org, Li@suse.de, shaohua.li@intel.com, marvin@mydatex.cz

On Tue, 20 Jan 2009 12:18:24 +0100
Holger Macht <hmacht@suse.de> wrote:

> Cc: stable@kernel.org

The patch applied OK to 2.6.28 but not to any earlier kernel.  If we
decide that it should be backported to 2.6.27 or earlier, a new patch
might be needed for that.

> Some devices trigger a DEVICE_CHECK on every evalutation of _STA. This
> can also be seen in commit 8b59560a3baf2e7c24e0fb92ea5d09eca92805db
> (ACPI: dock: avoid check _STA method).  If an undock is processed, the
> dock driver sends a uevent and userspace might read the show_docked
> property in sysfs. This causes an evaluation of _STA of the particular
> device which causes the dock driver to immediately dock again.
> 
> In any case, evaluation of _STA (show_docked) does not necessarily mean
> that we are docked, so check with the internal device structure.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=12360
> 
> Signed-off-by: Holger Macht <hmacht@suse.de>
> ---
> 
> diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> index 5b30b8d..afd5db3 100644
> --- a/drivers/acpi/dock.c
> +++ b/drivers/acpi/dock.c
> @@ -855,10 +855,14 @@ fdd_out:
>  static ssize_t show_docked(struct device *dev,
>  			   struct device_attribute *attr, char *buf)
>  {
> +	struct acpi_device *tmp;
> +
>  	struct dock_station *dock_station = *((struct dock_station **)
>  		dev->platform_data);
> -	return snprintf(buf, PAGE_SIZE, "%d\n", dock_present(dock_station));
>  
> +	if (ACPI_SUCCESS(acpi_bus_get_device(dock_station->handle, &tmp)))
> +		return snprintf(buf, PAGE_SIZE, "1\n");
> +	return snprintf(buf, PAGE_SIZE, "0\n");
>  }
>  static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);

That seems a little overwrought.  Won't plain old strcpy suffice?


--- a/drivers/acpi/dock.c~acpi-dock-dont-eval-_sta-on-every-show_docked-sysfs-read-simplification
+++ a/drivers/acpi/dock.c
@@ -861,8 +861,8 @@ static ssize_t show_docked(struct device
 		dev->platform_data);
 
 	if (ACPI_SUCCESS(acpi_bus_get_device(dock_station->handle, &tmp)))
-		return snprintf(buf, PAGE_SIZE, "1\n");
-	return snprintf(buf, PAGE_SIZE, "0\n");
+		return strcpy(buf, "1\n");
+	return strcpy(buf, "0\n");
 }
 static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
 
_

