From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Mon, 29 Jul 2002 19:56:50 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020729175650.GA1233@elf.ucw.cz>
References: <20020729090041.GB115@elf.ucw.cz> <20020729150807.3604@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020729150807.3604-Q0ErXNX1RuY/GWcAdfcqrQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, Lyle <lwspm-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >> The nice thing here, I beleive, is that suspend to disk could then just
> >> be an additional generic step between 1) and 2) that takes care of
> >> dumping memory content to disk.
> >
> >It can not, because after saving state you can not easily write to
> >swap partition.
> 
> Well, you have to. I mean, you can't write to swap before saving state
> (or you'll miss some state information). Which means the device dealing
> with the save has to be treated as a special case. At least, that's what
> we figured out when discussing this during OLS. 

Discussing with who?

Its rather simple: free half of memory, stop everything, save device
state, copy used memory into free memory, continue devices, save data
from "free" memory into swap.

> >Too complicated. Look at swsusp -- it is designed not to need
> >pre-allocated pages, pre-mapped DMA etc.
> 
> I didn't look at it recently, but does it work properly in a solid
> way whatever state other devices are ?

It is designed to be safe, yes.

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
