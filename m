From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Toshiba ACPI Extras 0.16
Date: Sat, 26 Jul 2003 06:20:12 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030726052012.GO1485@parcelfarce.linux.theplanet.co.uk>
References: <3F21BD11.8060405@prairienet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3F21BD11.8060405-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 25, 2003 at 07:28:17PM -0400, John Belmonte wrote:
> @@ -108,7 +108,9 @@
>  	int result;
>  	char* str2 = kmalloc(n + 1, GFP_KERNEL);
>  	if (str2 == 0) return 0;
> -	strlcpy(str2, str, n);
> +	/* NOTE: don't even _think_ about replacing this with strlcpy */
> +	strncpy(str2, str, n);
> +	str2[n] = 0;
>  	va_start(args, format);
>  	result = vsscanf(str2, format, args);
>  	va_end(args);

seems to me you'd be better off doing ...

	len = strlen(str);
	if (len > n)
		len = n;
	memcpy(str2, str, n);
	str2[n] = '\0';

i wrote a short note entitled "strncpy Considered Harmful" a few years ago.
unfortunately, it seems lost in time.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
