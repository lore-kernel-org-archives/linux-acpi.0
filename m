From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: help needed with invalid method in GPE block
Date: Wed, 19 Mar 2003 09:38:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030319083805.GA14882@dutidad.twi.tudelft.nl>
References: <F760B14C9561B941B89469F59BA3A84725A204@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A204-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 18, 2003 at 02:24:31PM -0800, Grover, Andrew wrote:
> > From: Charl P. Botha [mailto:c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org] 
> > I'm quite sure.  Yes, you do call acpi_ev_save_method_info() 
> > for each _Lxx
> > and _Exx method, but in acpi_ev_save_method_info() you only call
> > acpi_hw_enable_gpe() and NEVER 
> > acpi_hw_enable_gpe_for_wakeup().  As a matter
> > of fact, shouldn't that call rather be acpi_enable_event() (INSTEAD of
> > acpi_hw_enable_gpe()) with the WAKEUP parameter according to 
> > some mask?
> 
> I agree that it is currently never enabled for wakeup, but you said we
> never enable it at all, the opposite of what your last email said. I
> guess I'll assume the second statement is what you meant.

Your assumption is correct. :)  For all clarity, the event is enabled, but
not enabled for wakeup.

> BTW here is the bug:
> http://bugme.osdl.org/show_bug.cgi?id=470

Excellent, thank you very much.  So, if I understand correctly, this would
mean that the button driver would call this function that you're going to
add in order to indicate that it, the button, should be able to wake the
system?

Thanks again,
Charl

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
