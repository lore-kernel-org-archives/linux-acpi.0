From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ACPI issues - suspend-to-ram and processor speed
Date: Sat, 29 May 2004 14:49:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040529124934.GA15685@elf.ucw.cz>
References: <200405180213.34603.andre@eisenbach.com> <200405280117.51602.andre@eisenbach.com> <20040528082426.GD1808@elf.ucw.cz> <200405280221.52819.andre@eisenbach.com> <20040528093102.GG1808@elf.ucw.cz> <40B8815F.4000406@khmer.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40B8815F.4000406-LA8/tbxb0N8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Vibol Hou <vibol-LA8/tbxb0N8@public.gmane.org>
Cc: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!


> Where should one look if system doesn't do the slowly blinking power LED 
> when echo 3 > /proc/acpi/sleep?  It says entering state and then appears 
> to just power off, nothing flashing.

ACPI problem while entering suspend... Systems were where writing
wrong number to 4-bit field somewhere in hwsleep.c actually made it to
work...

								Pavel

> -Vibol
> 
> >Take a look at arch/i386/kernel/acpi/wakeup.S, there's where resume
> >begins. Try to find out if wakeup_code: is executed or not. (That's
> >where soldering iron comes to play). If wakeup_code is not executed,
> >you'll need to fix sleep code. If it is, wakeup needs to be fixed...
> >
> >								Pavel
> > 
> >
> 

-- 
934a471f20d6580d5aad759bf0d97ddc


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
