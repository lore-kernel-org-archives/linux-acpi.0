From: NoZizzing OrDripping <nozizzingordripping-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI trouble (AC module, etc.) with Toshiba 1115-S103
Date: Thu, 12 Dec 2002 16:43:16 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021213004316.39542.qmail@web14503.mail.yahoo.com>
References: <20021210092357.GA29390@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021210092357.GA29390-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--- Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:
> On Mon, Dec 09, 2002 at 10:59:22PM -0800, NoZizzing
> OrDripping wrote:
> > 
> > Status report for Toshiba Satellite 1115-S103
> laptop....
> > 
> > Just tried 2.4.20 + acpi-20021205-2.4.20.diff with
> a Toshiba Satellite
> > 1115-s103 laptop (new model, BIOS is "first
> production release", dated
> > 11/01/2002, street price is between $650 and
> $1000, depending on
> > rebates).  Built it all-modular and with debug
> messages.
> > 	$ root modprobe ac; dmesg
> > 
> > 	exfldio-0122 [31] Ex_setup_region       : Field
> [ACPW] Base+Offset+Width 38+0+4 is beyond end of
> region [GPIO] (length 3B)

> Known issue with most of the Toshiba Satellite
> series with a Phoenix
> BIOS.  I guess that Toshiba (or in fact Compal)
> still don't
> know how to debug correctly their ASLs.
> 
> You need a patched DSDT for this model.

I don't believe that Toshiba/Microsoft will ever
change their ways.  This is a brand new model.
However, it looks to me like I could easily make
a kernel patch to add a CONFIG_ACPI_RELAXED
configuration option that will allow these ASL
mistakes, such as off-by-one on region size, to
be accepted.  That would allow people to use many
broken DSDT's without having to go thru all of the
trouble of the current method of DSDT overriding.

> BTW, I think that my tosh3k kernel module at
> ftp://ftp.poupinou.org/tosh_3000/
> will work for you.  I am in process of rewrite it a
> little, then I think that I can probably add your
> model if you agree.

Yes, it works with the simple addition of this model
to the list...
{ "TOSHIBA", "Satellite 1115", "" },


> the output from dmesg
> > 
>
/lib/modules/2.4.20/kernel/drivers/acpi/toshiba_acpi.o:
> insmod
>
/lib/modules/2.4.20/kernel/drivers/acpi/toshiba_acpi.o
> failed
> > 
>
/lib/modules/2.4.20/kernel/drivers/acpi/toshiba_acpi.o:
> insmod toshiba_acpi failed
> 
> The toshiba acpi support would probably not work for
> you, because your BIOS is
> a Phoenix one, not a Toshiba one.
> 
> > 
> > Dunno if this was supposed to work or not.  The
> laptop has an extremely
> > limited BIOS, you cannot change very much at all
> with it.
> 
> This is a 'legacy-free' bios...
> 
> -- 
> Ducrot Bruno
> 
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
