From: "Bob Z" <ziuchkov-e94Sedi4moU@public.gmane.org>
Subject: Re: S3 and S4 broken on Toshiba Satellite 2400-s201
Date: Sat, 30 Jul 2005 15:54:49 -0500
Message-ID: <200507301554.49240.ziuchkov@uiuc.edu>
References: <200507301545.29522.ziuchkov@uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507301545.29522.ziuchkov-e94Sedi4moU@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I forgot to mention that usually I have the rest of the acpi modules loaded as 
well (instead of just 'container' as my lsmod output showed), but that 
particular try, I tried stripping down to the absolute bare minimum.  Here 
are the acpi modules I *usually* have loaded:

video                  16260  0
thermal                13576  0
toshiba_acpi            6164  0
fan                     4740  0
processor              22708  1 thermal
button                  4224  0
container               4608  0
ac                      4996  0
battery                10244  0


On Saturday 30 July 2005 03:45 pm, Bob Z wrote:
> Hello, I am new to this mailing list, so please bear with me.  I've been
> having a heck of a time getting everything working with my laptop.  It's a
> Toshiba Satellite 2400-s201.  I finally got my alps touchpad and my wifi
> card to work after days of fussing around with different kernel and patch
> versions.  I ended up with version 2.6.11 of the linux kernel because
> neither 2.6.8(.1) nor 2.6.12 would work with my touchpad.  Now everything
> works except for suspend to ram and suspend to disk.  All of the rest of
> the ACPI modules work fine for me.  I can poll my battery, scale my cpu
> frequency, use my extra function keys, etc.  It's just that whenever I try
> to suspend, I end up with a weird IRQ error and my computer locks up.  I've
> tried the built-in swsusp, the swsusp2 patches, the hibernate scripts, and
> just plain 'echo -n mem > /sys/power/state'.  Nothing works for me.  I've
> unloaded every module I can except for the acpi ones and I've killed every
> process except for syslogd, klogd, and my shell.  Still my computer
> freezes.  If I try to suspend to disk, it freezes with the IRQ error right
> after the memory image is written to ram but before the computer powers
> down.  If I try to suspend to memory, it suspends okay, but I get the IRQ
> error when I try to wake the computer.  It all seems to be a problem
> relating to IRQ 11, which is the IRQ used by everything that is built-in on
> this laptop.  I've tried the vanilla acpi from 2.6.11 and I've tried
> patching my kernel with
> acpi-20050408-2.6.11.diff.  Always I get the same problem.  I also tried
> disassembling my computer's DSDT and recompiling with intel's compiler
> according to instructions I found on the net.  Everything compiled without
> any errors or warnings.  I only got 3 'remarks'.  I also searched the dsdt
> for any reference to the windows OS.  It seems to check for windows
> versions and stores a value to an OSID variable.  I changed the code so
> that it stored the value as if it were a Windows XP machine and I
> recompiled my kernel so that it would use my compiled dsdt.  Still I got
> the same error.  I have attached every single piece of information I could
> think of that might help in diagnosing the problem.  The contents of the
> files are as follows:
>
> dmesg: output of dmesg after my computer boots
> dsdt.tar.bz2: the disassembled version of my computer's DSDT
> errormsg: an example output I get when trying to use swsusp (v1).  I tried
> to copy it as close to verbatim as possible, but some of the spaces may be
> off, as I had to copy it by hand since at this stage my computer is locked
> up. interrupts: contents of /proc/interrupts when everything is loaded on
> my computer
> modules: the modules I have present when trying to suspend
> processes: the processes I have present when trying to suspend
>
> Please forgive me if I have been too verbose.  I just would really like to
> get suspending to work.  I am really quite new to fiddling with ACPI on
> linux. Everything I have learned is from trying the past few days to get
> this to work.  I appreciate any advice that could be offered.  Thank you.
>
> Bob Z.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
