From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] PCI: do VIA IRQ fixup always, not just in PIC mode
Date: Tue, 10 May 2005 16:28:00 -0600
Message-ID: <200505101628.00548.bjorn.helgaas@hp.com>
References: <200505101044.15654.bjorn.helgaas@hp.com> <20050510210755.GA3967@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050510210755.GA3967-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
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
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 10 May 2005 3:07 pm, Greg KH wrote:
> On Tue, May 10, 2005 at 10:44:15AM -0600, Bjorn Helgaas wrote:
> > At least some VIA chipsets require the fixup even in IO-APIC mode.
> > 
> > This was found and debugged with the patient assistance of Stian
> > Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org> on an Asus CUV266-DLS motherboard.
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> 
> This is already present in the 2.6.12-rc4 kernel, right?

No, I reworked the VIA IRQ patch a while ago, but that rework
is in the ACPI BK tree:

    http://linux-acpi.bkbits.net:8080/26-stable-test/cset%404244603cD6KfNrnIjyYDqv0xzdI8cQ

So it's been in -mm for a while, but it's not in 2.6.12-rc4.
(I suggested a while ago that we consider it for 2.6.12, but
since it's intertwingled in the ACPI tree that might not be
easy.)

This current patch is incremental and applies to -mm.


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
