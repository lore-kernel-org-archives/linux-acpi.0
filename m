From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: ACPI PCI routing problem
Date: Fri, 11 Jul 2003 17:23:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307111723.45272.adq_dvb@lidskialf.net>
References: <200307110022.29512.adq_dvb@lidskialf.net> <200307111356.22376.adq_dvb@lidskialf.net> <20030711140227.GF22636@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030711140227.GF22636-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> > Yeah, I can easily make it work by turning it off or supplying
> > pci=noacpi. However, I'm pursuing this problem to develop a fix for the
> > issue.
> >
> > The new ACPI PCI routing seems to cause other people problems as well..
> > I've seen mention on various web pages. Not really a good situation to
> > leave these problems in the OS.
>
> Forgot to say: have you also the same kind of output, but
> with ACPI?  If all (at least the 15 first one) look like XT-PIC...

Yeah, its pretty much the same, although it says IO-APIC instead of XT-PIC.

If I don't use pci=noacpi, I get the problem I'm describing (obviously), with 
IRQs 21 etc mentioned.
If I use pci=noacpi, it also says IO-APIC, but it only has 16 IRQs total.

(I can't remember the _exact_ word it uses offhand.. something like 
IO-APIC-edge I think)




-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
