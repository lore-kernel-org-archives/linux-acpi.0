From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI C4 support
Date: Mon, 1 Mar 2004 20:48:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040301194825.GB2869@poupinou.org>
References: <20040228161011.GA10448@elf.ucw.cz> <20040301152810.GT2869@poupinou.org> <20040301180958.GI2624@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040301180958.GI2624-l3A5Bk7waGM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Behlert <behlert-l3A5Bk7waGM@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, trenn-l3A5Bk7waGM@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 01, 2004 at 07:09:58PM +0100, Stefan Behlert wrote:
> Moin,
> 
> On Mar 01, 04 16:28:10 +0100, Bruno Ducrot wrote:
> > On Sat, Feb 28, 2004 at 05:10:11PM +0100, Pavel Machek wrote:
> > > Hi!
> > > Thomas told me:
> > > >what about C4 - Cn states in the kernel implementation?
> > > >A short look into the /proc/acpi/processor/.../power file let me think
> > > >that only C0-C3 is supported by the kernel, even specification talks
> > > >about Cn states?
> > > As a first step, it would be nice if kernel at least used C0..C3 if
> > > the machine supports them... This should do the trick. Does it look
> > > okay?
> > 
> > No.  pblk_length is 0 or 6.  Not 5 nor 7 ;)
> 
> Sorry, I don't understand: We've a Laptop with a DSDT with
>   Processor (\_PR.CPU0, 0x01, 0x00001010, 0x07)
> in it.
> Comment from the responsible BIOS-team:
> "Our processor block object is 7 bytes in length because we also support
>  C4 (P_LVL4) which is at <P_BLK>+6.  Therefore, the size/length must be
>  reported as 7 and not 6."
> 
> Is the '7' the BIOS-developer mentioned the same '7' as mentioned by you?
> 

No.  Bad documentation.  Change documentation.  Look at acpi spec at
http://www.acpi.info/

You can define only latencies for C2 and C3 via FADT, so if you allow
C4 via the p_blk, you *don't* have latency for C4.  You *must* define C4
in a _CST object in order to get at least the latency, amongst other
informations.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
