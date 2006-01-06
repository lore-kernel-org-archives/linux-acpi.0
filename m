From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: Re. 2.6.15-mm1
Date: Thu, 5 Jan 2006 16:21:51 -0800
Message-ID: <20060105162151.6fc1716f.akpm@osdl.org>
References: <200601051801.29007@zodiac.zodiac.dnsalias.org>
	<20060105144720.25085afa.akpm@osdl.org>
	<200601060033.34276@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200601060033.34276-qgpBcDF1kIxsXm07kNcISIFwBlHcXKVlHZ5vskTnxNA@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Gran <alex-4mRm4CWMOdkHuPwBo6/EyUB+6BGkLq7r@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org, reiserfs-dev-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, vs-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org, Dave Jones <davej-rdkfGonbjUTCLXcRTR1eJlpr/1R2p/CL@public.gmane.org>, "Seth, Rohit" <rohit.seth-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Alexander Gran <alex-4mRm4CWMOdkHuPwBo6/EyUB+6BGkLq7r@public.gmane.org> wrote:
>
> Am Donnerstag, 5. Januar 2006 23:47 schrieb Andrew Morton:
> > > Jan  5 16:22:47 t40 kernel: mtrr: 0xe0000000,0x8000000 overlaps existing
> > > 0xe0000000,0x4000000
> > > Jan  5 16:22:48 t40 last message repeated 2 times
> >
> > Is that new?
> 
> Umm, no. I just thought it could be related to the X oops.

OK.  I don't know how common this is, nor whether it'll cause problems. 
David(s), do you know?

> > hm, it's not clear what oopsed.   Can you get a cleaner copy of this?
> 
> Hmm. I just rebooted to 2.6.15-mm1 runlevel one, fired up network and an sshd. 
> So I could ssh back to the oops machine. Well. X is clearer but even more 
> errors are in the logs now ;).
> First the X oops:
> EDAC PCI- Detected Parity Error on 0000:00:1e.0
> mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x4000000
> mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x4000000
> mtrr: 0xe0000000,0x8000000 overlaps existing 0xe0000000,0x4000000
> agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
> Unable to handle kernel NULL pointer dereference at virtual address 00000020
>  printing eip:
> c028b7cf
> *pde = 372d4067
> *pte = 00000000
> Oops: 0000 [#1]
> PREEMPT
> last sysfs file: /block/hda/queue/scheduler
> Modules linked in: aes_i586 cfq_iosched ehci_hcd uhci_hcd
> CPU:    0
> EIP:    0060:[<c028b7cf>]    Not tainted VLI
> EFLAGS: 00013202   (2.6.15-mm1)
> EIP is at agp_collect_device_status+0x14/0xd4
> eax: 00000058   ebx: f75c1f08   ecx: 00000000   edx: 00000058
> esi: 1f000207   edi: c19a80c0   ebp: c19af428   esp: f75c1ed0
> ds: 007b   es: 007b   ss: 0068
> Process Xorg (pid: 3843, threadinfo=f75c0000 task=f7890550)
> Stack: <0>00003246 1f000217 1f000207 1f000217 f75c1f08 1f000207 c19a80c0 
> c19af428
>        <0>c028b9e9 f75c1f08 00000002 00000000 c19720ec 00000000 1f000217 
> c19af400
>        <0>00000032 00000001 c028bfb5 c0297262 c19af400 c02972af 1f000207 
> c029727f
> Call Trace:
>  [<c028b9e9>] agp_generic_enable+0x72/0x10f
>  [<c028bfb5>] agp_enable+0xa/0xb
>  [<c0297262>] drm_agp_enable+0x2c/0x49
>  [<c02972af>] drm_agp_enable_ioctl+0x30/0x39
>  [<c029727f>] drm_agp_enable_ioctl+0x0/0x39
>  [<c029311d>] drm_ioctl+0x93/0x1e4
>  [<c0163664>] do_ioctl+0x64/0x6d
>  [<c01637a9>] vfs_ioctl+0x50/0x1be
>  [<c01ae603>] write_unix_file+0x0/0x500
>  [<c016394b>] sys_ioctl+0x34/0x51
>  [<c0102d0f>] sysenter_past_esp+0x54/0x75
> Code: 02 00 00 00 e8 94 66 f9 ff 89 c6 84 c0 74 de 89 f2 0f b6 c2 5b 5e c3 55 
> 57 56 53 83 ec 10 89 54 24 08 89 4c 24 04 e8 bc ff ff ff <8b> 15 20 00 00 00 
> 8b 1d 10 00 00 0
> 0 0f b6 c0 8d 48 04 8d 6c 24
>  <3>[drm:drm_release] *ERROR* Device busy: 1 0
> EDAC PCI- Detected Parity Error on 0000:00:1e.0

OK.  I've been assuming that this is a DRM bug but I note that the AGP tree
has been dinking with agp_collect_device_status(), so perhaps I had the wrong
David.

> Additionally every second or so I got these console (and kernel of cource) 
> message:
> EDAC PCI- Detected Parity Error on 0000:00:1e.0

Alan, Rohit: do we expect that the EDAC fixes which you're cooking up will
address this?  I think not?

> lspci:
> 0000:00:00.0 Host bridge: Intel Corporation 82855PM Processor to I/O 
> Controller (rev 03)
> 0000:00:01.0 PCI bridge: Intel Corporation 82855PM Processor to AGP Controller 
> (rev 03)
> 0000:00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM 
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01)
> 0000:00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM 
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01)
> 0000:00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM 
> (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01)
> 0000:00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 
> EHCI Controller (rev 01)
> 0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81)
> 0000:00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface 
> Bridge (rev 01)
> 0000:00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller 
> (rev 01)
> 0000:00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
> SMBus Controller (rev 01)
> 0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM 
> (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
> 0000:00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
> AC'97 Modem Controller (rev 01)
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf 
> [FireGL 9000] (rev 02)
> 0000:02:00.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus 
> Controller (rev 01)
> 0000:02:00.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus 
> Controller (rev 01)
> 0000:02:01.0 Ethernet controller: Intel Corporation 82540EP Gigabit Ethernet 
> Controller (Mobile) (rev 03)
> 0000:02:02.0 Ethernet controller: Atheros Communications, Inc. AR5211 802.11ab 
> NIC (rev 01)
> 
> Full log again attached
> 
> -- 
> Encrypted Mails welcome.
> PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
