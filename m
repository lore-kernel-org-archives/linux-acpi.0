From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: help needed with invalid method in GPE block
Date: Mon, 17 Mar 2003 15:07:31 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19BBCB@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'Charl P. Botha'" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

You can ignore the GPE error messages, they are leftover cruft and have no
meaning.


> -----Original Message-----
> From: Charl P. Botha [mailto:c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org]
> Sent: Monday, March 17, 2003 1:35 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] help needed with invalid method in GPE block
> 
> Dear list,
> 
> I'm still trying to get my stupid sleep/wake-button to wake my laptop.
> This
> is quite interesting:
> 
> ACPI Namespace successfully loaded at root c02cdcfc
> evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode
> successful
>    evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at
> 0000000000001028
>    evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to
> GPE15
>    evgpe-0138 [08] ev_save_method_info   : GPE number associated with
> method _L1D is not valid
>    evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at
> 000000000000102C
>    evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE16 to
> GPE31
>    evgpe-0138 [08] ev_save_method_info   : GPE number associated with
> method _L05 is not valid
>    evgpe-0138 [08] ev_save_method_info   : GPE number associated with
> method _L1D is not valid
> 
> Coincidentally, in my dsdt _L1D (the one with invalid number above) is a
> control method for my sleep button (control method type, not hard-wired).
> This _could_ explain why the button is not doing anything when pressed
> during sleep:
> 
>         Method (_L1D, 0, NotSerialized)
>         {
>             Notify (\_SB.SLPB, 0x02)
>         }
> 
> This is in the \_GPE scope.  I've tried hacking the control method sleep
> button example on page 66 of ACPIspec-2-0a.pdf into my dsdt as method
> _L01,
> but to no avail.  Then ACPI just claims that _L01 is invalid for the
> *second* GPE block:
> 
> evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode
> successful
> evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at
> 0000000000001028
> evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to GPE15
> evgpe-0138 [08] ev_save_method_info   : GPE number associated with method
> _L1D is not valid
> evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at
> 000000000000102C
> evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE16 to
> GPE31
> evgpe-0138 [08] ev_save_method_info   : GPE number associated with method
> _L05 is not valid
> evgpe-0138 [08] ev_save_method_info   : GPE number associated with method
> _L1D is not valid
> evgpe-0138 [08] ev_save_method_info   : GPE number associated with method
> _L01 is not valid
> 
> In both cases, my fixed DSDT compiled with iasl 20030228 with no errors
> and
> no warnings.
> 
> Can anyone explain to me why I have two GPE blocks?  This means (according
> to the code logic in the acpi driver) that a control method is ALWAYS
> going
> to have an invalid GPE number in at least one of the two blocks.
> 
> If anyone is interested, my original dsdt is here:
> http://cpbotha.net/thingies/dsdt.asl.original
> and the hacked one is here:
> http://cpbotha.net/thingies/dsdt.asl
> 
> The object of the game is to get my wake button to wake. :)
> 
> Thanks,
> Charl
> 
> --
> charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/
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
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
