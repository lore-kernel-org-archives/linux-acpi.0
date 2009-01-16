From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/3] ACPI: EC: Limit workaround for ASUS notebooks even more
Date: Fri, 16 Jan 2009 14:08:20 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901161408150.5705@localhost.localdomain>
References: <20090113235739.10548.20626.stgit@thinkpad>
 <20090113235746.10548.22798.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:63140 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761598AbZAPTIW (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 14:08:22 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KDK007D9VTXBAE1@vms173005.mailsrvcs.net> for
 Linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 13:08:22 -0600 (CST)
In-reply-to: <20090113235746.10548.22798.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

applied

--
Len Brown, Intel Open Source Technology Center

On Wed, 14 Jan 2009, Alexey Starikovskiy wrote:

> References: http://bugzilla.kernel.org/show_bug.cgi?id=11884
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/ec.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 8dfcbb8..e079426 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1027,7 +1027,8 @@ int __init acpi_ec_ecdt_probe(void)
>  	 * which needs it, has fake EC._INI method, so use it as flag.
>  	 * Keep boot_ec struct as it will be needed soon.
>  	 */
> -	if (ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI", &dummy)))
> +	if (!dmi_name_in_vendors("ASUS") ||
> +	    ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI", &dummy)))
>  		return -ENODEV;
>  install:
>  	if (!ec_install_handlers(boot_ec)) {
> 
