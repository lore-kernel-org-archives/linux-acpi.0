From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: ACPI + Laptop Power Management
Date: Fri, 21 Nov 2003 15:53:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031121135321.GF5917@luna.mooo.com>
References: <C386328088ED7F4E9F81AFBABDDF60DA03386202@wdmyexch02.my.asia.wdc.com> <20031121101232.GL32464@poupinou.org> <20031121111323.GB18223@luna.mooo.com> <3FBE0E02.3080203@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FBE0E02.3080203-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 21, 2003 at 02:07:14PM +0100, Luca Capello wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello Micha,
> 
> on 11/21/03 12:13, Micha Feigin wrote:
> | like said here, laptopmode is what you want since it holds back dirty
> | buffer flushes which is what you are experiencing. It will fire up the
> | disk on reads though. I attached a script that you can use to enter
> | laptopmode (was actually distributed with laptopmode as far as I could
> | tell when googling for the original patch). I call it in responce to
> | ac events from acpid to get it running when the power is disconnected.
> | Will have to make sure that you get those event though since I had to
> | twik my dsdt for that.
> thx for the script, I was searching for but I couldn't find :-(
> On the other hand, what do I search for in my DSDT? I mean, in which way
> can I know if the 'laptop_mode' is supported on my DSDT?

laptopmode has nothing to do with you dsdt. The dsdt is the acpi code in
the bios. Its relevent to look into it if you are using acpi and having
trouble since a lot of the bioses have a buggy dsdt table (acpi code
that is).
If you are using acpi look into acpid to be able to act upon acpi
events.
I this case, with acpid not running do (assuming you do have acpi
support, otherwise you won't see this file)
cat /proc/acpi/event
and pull out your power cord and then reinsert it. If you are getting
ACAD or BAT or somesuch thing messages then everything is ok (I don't
know how to do this with apm) and you can use acpid to run the
laptopmode script whenever your power is connected/disconnected.


> 
> | I could try making such a patch for ext3 if you want.
> Yes, please :-)

Will look into it.

> 
> Thx, bye,
> Gismo / Luca
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
> Comment: Using GnuPG with Debian - http://enigmail.mozdev.org
> 
> iD8DBQE/vg4AVAp7Xm10JmkRAmsWAJ928z25MNHuka49V08QWHa0NryAxACdFX8I
> iEg+mpKXPRz2VGqOOmu8y3g=
> =liFy
> -----END PGP SIGNATURE-----
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
