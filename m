From: Michael Madore <mmadore-JChM1cqIHx8AvxtiuMwx3w@public.gmane.org>
Subject: Error reading AC Adapter state
Date: Fri, 28 Mar 2003 10:53:10 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E849A16.5060809@aslab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

I've built kernel 2.4.21-pre5 with the latest ACPI patch.  Everything 
seems to work correctly with the exception of /proc/acpi/ac_adapter. 
 The following debug messages were generated during boot:

Mar 28 05:30:30 asl226 kernel:      osl-0888 [21] os_wait_semaphore     
: Failed to acquire semaphore[c130d4c0|1|0], AE_TIME
Mar 28 05:30:30 asl226 kernel:   utmisc-0743 [20] ut_acquire_mutex      
: Thread 0 could not acquire Mutex [ACPI_MTX_Events] AE_TIME
Mar 28 05:30:30 asl226 kernel:  exfldio-0140 [38] ex_setup_region       
: Field [ACPW] Base+Offset+Width 38+0+4 is beyond end of region [GPIO] 
(length 3B)
Mar 28 05:30:30 asl226 kernel:  psparse-1121: *** Error: Method 
execution failed [\_SB_.PCI0.LPCB.ACAD._PSR] (Node c1334328), 
AE_AML_REGION_LIMIT
Mar 28 05:30:30 asl226 kernel:  acpi_ac-0083 [22] acpi_ac_get_state     
: Error reading AC Adapter state
Mar 28 05:30:30 asl226 kernel: ACPI: Battery Slot [BAT1] (battery present)
Mar 28 05:30:30 asl226 kernel: ACPI: Power Button (FF) [PWRF]
Mar 28 05:30:30 asl226 kernel: ACPI: Lid Switch [LID]
Mar 28 05:30:30 asl226 kernel: ACPI: Sleep Button (CM) [SLPB]
Mar 28 05:30:30 asl226 kernel: ACPI: Processor [CPU0] (supports C1 C2, 2 
performance states, 8 throttling states)
Mar 28 05:30:30 asl226 kernel:      osl-0888 [23] os_wait_semaphore     
: Failed to acquire semaphore[c130d4c0|1|0], AE_TIME
Mar 28 05:30:30 asl226 kernel:   utmisc-0743 [22] ut_acquire_mutex      
: Thread 0 could not acquire Mutex [ACPI_MTX_Events] AE_TIME

Mike Madore



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
