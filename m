From: Romano Giannetti <romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org>
Subject: Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel
Date: Fri, 3 Jun 2005 17:45:12 +0200
Message-ID: <20050603154512.GA25974@pern.dea.icai.upco.es>
References: <20050329110309.GA17744@pern.dea.icai.upco.es> <20050525212520.419ee442.akpm@osdl.org> <20050603094448.GA3218@pern.dea.icai.upco.es> <20050603105010.GA7300@pern.dea.icai.upco.es> <20050603152540.GF3867@elf.ucw.cz>
Reply-To: romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050603152540.GF3867-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 03, 2005 at 05:25:40PM +0200, Pavel Machek wrote:
> Hi!
>
> Segfault of bash is expected when preempt counts go wrong. Could you
> look at scheduling while atomic tracebacks, and just fix whatever
> driver causes them? I do preempt swsusp here, and it works okay...
> 								Pavel

I will try to understand from where they come through the weekend. The
problem is that they are zillions... and I am not so expert. For example,
the first one look like this (this is from -rc2): 

Scheduling while atomic: really_suspend/0x00000001/5478
[schedule+1384/1568] schedule+0x568/0x620
[<c03a6af8>] schedule+0x568/0x620
[__mod_timer+453/496] __mod_timer+0x1c5/0x1f0
[<c0122245>] __mod_timer+0x1c5/0x1f0
[schedule_timeout+93/176] schedule_timeout+0x5d/0xb0
[<c03a75bd>] schedule_timeout+0x5d/0xb0
[process_timeout+0/16] process_timeout+0x0/0x10
[<c0122ce0>] process_timeout+0x0/0x10
[msleep+47/64] msleep+0x2f/0x40
[<c01230cf>] msleep+0x2f/0x40
[pci_set_power_state+400/464] pci_set_power_state+0x190/0x1d0
[<c0252be0>] pci_set_power_state+0x190/0x1d0
[pci_enable_device_bars+24/64] pci_enable_device_bars+0x18/0x40
[<c0252d28>] pci_enable_device_bars+0x18/0x40
[pci_enable_device+31/64] pci_enable_device+0x1f/0x40
[<c0252d6f>] pci_enable_device+0x1f/0x40
[pg0+276592203/1068393472] snd_via82xx_resume+0x1b/0x140 [snd_via82xx]
[<d0cdf64b>] snd_via82xx_resume+0x1b/0x140 [snd_via82xx]
[pg0+276450129/1068393472] snd_card_pci_resume+0x41/0x6e [snd]
[<d0cbcb51>] snd_card_pci_resume+0x41/0x6e [snd]
[pci_device_resume+44/64] pci_device_resume+0x2c/0x40
[<c025500c>] pci_device_resume+0x2c/0x40
[dpm_resume+168/176] dpm_resume+0xa8/0xb0
[<c02d6678>] dpm_resume+0xa8/0xb0
[device_resume+17/32] device_resume+0x11/0x20
[<c02d6691>] device_resume+0x11/0x20
[<c02d6691>] device_resume+0x11/0x20
[finish+8/64] finish+0x8/0x40
[<c0139f18>] finish+0x8/0x40
[pm_suspend_disk+148/192] pm_suspend_disk+0x94/0xc0
[<c013a0b4>] pm_suspend_disk+0x94/0xc0
[enter_state+134/144] enter_state+0x86/0x90
[<c0137a76>] enter_state+0x86/0x90
[software_suspend+15/32] software_suspend+0xf/0x20
[<c0137a8f>] software_suspend+0xf/0x20
[acpi_system_write_sleep+106/132] acpi_system_write_sleep+0x6a/0x84
[<c02927ea>] acpi_system_write_sleep+0x6a/0x84
[vfs_write+332/352] vfs_write+0x14c/0x160
[<c015c56c>] vfs_write+0x14c/0x160
[sys_write+81/128] sys_write+0x51/0x80
[<c015c651>] sys_write+0x51/0x80
[sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
[<c010335b>] sysenter_past_esp+0x54/0x75

How could I read it? I suspect acpi (there is that strange ACPI keys and
battery change of behaviour between preempt ands no preempt), but I cannot
boot without acpi, this laptop _need_ acpi (otherwise, no sound, problem
with pcmcia, and counting...) 

Thanks for any suggestion! 

       Romano

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
