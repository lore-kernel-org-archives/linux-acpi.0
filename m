From: Hilbert Barelds <h.j.barelds-XfCjptVMDKWuyJwMYI9mNQ@public.gmane.org>
Subject: Re: ACPI vs. PCMCIA on Compaq Evo N800c
Date: Sun, 27 Apr 2003 11:35:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1051436106.2388.9.camel@calvin.hjblocal.nl>
References: <3EAB29E2.5030702@woogie.net>
 <20030427100023.A16436@fermat.unipv.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20030427100023.A16436-xzhXYMPkGmXoPXhRcRtihA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Daniele,

I also have an Evo N800v RedHat 9

ATI.2 XFree patch

Still with kernel 2.4.21-pre4 and its acpi version, cpufreq patch.

With the latest version 2.4.21-rc1 and latest acpi patch the laptop gets
really hot.

kernel 2.5.68 no display on my radeon

-Fn F7 and Fn F8 not working
-lidswitch not working, but if working display doesn't come back
-irda not working
-acpi performance not working (known problem)

Anyone here that can help

Hilbert

On Sun, 2003-04-27 at 10:00, Daniele Boffi wrote:
> Mike,
> I have got a Evo N800v which should not be much different from N800c. I would
> say my acpi is fully functional (besides a small problem with CPU performance
> status: it works fine, changing its status when on AC or battery, but is not
> reported correctly in /proc/acpi).
> I don't see your problem. Actually, I've never tried to use PCMCIA since
> I don't need it, but here is the output of cardctl and lspci.
> 
> Regards,
> 
> Daniele
> 
> $ cardctl status
> Socket 0:
>   no card
> 
> 
> $ lspci
> 00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
> 00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)
> 00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42)
> 00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
> 00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 02)
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]
> 02:04.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
> 02:06.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
> 02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller (rev 42)
> 02:0e.0 USB Controller: NEC Corporation USB (rev 41)
> 02:0e.1 USB Controller: NEC Corporation USB (rev 41)
> 02:0e.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
> 
> > I'm trying to get ACPI working on my Compaq Evo N800c.  Actually, I 
> > should say that I have it working, or at least it's loading and I'm 
> > seeing entries in /proc/acpi, but whenever I boot with a kernel with 
> > ACPI enabled, it breaks PCMCIA.  The drivers attempt to load, but can't 
> > find the cardbus controller, which doesn't even show up in lspci.  Is 
> > this a common problem?  I've tried about 3 different kernel versions 
> > with both the stock ACPI and the patches from sourceforge, and they all 
> > behave the same way.  Any tips on where I should look to find a fix?
> > 
> > Thanks
> > Mike
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
