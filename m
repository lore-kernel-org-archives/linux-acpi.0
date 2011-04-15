From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] ACPI: ac: fixed indentation, commenting and line
	length coding style issues
Date: Fri, 15 Apr 2011 18:30:02 +0200
Message-ID: <20110415163001.GD11454@atrey.karlin.mff.cuni.cz>
References: <1302580763-11859-1-git-send-email-timcour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:36071 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751395Ab1DOQaD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Apr 2011 12:30:03 -0400
Content-Disposition: inline
In-Reply-To: <1302580763-11859-1-git-send-email-timcour@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timothy Courrejou <timcour@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> Fixed coding style issues.
> 
> Signed-off-by: Timothy Courrejou <timcour@gmail.com>
> ---
>  drivers/acpi/ac.c |   36 ++++++++++++++++++------------------
>  1 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 183a035..58c3f74 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -85,7 +85,7 @@ static struct acpi_driver acpi_ac_driver = {
>  
>  struct acpi_ac {
>  	struct power_supply charger;
> -	struct acpi_device *device;
> +	struct acpi_device * device;
>  	unsigned long long state;

This _adds_ coding style issue.


>  };
>  
> @@ -101,9 +101,10 @@ static const struct file_operations acpi_ac_fops = {
>  };
>  #endif
>  
> -/*
> - * AC Adapter Management
> - */
> +/* --------------------------------------------------------------------------
> +                               AC Adapter Management
> +   -------------------------------------------------------------------------- */
> +
>  static int acpi_ac_get_state(struct acpi_ac *ac)
>  {
>  	acpi_status status = AE_OK;

Reversed patch?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
