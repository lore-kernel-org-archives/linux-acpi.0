From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Fwd: ACPI error when trying entring in Sleep Mode]
Date: Mon, 17 Mar 2003 19:16:50 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030317181650.GK8319@poup.poupinou.org>
References: <3E75C4A6.6000507@tin.it> <20030317134809.GF8319@poup.poupinou.org> <3E75D6E2.4040001@tin.it> <20030317153147.GH8319@poup.poupinou.org> <3E760D7D.4040405@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E760D7D.4040405-nc/lrvXPQ4s@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marci <voloterreno-nc/lrvXPQ4s@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 17, 2003 at 07:01:33PM +0100, Marci wrote:
> Ducrot Bruno wrote:
> 
> >On Mon, Mar 17, 2003 at 03:08:34PM +0100, Marci wrote:
> > 
> >
> >>Ducrot Bruno wrote:
> >>
> >>   
> >>
> >>>There is an error in your DSDT.  I don't doubt that if you
> >>>follow the instruction in
> >>>http://acpi.sourceforge.net/wiki/index.php/HowToOverrideTable
> >>>
> >>>you will get a complain from iasl with a inproper declaration of
> >>>an operational region.  Check first if you can increase the size
> >>>for this region will be sufficiant.  If not, then do not hesitate
> >>>to request more help!
> >>>
> >>>Cheers,
> >>>
> >>>
> >>>
> >>>     
> >>>
> >>Ehm, excuse me for the question, but how I can increase the size for 
> >>this region?
> >>   
> >>
> >
> >You disassemble the DSDT ACPI table via:
> >iasl -d /proc/acpi/dsdt
> >this will create a file called
> >dsdt.dsl
> >
> >Then if try to reassemble it via
> >iasl -tc -p my_table dsdt.dsl
> >
> >you will certainly get an error about a bad over-sized operational region.
> >
> >iasl is an intel tools found here:
> >
> >http://developer.intel.com/technology/iapc/acpi/downloads.htm
> >(which is also linked from http://acpi.sourceforge.net/)
> >
> >You can either get the (binary) iasl compiler/disassembler for Linux,
> >or the ACPI-CA unix build environment if you want to compile it
> >yourself.
> >
> > 
> >
> >>And why under Windows the dsdt have no problem ( I'd like only understand 
> >>)
> >>   
> >>
> >
> >Windows AML interpreter do not check bound operational regions.
> >ACPI-CA AML interpreter (and also Linux one) does, however, check
> >bound such regions.  ACPI-CA current position for this stuff is to
> >check bound such regions even though that will implies that it
> >can not provide total compatibility support.
> >Note that their are other compatibilty issues as well.  For example,
> >most if not all toshiba laptops (I speak for the non-compal case)
> >was shipped with an error for which they implicitely returned a value.
> >
> >It was stated by ACPI sig. that it is an error.  Note that Toshiba
> >has then released new bios which corrected this behaviour.
> >
> >Alas, it is somehow hard to get correct support from all vendor...
> >
> >The issue you get (a bad sized operational region) is present in most
> >of the toshiba-compal model series.  And toshiba still do not have
> >corrected this issue, even though they were warned about.
> >
> >So, sometimes, complaining to the bios vendor work, sometimes not.  Just
> >that we get the same kind of stupid answer as 'it work under windows'
> >even from the same vendor.
> >
> >Cheers,
> >
> > 
> >
> X Karol : Thanks for the documentation
> 
> X Bruno:
> 
> If I try to reassemble the code I get these errors:
> 
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20030228 [Feb 28 2003]
> Copyright (C) 2000 - 2003 Intel Corporation
> Supports ACPI Specification Revision 2.0b
> 
> dsdt.dsl   864:                 Field (U1D3, WordAcc, NoLock, Preserve)
> Error    1047 -                           ^ Access width is greater than 
> region size
> 
> dsdt.dsl   866:                     UR49,   3
> Error    1051 -                        ^ Access width of Field Unit 
> extends beyond region limit
> 
> dsdt.dsl   870:                 Field (UBP1, WordAcc, NoLock, Preserve)
> Error    1047 -                           ^ Access width is greater than 
> region size
> 
> dsdt.dsl   872:                     U1PE,   2
> Error    1051 -                        ^ Access width of Field Unit 
> extends beyond region limit
> 
> dsdt.dsl   905:                 Field (UBP2, WordAcc, NoLock, Preserve)
> Error    1047 -                           ^ Access width is greater than 
> region size
> 
> dsdt.dsl   907:                     U2PE,   2
> Error    1051 -                        ^ Access width of Field Unit 
> extends beyond region limit
> 
> dsdt.dsl   933:                 Field (UBP3, WordAcc, NoLock, Preserve)
> Error    1047 -                           ^ Access width is greater than 
> region size
> 
> dsdt.dsl   935:                     U3PE,   2
> Error    1051 -                        ^ Access width of Field Unit 
> extends beyond region limit
> 
> dsdt.dsl   961:                 Field (UBP4, WordAcc, NoLock, Preserve)
> Error    1047 -                           ^ Access width is greater than 
> region size
> 
> dsdt.dsl   963:                     U4PE,   2
> Error    1051 -                        ^ Access width of Field Unit 
> extends beyond region limit
> 
> dsdt.dsl  2797:                 Method (STM, 0, Serialized)
> Warning  2019 -                           ^ Not all control paths return 
> a value (STM_)
> 
> dsdt.dsl  3240:     Method (_WAK, 1, NotSerialized)
> Warning  2026 -                ^ Reserved method must return a value (_WAK)
> 
> ASL Input:  dsdt.dsl - 3356 lines, 103057 bytes, 1269 keywords
> Compilation complete. 10 Errors, 2 Warnings, 0 Remarks, 419 Optimizations
> 
> I think this will be hard to fix, right? I should post this to MSI , 

No.  It is not hard to fix.  But I must admit that it can sound 'hard'
to be fixed.
You will have an
OperationRegion (FOO, xxx, yyy, size)
Field (FOO, xxx, yyy, zzz)
{
	...,
	...,
}
(or even more Field statements which refereference
the FOO operational region)

The problem is probably due to the 'size'
in the OperationRegion (FOO, ...)
which is too 'low'.

Please give us the ASL produced, since actually the
Method (STM, 0, Serialized) is more anoying than the
size issue.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
