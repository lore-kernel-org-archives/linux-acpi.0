From: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Subject: RE: eisa_set_level_irq(acpi_fadt.sci_int)
Date: Fri, 17 Oct 2003 12:39:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031017103941.GA2893@abra.quelltext.com>
References: <F760B14C9561B941B89469F59BA3A8470255EF51@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470255EF51-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 15, 2003 at 03:09:59PM -0700, Grover, Andrew wrote:
> > From: Brown, Len 
> > What does eisa_set_level_irq() do for us?
> > 
> > As its presence breaks the !CONFIG_PCI build, I deleted it and found
> > that ACPI in PIC mode seems to work just fine without it (at 
> > least on 2
> > of 2 systems tested so far)
> 
> This is how you set a PIC interrupt to PCI semantics (active low, level
> triggered.) If your ACPI interrupt is shared, the PCI subsystem will
> call this for the irq and so whether ACPI calls it or not is not an
> issue, but if ACPI is alone on the irq, it must call it or the irq will
> have ISA semantics.

There are a couple of laptops for which the calls to eisa_set_level_irq()
are needed to get some builtin devices to work, i.e. the Gericom 1st
SuperSonic, Supersonic GPRS, Supersonic2; FIC A360, A380; Medion MD 9703.

Apparently the BIOS only initializes the PCI interrupt lines required for
booting and leaves the setup of the rest to the OS. Without these calls
done by the ACPI IRQ routing code, I can't use FireWire, PCMCIA, modem,
and NIC, so please do not remove them. And the call for the ACPI interrupt
is needed, too, or the ACPI events (e.g. power button, lid) won't work.

Best regards,
Arndt

-- 
Arndt Schönewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>, Software Developer
Quelltext AG (http://www.quelltext-ag.de), Dortmund, Germany


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
