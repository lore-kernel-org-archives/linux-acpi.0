From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: If your ACPI-enabled machine does clean shutdown randomly...
Date: Mon, 1 Dec 2003 11:57:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031201105714.GA2734@atrey.karlin.mff.cuni.cz>
References: <20031128145249.GA563@elf.ucw.cz> <3FCB0F13.7010908@sbox.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FCB0F13.7010908-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gerfried Maier <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I was now able to log such a shutdown with temperature-printouts at the 
> important places.
> 
> When reading the log, I can state two things:
> * The temp-value causing the shutdown is definitly bogus, as the entries 
> before and after the trip-causing check are far below that value but 
> occuring at nearly the same time.
> * Unfortunately the value is not as ingredible as your 200C, so 
> distingushing between a bogus and a non-bogus value is not that simple.
> 
> I attached a cut from the syslog.

Well, from time to time my machine reports 170C and shuts down anyway
:-(. But I'm afraid to make check more complicated.

Perhaps checking if we got error handling right in thermal code/AML
interpretter is a good idea..

> ^^^^^^^) to thermal.c (2.4.22-version):

> 	acpi_thermal_call_usermode("/bin/logger ACPI poweroff");
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> # Unfortunately, this line does not generate the log-enty I expect it
> # to.

Ugh. This is nasty. You really want to do printk(KERN_CRIT, ....);


-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
