From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: performance mgt and sleep don't work on Acer TM621
Date: Mon, 13 Jan 2003 15:07:31 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030113140731.GA7365@brodo.de>
References: <200301131416.14923.mrvanes@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200301131416.14923.mrvanes-jG/AHqQBv7lBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Martin van Es <mrvanes-jG/AHqQBv7lBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On Mon, Jan 13, 2003 at 02:16:14PM +0100, Martin van Es wrote:
>  Recently I started experimenting with the 'write' interface and tried to
>  get the performance of my coppermine PIII 1G to switch from 1G to 733MHz
>  or vise versa using
>  echo -n 1 > /proc/acpi/CPU0/performance
>  
>  But both 'cat'ing performance to see what happened and running bogomips
>  show my processor is still running @ 1GHz. It is also the other way round.
>  Once booted at 733MHz (because of absence of AC adapter) it cannot be forced
>  into 1G, even with AC attached.
>  
>  Info tells me performance management is available:
>  cat /proc/acpi/processor/CPU0/info:
>  processor id:            0
>  acpi id:                 1
>  bus mastering control:   yes
>  power management:        yes
>  throttling control:      no
>  performance management:  yes
>  limit interface:         yes
>  
>  cat /proc/acpi/processor/CPU0/performance:
>  state count:             2
>  active state:            P0
>  states:
>     *P0:                  1000 MHz, 20000 mW, 500 uS
>      P1:                  733 MHz, 10000 mW, 500 uS
>  
>  Am I doing something wrong? Forgot to compile in something?

Have you compiled CONFIG_ACPI_DEBUG in? Are there any "strange" messages in
"dmesg" after you try such a frequency transition? 

BTW, if this is an Intel mobile processor and an Intel southbridge (ICH2-M 
or ICH3-M), you might want to try cpufreq instead 
( http://www.brodo.de/cpufreq/advanced.html ).

	Dominik


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
