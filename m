From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 4/6] ACPI: dock: add struct dock_station * directly to
	platform device data
Date: Sat, 10 Oct 2009 15:52:30 +0800
Message-ID: <20091010075230.GA7473@sli10-desk.sh.intel.com>
References: <20091007220509.15597.65501.stgit@bob.kio> <20091007220747.15597.90592.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3395 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192AbZJJHxI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Oct 2009 03:53:08 -0400
Content-Disposition: inline
In-Reply-To: <20091007220747.15597.90592.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Oct 08, 2009 at 06:07:47AM +0800, Alex Chiang wrote:
> Instead of adding a (struct dock_station **) to our dock device's
> platform data, we can add the (struct dock_station *) directly.
> 
> This change saves us some silly casting.
> 
> Signed-off-by: Alex Chiang <achiang@hp.com>
> ---
> 
>  drivers/acpi/dock.c |   19 +++++++------------
>  1 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> index 1d693a1..e53d49b 100644
> --- a/drivers/acpi/dock.c
> +++ b/drivers/acpi/dock.c
> @@ -857,8 +857,7 @@ static ssize_t show_docked(struct device *dev,
>  {
>  	struct acpi_device *tmp;
>  
> -	struct dock_station *dock_station = *((struct dock_station **)
> -		dev->platform_data);
> +	struct dock_station *dock_station = dev->platform_data;
>  
>  	if (ACPI_SUCCESS(acpi_bus_get_device(dock_station->handle, &tmp)))
>  		return snprintf(buf, PAGE_SIZE, "1\n");
> @@ -872,8 +871,7 @@ static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
>  static ssize_t show_flags(struct device *dev,
>  			  struct device_attribute *attr, char *buf)
>  {
> -	struct dock_station *dock_station = *((struct dock_station **)
> -		dev->platform_data);
> +	struct dock_station *dock_station = dev->platform_data;
>  	return snprintf(buf, PAGE_SIZE, "%d\n", dock_station->flags);
>  
>  }
> @@ -886,8 +884,7 @@ static ssize_t write_undock(struct device *dev, struct device_attribute *attr,
>  			   const char *buf, size_t count)
>  {
>  	int ret;
> -	struct dock_station *dock_station = *((struct dock_station **)
> -		dev->platform_data);
> +	struct dock_station *dock_station = dev->platform_data;
>  
>  	if (!count)
>  		return -EINVAL;
> @@ -905,8 +902,7 @@ static ssize_t show_dock_uid(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
>  {
>  	unsigned long long lbuf;
> -	struct dock_station *dock_station = *((struct dock_station **)
> -		dev->platform_data);
> +	struct dock_station *dock_station = dev->platform_data;
>  	acpi_status status = acpi_evaluate_integer(dock_station->handle,
>  					"_UID", NULL, &lbuf);
>  	if (ACPI_FAILURE(status))
> @@ -919,8 +915,7 @@ static DEVICE_ATTR(uid, S_IRUGO, show_dock_uid, NULL);
>  static ssize_t show_dock_type(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> -	struct dock_station *dock_station = *((struct dock_station **)
> -		dev->platform_data);
> +	struct dock_station *dock_station = dev->platform_data;
>  	char *type;
>  
>  	if (dock_station->flags & DOCK_IS_DOCK)
> @@ -972,8 +967,8 @@ static int dock_add(acpi_handle handle)
>  	if (ret)
>  		goto err_free;
>  
> -	platform_device_add_data(dock_device, &ds,
> -		sizeof(struct dock_station *));
> +	platform_device_add_data(dock_device, ds,
> +		sizeof(struct dock_station));

This patch isn't good. platform_device_add_data will malloc a new
'struct dock_station' and copy old to it, and later the two copy aren't
consistent. So NACK this one.

ACK other 5 patches.
