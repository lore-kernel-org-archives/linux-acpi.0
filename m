From: Ole Rohne <ole.rohne-vJEk5272eHo@public.gmane.org>
Subject: Fujitsu P2120 S3 resume - no video, lost PCI config, suggestions?
Date: 04 Mar 2003 20:35:46 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <ebw3cm26i25.fsf_-_@lxplus004.cern.ch>
References: <20030304173547.7a815082.nils@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030304173547.7a815082.nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In my quest to make S3 working on this platform, I've found the
underlying reason why the display is black after a S3: the vga adapter
(ATI Radeon M6 LY) looses its pci configuration and comes back with io
and memory disabled, and BASE_ADDRESS_n, LATENCY_TIMER,
CACHE_LINE_SIZE, and INTERRUPT_LINE containing garbage. At first I
felt let down by the BIOS, but on reading the ACPI spec it seems that
it is up to the OS to enumerate and configure devices on "known" buses.

So far I've tried calling pci_save_state/pci_restore_state from within
the radeonfb pci driver suspend/resume routines. Unfortunately, that
causes the machine to hang, probably just after PCI_COMMAND has been
updated. Alternatively, I've tried rewriting the PCI configuration
from userspace (setpci), which doesn't always hang but now the thing
claims there is nothing connected when I eg reload radeonfb.

Questions:
Is it really the job of the OS to configure PCI devices after a S3 sleep?

What is the reason for the hanging when I try to restore PCI config?

Is it possible that PCI "enumeration" and configuration needs to be
done early, like in real mode or before irqs are enabled?

	Appreciating your suggestions,
        Ole


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
