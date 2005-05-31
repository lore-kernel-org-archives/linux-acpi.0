From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Fw: [Bugme-new] [Bug 4496] New: Interrupt-problem depends on sound-playing: irq 10: nobody cared!
Date: Tue, 31 May 2005 12:49:07 -0600
Message-ID: <200505311249.07949.bjorn.helgaas@hp.com>
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
> I've patched the mm1-kernel with the patch below only.
> The Problem now is anymore a little diferent. I can play sound whit 
> cat soundfile > /dev/dsp. But after a few seconds there is this message
> in dmesg:
> 
> irq 20: nobody cared (try booting with the "irqpoll" option.

Can you please collect the complete dmesg log and contents of
/proc/interrupts?

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
> 
> When i start Sound whith xmms (alsa) i can hear sound. But when i stop
> xmms, there apears a new message in dmesg:
> 
> Unable to handle kernel paging request at virtual address b588e060

Hmmm...  I dunno about this one.

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
> 
> Then xmms freazes and i wasn't able to reboot or to kill xmms.
> 
> Should i try the other patches?
> 
> Hannes
> 
> > 
> > --- 2.6.12-rc5-mm1/drivers/pci/quirks.c.orig	2005-05-31 09:42:17.000000000 -0600
> > +++ 2.6.12-rc5-mm1/drivers/pci/quirks.c	2005-05-31 09:44:07.000000000 -0600
> > @@ -499,28 +499,20 @@
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi );
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi );
> >  
> > -static void __devinit quirk_via_irqpic(struct pci_dev *dev)
> > +static void quirk_via_irq(struct pci_dev *dev)
> >  {
> >  	u8 irq, new_irq;
> >  
> > -#ifdef CONFIG_X86_IO_APIC
> > -	if (nr_ioapics && !skip_ioapic_setup)
> > -		return;
> > -#endif
> > -#ifdef CONFIG_ACPI
> > -	if (acpi_irq_model != ACPI_IRQ_MODEL_PIC)
> > -		return;
> > -#endif
> >  	new_irq = dev->irq & 0xf;
> >  	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
> >  	if (new_irq != irq) {
> > -		printk(KERN_INFO "PCI: Via PIC IRQ fixup for %s, from %d to %d\n",
> > +		printk(KERN_INFO "PCI: Via IRQ fixup for %s, from %d to %d\n",
> >  			pci_name(dev), irq, new_irq);
> >  		udelay(15);	/* unknown if delay really needed */
> >  		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
> >  	}
> >  }
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irqpic);
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
> >  
> >  /*
> >   * PIIX3 USB: We have to disable USB interrupts that are
> > 
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
