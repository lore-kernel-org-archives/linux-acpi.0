From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: Re: [PATCH] IRQ params patch#4
Date: Thu, 24 Jul 2003 14:31:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307241431.27136.adq_dvb@lidskialf.net>
References: <F760B14C9561B941B89469F59BA3A8470255EEA0@orsmsx401.jf.intel.com> <200307241013.34507.adq_dvb@lidskialf.net> <bfol43$fj7$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <bfol43$fj7$1@main.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rob North <tzwvgwv2001-O/bDAPVd7B0N+BqQ9rBEUg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 24 July 2003 13:58, Rob North wrote:
> Andrew de Quincey wrote:
> > On Wednesday 23 July 2003 08:53, Grover, Andrew wrote:
> >>Andrew,
> >>
> >>You still hacking on this?
> >>
> >>Just got another bug report (completely different HW) that I think might
> >>be the same problem.
> >
> > Yeah, I've been having a wee break for a few days. back on it now.
> >
> > Interesting fact. All my onboard devices work now, but I didn't have any
> > PCI cards. I've just put a wireless PCI card in my machine, and its
> > having the same IRQ problems as I used to with the onoard ones!
>
> I take it that the IRQ polarity issues are now fixed.
> The remaining issues are to handle the cases where ACPI routing fails,
> and cases where the _SRS method fails?

For me, they seem to be fixed for onboard devices, but not for devices plugged 
into PCI slots. 

I can detect when _SRS fails easily enough as you can do doubt see. What I 
need is a way of reliably dropping back to a different configuration method 
if _SRS fails. On my board, when I hack it to pretend theres been a failure, 
I can't yet get the drop-backed-to mechanism to reconfigure any IRQs which 
were configured with _SRS (even if it fails) properly.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
