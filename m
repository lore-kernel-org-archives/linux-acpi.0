From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: acpi-20040715+D600+Suspend
Date: Tue, 31 Aug 2004 22:25:50 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4135332E.2040003@optonline.net>
References: <B44D37711ED29844BEA67908EAF36F03B0D6DE@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <B44D37711ED29844BEA67908EAF36F03B0D6DE-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Oops, that's my bad. Thanks for the quick explanation, Shaohua, looks 
like we have to move the resume to a special case that runs before 
sysdevs. If that's ok with everyone, I'll try to make a patch.

Nathan

Li, Shaohua wrote:

>Thanks you report this. Looks like the Link device resume issue. Link
>device is a sysdev, so its resume is in irq disabled. But ACPI method
>executed by Link device resume can't be in irq disabled. Most code in
>ACPI CA is designed to execute not in IRQ disabled. Looks like we
>ignored this.
>
>Thanks,
>Shaohua
>
>  
>
>>-----Original Message-----
>>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Ow Mun Heng
>>Sent: Wednesday, September 01, 2004 9:17 AM
>>To: Acpi-List
>>Subject: [ACPI] acpi-20040715+D600+Suspend
>>
>>Hi guys,
>>
>>	Lo and Behold, I managed to get S3 to work on my laptop by
>>    
>>
>following
>  
>
>>instructions on this website.
>>
>>http://www.loria.fr/~thome/d600/
>>
>>However, I've not tested it further(as in using the normal kernel boot
>>up line in grub.conf) to verify if it is the same whether or not I use
>>video=radeonfb.
>>
>>I'm getting these errors during Suspend to disk.
>>
>>Warning: CPU frequency out of sync: cpufreq and timingcore thinks of
>>    
>>
>600000,
>  
>
>>is 1400000 kHz.
>>Debug: sleeping function called from invalid context at mm/slab.c:1989
>>in_atomic():1, irqs_disabled():0
>>[<c01156ac>] __might_sleep+0xa5/0xaf
>>[<c0135d3f>] __kmalloc+0x40/0x76
>>[<c023bec9>] acpi_os_allocate+0xa/0xb
>>[<c024fa1f>] acpi_ut_allocate+0x34/0x57
>>[<c024f9b0>] acpi_ut_initialize_buffer+0x42/0x7d
>>[<c024c85e>] acpi_rs_create_byte_stream+0x23/0x39
>>[<c024dc1e>] acpi_rs_set_srs_method_data+0x1b/0x9d
>>[<c011ecd4>] __group_send_sig_info+0x36/0x9d
>>[<c011ee0a>] group_send_sig_info+0x58/0x61
>>[<c02556fd>] acpi_pci_link_set+0xde/0x155
>>[<c0255b0f>] irqrouter_resume+0x1c/0x30
>>[<c027bfff>] sysdev_resume+0x3e/0xc7
>>[<c027ea69>] device_power_up+0x5/0xa
>>[<c012b332>] do_magic_resume_2+0x63/0xb9
>>[<c02db0d9>] copy_done+0x49/0x4c
>>[<c012b536>] software_suspend+0x98/0xae
>>[<c0252322>] acpi_system_write_sleep+0x6a/0x85
>>[<c014650c>] vfs_write+0xb8/0xe4
>>[<c01465d6>] sys_write+0x3c/0x62
>>[<c01059fd>] sysenter_past_esp+0x52/0x71
>>ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
>>PCI: Setting latency timer of device 0000:00:1d.0 to 64
>>ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
>>PCI: Setting latency timer of device 0000:00:1d.1 to 64
>>ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
>>PCI: Setting latency timer of device 0000:00:1d.2 to 64
>>ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
>>PCI: Setting latency timer of device 0000:00:1d.7 to 64
>>ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
>>ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 7 (level, low) -> IRQ 7
>>PCI: Setting latency timer of device 0000:00:1f.5 to 64
>>radeonfb: resumed !
>>ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
>>Fixing swap signatures... ok
>>
>>
>>I also noticed that now, suspend does not work as it should/or was when
>>I was using 2.6.7 kernel.
>>
>>Right now, it will go to the Freeing memory section.. then the screen
>>goes blank. (blacklight still on) and then stays that way for quite
>>sometime before I see the words "radeonfb: resumed" and when that
>>happens, it's as though time stood still. It won't start writing to the
>>disk until I press a key. (I usually just press the spacebar) and then
>>it will start writing and works OK from that. (I am writing on my
>>    
>>
>laptop
>  
>
>>which is been suspended(hibernated) and resumed a few times already.
>>
>>Anything changed or broke??
>>
>>--
>>Ow Mun Heng
>>Fedora GNU/Linux Core 2 on D600 1.4Ghz CPU kernel 2.6.8.1.Aug.29
>>Neuromancer 01:06:38 up 1 day, 3:25, 1 user, load average: 0.73, 0.88,
>>0.93
>>
>>
>>-------------------------------------------------------
>>This SF.Net email is sponsored by BEA Weblogic Workshop
>>FREE Java Enterprise J2EE developer tools!
>>Get your free copy of BEA WebLogic Workshop 8.1 today.
>>http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
>>_______________________________________________
>>Acpi-devel mailing list
>>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>    
>>
>
>  
>




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
