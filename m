From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Dell D600: teaching radeonfb how to wake up...
Date: Thu, 20 Nov 2003 12:13:15 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031120111315.GB432@openzaurus.ucw.cz>
References: <20031119180119.GB22307@tate.loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031119180119.GB22307-xkTd+U360DcAs8EywTwl9A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: pavel-+ZI9xUNit7I@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Fortunately, the kernel tree contains bits of code which can be useful.
> All the registers are known by name and number, for example (and it's a
> pity that the documentation about the __PWR_MAN'' register is
> inexistent). And the radeonfb driver contains a few things and hints.
> I'd gladly try a piece of code, supposedly coming from ATI, which ought
> to reset the device somehow. This piece of code was to be linked to the
> powerbook power management system, and is #if0'ed anyway since it is
> quoted to be no cure for some problem. Still, I think it's worth trying.
> 
> I'm not an expert on kernel programming. On which code paths should I
> plug things ? Say I have to functions radeon_go_sleep and
> radeon_wake_up, what device info can I expect to access, and where
> should I plug my functions ? Does anybody know of a well-educated fb
> driver, where such a manual reset of the device is done on wakeup. I
> could follow this as an example.


If I were you, I'd create fix_ati.o module which would
"do the stuff", then insert it over network. That should
make debugging easier...
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
