From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: vaio 505 (again)
Date: 15 Jul 2003 14:05:11 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1058274311.3845.32.camel@dhcp22.swansea.linux.org.uk>
References: <1058266578.1077.16.camel@lana>
	 <20030715114933.GC616@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030715114933.GC616-MEqNC12sBsHxa7XIdbXXog@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: dongili-vcC760zL2fQ1GQ1Ptb7lUw@public.gmane.org
Cc: ACPI Devel Mailing List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Maw, 2003-07-15 at 12:49, Mattia Dongili wrote:
> >  pci_irq-0294 [23] acpi_pci_irq_derive   : Unable to derive IRQ for device 0000:00:1f.1
> > ACPI: No IRQ known for interrupt pin A of device 0000:00:1f.1 - using IRQ 255
> > 
> > 0000:00:1f.1 is:
> > 
> > 00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
> 
> Well, somebody correct me if I'm wrong: this simply means that your ide
> (as mine :) isn't listed within the _PRT methods of your DSDT and the acpi
> subsystem falls back to a default irq routing.

Legacy mode IDE devices do not use the PCI interrupts. 2.4.x knows that
it could be that the fix is missing from 2.5/2.6test



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
