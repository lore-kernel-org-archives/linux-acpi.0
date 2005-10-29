From: "Randy.Dunlap" <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [patch 7/9] Don't set dcdbas driver to default m
Date: Fri, 28 Oct 2005 19:02:33 -0700
Message-ID: <20051028190233.65f8b7c2.rdunlap@xenotime.net>
References: <200510282159.j9SLxY4u021622@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200510282159.j9SLxY4u021622-bipKiLWnuIsyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, ak-l3A5Bk7waGM@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 28 Oct 2005 14:59:52 -0700 akpm-3NddpPZAyC0@public.gmane.org wrote:

> 
> From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
> 
> It's nasty to set random drivers to default m because people who just press
> enter on make oldconfig get these.  Remove the default m

Not ACPI afaik, but I ack the change too.

> Signed-off-by: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
> Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
> ---
> 
>  drivers/firmware/Kconfig |    1 -
>  1 files changed, 1 deletion(-)
> 
> diff -puN drivers/firmware/Kconfig~dont-set-dcdbas-driver-to-default-m drivers/firmware/Kconfig
> --- 25/drivers/firmware/Kconfig~dont-set-dcdbas-driver-to-default-m	Fri Oct 28 14:59:11 2005
> +++ 25-akpm/drivers/firmware/Kconfig	Fri Oct 28 14:59:11 2005
> @@ -71,7 +71,6 @@ config DELL_RBU
>  config DCDBAS
>  	tristate "Dell Systems Management Base Driver"
>  	depends on X86 || X86_64
> -	default m
>  	help
>  	  The Dell Systems Management Base Driver provides a sysfs interface
>  	  for systems management software to perform System Management
> _


---
~Randy


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
