From: Heiko =?ISO-8859-1?Q?Ettelbr=FCck?= <hbruckynews-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: 2.4.20-pre10-ac1 and Compaq Evo N160
Date: 15 Oct 2002 21:52:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1034711544.1511.2.camel@speedy-gonzales>
References: <20021014105058.7898C2063B@mail.uboot.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021014105058.7898C2063B-Y//ra7+aop3NL9alfNIhog@public.gmane.org>
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

Hi,

me too, I have an Evo N160. I had the same experiences Andrew had: When
booting an ACPI-enabled kernel (with recent ACPI patch) without the boot
option "pci=noacpi" (PCI IRQ routing using ACPI disabled), the System
hangs on boot when assigned interrupts. Some people here on the list
spoke of "the old LNKG problem" - unfortunately I haven't been able (and
didn't have the time) to find enough information to fix the problem.
Dominik Brodowski suggested to either hack the kernel ACPI code or the
DSDT to force to notebook not to use the IRQ line which causes the
problem - but until now I have not understood the ACPI documentation
deeply enough to do that, and I'm not familiar enough with kernel
hacking to reach the same goal using this way.

Concerning my predecessor's (what's your name? ;-) ) issue about the
notebook hanging after some hours, I cannot agree - I didn't see such a
behaviour at my Evo. Perhaps you're right with your thought of a
hardware problem (I fear).

To answer to your last question: No, I didn't find a way to switch off
the backlight.

Regards,
Heiko

Am Mon, 2002-10-14 um 12.50 schrieb prozessor13acpi-nhk/dgjHjusAvxtiuMwx3w@public.gmane.org:
> i have the same notebook with the same problems.. but there is another bad thing. after a few hours the notebook hangs, the fan start to run and i have to switch it off.. :-( this problem started when i switched from 2.4.17 to 2.4.18..   do you have similar problems, or is this a hardware-problem on my notebook(bad memory, temperature...). 
> 
> ...and did you found a way to switch of the LCD backlight..
> 
> thx. max.
> 
> --- antwort auf ---
> von: Andrew Kohlsmith
> an: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> betreff: [ACPI] 2.4.20-pre10-ac1 and Compaq Evo N160
> datum: 12.10.02 15:38
> 
> I've been unable to get this machine to boot since the altirq patch for the 
> 0503 ACPI code.  It hangs just after trying to route IRQs.
> 
> With 2.4.20-pre10-ac1 I was able to get it to boot with pci=noacpi.  I'm going 
> to go back and try it with a few of the other kernels but I just wanted to 
> know if that pci=noacpi paramater tells the PCI subsystem to ignore the ACPI 
> IRQ routing tables or what it does.
> 
> Regards,
> Andrew




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
