From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Fix _STA checking in acpi_bus_add
Date: 23 Jan 2004 23:43:27 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1074919407.14755.6.camel@dhcppc4>
References: <200401021635.25419.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200401021635.25419.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks Bjorn,
-Len

ps. did you find this because you've got a system where the actual
get_status failed, or the _STA returned !present and that was ignored?

On Fri, 2004-01-02 at 18:35, Bjorn Helgaas wrote:
> In 2.6.1-rc1, acpi_bus_add() calls acpi_bus_get_status() to evaluate
> _STA, but botches checking the return value.  The result is that _STA
> is ignored (if it was evaluated correctly), or we check garbage (if
> the evaluation failed).  Here's a patch to fix it:
> 
> ===== drivers/acpi/scan.c 1.19 vs edited =====
> --- 1.19/drivers/acpi/scan.c	Sun May 25 18:00:00 2003
> +++ edited/drivers/acpi/scan.c	Fri Jan  2 16:14:25 2004
> @@ -703,11 +703,11 @@
>  	switch (type) {
>  	case ACPI_BUS_TYPE_DEVICE:
>  		result = acpi_bus_get_status(device);
> -		if (!result)
> -			break;
> -		if (!device->status.present) 
> +		if (ACPI_FAILURE(result) || !device->status.present) {
>  			result = -ENOENT;
> -		goto end;
> +			goto end;
> +		}
> +		break;
>  	default:
>  		STRUCT_TO_INT(device->status) = 0x0F;
>  		break;
> 



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
