From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: heatload 0.4 now with throttling support
Date: Wed, 18 Dec 2002 18:03:29 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021218180329.GA9439@clara.net>
References: <3E008120.5080908@uni-muenster.de> <20021218153355.GK347@poup.poupinou.org> <3E009EB5.7010109@muenster.de> <20021218170828.GA9127@clara.net> <3E00AEC8.9050906@muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E00AEC8.9050906-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Malte Thoma <thoma-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org>
Cc: ACPI-Devel <Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Malte Thoma [thoma-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org] wrote:
> In which directory, in /proc/acpi or in ../thermal_zone ?

Well, everything under /proc/acpi is well-known (so far at least)
ac_adapter/
thermal_zone/
battery/
processor/
etc.

In each of those directories there may be one or more other directories
- one for each node eg.

ACAD, AC0 for AC
BAT0, BAT1, BAT2, BATR for batteries
TZ0, THRM for thermal zones.
CPU0, PROC, for processor

The only thing you can do is opendir("/proc/acpi/thermalzone"), then
readdir for each item - ignore . and .. of course.

> Wonderfull task: something to develope for machines I cannot test it for :-(
> coming along that my skills are not guru-like :-(

If you don't hardcode the directories under ac_adapter,thermal_zone etc.
then you should be ok.

> processor ->throttling
processor/*/throttling
processor/*/performance


My processor (for example) doesn't support throttling, just performance.

> thermal*  -> ????

thermal_zone/*/temperature I guess :)

> battery -> state or status

Is it status or info which holds the most useful information?

> ac_adapter   -> state or status

Present: yes or no is about all that's useful there I think.


Faye

-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

I have the simplest tastes.  I am always satisfied with the best.
		-- Oscar Wilde


-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
