From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: ACPI + Laptop Power Management
Date: Mon, 24 Nov 2003 23:37:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031124213710.GA2700@luna.mooo.com>
References: <C386328088ED7F4E9F81AFBABDDF60DA03386202@wdmyexch02.my.asia.wdc.com> <20031121101232.GL32464@poupinou.org> <20031121111323.GB18223@luna.mooo.com> <3FBE0E02.3080203@pca.it> <20031121135321.GF5917@luna.mooo.com> <3FBE24DC.8020203@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FBE24DC.8020203-wlebWZzHoyE@public.gmane.org>
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

On Fri, Nov 21, 2003 at 03:44:44PM +0100, Luca Capello wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello Micha,
> 
> on 11/21/03 14:53, Micha Feigin wrote:
> | If you are using acpi look into acpid to be able to act upon acpi
> | events.
> | I this case, with acpid not running do (assuming you do have acpi
> | support, otherwise you won't see this file)
> | cat /proc/acpi/event
> | and pull out your power cord and then reinsert it. If you are getting
> | ACAD or BAT or somesuch thing messages then everything is ok (I don't
> | know how to do this with apm) and you can use acpid to run the
> | laptopmode script whenever your power is connected/disconnected.
> yes, I can, I mean, I had already checked for this event (AC-adapter)
> and it works :-) BTW, for those who don't know, I'm using an ASUS M3N
> (Centrino) with the latest BIOS available (0205A released 20031117).
> I've just a little problem and I'm going to inform this list ASAP (I
> need some tests before).
> 
> | Will look into it.
> Thank you very much!
> 

Someone already answeared that, but I looked into it and ext3 already
takes into account the entries in bdflush to postpone flushing when in
laptop mode (I haven't checked if it checks for laptop mode to do that
but I doubt).
I read in the descripition that ext3 was already handled, but the code
was in the jbd directory and not the ext3 directory, and since I haven't
bothered with ext3 before (I am currently using reiserfs) I thought it
was related to something else.
If anyone wants a similar patch against reiserfs, I got one (if someone
can point me in the right direction to post it so that it can be
reviewed and put into the kernel it will also be nice - is lkml the
place?).

> Thx, bye,
> Gismo / Luca
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
> Comment: Using GnuPG with Debian - http://enigmail.mozdev.org
> 
> iD8DBQE/viTaVAp7Xm10JmkRAuHGAJ910nA2C57ZEyGlZ2ymRZQpTBwFjQCfXlIy
> xCTsJEBr1k1Pqb+LvwC11rw=
> =+fWR
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
