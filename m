From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: ACPI PCI routing problem
Date: Fri, 11 Jul 2003 17:29:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307111729.27552.adq_dvb@lidskialf.net>
References: <200307110022.29512.adq_dvb@lidskialf.net> <200307111243.34695.adq_dvb@lidskialf.net> <1057932596.20629.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1057932596.20629.0.camel-2MMpYkNvuYAXoXS6vNje7nviChZXdy279dF7HbQ/qKg@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Friday 11 July 2003 15:09, Alan Cox wrote:
> On Gwe, 2003-07-11 at 12:43, Andrew de Quincey wrote:
> > > How look /proc/interrupts with IO-APIC, but without ACPI (I mean, no
> > > acpi at all at compile time)?
> >
> > Hi, here you go. ACPI disabled, but APIC/IO-APIC left in. Interesting,
> > everything is set to XT-PIC....
> >
> > During boot it says: Found and enabled local APIC!
> > But does not have any mention of the IO-APIC.
>
> local apic and i/o apic are seperate devices. A system can have one
> (on the CPU) but not the other

Yep. My system does have an IO APIC however. It doesn't find it when I disable 
ACPI. I assume this is the expected behaviour, since otherwise you'd have to 
scan in the area of memory they're mapped to.



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
