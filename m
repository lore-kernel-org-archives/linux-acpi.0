From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] correct ACPI URL
Date: 26 Jan 2004 14:49:08 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1075146544.2485.0.camel@dhcppc4>
References: <20040125165934.1d89f8e7.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040125165934.1d89f8e7.rddunlap-3NddpPZAyC0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Accepted

thanks,
-Len

On Sun, 2004-01-25 at 19:59, Randy.Dunlap wrote:
> Please apply to 2.6.current.
> 
> --
> ~Randy
> 
> 
> description:      use correct ACPI URL;
> 
> diffstat:=
>  arch/i386/boot/setup.S |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -Naurp ./arch/i386/boot/setup.S~acpi_url ./arch/i386/boot/setup.S
> --- ./arch/i386/boot/setup.S~acpi_url	2004-01-08 22:59:44.000000000 -0800
> +++ ./arch/i386/boot/setup.S	2004-01-25 16:48:02.000000000 -0800
> @@ -307,7 +307,7 @@ loader_ok:
>  # a whole bunch of different types, and allows memory holes and
>  # everything.  We scan through this memory map and build a list
>  # of the first 32 memory areas, which we return at [E820MAP].
> -# This is documented at http://www.teleport.com/~acpi/acpihtml/topic245.htm
> +# This is documented at http://www.acpi.info/, in the ACPI 2.0 specification.
>  
>  #define SMAP  0x534d4150
>  



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
