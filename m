From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: help needed with invalid method in GPE block
Date: Tue, 18 Mar 2003 14:25:11 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19BBD5@orsmsx107.jf.intel.com>
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
To: "'Charl P. Botha'" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

So,
We are calling acpi_hw_enable_gpe() on 0x1D or not?



> -----Original Message-----
> From: Charl P. Botha [mailto:c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org]
> Sent: Tuesday, March 18, 2003 2:09 PM
> To: Grover, Andrew
> Cc: Moore, Robert; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] help needed with invalid method in GPE block
> 
> On Tue, Mar 18, 2003 at 01:54:11PM -0800, Grover, Andrew wrote:
> > > Through printk()s all over, it seems that the acpi code never
> > > explicitly
> > > enables the 0x1D event on my machine at all, nevermind enabling it for
> > > waking.  Is this a problem with my firmware/dsdt or with the
> > > acpi kernel
> > > code?
> >
> > Are you sure? We should be calling acpi_ev_save_method_info for each
> > _Lxx or _Exx entry under _GPE scope, and that function enables the GPE.
> > Please let me know if this is not the case.
> 
> I'm quite sure.  Yes, you do call acpi_ev_save_method_info() for each _Lxx
> and _Exx method, but in acpi_ev_save_method_info() you only call
> acpi_hw_enable_gpe() and NEVER acpi_hw_enable_gpe_for_wakeup().  As a
> matter
> of fact, shouldn't that call rather be acpi_enable_event() (INSTEAD of
> acpi_hw_enable_gpe()) with the WAKEUP parameter according to some mask?
> 
> Fact is, with my ACPI-untrained eyes, I couldn't find any occurrence where
> acpi_hw_enable_gpe_for_wakeup() is directly or indirectly called for the
> sleep button method (_L1D in my case).
> 
> Your thoughts?
> 
> Thanks,
> Charl
> 
> --
> charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Does your code think in ink?
> You could win a Tablet PC. Get a free Tablet PC hat just for playing.
> What are you waiting for?
> http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
