From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 06/10] ACPI / scan: Add acpi_dev_get_next_child()
Date: Thu, 02 Jul 2015 01:39:52 +0200
Message-ID: <1516448.2XgHR7bxIM@vostro.rjw.lan>
References: <1435676108-20590-1-git-send-email-tomeu.vizoso@collabora.com> <1435676108-20590-7-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46358 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751862AbbGAXNc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2015 19:13:32 -0400
In-Reply-To: <1435676108-20590-7-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tuesday, June 30, 2015 04:55:04 PM Tomeu Vizoso wrote:
> So fwnode_get_next_child_node() can be implemented for ACPI firmware
> nodes.
> 
> This re-implements acpi_get_next_child() in terms of
> acpi_dev_get_next_child().
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Looks good to me.


> ---
> 
>  drivers/acpi/scan.c  |  5 ++---
>  include/linux/acpi.h | 17 +++++++++++++++--
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 2649a06..45cf1b7 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1482,10 +1482,9 @@ int acpi_device_add(struct acpi_device *device,
>  	return result;
>  }
>  
> -struct acpi_device *acpi_get_next_child(struct device *dev,
> -					struct acpi_device *child)
> +struct acpi_device *acpi_dev_get_next_child(struct acpi_device *adev,
> +					    struct acpi_device *child)
>  {
> -	struct acpi_device *adev = ACPI_COMPANION(dev);
>  	struct list_head *head, *next;
>  
>  	if (!adev)
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index fc84e42..2afcdb9 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -752,8 +752,14 @@ int acpi_dev_prop_read_single(struct acpi_device *adev, const char *propname,
>  int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
>  		       enum dev_prop_type proptype, void *val, size_t nval);
>  
> -struct acpi_device *acpi_get_next_child(struct device *dev,
> -					struct acpi_device *child);
> +struct acpi_device *acpi_dev_get_next_child(struct acpi_device *adev,
> +					    struct acpi_device *child);
> +
> +static inline struct acpi_device *acpi_get_next_child(struct device *dev,
> +						      struct acpi_device *child)
> +{
> +	return acpi_dev_get_next_child(ACPI_COMPANION(dev), child);
> +}
>  #else
>  static inline int acpi_dev_get_property(struct acpi_device *adev,
>  					const char *name, acpi_object_type type,
> @@ -804,6 +810,13 @@ static inline struct acpi_device *acpi_get_next_child(struct device *dev,
>  	return NULL;
>  }
>  
> +static inline struct acpi_device *acpi_dev_get_next_child(
> +						struct acpi_device *adev,
> +						struct acpi_device *child)
> +{
> +	return NULL;
> +}
> +
>  static inline struct acpi_device *acpi_get_parent_dev(struct acpi_device *adev)
>  {
>  	return NULL;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
