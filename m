From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: [SoftwareSuspend-devel] sleeping functions called from an invalid context
Date: Tue, 23 Nov 2004 09:35:09 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057599927C@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, Borislav Petkov <petkov-xhPu7QH+N+StU9/U+hoEgQ@public.gmane.org>
Cc: SoftwareSuspend Development <softwaresuspend-devel-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Yes, there is a patch under discussion in
http://bugme.osdl.org/show_bug.cgi?id=3D3469

Thanks,
Shaohua

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Nigel Cunningham
>Sent: Tuesday, November 23, 2004 5:30 AM
>To: Borislav Petkov
>Cc: SoftwareSuspend Development; ACPI List
>Subject: [ACPI] Re: [SoftwareSuspend-devel] sleeping functions called
from
>an invalid context
>
>Hi.
>
>Okay. The first is my fault, the second is ACPI related and I'll
>therefore copy my reply to the ACPI list.
>
>Regards,
>
>Nigel
>
>On Mon, 2004-11-22 at 19:03, Borislav Petkov wrote:
>> Hi there list,
>>
>> here's what i get in the dmesg when i resume my priorly suspended
machine:
>>
>> Looking for first block of swap header at block 0.
>> Setting logical block size of resume device to 4096.
>> Software Suspend 2.1.5: Swap space signature found.
>> Software Suspend 2.1.5: Suspending enabled.
>> Software Suspend 2.1.5: Initiating a software suspend cycle.
>> Debug: sleeping function called from invalid context at
>> include/asm/semaphore.h:130
>> in_atomic():1, irqs_disabled():1
>>  [<c010632e>] dump_stack+0x1e/0x30
>>  [<c011d3a7>] __might_sleep+0xb7/0xe0
>>  [<c025dc00>] tty_write+0xe0/0x550
>>  [<c018e3cf>] vfs_write+0xcf/0x140
>>  [<c018e50b>] sys_write+0x4b/0x80
>>  [<c0156a04>] move_cursor_to+0x64/0x80
>>  [<c0156bf7>] text_prepare_status+0xa7/0x3d0
>>  [<c0155ea3>] prepare_status+0x103/0x140
>>  [<c015c996>] suspend_calculate_checksums+0x36/0xc0
>>  [<c01531b3>] save_image_part1+0x1a3/0x1c0
>>  [<c015359c>] do_suspend2_suspend_2+0xc/0x90
>>  [<c031d2a7>] do_suspend2_lowlevel+0xcc/0x665
>>  [<c0152f5e>] save_image+0x10e/0x1c0
>>  [<c01546a3>] do_activate+0x613/0x7c0
>>  [<c014a18b>] suspend_try_suspend+0x3b/0x40
>>  [<c014a208>] proc_try_suspend+0x8/0x10
>>  [<c01d9bc7>] proc_file_write+0x37/0x50
>>  [<c018e3cf>] vfs_write+0xcf/0x140
>>  [<c018e50b>] sys_write+0x4b/0x80
>>  [<c0105beb>] syscall_call+0x7/0xb
>> Warning: CPU frequency is 1500000, cpufreq assumed 600000 kHz.
>> Debug: sleeping function called from invalid context at
mm/slab.c:2059
>> in_atomic():0, irqs_disabled():1
>>  [<c010632e>] dump_stack+0x1e/0x30
>>  [<c011d3a7>] __might_sleep+0xb7/0xe0
>>  [<c016df6b>] __kmalloc+0xcb/0xe0
>>  [<c02368be>] acpi_os_allocate+0x10/0x14
>>  [<c024afe1>] acpi_ut_allocate+0x35/0x59
>>  [<c024af67>] acpi_ut_initialize_buffer+0x45/0x8a
>>  [<c0247cc8>] acpi_rs_create_byte_stream+0x2c/0x48
>>  [<c02490ab>] acpi_rs_set_srs_method_data+0x1d/0xa2
>>  [<c0252298>] acpi_pci_link_set+0x102/0x17a
>>  [<c0252636>] acpi_pci_link_resume+0x1e/0x24
>>  [<c025265a>] irqrouter_resume+0x1e/0x36
>>  [<c0285683>] sysdev_resume+0x103/0x108
>>  [<c015283e>] suspend_drivers_resume+0xce/0x110
>>  [<c01534b8>] do_suspend2_resume_2+0x38/0xd0
>>  [<c031d830>] do_suspend2_lowlevel+0x655/0x665
>>  [<c0152f5e>] save_image+0x10e/0x1c0
>>  [<c01546a3>] do_activate+0x613/0x7c0
>>  [<c014a18b>] suspend_try_suspend+0x3b/0x40
>>  [<c014a208>] proc_try_suspend+0x8/0x10
>>  [<c01d9bc7>] proc_file_write+0x37/0x50
>>  [<c018e3cf>] vfs_write+0xcf/0x140
>>  [<c018e50b>] sys_write+0x4b/0x80
>>  [<c0105beb>] syscall_call+0x7/0xb
>>
>> The same two stack traces repeat at every resume cycle.
>>
>> [root@gollum:08:59:26:gollum:1307)->  cat
>/proc/software_suspend/debug_info
>> Please include the following information in bug reports:
>> - SUSPEND core   : 2.1.5
>> - Kernel Version : 2.6.9
>> - Compiler vers. : 3.3
>> - Modules loaded : psmouse ppp_deflate zlib_deflate zlib_inflate
evdev
>usbhid
>> bsd_comp ppp_generic slhc asus_acpi uhci_hcd ehci_hcd tg3 fan
>> - Attempt number : 3
>> - Parameters     : 0 2048 0 1 0 8192 5
>> - Limits         : 130880 pages RAM. Initial boot: 127304.
>> - Overall expected compression percentage: 0.
>> - LZF Compressor enabled.
>>   Compressed 443838464 bytes into 155752027 (64 percent compression).
>> - Swapwriter active.
>>   Swap available for image: 244011 pages.
>> - Debugging compiled in.
>> - Preemptive kernel.
>> - I/O speed: Write 31 MB/s, Read 39 MB/s.
>>
>> The machine still functions OK after resuming although the usbhid
fails
>> sometimes and the mouse is dead. When I unplug and plug it in again,
it
>is
>> back and functioning.
>>
>> Regards,
>> Boris.
>
>--
>Nigel Cunningham
>Pastoral Worker
>Christian Reformed Church of Tuggeranong
>PO Box 1004, Tuggeranong, ACT 2901
>
>You see, at just the right time, when we were still powerless, Christ
>died for the ungodly.		-- Romans 5:6
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real
users.
>Discover which products truly live up to the hype. Start reading now.
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
