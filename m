From: Thomas Glomann <mailinglists-WoYc4IhrKEiELgA04lAiVw@public.gmane.org>
Subject: Re: high pitch noise with kernel 2.6 and ACPI (Dell Inspiron 8200)
Date: Thu, 19 Feb 2004 10:02:32 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402191002.32216.mailinglists@glomann.de>
References: <200402181320.29381.mailinglists@glomann.de> <200402182017.47960.mailinglists@glomann.de> <20040218214542.58569565.mike@it-loops.com>
Reply-To: mailinglists-WoYc4IhrKEiELgA04lAiVw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040218214542.58569565.mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>
> You could try and change HZ from 1000 to 100 in
> "src/linux/include/asm/param.h"
>
> #ifdef __KERNEL__
> # define HZ   1000   <--- change this to 100
> # define USER_HZ  100   /* .. some user interfaces are in "ticks" */
> # define CLOCKS_PER_SEC (USER_HZ) /* like times() */
> #endif
>
> It worked for me and I haven't seen any side effects after changing it.
>
>
> /Michael


I will try that and see if there's any side effects.

Thanks alot guys !   :)



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
