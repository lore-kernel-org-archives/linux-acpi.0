From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: acpi driver blacklist override linux 2.4.18
Date: Tue, 30 Jul 2002 05:10:25 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730051025.C111@toy.ucw.cz>
References: <200207251833.UAA03087@betty.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200207251833.UAA03087-e7OjjGEhTcdpPtxwXY8Srg@public.gmane.org>; from ptb-lKqjX1hQmNLe5aOfsHch1g@public.gmane.org on Thu, Jul 25, 2002 at 08:33:56PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Peter T. Breuer" <ptb-lKqjX1hQmNLe5aOfsHch1g@public.gmane.org>
Cc: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dwmw2-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, "Peter T. Breuer" <ptb-e7OjjGEhTcdpPtxwXY8Srg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> But the Portege 4000 is near totally different. I get the feeling
> that the id comparison is funky. Maybe it shouldn't be a less than,
> or something?? I suggest the test be modified. I overrode it with the
> following setup args modif in driver.c:

You need to fix the blacklist, not adding blacklist-disable option.

> + static int blacklist_disabled = 0;
>   static int __init acpi_setup(char *str) {
>         while (str && *str) {
>         if (strncmp(str, "off", 3) == 0)
>                 acpi_disabled = 1;
> +       else if (strncmp(str, "nobl", 3) == 0)

It should be ..., 4)
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
