From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Why do I have to set pci=noacpi for network card to work?
Date: Tue, 26 Apr 2005 12:23:31 -0600
Message-ID: <200504261223.31963.bjorn.helgaas@hp.com>
References: <16A54BF5D6E14E4D916CE26C9AD3057501C8AD2D@pdsmsx402.ccr.corp.intel.com> <200504261132.25783.gkanis@cems.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200504261132.25783.gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Vasileios Gkanis <gkanis-4fMUIQ/vbHD2fBVCVOL8/A@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 26 April 2005 10:32 am, Vasileios Gkanis wrote:
> > pci=noacpi disallow ACPI doing IRQ routing and PCI bus scan. Did
> > acpi=noirq help the system? If yes, it maybe an interrupt issue.
> With acpi=noirq, I can get an IP address. 
> 
> I found these errors in dmesg
> 
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>     ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LPCB.LNKA] in namespace, 
> AE_NOT_FOUND
>     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._PRT] (Node 
> dfec1ca0), AE_NOT_FOUND

Looks to me like your _PRT references LNKA, which should
appear in the namespace.  But apparently it doesn't.

That's a bug in your firmware.  Are any BIOS upgrades available?

You could disassemble your DSDT to explore this further.
In short, "cp /proc/acpi/dsdt dsdt; iasl -d dsdt;
cat dsdt.dsl".

You can get iasl here:
    http://www.intel.com/technology/IAPC/acpi/downloads.htm


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
