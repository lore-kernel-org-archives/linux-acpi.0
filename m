From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: State of ACPI on my Compaq Presario 2100z
Date: Thu, 2 Sep 2004 16:56:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040902145638.GA742@elf.ucw.cz>
References: <200409010224.10507.andre@eisenbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200409010224.10507.andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I've contacted you guys a while ago about the problems with my Compaq Presario 
> 2100, back then specifically my problems with a slowdown when running on 
> battery and suspend problems. I even soldered up some parallel port LED's 
> back then, but never got to put them to good use.
> 
> Since then, ACPI is working even worse than before, now the notebook doesn't 
> shut down properly anymore. The last message is "Power off." (when doing 
> shutdown -h now), or "Sending acpi_power_off" (when doing echo -n disk 
> > /sys/power/state).
> 
> Battery, AC, thermal zone and CPU info works fine.
> 
> Suspending to memory suspends the notebook, but opening the lid again (or 
> pressing the power button) only results in a sub-second wake-up (fan starts, 
> hd starts ever so slightly, lcd stays off), then all goes dark again - 
> everything off. Pressing the power button again just starts regular boot.
> 
> Suspending to disk seems to work with every module unloaded and outside of X. 
> Trying the same from within X is a totally different (ugly) problem 
> alltogether. But that's not important to me anyway.
> 
> I'm currently running kernel 2.6.9-rc1-mm2 (acpi 20040816).
> 
> As I did back then, I am very interested in helping out troubleshooting the 
> problem. I am a software developer, but I just don't know where to start 
> here. If somebody wishes to speculate what may be wrong (with suspend/powe 
> off) from a birds-eye view, I might find a place to start my journey into 
> ACPI.

You might want to stick some infinite loop at the beggining of
wakeup.S and see if it ever reaches that...
							Pavel
-- 
When do you have heart between your knees?


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
