From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: ACPI C4 support
Date: Mon, 1 Mar 2004 20:16:15 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040301191615.GE562@elf.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A84702C932FD@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84702C932FD-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Stefan Behlert <behlert-l3A5Bk7waGM@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, trenn-l3A5Bk7waGM@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of 
> > Stefan Behlert
> > > No.  pblk_length is 0 or 6.  Not 5 nor 7 ;)
> > 
> > Sorry, I don't understand: We've a Laptop with a DSDT with
> >   Processor (\_PR.CPU0, 0x01, 0x00001010, 0x07)
> > in it.
> > Comment from the responsible BIOS-team:
> > "Our processor block object is 7 bytes in length because we 
> > also support
> >  C4 (P_LVL4) which is at <P_BLK>+6.  Therefore, the 
> > size/length must be
> >  reported as 7 and not 6."
> > 
> > Is the '7' the BIOS-developer mentioned the same '7' as 
> > mentioned by you?
> 
> This is wrong.
> 
> There is confusion here because what older systems do on C3 is different
> from what more recent systems do on C3, at the electrical level. I know
> at least internally the improved C3-like state was called "C4" but to
> the OS it just looks just like C3, and the value for C4 should go in
> P_LVL3. P_BLK length should remain 6.
> 
> The only way to get more than C1, C2, and C3 is via the _CST object.
> 
> Please tell the BIOS developer this. I have an old BIOS developers guide
> version that agrees with them but I just asked the experts internally
> and they said no.

Is updated verision of BIOS developers guide available somewhere?

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
