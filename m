From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [ACPI] Re: kernel 2.6.10 , uhci-hcd problem after ACPI S3 suspend.
Date: Wed, 5 Jan 2005 15:09:02 -0800 (PST)
Message-ID: <20050105230902.4085.qmail@web50204.mail.yahoo.com>
References: <Pine.LNX.4.44L0.0501051727100.1001-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0501051727100.1001-100000@ida.rowland.org>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

The dmesg from a kernel 2.6.10 with CONFIG_USB_DEBUG
is bellow:
suspended without any device plugged, resumed, plugged
a device in.

uhci_hcd 0000:00:1d.1: suspend_hc
PM: Preparing system for suspend
ehci_hcd 0000:00:1d.7: --> PCI D3hot
uhci_hcd 0000:00:1d.2: suspend_hc
uhci_hcd 0000:00:1d.2: --> PCI D0/legacy
uhci_hcd 0000:00:1d.1: suspend_hc
uhci_hcd 0000:00:1d.1: --> PCI D0/legacy
uhci_hcd 0000:00:1d.0: suspend_hc
uhci_hcd 0000:00:1d.0: --> PCI D0/legacy
PM: Entering state.
 hwsleep-0307 [23] acpi_enter_sleep_state: Entering
sleep state [S3]
Back to C!
Warning: CPU frequency is 1700000, cpufreq assumed
1000000 kHz.
Debug: sleeping function called from invalid context
at mm/slab.c:2062
in_atomic():0, irqs_disabled():1
 [<c01188f5>] __might_sleep+0x95/0xb0
 [<c0216247>] acpi_ut_trace+0x28/0x2e
 [<c0140690>] kmem_cache_alloc+0x50/0x60
 [<c021d362>] acpi_pci_link_set+0x89/0x26b
 [<c021da11>] acpi_pci_link_resume+0x45/0x79
 [<c021da88>] irqrouter_resume+0x43/0x5e
 [<c025a0c6>] sysdev_resume+0x66/0xc4
 [<c025dbb5>] device_power_up+0x5/0xa
 [<c0131bd0>] suspend_enter+0x30/0x50
 [<c0131c93>] enter_state+0x63/0x90
 [<c021a513>] acpi_suspend+0x28/0x35
 [<c01d9a44>] copy_from_user+0x54/0x90
 [<c021a618>] acpi_system_write_sleep+0x66/0x77
 [<c01548e1>] vfs_write+0xd1/0x130
 [<c01549f1>] sys_write+0x41/0x70
 [<c0102e0d>] sysenter_past_esp+0x52/0x75
hub 4-0:1.0: resubmit --> -108
hub 2-0:1.0: resubmit --> -108
hub 3-0:1.0: resubmit --> -108
PM: Finishing up.
uhci_hcd 0000:00:1d.0: resume from PCI D0 (legacy)
PCI: Setting latency timer of device 0000:00:1d.0 to
64
uhci_hcd 0000:00:1d.1: resume from PCI D0 (legacy)
PCI: Setting latency timer of device 0000:00:1d.1 to
64
uhci_hcd 0000:00:1d.2: resume from PCI D0 (legacy)
PCI: Setting latency timer of device 0000:00:1d.2 to
64
ehci_hcd 0000:00:1d.7: resume from PCI D3hot
ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0
ithresh=8 period=1024 Reset HALT
ehci_hcd 0000:00:1d.7: reset hcs_params 0x103206 dbg=1
cc=3 pcc=2 ordered !ppc ports=6
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7
uframes 1024 64 bit addr
ehci_hcd 0000:00:1d.7: capability 0001 at 68
ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0
ithresh=8 period=1024 Reset HALT
PCI: cache line size of 32 is not supported by device
0000:00:1d.7
ehci_hcd 0000:00:1d.7: init command 010001 (park)=0
ithresh=1 period=1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 restarted, EHCI 1.00,
driver 26 Oct 2004
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 7 (level,
low) -> IRQ 7
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level,
low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to
64
uhci_hcd 0000:00:1d.2: wakeup_hc
uhci_hcd 0000:00:1d.1: wakeup_hc
uhci_hcd 0000:00:1d.0: wakeup_hc
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 5 (level,
low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.6 to
64
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 5 (level,
low) -> IRQ 5
hub 4-0:1.0: state 5 ports 2 chg fffc evt 0006
hub 2-0:1.0: state 5 ports 2 chg fffc evt 0006
hub 3-0:1.0: state 5 ports 2 chg fffc evt 0006
uhci_hcd 0000:00:1d.2: suspend_hc
uhci_hcd 0000:00:1d.1: suspend_hc
uhci_hcd 0000:00:1d.0: suspend_hc
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps
Full Duplex
hub 1-0:1.0: state 5 ports 6 chg ffc0 evt 0010
ehci_hcd 0000:00:1d.7: GetStatus port 4 status 001803
POWER sig=j  CSC CONNECT
hub 1-0:1.0: port 4, status 0501, change 0001, 480
Mb/s
hub 1-0:1.0: debounce: port 4: total 100ms stable
100ms status 0x501
ehci_hcd 0000:00:1d.7: port 4 full speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 4 status 003801
POWER OWNER sig=j  CONNECT
uhci_hcd 0000:00:1d.1: wakeup_hc
[root@r50p ~]# 


--- Alan Stern <stern@rowland.harvard.edu> wrote:

> On Wed, 5 Jan 2005, Paul Ionescu wrote:
> 
> > Hi Alan,
> > 
> > CONFIG_USB_SUSPEND is not set.
> > Should I try to set it ? 
> > I thought it is for something else from its
> attached
> > help, that's why I left it unset.
> 
> No, leaving it unset is fine (and probably best, for
> the moment).  I just 
> wanted to know whether or not you had set it.
> 
> Alan Stern
> 
> 



		
__________________________________ 
Do you Yahoo!? 
Read only the mail you want - Yahoo! Mail SpamGuard. 
http://promotions.yahoo.com/new_mail 


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
