From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Wed, 24 Jul 2002 19:07:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020724170754.GA7543@atrey.karlin.mff.cuni.cz>
References: <20020724133821.5598714808@o-o.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020724133821.5598714808-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Lyle <lwspm-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> The more I look at this, the more convinced I am that driver-model.txt 
> describes the proper approach, and suspend.c just has it backwards.  Even 
> though no drivers really implement the functionality properly yet, it makes 
> sense to get the framework right so that they *can*, eventually.
> 
> I don't know why driver.h has the enums listed in a different order from 
> driver-model.txt, or if it's really necessary to fix the order, unless 
> somebody decides to start doing ordered comparisons.

The diff looks right, will apply...
									Pavel

> Just to make it clear what I mean:
> 			 
> *** kernel/suspend.c   Wed Jul 24 09:21:39 2002
> --- kernel/suspend.c.orig      Wed Jul 24 09:20:32 2002
> ***************
> *** 647,650 ****
>   {
> -       device_resume(RESUME_ENABLE);
>         device_resume(RESUME_RESTORE_STATE);
>   }
> --- 647,650 ----
>   {
>         device_resume(RESUME_RESTORE_STATE);
> +       device_resume(RESUME_ENABLE);
>   }
> ***************
> *** 655,658 ****
>         device_suspend(4, SUSPEND_NOTIFY);
> -       device_suspend(4, SUSPEND_DISABLE);
>         device_suspend(4, SUSPEND_SAVE_STATE);
>         if(!pm_suspend_state) {
> --- 655,658 ----
>         device_suspend(4, SUSPEND_NOTIFY);
>         device_suspend(4, SUSPEND_SAVE_STATE);
> +       device_suspend(4, SUSPEND_DISABLE);
>         if(!pm_suspend_state) {
> ***************
> *** 674,677 ****
>   {
> -       device_resume(RESUME_ENABLE);
>         device_resume(RESUME_RESTORE_STATE);
>         if(flags & RESUME_PHASE2) {
> --- 674,677 ----
>   {
>         device_resume(RESUME_RESTORE_STATE);
> +       device_resume(RESUME_ENABLE);
>         if(flags & RESUME_PHASE2) {
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
