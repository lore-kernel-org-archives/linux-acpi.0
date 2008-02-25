From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [patch 2.6.25-rc2-git] crosslink ACPI and "real" device nodes
Date: Tue, 26 Feb 2008 05:47:08 +0800
Message-ID: <1203976028.10256.87.camel@acpi-hp-zz.sh.intel.com>
References: <200802222154.25204.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47683 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbYBZGeL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Feb 2008 01:34:11 -0500
In-Reply-To: <200802222154.25204.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org


On Sat, 2008-02-23 at 13:54 +0800, David Brownell wrote:
> Add cross-links between ACPI device and "real" devices in sysfs,
> exposing otherwise-hidden interrelationships between the various
> device nodes for ACPI stuff.  As a representative example, one
> hardware device is exposed as two logical devices (PNP and ACPI):
> 
>   .../pnp0/00:06/
>   .../LNXSYSTM:00/device:00/PNP0A03:00/device:15/PNP0B00:00/
> 
> The PNP device gets a "firmware_node" link pointing to the ACPI
> device,
> and is what a Linux device driver binds to.  The ACPI device has
> instead
> a "physical_node" link pointing back to the PNP device.  Other
> firmware
> frameworks, like OpenFirmware, could do the same thing to couple their
> firmware tables to the rest of the system.
> 
> (Based on a patch from Zhang Rui.  This version is modified to not
> depend on the patch makig ACPI initialize driver model wakeup flags.)
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> Cc: Zhang Rui <rui.zhang@intel.com>
> ---
> Another extract from the "teach ACPI how to use driver model wakeup
> flags" patch series.  The linkage helps sort out confusion about which
> devices are wakeup-capable, among other things, and can help when
> interpreting /proc/acpi/wakeup contents.
> 
>  drivers/acpi/glue.c |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> --- g26.orig/drivers/acpi/glue.c        2008-02-22 20:39:19.000000000
> -0800
> +++ g26/drivers/acpi/glue.c     2008-02-22 20:46:40.000000000 -0800
> @@ -142,6 +142,7 @@ EXPORT_SYMBOL(acpi_get_physical_device);
> 
>  static int acpi_bind_one(struct device *dev, acpi_handle handle)
>  {
> +       struct acpi_device *acpi_dev;
>         acpi_status status;
> 
>         if (dev->archdata.acpi_handle) {
> @@ -157,6 +158,16 @@ static int acpi_bind_one(struct device *
>         }
>         dev->archdata.acpi_handle = handle;
> 
> +       status = acpi_bus_get_device(handle, &acpi_dev);
> +       if (!ACPI_FAILURE(status)) {
> +               int ret;
> +
> +               ret = sysfs_create_link(&dev->kobj,
> &acpi_dev->dev.kobj,
> +                               "firmware_node");
> +               ret = sysfs_create_link(&acpi_dev->dev.kobj,
> &dev->kobj,
> +                               "physical_node");
> +       }
ret is not needed here...

>         return 0;
>  }
> 
> @@ -165,8 +176,17 @@ static int acpi_unbind_one(struct device
>         if (!dev->archdata.acpi_handle)
>                 return 0;
>         if (dev ==
> acpi_get_physical_device(dev->archdata.acpi_handle)) {
> +               struct acpi_device *acpi_dev;
> +
>                 /* acpi_get_physical_device increase refcnt by one */
>                 put_device(dev);
> +
> +               if (!acpi_bus_get_device(dev->archdata.acpi_handle,
> +                                       &acpi_dev)) {
> +                       sysfs_remove_link(&dev->kobj,
> "firmware_node");
> +                       sysfs_remove_link(&acpi_dev->dev.kobj,
> "physical_node");
> +               }
> +
>                 acpi_detach_data(dev->archdata.acpi_handle,
>                                  acpi_glue_data_handler);
>                 dev->archdata.acpi_handle = NULL;
> 
> 

