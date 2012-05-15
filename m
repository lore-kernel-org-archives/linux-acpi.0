From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: fix regression on D3hot detection
Date: Tue, 15 May 2012 17:47:43 +0200
Message-ID: <201205151747.43197.rjw@sisk.pl>
References: <5165867.6kdtKH1k0B@penguin>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:45841 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965236Ab2EOPms (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 May 2012 11:42:48 -0400
In-Reply-To: <5165867.6kdtKH1k0B@penguin>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lekensteyn <lekensteyn@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tuesday, May 15, 2012, Lekensteyn wrote:
> Commit 1cc0c998fdf2cb665d625fb565a0d6db5c81c639 tried clear up some confusion
> around D3hot and D3cold but accidentally changed behaviour on validating device
> power states. It added an extra condition: i < ACPI_STATE_D3_HOT which means
> that only states D0, D1 and D2 are accepted if there are no power resources but
> the _PSx method exist. D3(hot) is missing here.

Which is intentional (that follows from the ACPI spec.).

> This fixes https://bugzilla.kernel.org/show_bug.cgi?id=43228

I'll have a look at the bug later.

Thanks,
Rafael


> Reported-by: rockorequin@hotmail.com
> Signed-off-by: Peter Lekensteyn <lekensteyn@gmail.com>
> Tested-by: rockorequin@hotmail.com
> ---
>  drivers/acpi/scan.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 7417267..932c427 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -895,7 +895,7 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
>  		 * D3hot is only valid if _PR3 present.
>  		 */
>  		if (ps->resources.count ||
> -		    (ps->flags.explicit_set && i < ACPI_STATE_D3_HOT))
> +		    (ps->flags.explicit_set && i <= ACPI_STATE_D3_HOT))
>  			ps->flags.valid = 1;
>  
>  		ps->power = -1;	/* Unknown - driver assigned */
> 

