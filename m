From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: Testing: NVidia closed driver fails.
Date: Fri, 20 Sep 2002 01:11:51 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209192215.g8JMEv306270@pfn1.pefnos>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com> <20020919150652.GC311@poup.poupinou.org> <200209192208.40254.jbr.1@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200209192208.40254.jbr.1-hi6Y0CQ0nG0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Jochen Reinwand <jbr.1-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>
> I read somewhere that NVidia kernel drivers make problems with apm.
> In the syslog appears the following when starting X:
>
> kernel: apm: set display: Power management disabled
That happens at both my Linux boxes (using ACPI). Consider it normal.

>
> It's a few seconds after the modules are inserted, so perhaps SuSE does it
> somewhere in the startup scripts... Have not found it yet...
>
>
> I have a KT133 (Asus A7V) and also a Geforce 2 MX.
Mine must be a Chaintech.

> With ACPI enabled X gets slow. I mean REALLY SLOW! It needs up to 20
> seconds to start and then consumes as much CPU time as possible. It's an
> adventure to try to hit something with the mouse pointer.
> Everything is funktioning perfectly without ACPI.
> Perhaps an interrupt problem. ACPI shares an interrupt with a bttv card.
> The GeForce has it's own interrupt.
Huh! You just mentioned a magic word: bttv. I do have a bt878 card, I have to 
look if that is the problem after all.

To A. Grover: if the trouble lies in the bttv driver, the kernel will be 
considered broken until both drivers co-exist..

>
> Jochen
>

> > > I have tried the 2.4.20-pre7 + acpi-20020918 patch on a single Athlon
> > > XP 1.7+, VIA VT8637 KT266 chipset. The system boots and displays some
> > > ACPI info that looks fine.
> > > However, the proprietary NVidia video driver (I have a Geforce 2 MX
> > > card and the newest 1.0.3123 proprietary driver) fails to start the X
> > > system. I strongly suspect (although I don't have enough debug info
> > > yet) that the acpi patch is the one that makes NVidia fail. The 2.4.19
> > > worked until the acpi patch was applied to it.
> >
> > Ducrot Bruno:
> > I suspect an interrupt trouble.  Could you 'lspci -xxx -vvv' the device
> > with and without acpi?
Please hold a bit as the system in question is my 'stable' one and I don't 
want to debug it too often. I will certainly do that, but it may take a 
couple of days.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
