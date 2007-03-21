From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 8249] New: NMI watchdog
 detected LOCKUP when plugging USB devices with acpi=off
Date: Wed, 21 Mar 2007 11:07:25 -0700
Message-ID: <20070321110725.9d40e0c0.akpm@linux-foundation.org>
References: <200703211418.l2LEIjxr022653@fire-2.osdl.org>
	<20070321084112.3c19fa47.akpm@linux-foundation.org>
	<20070321175624.GA10891@xanadu.blop.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070321175624.GA10891@xanadu.blop.info>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Lucas Nussbaum <lucas@lucas-nussbaum.net>
Cc: linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 21 Mar 2007 18:56:24 +0100
Lucas Nussbaum <lucas@lucas-nussbaum.net> wrote:

> On 21/03/07 at 08:41 -0800, Andrew Morton wrote:
> > On Wed, 21 Mar 2007 07:18:45 -0700 bugme-daemon@bugzilla.kernel.org wrote:
> > 
> > > http://bugzilla.kernel.org/show_bug.cgi?id=8249
> > > 
> > >            Summary: NMI watchdog detected LOCKUP when plugging USB devices
> > >                     with acpi=off
> > >     Kernel Version: 2.6.21-rc4
> > >             Status: NEW
> > >           Severity: high
> > >              Owner: greg@kroah.com
> > >          Submitter: lucas@lucas-nussbaum.net
> > > 
> > > 
> > > Most recent kernel where this bug did *NOT* occur: none, as far as I know
> > > Problem Description:
> > > 
> > > My kernel is running with acpi=off to workaround another bug. When I turn on my
> > > USB printer (a Canon PIXMA MP750), I get this on the serial console:
> > > 
> > > usb 1-1: new full speed USB device using ohci_hcd and address 2
> > > usb 1-1: configuration #1 chosen from 1 choice
> > > BUG: NMI Watchdog detected LOCKUP on CPU0, eip 00007db7, registers:
> > > Modules linked in: nfs nfsd exportfs lockd nfs_acl sunrpc ppdev lp ipv6
> > > dm_snapshot dm_mirror dm_mod apm eeprom i2c_i801 snd_es1938 snd_opl3_lib
> > > snd_hwdep snd_mpu401_uart snd_pcm_oss snd_pcm snd_page_alloc snd_mixer_oss
> > > snd_seq_dummy snd_seq_oss bt878 snd_seq_midi snd_rawmidi snd_seq_midi_event
> > > tuner bttv snd_seq video_buf firmware_class snd_timer snd_seq_device ir_common
> > > compat_ioctl32 i2c_algo_bit snd btcx_risc tveeprom videodev v4l2_common
> > > v4l1_compat soundcore i2c_amd756 i2c_core nvidia_agp agpgart shpchp pci_hotplug
> > > parport_pc parport evdev analog rtc gameport pcspkr ext3 jbd mbcache ide_cd
> > > cdrom ide_disk generic amd74xx e100 mii ide_core ohci_hcd usbcore
> > > CPU:    0
> > > EIP:    00b8:[<00007db7>]    Not tainted VLI
> > > EFLAGS: 00000006   (2.6.21-rc4 #3)
> > > EIP is at 0x7db7
> > > eax: 00000ac2   ebx: 00000001   ecx: 00000000   edx: 0000e42e
> > > esi: dfe2bf2e   edi: 0000530a   ebp: 00000000   esp: dfe2be66
> > > ds: 0000   es: 0000   fs: 0000  gs: 0000  ss: 0068
> > > Process hald (pid: 2198, ti=dfe2a000 task=dff94a70 task.ti=dfe2a000)
> > > Stack: c2fb0001 0060ef9e 00010000 530a0000 007b0000 007b0000 f7200000 5de0deb8 
> > >        0000eefd 00d80000 c0400000 0033c15e 02820000 00010000 00000000 00000000 
> > >        bf2a0000 bf2edfe2 bf2cdfe2 0400dfe2 c5cb0000 bee0ef9e bedcdfe2 bed8dfe2 
> > > Call Trace:
> > >  =======================
> > > Code:  Bad EIP value.
> > > 
> > > I could also reproduce the same crash using two another USB peripherals (a
> > > remote controller and a mouse).
> > > 
> > > Without acpi=off, it works fine.
> > > 
> > 
> > (Please respond via reply-to-all, not via bugzilla web forms)
> > 
> > Are you able to get a cleaner kenrel trace than that?  This one seems a bit
> > mangled.
> 
> No. Initially, I didn't have debugging symbols compiled in, so I rebuilt
> the kernel in the hope that I would get something useful. But I got the
> same trace.
> 
> > Please raise a buzilla entry against acpi for the "another bug", if you
> > haven't done so.
> 
> It's http://bugzilla.kernel.org/show_bug.cgi?id=7937 (wake on lan
> doesn't work when acpi is enabled (works if disabled).
> 
> > I assume this indicates a bug in USB (as well) but with this trace it is
> > hard to tell.
> 
> How could I get a more useful output ?

ugly.

Have you tried it with the NMI watchdog disabled?  The machine might just
lock up dead.  Or it might do something useful&interesting, dunno.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
