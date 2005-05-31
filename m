From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Fw: [Bugme-new] [Bug 4496] New: Interrupt-problem depends on sound-playing: irq 10: nobody cared!
Date: Tue, 31 May 2005 13:51:45 -0600
Message-ID: <200505311351.45705.bjorn.helgaas@hp.com>
References: <20050525224328.734adc03.akpm@osdl.org> <200505310957.28789.bjorn.helgaas@hp.com> <1117564793.4816.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1117564793.4816.11.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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
To: Hannes Diethelm <hannes-diethelm-goEDY2E6dbVyDzI6CaY1VQ@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 31 May 2005 12:39 pm, Hannes Diethelm wrote:
> irq 20: nobody cared (try booting with the "irqpoll" option.
>  [<c014117a>] __report_bad_irq+0x2a/0xa0
>  [<c01409a0>] handle_IRQ_event+0x30/0x70
>  [<c0141290>] note_interrupt+0x80/0xf0
>  [<c0140b1c>] __do_IRQ+0x13c/0x140
>  [<c0105969>] do_IRQ+0x19/0x30
>  [<c0103b62>] common_interrupt+0x1a/0x20
>  [<c0100d70>] default_idle+0x0/0x30
>  [<c0100d93>] default_idle+0x23/0x30
>  [<c0100e60>] cpu_idle+0x80/0x90
>  [<c05189dd>] start_kernel+0x18d/0x1d0
>  [<c05183c0>] unknown_bootoption+0x0/0x1e0
> handlers:
> [<e0c56e20>] (radeon_driver_irq_handler+0x0/0xc0 [radeon])
> Disabling IRQ #20

I don't see anything obviously wrong in the information you sent.
The radeon seems to be the only thing on IRQ 20, we seem to be
getting a stream of interrupts there, but the radeon claims not
to be generating them.

But everything worked with the debian 2.6.8 kernel.  Can you look
at the logs there and see what changed?

> Unable to handle kernel paging request at virtual address b588e060
>  printing eip:
> c03354d7
> *pde = 0b06a067
> *pte = 00000000
> Oops: 0000 [#1]
> PREEMPT SMP
> Modules linked in: radeon drm
> CPU:    0
> EIP:    0060:[<c03354d7>]    Not tainted VLI
> EFLAGS: 00210282   (2.6.12-rc5-mm1)
> EIP is at snd_pcm_mmap_data_close+0x7/0x12
> eax: b588e000   ebx: c03354d0   ecx: cd879e00   edx: cc2d9250
> esi: df452ce8   edi: cd879e00   ebp: cd4d7908   esp: cb06ff40
> ds: 007b   es: 007b   ss: 0068
> Process xmms (pid: 4784, threadinfo=cb06e000 task=cb61c030)
> Stack: c01542b6 cd4d7908 cd4d7930 df452cbc 00000000 ded76040 cd4d7908
> ded76040
>        c0155c2f cd4d7908 cd4d7908 b588e000 b587e000 c015604b ded76040
> cd4d7908
>        cd4d71d0 b587e000 b588e000 cd4d71d0 ded76040 ded76070 00000002
> cb06e000
> Call Trace:
>  [<c01542b6>] remove_vm_struct+0x96/0xa0
>  [<c0155c2f>] unmap_vma_list+0x1f/0x30
>  [<c015604b>] do_munmap+0x11b/0x150
>  [<c01560c5>] sys_munmap+0x45/0x70
>  [<c01031a5>] syscall_call+0x7/0xb
> Code: 00 00 00 00 8b 44 24 04 8b 40 50 8b 40 60 f0 ff 80 a4 00 00 00 c3
> 8d b4 26  00 00 00 00 8d bc 27 00 00 00 00 8b 44 24 04 8b 40 50 <8b> 40
> 60 f0 ff 88 a4 00  00 00 c3 51 52 e8 37 b8 0b 00 5a 59 e9

This looks like http://bugzilla.kernel.org/show_bug.cgi?id=4662, which,
if I read the bugzilla correctly should be fixed by reverting this
patch:

    http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm1/broken-out/avoiding-mmap-fragmentation-fix-2.patch

Can you try reverting that (apply it with "patch -p1 -R").


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
