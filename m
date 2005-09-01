From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: [Bugme-new] [Bug 5171] New: Linux-2.6.13 crash on boot
Date: Thu, 1 Sep 2005 12:50:00 -0700
Message-ID: <20050901125000.24ef6bcc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org


A regression..


Begin forwarded message:

Date: Thu, 1 Sep 2005 10:39:00 -0700
From: bugme-daemon-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
To: bugme-new-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Subject: [Bugme-new] [Bug 5171] New: Linux-2.6.13 crash on boot


http://bugzilla.kernel.org/show_bug.cgi?id=5171

           Summary: Linux-2.6.13 crash on boot
    Kernel Version: 2.6.13-rc7 and later
            Status: NEW
          Severity: high
             Owner: acpi_other-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
         Submitter: masouds-VSK0CvVmMoVQFI55V6+gNQ@public.gmane.org
                CC: masouds-VSK0CvVmMoVQFI55V6+gNQ@public.gmane.org


Most recent kernel where this bug did not occur: 2.6.13-rc6
Distribution: Unbutnu 5.04
Hardware Environment: 2x866 MHz machine with MSI-694D board (via chipset), 768
Megs of RAM, a 160Gig IDE hdd, VIA-Rhine nic, SymBIOS scsi card, 3dfx voodoo
graphics adapter
Software Environment: gcc version 3.3.5, nothing else running at the time of crash
Problem Description/Steps to reproduce:
Configure the kernel on the same hardware with the attached config and set it to
boot. It crashes with the attached capture file (through serial interface)
only SMP kernel crashes. UP boots fine.
Some chasing in the source showed that it is the call to non-set pm_idle_save()
function that fails. It probably has something to do with the machine being an SMP.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
