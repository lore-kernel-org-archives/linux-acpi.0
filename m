From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: [Bug 4416] New: Box hangs solid during swsusp resume
Date: Tue, 29 Mar 2005 02:20:02 -0800
Message-ID: <20050329022002.6b3abd0f.akpm@osdl.org>
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
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Could someone please take a look?


Begin forwarded message:

Date: Tue, 29 Mar 2005 02:17:54 -0800
From: bugme-daemon-3NddpPZAyC0@public.gmane.org
To: akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org
Subject: [Bug 4416] New: Box hangs solid during swsusp resume


http://bugme.osdl.org/show_bug.cgi?id=4416

           Summary: Box hangs solid during swsusp resume
    Kernel Version: 2.6.12-rc1-mm[1-3]
            Status: NEW
          Severity: high
             Owner: akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org
         Submitter: rjwysocki-KKrjLPT3xs0@public.gmane.org


Distribution: SUSE 9.2 x86-64 
 
Hardware Environment: Asus L5D 
 
Problem Description: The box hangs solid while resuming from disk, after the 
system image has been restored.  Apparently, the hang occurs as a result of the 
call to pci_write_config_word() with pmcsr = 0 in 
drivers/pci/pci.c:pci_set_power_state().  In fact, the function 
pci_write_config_word() completes successfully but the box hangs during 
msleep() afterwards.  It cartainly is related to the fact that ACPI PCI links 
are not set before pci_set_power_state() is called. 
 
Steps to reproduce: Suspend the box to disk and try to resume it.  The problem 
is 100% reproducible. 
 
Greets, 
Rafael

------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
