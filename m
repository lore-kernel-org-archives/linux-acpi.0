From: Hilbert Barelds <list-XfCjptVMDKWuyJwMYI9mNQ@public.gmane.org>
Subject: Re: ACPI vs. PCMCIA on Compaq Evo N800c
Date: Mon, 28 Apr 2003 22:49:03 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1051562943.2523.53.camel@calvin.hjblocal.nl>
References: <3EAB29E2.5030702@woogie.net>
 <20030427100023.A16436@fermat.unipv.it>
 <1051436106.2388.9.camel@calvin.hjblocal.nl>
 <16045.32403.175503.231256@hotzenplotz.chateau-neukoelln.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <16045.32403.175503.231256-/D6BEnooUbBSBwh6+m2SNzw7hsPlABbXrfATN7qnIZ4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stephan Krings <Stephan.Krings-Mmb7MZpHnFY@public.gmane.org>
Cc: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2003-04-28 at 21:18, Stephan Krings wrote:
> Hi,
> 
> > I also have an Evo N800v RedHat 9
> 
> I'm using a N800c, but still some comments:
> 
> > -Fn F7 and Fn F8 not working
> 
> This is not ACPI related I think: I also had this problem once, and if
> I remember correctly it was related to the version of XFree86 I was
> using. Try to install the latest 4.3.0 and see if it helps.

RedHat 9 has XFree 4.3.0 it seems that the 2.4.20 kernel has a working
Fn 7, fn 8 and lid switcht, bit 2.4.21-pre4 not

> > -lidswitch not working, but if working display doesn't come back
> 
> Yes, I'm having that problem, too. I can work around it by switching
> blindly to a text console and pressing the lid button, again. The text
> console will appear then and switching back to X works now. But this
> doesn't seem to work if I have the radeon framebuffer enabled. This
> still sucks...

Hmmm, I think the radeon frame buffer and XFree byte each other. I think
I am going to try that later this week.

> I tried to locate and disable the code in the DSDT, which toggles the
> backlight off when the lid button is activated, but didn't
> succeed. This seems to happen beyong the ACPI realm.
> 
> > -irda not working
> 
> Can't confirm that. From my modules.conf:
> 
> alias irda0 nsc-ircc
> options nsc-ircc io=0x03e8 irq=3
> 
> I used that to communicate to a mobile phone (Nokia 6210) and it
> worked fine.
> 

Thanks I wil try that.

> > -acpi performance not working (known problem)
> 
> Same for me. If you manually need to toggle the CPU frequency, try the
> cpufreq patch. 

the cpufreq patch seems te work, but I don't notice any difference in
power consumption reported the battery status


> 
> Regards,
> 
> Stephan

Thanks Stephan, I will report to the list the results of my experiments,

Hilbert


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
