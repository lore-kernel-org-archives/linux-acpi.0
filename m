From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Resume from suspend-to-ram (radeon)
Date: 23 Feb 2004 02:00:09 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077519609.12675.63.camel@dhcppc4>
References: <c15rn0$5bu$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <c15rn0$5bu$2@sea.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Giridhar Pemmasani <giri-IxWJ8JVbGpr5NRxSJurNR4dd74u8MsAO@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, benh-t6+wdnd7Ef+CjzjZhc0bXmD2FQJk+8+b@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ben,
has radeon_pm.c suspend/resume worked under other conditions?

thanks,
-Len

On Fri, 2004-02-20 at 15:46, Giridhar Pemmasani wrote:
> I have already posted the following message to LKML. However, since there
> was lot of discussion on this topic in this mailing list, I am posting here
> too. 
> 
> I have Dell Latitude D600 laptop with Radeon R250 Lf (Mobility 9000
> M9) video card. I have been trying to get suspend-to-ram work with
> this laptop since 2.5.70 or so. The problem almost always was that if
> frame buffer (I have tried radeon and vesa) is used, resume won't
> finish - it would hang right after pressing power button and if plain
> console is used resume works fine, but the LCD stays off.
> 
> Since new radeonfb has suspend/resume driver model, I thought I might
> give it a try, but still the laptop would hang during resume. With a
> bit of trial and error (and some guess work), I got the laptop to
> resume successfully with the following patch.
> 
> --- radeon_pm.c.orig    2004-02-20 15:11:18.000000000 -0500
> +++ radeon_pm.c 2004-02-20 15:12:23.000000000 -0500
> @@ -907,11 +907,13 @@
>  
>         /* Restore display & engine */
>         radeonfb_set_par(info);
> -       fb_pan_display(info, &info->var);
> -       fb_set_cmap(&info->cmap, 1, info);
> +       /* fb_pan_display(info, &info->var);
> +        * fb_set_cmap(&info->cmap, 1, info);
> +        */
>  
>         /* Refresh */
> -       fb_set_suspend(info, 0);
> +       /* fb_set_suspend(info, 0);
> +        */
>  
>         /* Unblank */
>         rinfo->lock_blank = 0;
> 
> 
> Right now after resume, console still remains blank, but X restores
> the screen properly. Note that since frame buffer is not restored
> properly, the console is pretty much useless, but it is not a problem
> for me as I use X all the time.
> 
> I have used this patch with kernel 2.6.3-mm2. I haven't tried 2.6.3,
> but I think it may work with 2.6.3 too.
> 
> I am also attaching config.bz2 and /etc/acpi/sleep (the script used to
> suspend the laptop). 
> 
> I am not subscribed to LKML, so please CC me.
> 



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
