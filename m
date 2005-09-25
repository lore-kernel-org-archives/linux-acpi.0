From: Olaf Jansen-Olliges <o.jansen-n+qsWun7DryELgA04lAiVw@public.gmane.org>
Subject: Re: Acer Extensa 3002 WLMi: Help wanted fixing the DSDT
Date: Sun, 25 Sep 2005 16:41:05 +0200
Message-ID: <200509251641.06487.o.jansen@orb-net.de>
References: <4334789A.8020803@rrz.uni-koeln.de> <200509240930.30642.o.jansen@orb-net.de> <433694FA.9040803@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <433694FA.9040803-F8dkAKZEjLURtNtAH2Wc8g@public.gmane.org>
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

Hi Berthold, 

> thanks a lot for the offer. Of course I'm interested.

I'll send it to you by mail. ( anyone else? :-) )

> At the moment I have a working 2.6.11.11 kernel with the SBS driver from
> Rich Townsend and suspend2. But I'd like to use a more recent kernel. So
> I have to get the DSDT working.

With the kernel < 2.6.12 i used the acpi-ec-nospinlock patch included in Richs 
sbs-package. Later i had to use the ec-burst patch from Luming Yu from here:

http://bugzilla.kernel.org/attachment.cgi?id=5574&action=view

Then I have to pass ec_burst=1 as kernel parameter. Without this my machine 
misses keystrokes when I'm typing "fast". (I use this with a 2.6.13 vanilla 
kernel) 


> I've tried to compile newer versions of iasl on my system (Debian
> stable), but it always ended with some errors so far. So I got me a
> prebuild version 20040715 from the web, I found somewhere.
Perhaps this has to do with the flex version on you machine. I've read about 
some problems due to a too recent version of this package. I'm using gentoo 
so I'm not sure, but there seems to be a flex-old (or something like that) 
for debian with which you may have more luck getting iasl compiled.

>
> I had the reboot problem myself with the fixed version of my original
> DSDT (without sbs patch). It has something to do with the thermal
> management.

Yes but this even happens if you recompile a "unchanged" DSDT. So the produced 
code is not usable I'm afraid.


> I've tested my patched DSDT, although I got the error messages from the
> compiler (Just curiosity ...). With the sbs patch, the battery readout
> was working for some time. But after about 30 minutes the battery state
> wasn't available anymore.
I'm using my patched dsdt since february this year and the battery status is 
working without any problems on different kernel versions. The only issue i 
had was the missing keystroke problem. BTW. I'm using the acpi-dsdt-initrd 
patch for "feeding" my dsdt to the kernel.

Best
	Olaf


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
