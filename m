From: Alan Cox <alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: mpparse.c APIC/ACPI support
Date: Tue, 4 Mar 2003 16:24:14 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303042124.h24LOE916749@devserv.devel.redhat.com>
References: <000001c2e27f$74ae2910$0200a8c0@brutzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <000001c2e27f$74ae2910$0200a8c0-IGm5bqYn3xw@public.gmane.org> from "DPR" at Mar 04, 2003 07:54:10 PM
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org
Cc: 'Grover Andrew' <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "\"'Cagle, John (ISS-Houston)'\"" <john.cagle-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> <4>PCI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
> <4>PCI: No IRQ known for interrupt pin A of device 00:12.0
> 
> The devices 00:10.0 up to 00:10.3 are my USB 1.1/2.0 controllers, device 00:11.1 is my EIDE
> controller and device 00:12.0 is my ethernet adapter.

There is deep magic to beware of in the IDE case. I recently fixed this
for 2.4 (and sent Linus a patch for 2.5). If the IDE controller channels
are in legacy mode then the IRQ is 14/15 and ISA style. In that case we
shouldn't be looking up the IRQ line in the ACPI and PC BIOS cases at least.

For some non PC platforms it may be more complex


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
