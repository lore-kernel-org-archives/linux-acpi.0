From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: help needed with invalid method in GPE block
Date: Tue, 18 Mar 2003 22:44:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030318214414.GA12883@dutidad.twi.tudelft.nl>
References: <F760B14C9561B941B89469F59BA3A847E96D1A@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96D1A-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
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

On Tue, Mar 18, 2003 at 09:21:15AM -0800, Grover, Andrew wrote:
> > From: Charl P. Botha [mailto:c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org] 
> > Can I assume that you mean:
> > acpe_enable_event(gpe_num, ACPI_EVENT_GPE, ACPI_EVENT_WAKE_ENABLE);
> > where gpe_num is in my case 0x1D (the method in the asl is _L1D)?
> 
> Hehe yes. Did I mention the next version will change that interface? :)
> 
> > I was planning on adding this just after the
> > status = acpi_hw_enable_gpe (gpe_event_info);
> > call in the acpi_ev_save_method_info() function of evgpeblk.c IF the
> > gpe_num is 0x1D.  Is this okay for verifying?
> 
> I would think so, but there's only one way to find out...

Yay, my frikking sleep button is now waking the laptop from sleep! Nevermind
the fact that everything else is still dead (these problems seem a tad more
tractable), the BUTTON IS WORKING.

Through printk()s all over, it seems that the acpi code never explicitly
enables the 0x1D event on my machine at all, nevermind enabling it for
waking.  Is this a problem with my firmware/dsdt or with the acpi kernel
code?

I ran into some *cough* Microsoft documents *cough* online that claimed that
*cough* Windows *cough* enabled/disabled certain devices for waking.
According to these documents, the sleep button was always enabled.  Should
Linux ACPI be doing the same?

Thanks,
Charl

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
