From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: help needed with invalid method in GPE block
Date: Tue, 18 Mar 2003 14:24:31 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A204@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Charl P. Botha [mailto:c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org] 
> > > Through printk()s all over, it seems that the acpi code never 
> > > explicitly
> > > enables the 0x1D event on my machine at all, nevermind 
> enabling it for
> > > waking.  Is this a problem with my firmware/dsdt or with the 
> > > acpi kernel
> > > code?
> > 
> > Are you sure? We should be calling acpi_ev_save_method_info for each
> > _Lxx or _Exx entry under _GPE scope, and that function 
> enables the GPE.
> > Please let me know if this is not the case.
> 
> I'm quite sure.  Yes, you do call acpi_ev_save_method_info() 
> for each _Lxx
> and _Exx method, but in acpi_ev_save_method_info() you only call
> acpi_hw_enable_gpe() and NEVER 
> acpi_hw_enable_gpe_for_wakeup().  As a matter
> of fact, shouldn't that call rather be acpi_enable_event() (INSTEAD of
> acpi_hw_enable_gpe()) with the WAKEUP parameter according to 
> some mask?

I agree that it is currently never enabled for wakeup, but you said we
never enable it at all, the opposite of what your last email said. I
guess I'll assume the second statement is what you meant.

BTW here is the bug:
http://bugme.osdl.org/show_bug.cgi?id=470

Apparently it only allows CCs to registered people, so I couldn't add
you, but if you have any extra comments, feel free to register and add
them there.

Regards -- Andy



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
