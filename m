From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: PATCH default C1
Date: Sat, 17 Sep 2005 11:13:44 +0200
Message-ID: <20050917091344.GB1522@isilmar.linta.de>
References: <432697CC.3020201@tzi.de> <20050913180219.GB9572@dominikbrodowski.de> <432B1708.4060403@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <432B1708.4060403-cGBD8117FJM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,


On Fri, Sep 16, 2005 at 09:03:36PM +0200, Janosch Machowinski wrote:
> @@ -678,6 +669,13 @@
>  
>  		(pr->power.count)++;
>  		memcpy(&(pr->power.states[pr->power.count]), &cx, sizeof(cx));
> +
> +		/* We support up to ACPI_PROCESSOR_MAX_POWER. */
> +		if (pr->power.count >= ACPI_PROCESSOR_MAX_POWER) {
> +		        printk(KERN_WARNING "Limiting number of power states to max (%d)\n", ACPI_PROCESSOR_MAX_POWER);
> +			printk(KERN_WARNING "Please increase ACPI_PROCESSOR_MAX_POWER if needed.\n");
> +			break;
> +		}


Memory corruption: If pr->power.count is ACPI_PROCESSOR_MAX_POWER (or
larger), pr->power.states[pr->power.count] is pointing to an invalid memory
address. Therefore, the check needs to stay at the place it was before.


	Dominik


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
