From: Lu Tong <ltong-r3+FECOBLOPAaqN1iTbosg@public.gmane.org>
Subject: Re: Thinkpad R32 2.5.65-acpi
Date: Mon, 24 Mar 2003 12:22:33 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030324172233.GA17402@dao.cs.ohiou.edu>
References: <200303240706.h2O76pF09989@throb.netspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200303240706.h2O76pF09989-7GtV0IYKK74tA4QZiFxQkx2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I has exactly the same problem with you on a IBM X22. the workaround is to comment out the "if (ec_ecdt && ec_ecdt->uid == uid) {...}" block in acpi_ec_add() of ec.c. the problem is due to some bug in space_hanlder management. btw, ShiftLeft (Local0, 0x08, Local0) is a right fix. 

--ltong

On Mon, Mar 24, 2003 at 02:06:51AM -0500, bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org wrote:
> 
> I've been playing around with ACPI power management a bit on my R32.
> 
> I'm a bit new to this, but I think I've done my homework.  I Found the
> ECDT table replacement stuff, and followed those instructions.  This
> lead to a number of errors right after initializing ACPI(right after
> the PCI IRQ routing):
> 
> 
> evregion-0341: *** Error: Handler for [SystemMemory] 
> 		   returned AE_BAD_PARAMETER
> psparse-1121: *** Error: Method execution failed [\SMI_] 
> 	      	   (Node c13b8728), AE_BAD_PARAMETER
> psparse-1121: *** Error: Method execution failed [\KCMD] 
> 		   (Node c13bcda8), AE_BAD_PARAMETER
> psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.
> 		   LPC_.EC__.PUBS._STA] (Node c131cea8), AE_BAD_PARAMETER
> evregion-0341: *** Error: Handler for [SystemMemory]
> 		    returned AE_BAD_PARAMETER
> psparse-1121: *** Error: Method execution failed [\SMI_] 
> 		   (Node c13b8728), AE_BAD_PARAMETER
> psparse-1121: *** Error: Method execution failed [\RBEC] 
> 		   (Node c13b8ba8), AE_BAD_PARAMETER
> psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.
> 		   LPC_.EC__.BAT0._STA] (Node c13194a8), AE_BAD_PARAMETER
> evregion-0341: *** Error: Handler for [SystemMemory] returned 
> 		   AE_BAD_PARAMETER
> psparse-1121: *** Error: Method execution failed 
> 		   [\SMI_] (Node c13b8728), AE_BAD_PARAMETER
> psparse-1121: *** Error: Method execution failed 
> 		   [\RBEC] (Node c13b8ba8), AE_BAD_PARAMETER
> psparse-1121: *** Error: Method execution failed 
> 		   [\_SB_.PCI0.LPC_.EC__.BAT1._STA] (Node c1319b28),
> 		    AE_BAD_PARAMETER
> 
> FWIW I get the same messages (or at least very similar) messages under
> recent kernels (2.4 series with acpi patches , 2.5.65, and and acpi
> patched 2.5.65.)
> 
> In /proc/acpi, there is no sleep file, there is an empty battery, an
> empty ac_adapter directory, a CPU directory that seems to be
> reasonable, and a thermal directory that says 50C all the time.
> 
> Closing and opening the lid leads to another series of error messages,
> and little else. I won't get into that here.
> 
> I tried to enable ACPI debugging selectively so I might trace what was
> going on, but I got pretty confused and gave up.
> 
> Anyway, so I thought I'd try to take a look at the dsdt code and
> disassemble it.  Interestingly, recompiling it produced an error:
> 
> dsdt.dsl  5881:                 ShiftLeft (Arg0, 0x08, Local0)
> Error    1014 -                               ^ Method argument 
> 						is not initialized (Arg0)
> 
> This is from
> 
>      Method (_L18, 0, NotSerialized)
>         {
>             Sleep (0x07D0)
>             Store (\KCMD (0xC9, 0x00), Local0)
>             Store (Local0, \RRBF)
>             If (LEqual (Local0, 0x2F))
>             {
> BAD>>           ShiftLeft (Arg0, 0x08, Local0)
>                 Store (Or (0x2013, Local0), Local0)
>                 \_SB.PCI0.LPC.EC.HKEY.MHKQ (Local0)
>             }
> 
>             Notify (\_SB.SLPB, 0x02)
>         }
> 
> 
> 
> The line is pretty nonsensical, so I figured this couldn't be any worse
> (and maybe what "they" meant to do in the first place):
> 
>         ShiftLeft (Local0, 0x08, Local0)
> 
> So I compiled, and ran it.  The table gets loaded, but everything
> seems pretty much the same.
> 
> Also of note, I specifically went into dmi_scan and de-Blacklisted my
> laptop from the smbus ban (and crossed my fingers), since I wan't sure
> if that was causing problems and it seems unlikely to destroy anything
> from what I've read (fingers crossed).
> 
> I suspect that I've attemted to fix one of the switches, which
> probably won't fix any of the above error messages.
> 
> Anyway, any input on where to go from here would be helpful.  I'm
> rather amazed at how broken the tables are.
> 
> 
> 
> --
> Hello, Justice Department?  I'd like to report a subversive penguin.  
>   --Tom Tomorrow "This Modern World"
> Brian Perkins                bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by:Crypto Challenge is now open! 
> Get cracking and register here for some mind boggling fun and 
> the chance of winning an Apple iPod:
> http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
