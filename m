From: Troy Schultz <tschultz-zzOxFVvAfJPQT0dZR+AlfA@public.gmane.org>
Subject: Re: hp xt1260; upgraded bios to 1.05, now no backlight
	w/batteries
Date: 06 Mar 2003 06:53:57 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1046951637.1634.3.camel@p2710>
References: <200303051956.h25Ju2N04777@p2.parker.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200303051956.h25Ju2N04777-paYRYfI9b/YMuHHiPFXXZ1fOaUvyCJUZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Brad Parker <brad-2nKKSigPee+ibv+y4V69FXNtEUiqdi9I@public.gmane.org>
Cc: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2003-03-05 at 14:56, Brad Parker wrote:

<snip>


> I recently upgraded the bios to "v1.05" because the HP web site said
> it had ACPI fixes.
> 
> Once I did that the backlight stopped working when the ac power was not connected.
> 
> Oddly, this seems to be caused by running linux.  
> 
> If I boot the bios upgrade disk and flash the bios, the problem goes
> away.  Everything works as expected.
> 
> I then run linux (2.4.21-pre3-acpi-20030125-swsusp18).  It boots and
> works fine.  I poweroff and reboot and the problem reoccurs.  Several
> seconds after the bios comes up, before grub, the backlight shuts off.
> Pressing the lid button restores the light for a few seconds.  If I
> plug in the ac and press the lid button is comes back on and stays on.
> 
> This linux has a "fixed" DSDT table.  The changes are very minor (one
> missing global, one bad length, several bad access types).  I
> originally did this because I could not see the battery or power
> info. With the fixes the battery and power work as expected.
> 
> If I remove the battery and press the reset button the problem stays.  It makes
> me wonder if the DSDT 'code' is wacking some persistent memory inside the
> unit...  is that possible?
> 
> Should I try using the bios version of the DSDT?

Yes, most likely the DSDT was changed in the new BIOS.  I would suggest
you try the new BIOS's DSDT first, and then if you have problems you
will have to grab the new DSDT and make changes if necessary.

Best Regards
-- 
Troy Schultz <tschultz-zzOxFVvAfJPQT0dZR+AlfA@public.gmane.org>



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
