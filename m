From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: Standby (S1) does not work
Date: Mon, 7 Jun 2004 14:29:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040607122920.GA11860@elf.ucw.cz>
References: <pan.2004.06.06.15.05.09.196978@luminal.org> <pan.2004.06.07.00.34.31.1417@luminal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <pan.2004.06.07.00.34.31.1417-wxkiEGMmYARAfugRpC6u6w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Grigoriev <mag-wxkiEGMmYARAfugRpC6u6w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > In possibly related news, I noticed this abnormality:
> > 
> > # cat /sys/power/state
> > standby mem disk
> > 
> > # cat /proc/acpi/sleep
> > S0 S3 S4 S4bios S5
> > 
> > Notice that proc does not even list S1!
> 
> Further research shows that S1 does in fact not exist. _S1 is not defined
> in the DSDT. I thought S1 is like the most basic ACPI mode and everybody
> would have it, no? Do you think that it is actually not supported by
> hardware, or is it just that the didn't bother adding it to the
> DSDT?

S1 is basically useless, no wonder hw manufacturers do not support
it. It was workaround for old windows...
							Pavel


> Would it be a safe experiment to try throwing something like 
> 
>     Name (\_S1, Package (0x03)
>     {
>         0x02, 
>         0x02, 
>         0x00
>     })
> 
> into the DSDT?

You are not linkely to fry anything.

-- 
934a471f20d6580d5aad759bf0d97ddc


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
