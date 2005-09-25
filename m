From: Berthold Cogel <cogel-F8dkAKZEjLURtNtAH2Wc8g@public.gmane.org>
Subject: Re: Acer Extensa 3002 WLMi: Help wanted fixing the DSDT
Date: Sun, 25 Sep 2005 14:15:54 +0200
Message-ID: <433694FA.9040803@rrz.uni-koeln.de>
References: <4334789A.8020803@rrz.uni-koeln.de> <200509240930.30642.o.jansen@orb-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200509240930.30642.o.jansen-n+qsWun7DryELgA04lAiVw@public.gmane.org>
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

Olaf Jansen-Olliges wrote:
> 
>>Intel ACPI Component Architecture
>>ASL Optimizing Compiler / AML Disassembler version 20040715 [Sep 22 2004]
> 
> 
> With this Version I have had no chance to recompile my DSDT. When I try to 
> load the changed DSDT my machine reboots immediytely - the produced code 
> seems to be incorrect. Try version 20041203 (or newer)
> 
> Regards and good Luck
> 	Olaf
> 
> BTW: If you want to you may get my patched DSDT - I've got the battery thing 
> working. You may mail me if you are interested in this. 
> 

Hello Olaf,

thanks a lot for the offer. Of course I'm interested.

At the moment I have a working 2.6.11.11 kernel with the SBS driver from
Rich Townsend and suspend2. But I'd like to use a more recent kernel. So
I have to get the DSDT working.

I've tried to compile newer versions of iasl on my system (Debian
stable), but it always ended with some errors so far. So I got me a
prebuild version 20040715 from the web, I found somewhere.

I had the reboot problem myself with the fixed version of my original
DSDT (without sbs patch). It has something to do with the thermal
management.
I got a lot of messages about increasing temperature in the logs and the
system has shut itself down more or less immedeatly.
The system had to cool down a bit, before I tried to test a new kernel.
After this, the system was stable after reboot.

I've tested my patched DSDT, although I got the error messages from the
compiler (Just curiosity ...). With the sbs patch, the battery readout
was working for some time. But after about 30 minutes the battery state
wasn't available anymore.


Best regards,

Berthold



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
