From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: ACPI PCI bus mismatch ?
Date: Mon, 10 Feb 2003 17:17:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030210161754.GI25625@poup.poupinou.org>
References: <F760B14C9561B941B89469F59BA3A84713802A@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84713802A-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Alvaro Lopes <alvieboy-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

On Thu, Feb 06, 2003 at 12:39:43PM -0800, Grover, Andrew wrote:
> > From: Alvaro Lopes [mailto:alvieboy-JkNoWtNHh5AAvxtiuMwx3w@public.gmane.org] 
> > OK, I tracked the problem down to acpi_os_derive_pci_id(). If 
> > I remove 
> > the call to acpi_os_derive_pci_id() in 
> > acpi_ev_pci_config_region_setup() 
> > it works fine.
> > 
> > Will do some tests on 2.5.x now and let you know.
> 
> Grrreat.
> 
> We stuck that code in because some IA64 systems needed it to work.
> 
> Sounds like we need to re-think all this. A hack for right now might be
> to only call derive on IA64 boxes.


It is KO for me.

I sticked:
printk(KERN_DEBUG "BEFORE: 0x%x 0x%x 0x%x 0x%x\n", pci_id->segment, pci_id->bus,
                                                   pci_id->device, pci_id->function);
acpi_os_derive_pci_id(...);
printk(KERN_DEBUG "AFTER: 0x%x 0x%x 0x%x 0x%x\n", pci_id->segment, pci_id->bus,
                                                   pci_id->device, pci_id->function);

in drivers/acpi/events/evrgnini.c::ev_pci_config_region_setup()

and it show me that pci_id->bus is *always* 0 at BEFORE, and will be
correct in AFTER (tested by creating 2 OPs, in fact).

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
