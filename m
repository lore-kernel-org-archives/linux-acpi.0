From: Jonathan Steinert <hachi-rIxVFxJalAJeoWH0uzbU5w@public.gmane.org>
Subject: Re: lcd backlight
Date: Sat, 12 Jul 2003 23:11:09 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F10DBDD.20607@kuiki.net>
References: <m365m7jjkk.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m365m7jjkk.fsf-eUECQUGGJJCHAtaq1fIXeWD2FQJk+8+b@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'm in a jam, I've got an Nvidia Geforce 4 440 Go, and /every/ time I 
see a backlight control it is for a radeon. Does anyone have one for 
nvidia chipsets? or does anyone have hints on how to build one? I'm not 
much of a C programmer, but I might be able  to fiddle my way though it.

Now, the reasoning why I posted this to the ACPI list? Because when I 
enable ACPI (with a patched DSDT) on my Dell Inspiron 8200, and create 
any events (S1, close lid, etc.) the display is off (both the LCD and 
the backlight turn off) until I reboot. If you have any hints on how to 
fix this instead, that would be much appreciated.

Thanks much,

Jonathan Steinert

James H. Cloos Jr. wrote:

>A bios setting causes a regular screen blank, but w/ acpi the lcd's
>backlight is left on.  
>
>The following function (based on 's radeontools) controls the
>backlight perfectly:
>
>void radeon_cmd_light(int param)
>{
>    unsigned long dac_cntl;
>
>    dac_cntl = radeon_get(RADEON_LVDS_GEN_CNTL,"RADEON_LVDS_GEN_CNTL");
>    if(param != 0) {
>        dac_cntl |= RADEON_LVDS_ON;
>    } else {
>        dac_cntl &= ~ RADEON_LVDS_ON;
>    }
>    radeon_set(RADEON_LVDS_GEN_CNTL,"RADEON_LVDS_GEN_CNTL",dac_cntl);
>}
>
>
>What needs to be done, given this info on how to control the
>backlight and the bios's dsdt, to convince the kernel to toggle
>the backlight when the screen blanks?
>
>-JimC
>
>
>
>-------------------------------------------------------
>This SF.Net email sponsored by: Parasoft
>Error proof Web apps, automate testing & more.
>Download & eval WebKing and get a free book.
>www.parasoft.com/bulletproofapps1
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>  
>




-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
