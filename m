From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: [Bugme-new] [Bug 4710] New: Dual core processor doesn't get
 identified
Date: Fri, 17 Jun 2005 00:39:09 -0700
Message-ID: <20050617003909.469dc1b8.akpm@osdl.org>
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



Begin forwarded message:

Date: Sat, 4 Jun 2005 12:34:04 -0700
From: bugme-daemon-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
To: bugme-new-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Subject: [Bugme-new] [Bug 4710] New: Dual core processor doesn't get identified


http://bugzilla.kernel.org/show_bug.cgi?id=4710

           Summary: Dual core processor doesn't get identified
    Kernel Version: 2.6.12-rc5
            Status: NEW
          Severity: normal
             Owner: ak-l3A5Bk7waGM@public.gmane.org
         Submitter: bakhos-yo6/AMyCM4KVc3sceRu5cw@public.gmane.org


Distribution: Gentoo Linux  
Hardware Environment: Tyan S2895 motherboard + 2x Opteron 270 processors 
Software Environment: mostly kept with latest stable amd64 release, kernel is 
vanilla-sources 2.6.12-rc5 (no gentoo patches) 
Problem Description: 
The processors do not get properly detected. The first cpu, first core get a 
look up error in namespace, while the other just say that the model is 
unknown. But the system still boot, and work (I do have some unexplained 
segmentation fault in basic programs (sed, rm, cat, which, patch...) that I 
have to investigate). 
I'll attach the output of: dmesg and /proc/cpuinfo 
Here is a few of the lines from dmesg: 
CPU 0(2) -> Node 0 -> Core 0 
    ACPI-0198: *** Error: Looking up [\_PR_.CPU2] in namespace, AE_NOT_FOUND 
CPU 1(2) -> Node 0 -> Core 1 
AMD Athlon(tm) or Opteron(tm) CPU-model unknown stepping 02 
CPU 2(2) -> Node 0 -> Core 0 
AMD Athlon(tm) or Opteron(tm) CPU-model unknown stepping 02 
CPU 3(2) -> Node 0 -> Core 1 
AMD Athlon(tm) or Opteron(tm) CPU-model unknown stepping 02 
 
The ACPI is also having a few problems: 
ACPI: Subsystem revision 20050309 
    ACPI-0352: *** Error: Looking up [\_SB_.PCI1.LNK3] in namespace, 
AE_NOT_FOUND 
search_node ffff810003280dc0 start_node ffff810003280dc0 return_node 
0000000000000000 
    ACPI-0352: *** Error: Looking up [\_SB_.PCI1.LNK4] in namespace, 
AE_NOT_FOUND 
search_node ffff810003280ac0 start_node ffff810003280ac0 return_node 
0000000000000000 
    ACPI-0352: *** Error: Looking up [\_SB_.PCI1.LNK1] in namespace, 
AE_NOT_FOUND 
search_node ffff8100032807c0 start_node ffff8100032807c0 return_node 
0000000000000000 
    ACPI-0352: *** Error: Looking up [\_SB_.PCI1.LNK2] in namespace, 
AE_NOT_FOUND 
search_node ffff8100032804c0 start_node ffff8100032804c0 return_node 
0000000000000000 
 
Steps to reproduce: Boot the kernel 
 
It should be noted that even the BIOS does not properly detect the CPU (it 
state a stepping of E4). I have sent an e-mail to the tech support at Tyan 
about this, but I am waiting a reply. I don't think there's any other BIOS 
available, since the motherboard is not listed on the BIOS update page.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
