From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Laptop backlight/S1 in 2.6.6 vanilla
Date: Fri, 28 May 2004 10:08:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040528080821.GB1808@elf.ucw.cz>
References: <40B1D0BA.8080303@khmer.cc> <20040525192551.GM5215@openzaurus.ucw.cz> <40B6EB6F.4090508@khmer.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40B6EB6F.4090508-LA8/tbxb0N8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Vibol Hou <vibol-LA8/tbxb0N8@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I commented out pm_prepare_console() and pm_restore_console() in 
> kernel/power/main.c and the screen no longer turns back on.  However, 
> I'm still uncertain if this is safe.  What I do notice is that some 
> keyboard input still makes it into the terminal where I have initiated 
> sleep from while the machine is in S1 so it appears after I wake up the 
> machine.

It should be safe for S1. Not sure about S3, and it is bad idea for
S4.

> Somehow, this has also resolved another problem I had with the machine 
> cycling in and out of S1 mode a few times before finally staying awake.

Good.
									Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
