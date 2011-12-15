From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Thunderbolt hotplug issue, was: Re: xhci errors when hotplugging a
 NEC uPD720200 USB hub.
Date: Thu, 15 Dec 2011 13:48:34 -0800
Message-ID: <20111215214834.GB6482@xanatos>
References: <loom.20111214T205055-477@post.gmane.org>
 <20111215001636.GA7840@xanatos>
 <1323965859.69300.YahooMailNeo@web162001.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1323965859.69300.YahooMailNeo-LtZJKGGQQWhal3a5i+KC+JEhsgyP+Z75VpNB7YpNyf8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vick <weasalandme-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Please don't top-post.

On Thu, Dec 15, 2011 at 08:17:39AM -0800, vick wrote:
> Yeah, Sony jumped on the wagon quick and they actually have a sweet setup now if it would only work with linux. The docking station has a built-in radeon video card (which doesn't work yet but I'm trying to get some help from the DRM group), a network card, a USB 3.0 hub and a dvd all going through the Light Peak interface.
> 
> 
> Attached are 2 dmsg outputs, the working one is when the docking station is available and plugged in during boot, the nonworking1 is the one where I plug the dock after boot is complete.
> This is a vanilla 3.2.0-rc5 from kernel.org booted into singe user mode compiled with CONFIG_USB_XHCI_HCD_DEBUGGING and CONFIG_USB_DEBUG. I did not add any additional options to the xhci module so if I was supposed to let me know which ones.
> I loaded acpiphp module to handle the pci hotplug in this case. I was forcing a pci rescan before but I think I see the same error messages.

The non-working dmesg is very odd, and I think it's a PCI hot plug or
ACPI issue.  Around 1 second in, the Thunderbolt dock is found, but later
it is hot-removed, and the PCI drivers are not notified of removal.
Then the dock is hot-plugged again, and the PCI core attempts to
initialized the drivers again, which fails.

> [    1.009781] ACPI: ACPI Dock Station Driver: 1 docks/bays found
> [    1.009841] HEST: Table not found.
> [    1.009898] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    1.010335] \_SB_.PCI0:_OSC invalid UUID
> [    1.010336] _OSC request data:1 8 1f 

I'm not sure what the ACPI message about invalid UUID means.  Maybe the
ACPI folks know.

> [    1.010339] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
> [    1.011027] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
> [    1.011088] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
> [    1.011149] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
> [    1.011222] pci_root PNP0A08:00: host bridge window [mem 0x9fa00000-0xfeafffff]
> [    1.011303] pci 0000:00:00.0: [8086:0104] type 0 class 0x000600
> [    1.011333] pci 0000:00:02.0: [8086:0126] type 0 class 0x000300
> [    1.011342] pci 0000:00:02.0: reg 10: [mem 0xd0000000-0xd03fffff 64bit]
> [    1.011347] pci 0000:00:02.0: reg 18: [mem 0xa0000000-0xafffffff 64bit pref]
> [    1.011351] pci 0000:00:02.0: reg 20: [io  0xa000-0xa03f]
> [    1.011397] pci 0000:00:16.0: [8086:1c3a] type 0 class 0x000780
> [    1.011419] pci 0000:00:16.0: reg 10: [mem 0xd9404000-0xd940400f 64bit]
> [    1.011480] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
> [    1.011484] pci 0000:00:16.0: PME# disabled
> [    1.011515] pci 0000:00:1a.0: [8086:1c2d] type 0 class 0x000c03
> [    1.011817] pci 0000:00:1a.0: reg 10: [mem 0xd9409000-0xd94093ff]
> [    1.013557] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
> [    1.013562] pci 0000:00:1a.0: PME# disabled
> [    1.013586] pci 0000:00:1b.0: [8086:1c20] type 0 class 0x000403
> [    1.013601] pci 0000:00:1b.0: reg 10: [mem 0xd9400000-0xd9403fff 64bit]
> [    1.013655] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> [    1.013659] pci 0000:00:1b.0: PME# disabled
> [    1.013680] pci 0000:00:1c.0: [8086:1c10] type 1 class 0x000604
> [    1.013740] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    1.013744] pci 0000:00:1c.0: PME# disabled
> [    1.013768] pci 0000:00:1c.1: [8086:1c12] type 1 class 0x000604
> [    1.013828] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
> [    1.013832] pci 0000:00:1c.1: PME# disabled
> [    1.013855] pci 0000:00:1c.2: [8086:1c14] type 1 class 0x000604
> [    1.013915] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
> [    1.013919] pci 0000:00:1c.2: PME# disabled
> [    1.013942] pci 0000:00:1c.3: [8086:1c16] type 1 class 0x000604
> [    1.014002] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
> [    1.014006] pci 0000:00:1c.3: PME# disabled
> [    1.014036] pci 0000:00:1c.6: [8086:1c1c] type 1 class 0x000604
> [    1.014138] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
> [    1.014143] pci 0000:00:1c.6: PME# disabled
> [    1.014179] pci 0000:00:1d.0: [8086:1c26] type 0 class 0x000c03
> [    1.014475] pci 0000:00:1d.0: reg 10: [mem 0xd9408000-0xd94083ff]
> [    1.016216] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> [    1.016220] pci 0000:00:1d.0: PME# disabled
> [    1.016245] pci 0000:00:1f.0: [8086:1c4b] type 0 class 0x000601
> [    1.016357] pci 0000:00:1f.2: [8086:282a] type 0 class 0x000104
> [    1.016375] pci 0000:00:1f.2: reg 10: [io  0xa088-0xa08f]
> [    1.016382] pci 0000:00:1f.2: reg 14: [io  0xa094-0xa097]
> [    1.016390] pci 0000:00:1f.2: reg 18: [io  0xa080-0xa087]
> [    1.016398] pci 0000:00:1f.2: reg 1c: [io  0xa090-0xa093]
> [    1.016406] pci 0000:00:1f.2: reg 20: [io  0xa060-0xa07f]
> [    1.016414] pci 0000:00:1f.2: reg 24: [mem 0xd9407000-0xd94077ff]
> [    1.016445] pci 0000:00:1f.2: PME# supported from D3hot
> [    1.016449] pci 0000:00:1f.2: PME# disabled
> [    1.016467] pci 0000:00:1f.3: [8086:1c22] type 0 class 0x000c05
> [    1.016481] pci 0000:00:1f.3: reg 10: [mem 0xd9405000-0xd94050ff 64bit]
> [    1.016502] pci 0000:00:1f.3: reg 20: [io  0xa040-0xa05f]
> [    1.016728] pci 0000:02:00.0: [8086:0091] type 0 class 0x000280
> [    1.016875] pci 0000:02:00.0: reg 10: [mem 0xd8400000-0xd8401fff 64bit]
> [    1.017445] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
> [    1.017479] pci 0000:02:00.0: PME# disabled
> [    1.024053] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
> [    1.024113] pci 0000:00:1c.0:   bridge window [io  0x9000-0x9fff]
> [    1.024117] pci 0000:00:1c.0:   bridge window [mem 0xd8400000-0xd93fffff]
> [    1.024124] pci 0000:00:1c.0:   bridge window [mem 0xd0400000-0xd13fffff 64bit pref]
> [    1.024191] pci 0000:03:00.0: [10ec:5209] type 0 class 0x00ff00
> [    1.024212] pci 0000:03:00.0: reg 10: [mem 0xd7400000-0xd7400fff]
> [    1.024338] pci 0000:03:00.0: supports D1 D2
> [    1.024339] pci 0000:03:00.0: PME# supported from D1 D2 D3hot
> [    1.024344] pci 0000:03:00.0: PME# disabled
> [    1.031930] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
> [    1.032021] pci 0000:00:1c.1:   bridge window [io  0x8000-0x8fff]
> [    1.032035] pci 0000:00:1c.1:   bridge window [mem 0xd7400000-0xd83fffff]
> [    1.032042] pci 0000:00:1c.1:   bridge window [mem 0xd1400000-0xd23fffff 64bit pref]
> [    1.032158] pci 0000:04:00.0: [1033:0194] type 0 class 0x000c03
> [    1.032184] pci 0000:04:00.0: reg 10: [mem 0xd6400000-0xd6401fff 64bit]
> [    1.032289] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
> [    1.032294] pci 0000:04:00.0: PME# disabled
> [    1.039974] pci 0000:00:1c.2: PCI bridge to [bus 04-04]
> [    1.040062] pci 0000:00:1c.2:   bridge window [io  0x7000-0x7fff]
> [    1.040066] pci 0000:00:1c.2:   bridge window [mem 0xd6400000-0xd73fffff]
> [    1.040072] pci 0000:00:1c.2:   bridge window [mem 0xd2400000-0xd33fffff 64bit pref]
> [    1.040196] pci 0000:05:00.0: [10ec:8168] type 0 class 0x000200
> [    1.040263] pci 0000:05:00.0: reg 10: [io  0x6000-0x60ff]
> [    1.040382] pci 0000:05:00.0: reg 18: [mem 0xd3404000-0xd3404fff 64bit pref]
> [    1.040450] pci 0000:05:00.0: reg 20: [mem 0xd3400000-0xd3403fff 64bit pref]
> [    1.040662] pci 0000:05:00.0: supports D1 D2
> [    1.040663] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    1.040678] pci 0000:05:00.0: PME# disabled
> [    1.047959] pci 0000:00:1c.3: PCI bridge to [bus 05-05]
> [    1.048049] pci 0000:00:1c.3:   bridge window [io  0x6000-0x6fff]
> [    1.048053] pci 0000:00:1c.3:   bridge window [mem 0xd5400000-0xd63fffff]
> [    1.048059] pci 0000:00:1c.3:   bridge window [mem 0xd3400000-0xd43fffff 64bit pref]
> [    1.048132] pci 0000:00:1c.6: PCI bridge to [bus 08-20]
> [    1.048193] pci 0000:00:1c.6:   bridge window [io  0x3000-0x5fff]
> [    1.048199] pci 0000:00:1c.6:   bridge window [mem 0xb0000000-0xcfffffff]
> [    1.048208] pci 0000:00:1c.6:   bridge window [mem 0xd4400000-0xd53fffff 64bit pref]

The xHCI driver eventually loads for PCI device 0000:04:00.0:

> [    3.088620] xhci_hcd 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> [    3.088727] xhci_hcd 0000:04:00.0: setting latency timer to 64
> [    3.088731] xhci_hcd 0000:04:00.0: xHCI Host Controller
> [    3.088812] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus number 3

The driver works fine, and is even able to get the NEC firmware version:

> [    3.092705] xhci_hcd 0000:04:00.0: Vendor specific event TRB type = 48
> [    3.092708] xhci_hcd 0000:04:00.0: NEC firmware version 40.15

The host controller shows that there's nothing attached to the ports on
init:

> [    3.190122] xhci_hcd 0000:04:00.0: get port status, actual port 0 status  = 0x2a0
> [    3.190124] xhci_hcd 0000:04:00.0: Get port status returned 0x2a0
> [    3.190128] xhci_hcd 0000:04:00.0: get port status, actual port 1 status  = 0x2a0
> [    3.190130] xhci_hcd 0000:04:00.0: Get port status returned 0x2a0

Later the bus is suspended and eventually the PCI host is suspended as
well:

> [    6.948921] hub 3-0:1.0: hub_suspend
> [    6.948924] usb usb3: bus auto-suspend, wakeup 1
> [    6.948988] hub 4-0:1.0: hub_suspend
> [    6.948990] usb usb4: bus auto-suspend, wakeup 1
> [    6.949743] xhci_hcd 0000:04:00.0: // Setting command ring address to 0x37021001
> [    6.949780] xhci_hcd 0000:04:00.0: hcd_pci_runtime_suspend: 0
> [    6.949846] xhci_hcd 0000:04:00.0: PME# enabled

It wakes up later:

> [   25.939067] xhci_hcd 0000:04:00.0: PME# disabled
> [   25.939081] xhci_hcd 0000:04:00.0: setting latency timer to 64
> [   25.939092] xhci_hcd 0000:04:00.0: // Setting command ring address to 0x37021001
> [   25.939127] xhci_hcd 0000:04:00.0: hcd_pci_runtime_resume: 0
> [   25.939130] usb usb3: usb auto-resume
> [   25.939153] usb usb4: usb wakeup-resume
> [   25.939154] usb usb4: usb auto-resume
> [   25.954917] hub 4-0:1.0: hub_resume
> [   25.954935] xhci_hcd 0000:04:00.0: get port status, actual port 0 status  = 0x2a0
> [   25.954942] xhci_hcd 0000:04:00.0: Get port status returned 0x2a0
> [   25.954955] xhci_hcd 0000:04:00.0: get port status, actual port 1 status  = 0x2a0
> [   25.954960] xhci_hcd 0000:04:00.0: Get port status returned 0x2a0
> [   25.955024] hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
> [   25.955035] hub 3-0:1.0: hub_resume
> [   25.955041] xhci_hcd 0000:04:00.0: get port status, actual port 0 status  = 0x2a0
> [   25.955042] xhci_hcd 0000:04:00.0: Get port status returned 0x100
> [   25.955047] xhci_hcd 0000:04:00.0: get port status, actual port 1 status  = 0x2a0
> [   25.955049] xhci_hcd 0000:04:00.0: Get port status returned 0x100
> [   25.955083] hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0000
> [   25.955711] hub 4-0:1.0: hub_suspend
> [   25.955716] usb usb4: bus auto-suspend, wakeup 1
> [   25.955771] usb usb4: usb auto-resume
> [   25.982909] hub 4-0:1.0: hub_resume
> [   25.982927] xhci_hcd 0000:04:00.0: get port status, actual port 0 status  = 0x2a0
> [   25.982933] xhci_hcd 0000:04:00.0: Get port status returned 0x2a0
> [   25.982946] xhci_hcd 0000:04:00.0: get port status, actual port 1 status  = 0x2a0
> [   25.982951] xhci_hcd 0000:04:00.0: Get port status returned 0x2a0
> [   25.983014] hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000

But the host reports there is nothing attached to the ports again.

Then your dock gets re-enumerated *again* without any sort of PCI
disconnect for the existing drivers:

> [   26.714909] ACPI: \_SB_.DOCK - docking
> [   26.717134] pci 0000:08:00.0: [8086:151b] type 1 class 0x000604
> [   26.717227] pci 0000:08:00.0: supports D1 D2
> [   26.717228] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   26.717234] pci 0000:08:00.0: PME# disabled
> [   26.717351] pci 0000:0a:00.0: [8086:151b] type 1 class 0x000604
> [   26.717442] pci 0000:0a:00.0: supports D1 D2
> [   26.717443] pci 0000:0a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   26.717449] pci 0000:0a:00.0: PME# disabled
> [   26.717508] pci 0000:0a:03.0: [8086:151b] type 1 class 0x000604
> [   26.717604] pci 0000:0a:03.0: supports D1 D2
> [   26.717605] pci 0000:0a:03.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   26.717610] pci 0000:0a:03.0: PME# disabled
> [   26.717660] pci 0000:0a:04.0: [8086:151b] type 1 class 0x000604
> [   26.717751] pci 0000:0a:04.0: supports D1 D2
> [   26.717752] pci 0000:0a:04.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   26.717757] pci 0000:0a:04.0: PME# disabled
> [   26.717831] pci 0000:08:00.0: PCI bridge to [bus 0a-1d]
> [   26.719281] pci 0000:08:00.0:   bridge window [io  0x3000-0x5fff]
> [   26.719287] pci 0000:08:00.0:   bridge window [mem 0xb0000000-0xc03fffff]
> [   26.719296] pci 0000:08:00.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
> [   26.719363] pci 0000:0a:00.0: PCI bridge to [bus 0b-0b]
> [   26.720785] pci 0000:0a:00.0:   bridge window [mem 0xc0300000-0xc03fffff]
> [   26.720861] pci 0000:0a:03.0: PCI bridge to [bus 0c-0c]
> [   26.722375] pci 0000:14:00.0: [8086:151b] type 1 class 0x000604
> [   26.722529] pci 0000:14:00.0: supports D1 D2
> [   26.722531] pci 0000:14:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   26.722538] pci 0000:14:00.0: PME# disabled
> [   26.722593] pci 0000:0a:04.0: PCI bridge to [bus 14-1d]
> [   26.723991] pci 0000:0a:04.0:   bridge window [io  0x3000-0x5fff]
> [   26.723996] pci 0000:0a:04.0:   bridge window [mem 0xb0000000-0xc02fffff]
> [   26.724005] pci 0000:0a:04.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
> [   26.724162] pci 0000:15:03.0: [8086:151b] type 1 class 0x000604
> [   26.724318] pci 0000:15:03.0: supports D1 D2
> [   26.724319] pci 0000:15:03.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   26.724327] pci 0000:15:03.0: PME# disabled
> [   26.724407] pci 0000:15:04.0: [8086:151b] type 1 class 0x000604
> [   26.724563] pci 0000:15:04.0: supports D1 D2
> [   26.724564] pci 0000:15:04.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   26.724572] pci 0000:15:04.0: PME# disabled
> [   26.724697] pci 0000:14:00.0: PCI bridge to [bus 15-1d]
> [   26.726080] pci 0000:14:00.0:   bridge window [io  0x3000-0x5fff]
> [   26.726088] pci 0000:14:00.0:   bridge window [mem 0xb0000000-0xc02fffff]
> [   26.726101] pci 0000:14:00.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
> [   26.726252] pci 0000:16:00.0: [1002:6740] type 0 class 0x000300
> [   26.726308] pci 0000:16:00.0: reg 10: [mem 0x00000000-0x0fffffff 64bit pref]
> [   26.726352] pci 0000:16:00.0: reg 18: [mem 0x00000000-0x0001ffff 64bit]
> [   26.726381] pci 0000:16:00.0: reg 20: [io  0x0000-0x00ff]
> [   26.726437] pci 0000:16:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
> [   26.726513] pci 0000:16:00.0: supports D1 D2
> [   26.726602] pci 0000:16:00.1: [1002:aa90] type 0 class 0x000403
> [   26.726661] pci 0000:16:00.1: reg 10: [mem 0x00000000-0x00003fff 64bit]
> [   26.726871] pci 0000:16:00.1: supports D1 D2
> [   26.726942] pci 0000:15:03.0: PCI bridge to [bus 16-16]
> [   26.728314] pci 0000:15:03.0:   bridge window [io  0x5000-0x5fff]
> [   26.728322] pci 0000:15:03.0:   bridge window [mem 0xc0200000-0xc02fffff]
> [   26.728335] pci 0000:15:03.0:   bridge window [mem 0xb0000000-0xbfffffff 64bit pref]
> [   26.728501] pci 0000:17:00.0: [8086:151b] type 1 class 0x000604
> [   26.728719] pci 0000:17:00.0: supports D1 D2
> [   26.728721] pci 0000:17:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   26.728731] pci 0000:17:00.0: PME# disabled
> [   26.728810] pci 0000:15:04.0: PCI bridge to [bus 17-1d]
> [   26.730163] pci 0000:15:04.0:   bridge window [io  0x3000-0x4fff]
> [   26.730171] pci 0000:15:04.0:   bridge window [mem 0xc0000000-0xc01fffff]
> [   26.730185] pci 0000:15:04.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
> [   26.730392] pci 0000:18:00.0: [8086:151b] type 1 class 0x000604
> [   26.730619] pci 0000:18:00.0: supports D1 D2
> [   26.730620] pci 0000:18:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   26.730631] pci 0000:18:00.0: PME# disabled
> [   26.730765] pci 0000:18:01.0: [8086:151b] type 1 class 0x000604
> [   26.730986] pci 0000:18:01.0: supports D1 D2
> [   26.730988] pci 0000:18:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   26.730998] pci 0000:18:01.0: PME# disabled
> [   26.731115] pci 0000:18:02.0: [8086:151b] type 1 class 0x000604
> [   26.731337] pci 0000:18:02.0: supports D1 D2
> [   26.731338] pci 0000:18:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   26.731349] pci 0000:18:02.0: PME# disabled
> [   26.731470] pci 0000:18:03.0: [8086:151b] type 1 class 0x000604
> [   26.731692] pci 0000:18:03.0: supports D1 D2
> [   26.731693] pci 0000:18:03.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   26.731704] pci 0000:18:03.0: PME# disabled
> [   26.731829] pci 0000:18:04.0: [8086:151b] type 1 class 0x000604
> [   26.732051] pci 0000:18:04.0: supports D1 D2
> [   26.732052] pci 0000:18:04.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   26.732062] pci 0000:18:04.0: PME# disabled
> [   26.732252] pci 0000:17:00.0: PCI bridge to [bus 18-1d]
> [   26.733602] pci 0000:17:00.0:   bridge window [io  0x3000-0x4fff]
> [   26.733613] pci 0000:17:00.0:   bridge window [mem 0xc0000000-0xc01fffff]
> [   26.733631] pci 0000:17:00.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
> [   26.733851] pci 0000:19:00.0: [10ec:8168] type 0 class 0x000200
> [   26.733905] pci 0000:19:00.0: reg 10: [io  0x0000-0x00ff]
> [   26.734000] pci 0000:19:00.0: reg 18: [mem 0x00000000-0x00000fff 64bit pref]
> [   26.734059] pci 0000:19:00.0: reg 20: [mem 0x00000000-0x00003fff 64bit pref]
> [   26.734228] pci 0000:19:00.0: supports D1 D2
> [   26.734230] pci 0000:19:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [   26.734242] pci 0000:19:00.0: PME# disabled
> [   26.734336] pci 0000:18:00.0: PCI bridge to [bus 19-19]
> [   26.735646] pci 0000:18:00.0:   bridge window [io  0x4000-0x4fff]
> [   26.735674] pci 0000:18:00.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
> [   26.735897] pci 0000:1a:00.0: [11ab:6121] type 0 class 0x000101
> [   26.735951] pci 0000:1a:00.0: reg 10: [io  0x8000-0x8007]
> [   26.735989] pci 0000:1a:00.0: reg 14: [io  0x8040-0x8043]
> [   26.736027] pci 0000:1a:00.0: reg 18: [io  0x8200-0x8207]
> [   26.736065] pci 0000:1a:00.0: reg 1c: [io  0x8800-0x8803]
> [   26.736103] pci 0000:1a:00.0: reg 20: [io  0x900000-0x90000f]
> [   26.736142] pci 0000:1a:00.0: reg 24: [mem 0x00800000-0x008003ff]
> [   26.736294] pci 0000:1a:00.0: supports D1
> [   26.736295] pci 0000:1a:00.0: PME# supported from D0 D1 D3hot
> [   26.736307] pci 0000:1a:00.0: PME# disabled
> [   26.736365] pci 0000:1a:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
> [   26.737704] pci 0000:18:01.0: PCI bridge to [bus 1a-1a]
> [   26.739075] pci 0000:18:01.0:   bridge window [io  0x3000-0x3fff]
> [   26.739085] pci 0000:18:01.0:   bridge window [mem 0xc0100000-0xc01fffff]
> [   26.739334] pci 0000:1b:00.0: [1033:0194] type 0 class 0x000c03
> [   26.739405] pci 0000:1b:00.0: reg 10: [mem 0x00000000-0x00001fff 64bit]
> [   26.739706] pci 0000:1b:00.0: PME# supported from D0 D3hot D3cold
> [   26.739717] pci 0000:1b:00.0: PME# disabled
> [   26.739802] pci 0000:18:02.0: PCI bridge to [bus 1b-1b]
> [   26.741179] pci 0000:18:02.0:   bridge window [mem 0xc0000000-0xc00fffff]
> [   26.741360] pci 0000:18:03.0: PCI bridge to [bus 1c-1c]
> [   26.742925] pci 0000:18:04.0: PCI bridge to [bus 1d-1d]
> [   26.745179] ACPI: Delete PCI Interrupt Routing Table for 0000:0a
> [   26.745497] [Firmware Bug]: ACPI(GFXA) defines _DOD but not _DOS

This ACPI message might be the reason why drivers weren't notified that
the dock was removed.

Then the PCI core attempts to re-initialize the drivers, but the memory
for the BARs are already allocated.  This causes the video driver to
complain, and the xHCI driver to fail to initialize:

> [   26.747443] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:1f/device:4d/device:50/device:51/device:52/LNXVIDEO:0a/input/input8
> [   26.749281] ACPI: Video Device [GFXA] (multi-head: yes  rom: no  post: no)
> [   26.750838] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
> [   26.752790] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
> [   26.754290] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
> [   26.755769] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
> [   26.757225] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
> [   26.758682] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
> [   26.760112] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
> [   26.762090] pci 0000:08:00.0: BAR 15: assigned [mem 0xb0000000-0xcbffffff pref]
> [   26.763835] pci 0000:08:00.0: BAR 14: can't assign mem (size 0x10400000)
> [   26.765355] pci 0000:08:00.0: BAR 13: assigned [io  0x3000-0x5fff]
> [   26.766702] pci 0000:0a:04.0: BAR 15: assigned [mem 0xb0000000-0xcbffffff pref]
> [   26.768037] pci 0000:0a:00.0: BAR 14: can't assign mem (size 0x100000)
> [   26.769372] pci 0000:0a:04.0: BAR 14: can't assign mem (size 0x10300000)
> [   26.770672] pci 0000:0a:04.0: BAR 13: assigned [io  0x3000-0x5fff]
> [   26.771932] pci 0000:0a:00.0: PCI bridge to [bus 0b-0b]
> [   26.773203] pci 0000:0a:03.0: PCI bridge to [bus 0c-0c]
> [   26.774463] pci 0000:14:00.0: BAR 15: assigned [mem 0xb0000000-0xcbffffff pref]
> [   26.775729] pci 0000:14:00.0: BAR 14: can't assign mem (size 0x10300000)
> [   26.776986] pci 0000:14:00.0: BAR 13: assigned [io  0x3000-0x5fff]
> [   26.778253] pci 0000:15:03.0: BAR 15: assigned [mem 0xb0000000-0xc7ffffff pref]
> [   26.779533] pci 0000:15:03.0: BAR 14: can't assign mem (size 0x100000)
> [   26.780812] pci 0000:15:04.0: BAR 14: can't assign mem (size 0x200000)
> [   26.782086] pci 0000:15:04.0: BAR 15: assigned [mem 0xc8000000-0xc80fffff 64bit pref]
> [   26.783356] pci 0000:15:03.0: BAR 13: assigned [io  0x3000-0x3fff]
> [   26.784600] pci 0000:15:04.0: BAR 13: assigned [io  0x4000-0x5fff]
> [   26.785829] pci 0000:16:00.0: BAR 0: assigned [mem 0xb0000000-0xbfffffff 64bit pref]
> [   26.787098] pci 0000:16:00.0: BAR 0: set to [mem 0xb0000000-0xbfffffff 64bit pref] (PCI address [0xb0000000-0xbfffffff])
> [   26.788379] pci 0000:16:00.0: BAR 2: can't assign mem (size 0x20000)
> [   26.789661] pci 0000:16:00.0: BAR 6: assigned [mem 0xc0000000-0xc001ffff pref]
> [   26.790950] pci 0000:16:00.1: BAR 0: can't assign mem (size 0x4000)
> [   26.792240] pci 0000:16:00.0: BAR 4: assigned [io  0x3000-0x30ff]
> [   26.793535] pci 0000:16:00.0: BAR 4: set to [io  0x3000-0x30ff] (PCI address [0x3000-0x30ff])
> [   26.794841] pci 0000:15:03.0: PCI bridge to [bus 16-16]
> [   26.796135] pci 0000:15:03.0:   bridge window [io  0x3000-0x3fff]
> [   26.797446] pci 0000:15:03.0:   bridge window [mem 0xb0000000-0xc7ffffff pref]
> [   26.798767] pci 0000:17:00.0: BAR 14: can't assign mem (size 0x200000)
> [   26.800078] pci 0000:17:00.0: BAR 15: assigned [mem 0xc8000000-0xc80fffff 64bit pref]
> [   26.801389] pci 0000:17:00.0: BAR 13: assigned [io  0x4000-0x5fff]
> [   26.802689] pci 0000:18:00.0: BAR 15: assigned [mem 0xc8000000-0xc80fffff 64bit pref]
> [   26.803985] pci 0000:18:01.0: BAR 14: can't assign mem (size 0x100000)
> [   26.805290] pci 0000:18:02.0: BAR 14: can't assign mem (size 0x100000)
> [   26.806570] pci 0000:18:00.0: BAR 13: assigned [io  0x4000-0x4fff]
> [   26.807842] pci 0000:18:01.0: BAR 13: assigned [io  0x5000-0x5fff]
> [   26.809111] pci 0000:19:00.0: BAR 4: assigned [mem 0xc8000000-0xc8003fff 64bit pref]
> [   26.810423] pci 0000:19:00.0: BAR 4: set to [mem 0xc8000000-0xc8003fff 64bit pref] (PCI address [0xc8000000-0xc8003fff])
> [   26.811725] pci 0000:19:00.0: BAR 2: assigned [mem 0xc8004000-0xc8004fff 64bit pref]
> [   26.813040] pci 0000:19:00.0: BAR 2: set to [mem 0xc8004000-0xc8004fff 64bit pref] (PCI address [0xc8004000-0xc8004fff])
> [   26.814344] pci 0000:19:00.0: BAR 0: assigned [io  0x4000-0x40ff]
> [   26.815647] pci 0000:19:00.0: BAR 0: set to [io  0x4000-0x40ff] (PCI address [0x4000-0x40ff])
> [   26.816940] pci 0000:18:00.0: PCI bridge to [bus 19-19]
> [   26.818232] pci 0000:18:00.0:   bridge window [io  0x4000-0x4fff]
> [   26.819553] pci 0000:18:00.0:   bridge window [mem 0xc8000000-0xc80fffff 64bit pref]
> [   26.820885] pci 0000:1a:00.0: BAR 5: can't assign mem (size 0x400)
> [   26.822207] pci 0000:1a:00.0: BAR 4: assigned [io  0x5000-0x500f]
> [   26.823549] pci 0000:1a:00.0: BAR 4: set to [io  0x5000-0x500f] (PCI address [0x5000-0x500f])
> [   26.824904] pci 0000:1a:00.0: BAR 0: assigned [io  0x5010-0x5017]
> [   26.826276] pci 0000:1a:00.0: BAR 0: set to [io  0x5010-0x5017] (PCI address [0x5010-0x5017])
> [   26.827669] pci 0000:1a:00.0: BAR 2: assigned [io  0x5018-0x501f]
> [   26.829073] pci 0000:1a:00.0: BAR 2: set to [io  0x5018-0x501f] (PCI address [0x5018-0x501f])
> [   26.830462] pci 0000:1a:00.0: BAR 1: assigned [io  0x5020-0x5023]
> [   26.831850] pci 0000:1a:00.0: BAR 1: set to [io  0x5020-0x5023] (PCI address [0x5020-0x5023])
> [   26.833243] pci 0000:1a:00.0: BAR 3: assigned [io  0x5024-0x5027]
> [   26.834665] pci 0000:1a:00.0: BAR 3: set to [io  0x5024-0x5027] (PCI address [0x5024-0x5027])
> [   26.836092] pci 0000:18:01.0: PCI bridge to [bus 1a-1a]
> [   26.837511] pci 0000:18:01.0:   bridge window [io  0x5000-0x5fff]
> [   26.838937] pci 0000:1b:00.0: BAR 0: can't assign mem (size 0x2000)
> [   26.840290] pci 0000:18:02.0: PCI bridge to [bus 1b-1b]
> [   26.841634] pci 0000:18:03.0: PCI bridge to [bus 1c-1c]
> [   26.842987] pci 0000:18:04.0: PCI bridge to [bus 1d-1d]
> [   26.844341] pci 0000:17:00.0: PCI bridge to [bus 18-1d]
> [   26.845663] pci 0000:17:00.0:   bridge window [io  0x4000-0x5fff]
> [   26.847023] pci 0000:17:00.0:   bridge window [mem 0xc8000000-0xc80fffff 64bit pref]
> [   26.848390] pci 0000:15:04.0: PCI bridge to [bus 17-1d]
> [   26.849757] pci 0000:15:04.0:   bridge window [io  0x4000-0x5fff]
> [   26.851098] pci 0000:15:04.0:   bridge window [mem 0xc8000000-0xc80fffff 64bit pref]
> [   26.852434] pci 0000:14:00.0: PCI bridge to [bus 15-1d]
> [   26.853759] pci 0000:14:00.0:   bridge window [io  0x3000-0x5fff]
> [   26.855101] pci 0000:14:00.0:   bridge window [mem 0xb0000000-0xcbffffff pref]
> [   26.856433] pci 0000:0a:04.0: PCI bridge to [bus 14-1d]
> [   26.857767] pci 0000:0a:04.0:   bridge window [io  0x3000-0x5fff]
> [   26.859113] pci 0000:0a:04.0:   bridge window [mem 0xb0000000-0xcbffffff pref]
> [   26.860458] pci 0000:08:00.0: PCI bridge to [bus 0a-1d]
> [   26.861803] pci 0000:08:00.0:   bridge window [io  0x3000-0x5fff]
> [   26.863159] pci 0000:08:00.0:   bridge window [mem 0xb0000000-0xcbffffff pref]
> [   26.864512] pci 0000:08:00.0: no hotplug settings from platform
> [   26.865856] pci 0000:0a:00.0: no hotplug settings from platform
> [   26.867190] pci 0000:0a:03.0: no hotplug settings from platform
> [   26.868503] pci 0000:0a:04.0: no hotplug settings from platform
> [   26.869820] pci 0000:14:00.0: no hotplug settings from platform
> [   26.871123] pci 0000:15:03.0: no hotplug settings from platform
> [   26.872412] pci 0000:16:00.0: no hotplug settings from platform
> [   26.873698] pci 0000:16:00.1: no hotplug settings from platform
> [   26.874972] pci 0000:15:04.0: no hotplug settings from platform
> [   26.876222] pci 0000:17:00.0: no hotplug settings from platform
> [   26.877442] pci 0000:18:00.0: no hotplug settings from platform
> [   26.878650] pci 0000:19:00.0: no hotplug settings from platform
> [   26.879841] pci 0000:18:01.0: no hotplug settings from platform
> [   26.881025] pci 0000:1a:00.0: no hotplug settings from platform
> [   26.882189] pci 0000:18:02.0: no hotplug settings from platform
> [   26.883336] pci 0000:1b:00.0: no hotplug settings from platform
> [   26.884471] pci 0000:18:03.0: no hotplug settings from platform
> [   26.885597] pci 0000:18:04.0: no hotplug settings from platform
> [   26.886717] pci 0000:08:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> [   26.887831] pci 0000:08:00.0: setting latency timer to 64
> [   26.887840] pci 0000:0a:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> [   26.888944] pci 0000:0a:00.0: setting latency timer to 64
> [   26.888953] pci 0000:0a:03.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
> [   26.890045] pci 0000:0a:03.0: setting latency timer to 64
> [   26.890053] pci 0000:0a:04.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> [   26.891132] pci 0000:0a:04.0: setting latency timer to 64
> [   26.891142] pci 0000:14:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> [   26.892220] pci 0000:14:00.0: setting latency timer to 64
> [   26.892232] pci 0000:15:03.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
> [   26.893297] pci 0000:15:03.0: setting latency timer to 64
> [   26.893309] pci 0000:15:04.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> [   26.894377] pci 0000:15:04.0: setting latency timer to 64
> [   26.894391] pci 0000:17:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> [   26.895448] pci 0000:17:00.0: setting latency timer to 64
> [   26.895464] pci 0000:18:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> [   26.896493] pci 0000:18:00.0: setting latency timer to 64
> [   26.896509] pci 0000:18:01.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
> [   26.897510] pci 0000:18:01.0: setting latency timer to 64
> [   26.897526] pci 0000:18:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> [   26.898503] pci 0000:18:02.0: setting latency timer to 64
> [   26.898519] pci 0000:18:03.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
> [   26.899480] pci 0000:18:03.0: setting latency timer to 64
> [   26.899496] pci 0000:18:04.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> [   26.900432] pci 0000:18:04.0: setting latency timer to 64
> [   26.900504] pcieport 0000:08:00.0: setting latency timer to 64
> [   26.900569] pcieport 0000:08:00.0: irq 48 for MSI/MSI-X
> [   26.900738] pcieport 0000:0a:00.0: setting latency timer to 64
> [   26.900799] pcieport 0000:0a:00.0: irq 49 for MSI/MSI-X
> [   26.900959] pcieport 0000:0a:03.0: setting latency timer to 64
> [   26.901021] pcieport 0000:0a:03.0: irq 50 for MSI/MSI-X
> [   26.901180] pcieport 0000:0a:04.0: setting latency timer to 64
> [   26.901241] pcieport 0000:0a:04.0: irq 51 for MSI/MSI-X
> [   26.901425] pcieport 0000:14:00.0: setting latency timer to 64
> [   26.901526] pcieport 0000:14:00.0: irq 52 for MSI/MSI-X
> [   26.901742] pcieport 0000:15:03.0: setting latency timer to 64
> [   26.901845] pcieport 0000:15:03.0: irq 53 for MSI/MSI-X
> [   26.902113] pcieport 0000:15:04.0: setting latency timer to 64
> [   26.902224] pcieport 0000:15:04.0: irq 54 for MSI/MSI-X
> [   26.902446] vgaarb: device added: PCI:0000:16:00.0,decodes=io+mem,owns=none,locks=none
> [   26.903397] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=none:owns=io+mem
> [   26.904512] vgaarb: transferring owner from PCI:0000:00:02.0 to PCI:0000:16:00.0
> [   26.905754] pcieport 0000:17:00.0: setting latency timer to 64
> [   26.905901] pcieport 0000:17:00.0: irq 55 for MSI/MSI-X
> [   26.906263] pcieport 0000:18:00.0: setting latency timer to 64
> [   26.906415] pcieport 0000:18:00.0: irq 56 for MSI/MSI-X
> [   26.906753] pcieport 0000:18:01.0: setting latency timer to 64
> [   26.906900] pcieport 0000:18:01.0: irq 57 for MSI/MSI-X
> [   26.907205] pcieport 0000:18:02.0: setting latency timer to 64
> [   26.907349] pcieport 0000:18:02.0: irq 58 for MSI/MSI-X
> [   26.907666] pcieport 0000:18:03.0: setting latency timer to 64
> [   26.907819] pcieport 0000:18:03.0: irq 59 for MSI/MSI-X
> [   26.908174] pcieport 0000:18:04.0: setting latency timer to 64
> [   26.908323] pcieport 0000:18:04.0: irq 60 for MSI/MSI-X
> [   26.908631] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [   26.909687] r8169 0000:19:00.0: enabling device (0000 -> 0003)
> [   26.910678] r8169 0000:19:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> [   26.911866] r8169 0000:19:00.0: setting latency timer to 64
> [   26.912049] r8169 0000:19:00.0: irq 61 for MSI/MSI-X
> [   26.912467] r8169 0000:19:00.0: eth1: RTL8168evl/8111evl at 0xffffc90000c3e000, 54:42:49:97:a2:64, XID 0c900800 IRQ 61
> [   26.913617] r8169 0000:19:00.0: eth1: jumbo features [frames: 9200 bytes, tx checksumming: ko]
> [   26.914976] xhci_hcd 0000:1b:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> [   26.916313] xhci_hcd 0000:1b:00.0: controller already in use
> [   26.916351] xhci_hcd 0000:1b:00.0: PCI INT A disabled
> [   26.917766] xhci_hcd 0000:1b:00.0: init 0000:1b:00.0 fail, -16
> [   26.919149] xhci_hcd: probe of 0000:1b:00.0 failed with error -16
> [   26.920364] acpiphp: Slot [1-1] registered
> [   26.921538] acpiphp: Slot [2] registered
> [   26.922522] acpiphp: Slot [3] registered
> [   26.923541] acpiphp: Slot [1-2] registered
> [   26.924485] acpiphp_glue: sibling found, but _SUN doesn't match!
> [   26.925541] pata_marvell 0000:1a:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
> [   26.925604] acpiphp: Slot [1-3] registered
> [   26.925659] acpiphp: Slot [1-4] registered
> [   26.925710] acpiphp: Slot [1-5] registered
> [   26.929479] pata_marvell 0000:1a:00.0: setting latency timer to 64
> [   26.929983] scsi6 : pata_marvell
> [   26.931004] scsi7 : pata_marvell
> [   26.931981] ata7: PATA max UDMA/100 cmd 0x5010 ctl 0x5020 bmdma 0x5000 irq 19
> [   26.932980] ata8: PATA max UDMA/133 cmd 0x5018 ctl 0x5024 bmdma 0x5008 irq 19
> [   27.295886] ata8.00: ATAPI: Optiarc DVD RW AD-7690H, 1.70, max UDMA/100
> [   27.311893] ata8.00: configured for UDMA/100
> [   27.316989] scsi 7:0:0:0: CD-ROM            Optiarc  DVD RW AD-7690H  1.70 PQ: 0 ANSI: 5
> [   27.334382] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda caddy
> [   27.335401] cdrom: Uniform CD-ROM driver Revision: 3.20
> [   27.336636] sr 7:0:0:0: Attached scsi CD-ROM sr0

I can't help you with PCI hotplug/unplug or ACPI issues, so I hope the
folks on those mailing lists can figure it out.

Sarah Sharp

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sony-vaio-light-peak-usb3-nonworking1.txt"

025fe00000
[    0.000000]  0100000000 - 025fe00000 page 2M
[    0.000000] kernel direct mapping tables up to 25fe00000 @ 9ae34000-9ae3f000
[    0.000000] RAMDISK: 36efa000 - 37775000
[    0.000000] ACPI: RSDP 00000000000fe020 00024 (v02   Sony)
[    0.000000] ACPI: XSDT 000000009affe120 000A4 (v01   Sony     VAIO 20110616      01000013)
[    0.000000] ACPI: FACP 000000009affb000 000F4 (v04   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: DSDT 000000009afef000 085DF (v01   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: FACS 000000009af6e000 00040
[    0.000000] ACPI: TCPA 000000009affd000 00032 (v02   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: ASF! 000000009affc000 000A5 (v32   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: HPET 000000009affa000 00038 (v01   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: APIC 000000009aff9000 0008C (v02   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: MCFG 000000009aff8000 0003C (v01   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: SLIC 000000009afee000 00176 (v01   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: WDAT 000000009afed000 00224 (v01   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: SSDT 000000009afec000 00CA6 (v01   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: BOOT 000000009afea000 00028 (v01   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: SSDT 000000009afe8000 0022B (v01   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: ASPT 000000009afe5000 00034 (v07   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: SSDT 000000009afe4000 00804 (v01   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: SSDT 000000009afe3000 00996 (v01   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: SSDT 000000009afe2000 00EE8 (v01   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: SSDT 000000009afe1000 002DD (v01   Sony     VAIO 20110616 ACPI 00040000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000025fe00000
[    0.000000] Initmem setup node 0 0000000000000000-000000025fe00000
[    0.000000]   NODE_DATA [000000025fdfb000 - 000000025fdfffff]
[    0.000000]  [ffffea0000000000-ffffea00085fffff] PMD -> [ffff880257400000-ffff88025e5fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x0025fe00
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x00000092
[    0.000000]     0: 0x00000100 -> 0x0009ae3f
[    0.000000]     0: 0x0009afff -> 0x0009b000
[    0.000000]     0: 0x00100000 -> 0x0025fe00
[    0.000000] On node 0 totalpages: 2075586
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3909 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 616056 pages, LIFO batch:31
[    0.000000]   Normal zone: 19705 pages used for memmap
[    0.000000]   Normal zone: 1421575 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x00] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x00] disabled)
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 0000000000092000 - 0000000000093000
[    0.000000] PM: Registered nosave memory: 0000000000093000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 000000009ae3f000 - 000000009aebf000
[    0.000000] PM: Registered nosave memory: 000000009aebf000 - 000000009afbf000
[    0.000000] PM: Registered nosave memory: 000000009afbf000 - 000000009afff000
[    0.000000] PM: Registered nosave memory: 000000009b000000 - 000000009fa00000
[    0.000000] PM: Registered nosave memory: 000000009fa00000 - 00000000e0000000
[    0.000000] PM: Registered nosave memory: 00000000e0000000 - 00000000f0000000
[    0.000000] PM: Registered nosave memory: 00000000f0000000 - 00000000feb00000
[    0.000000] PM: Registered nosave memory: 00000000feb00000 - 00000000feb04000
[    0.000000] PM: Registered nosave memory: 00000000feb04000 - 00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fed10000
[    0.000000] PM: Registered nosave memory: 00000000fed10000 - 00000000fed1a000
[    0.000000] PM: Registered nosave memory: 00000000fed1a000 - 00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000ffd80000
[    0.000000] PM: Registered nosave memory: 00000000ffd80000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at 9fa00000 (gap: 9fa00000:40600000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88025fa00000 s82048 r8192 d24448 u262144
[    0.000000] pcpu-alloc: s82048 r8192 d24448 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2041540
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.2.0-rc5 root=UUID=a68d325e-11bf-426b-81fc-b2d3855e4eb0 ro single
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave/xrstor: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 8101508k/9959424k available (3184k kernel code, 1657080k absent, 200836k reserved, 3521k data, 556k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:33024 nr_irqs:744 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 67108864 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.004000] Detected 2693.729 MHz processor.
[    0.000002] Calibrating delay loop (skipped), value calculated using timer frequency.. 5387.45 BogoMIPS (lpj=10774916)
[    0.000120] pid_max: default: 32768 minimum: 301
[    0.000211] Security Framework initialized
[    0.000874] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.002488] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.003187] Mount-cache hash table entries: 256
[    0.003341] Initializing cgroup subsys cpuacct
[    0.003400] Initializing cgroup subsys memory
[    0.003466] Initializing cgroup subsys devices
[    0.003524] Initializing cgroup subsys freezer
[    0.003582] Initializing cgroup subsys net_cls
[    0.003640] Initializing cgroup subsys blkio
[    0.003721] CPU: Physical Processor ID: 0
[    0.003778] CPU: Processor Core ID: 0
[    0.003838] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.003838] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.003959] mce: CPU supports 7 MCE banks
[    0.004025] CPU0: Thermal monitoring enabled (TM1)
[    0.004087] using mwait in idle threads.
[    0.004556] ACPI: Core revision 20110623
[    0.022993] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.062721] CPU0: Intel(R) Core(TM) i7-2620M CPU @ 2.70GHz stepping 07
[    0.168219] Performance Events: PEBS fmt1+, SandyBridge events, Intel PMU driver.
[    0.168410] PEBS disabled due to CPU errata.
[    0.168469] ... version:                3
[    0.168526] ... bit width:              48
[    0.168582] ... generic registers:      4
[    0.168638] ... value mask:             0000ffffffffffff
[    0.168696] ... max period:             000000007fffffff
[    0.168754] ... fixed-purpose events:   3
[    0.168810] ... event mask:             000000070000000f
[    0.168989] NMI watchdog enabled, takes one hw-pmu counter.
[    0.169129] Booting Node   0, Processors  #1
[    0.169213] smpboot cpu 1: start_ip = 8d000
[    0.280240] NMI watchdog enabled, takes one hw-pmu counter.
[    0.280388]  #2
[    0.280431] smpboot cpu 2: start_ip = 8d000
[    0.388197] NMI watchdog enabled, takes one hw-pmu counter.
[    0.388341]  #3
[    0.388382] smpboot cpu 3: start_ip = 8d000
[    0.496249] NMI watchdog enabled, takes one hw-pmu counter.
[    0.496331] Brought up 4 CPUs
[    0.496386] Total of 4 processors activated (21549.97 BogoMIPS).
[    0.499960] devtmpfs: initialized
[    0.502814] PM: Registering ACPI NVS region at 9aebf000 (1048576 bytes)
[    0.503020] NET: Registered protocol family 16
[    0.503167] ACPI: bus type pci registered
[    0.503291] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.504688] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.521449] PCI: Using configuration type 1 for base access
[    0.522090] bio: create slab <bio-0> at 0
[    0.522220] ACPI: Added _OSI(Module Device)
[    0.522277] ACPI: Added _OSI(Processor Device)
[    0.522334] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.522392] ACPI: Added _OSI(Processor Aggregator Device)
[    0.523615] ACPI: EC: Look up EC in DSDT
[    0.524758] ACPI: Executed 1 blocks of module-level executable AML code
[    0.536182] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.544667] ACPI: SSDT 000000009ae70718 0067C (v01   Sony     VAIO 20110616 INTL 20100121)
[    0.545135] ACPI: Dynamic OEM Table Load:
[    0.545270] ACPI: SSDT           (null) 0067C (v01   Sony     VAIO 20110616 INTL 20100121)
[    0.556453] ACPI: SSDT 000000009ae71a98 00303 (v01   Sony     VAIO 20110616 INTL 20100121)
[    0.556961] ACPI: Dynamic OEM Table Load:
[    0.557094] ACPI: SSDT           (null) 00303 (v01   Sony     VAIO 20110616 INTL 20100121)
[    0.568284] ACPI: SSDT 000000009ae6fd98 00119 (v01   Sony     VAIO 20110616 INTL 20100121)
[    0.568737] ACPI: Dynamic OEM Table Load:
[    0.568871] ACPI: SSDT           (null) 00119 (v01   Sony     VAIO 20110616 INTL 20100121)
[    0.992224] ACPI: Interpreter enabled
[    0.992283] ACPI: (supports S0 S3 S4 S5)
[    0.992516] ACPI: Using IOAPIC for interrupt routing
[    1.008952] ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
[    1.009781] ACPI: ACPI Dock Station Driver: 1 docks/bays found
[    1.009841] HEST: Table not found.
[    1.009898] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.010335] \_SB_.PCI0:_OSC invalid UUID
[    1.010336] _OSC request data:1 8 1f 
[    1.010339] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    1.011027] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    1.011088] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    1.011149] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    1.011222] pci_root PNP0A08:00: host bridge window [mem 0x9fa00000-0xfeafffff]
[    1.011303] pci 0000:00:00.0: [8086:0104] type 0 class 0x000600
[    1.011333] pci 0000:00:02.0: [8086:0126] type 0 class 0x000300
[    1.011342] pci 0000:00:02.0: reg 10: [mem 0xd0000000-0xd03fffff 64bit]
[    1.011347] pci 0000:00:02.0: reg 18: [mem 0xa0000000-0xafffffff 64bit pref]
[    1.011351] pci 0000:00:02.0: reg 20: [io  0xa000-0xa03f]
[    1.011397] pci 0000:00:16.0: [8086:1c3a] type 0 class 0x000780
[    1.011419] pci 0000:00:16.0: reg 10: [mem 0xd9404000-0xd940400f 64bit]
[    1.011480] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.011484] pci 0000:00:16.0: PME# disabled
[    1.011515] pci 0000:00:1a.0: [8086:1c2d] type 0 class 0x000c03
[    1.011817] pci 0000:00:1a.0: reg 10: [mem 0xd9409000-0xd94093ff]
[    1.013557] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.013562] pci 0000:00:1a.0: PME# disabled
[    1.013586] pci 0000:00:1b.0: [8086:1c20] type 0 class 0x000403
[    1.013601] pci 0000:00:1b.0: reg 10: [mem 0xd9400000-0xd9403fff 64bit]
[    1.013655] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.013659] pci 0000:00:1b.0: PME# disabled
[    1.013680] pci 0000:00:1c.0: [8086:1c10] type 1 class 0x000604
[    1.013740] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.013744] pci 0000:00:1c.0: PME# disabled
[    1.013768] pci 0000:00:1c.1: [8086:1c12] type 1 class 0x000604
[    1.013828] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.013832] pci 0000:00:1c.1: PME# disabled
[    1.013855] pci 0000:00:1c.2: [8086:1c14] type 1 class 0x000604
[    1.013915] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    1.013919] pci 0000:00:1c.2: PME# disabled
[    1.013942] pci 0000:00:1c.3: [8086:1c16] type 1 class 0x000604
[    1.014002] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    1.014006] pci 0000:00:1c.3: PME# disabled
[    1.014036] pci 0000:00:1c.6: [8086:1c1c] type 1 class 0x000604
[    1.014138] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    1.014143] pci 0000:00:1c.6: PME# disabled
[    1.014179] pci 0000:00:1d.0: [8086:1c26] type 0 class 0x000c03
[    1.014475] pci 0000:00:1d.0: reg 10: [mem 0xd9408000-0xd94083ff]
[    1.016216] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.016220] pci 0000:00:1d.0: PME# disabled
[    1.016245] pci 0000:00:1f.0: [8086:1c4b] type 0 class 0x000601
[    1.016357] pci 0000:00:1f.2: [8086:282a] type 0 class 0x000104
[    1.016375] pci 0000:00:1f.2: reg 10: [io  0xa088-0xa08f]
[    1.016382] pci 0000:00:1f.2: reg 14: [io  0xa094-0xa097]
[    1.016390] pci 0000:00:1f.2: reg 18: [io  0xa080-0xa087]
[    1.016398] pci 0000:00:1f.2: reg 1c: [io  0xa090-0xa093]
[    1.016406] pci 0000:00:1f.2: reg 20: [io  0xa060-0xa07f]
[    1.016414] pci 0000:00:1f.2: reg 24: [mem 0xd9407000-0xd94077ff]
[    1.016445] pci 0000:00:1f.2: PME# supported from D3hot
[    1.016449] pci 0000:00:1f.2: PME# disabled
[    1.016467] pci 0000:00:1f.3: [8086:1c22] type 0 class 0x000c05
[    1.016481] pci 0000:00:1f.3: reg 10: [mem 0xd9405000-0xd94050ff 64bit]
[    1.016502] pci 0000:00:1f.3: reg 20: [io  0xa040-0xa05f]
[    1.016728] pci 0000:02:00.0: [8086:0091] type 0 class 0x000280
[    1.016875] pci 0000:02:00.0: reg 10: [mem 0xd8400000-0xd8401fff 64bit]
[    1.017445] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    1.017479] pci 0000:02:00.0: PME# disabled
[    1.024053] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    1.024113] pci 0000:00:1c.0:   bridge window [io  0x9000-0x9fff]
[    1.024117] pci 0000:00:1c.0:   bridge window [mem 0xd8400000-0xd93fffff]
[    1.024124] pci 0000:00:1c.0:   bridge window [mem 0xd0400000-0xd13fffff 64bit pref]
[    1.024191] pci 0000:03:00.0: [10ec:5209] type 0 class 0x00ff00
[    1.024212] pci 0000:03:00.0: reg 10: [mem 0xd7400000-0xd7400fff]
[    1.024338] pci 0000:03:00.0: supports D1 D2
[    1.024339] pci 0000:03:00.0: PME# supported from D1 D2 D3hot
[    1.024344] pci 0000:03:00.0: PME# disabled
[    1.031930] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    1.032021] pci 0000:00:1c.1:   bridge window [io  0x8000-0x8fff]
[    1.032035] pci 0000:00:1c.1:   bridge window [mem 0xd7400000-0xd83fffff]
[    1.032042] pci 0000:00:1c.1:   bridge window [mem 0xd1400000-0xd23fffff 64bit pref]
[    1.032158] pci 0000:04:00.0: [1033:0194] type 0 class 0x000c03
[    1.032184] pci 0000:04:00.0: reg 10: [mem 0xd6400000-0xd6401fff 64bit]
[    1.032289] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    1.032294] pci 0000:04:00.0: PME# disabled
[    1.039974] pci 0000:00:1c.2: PCI bridge to [bus 04-04]
[    1.040062] pci 0000:00:1c.2:   bridge window [io  0x7000-0x7fff]
[    1.040066] pci 0000:00:1c.2:   bridge window [mem 0xd6400000-0xd73fffff]
[    1.040072] pci 0000:00:1c.2:   bridge window [mem 0xd2400000-0xd33fffff 64bit pref]
[    1.040196] pci 0000:05:00.0: [10ec:8168] type 0 class 0x000200
[    1.040263] pci 0000:05:00.0: reg 10: [io  0x6000-0x60ff]
[    1.040382] pci 0000:05:00.0: reg 18: [mem 0xd3404000-0xd3404fff 64bit pref]
[    1.040450] pci 0000:05:00.0: reg 20: [mem 0xd3400000-0xd3403fff 64bit pref]
[    1.040662] pci 0000:05:00.0: supports D1 D2
[    1.040663] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.040678] pci 0000:05:00.0: PME# disabled
[    1.047959] pci 0000:00:1c.3: PCI bridge to [bus 05-05]
[    1.048049] pci 0000:00:1c.3:   bridge window [io  0x6000-0x6fff]
[    1.048053] pci 0000:00:1c.3:   bridge window [mem 0xd5400000-0xd63fffff]
[    1.048059] pci 0000:00:1c.3:   bridge window [mem 0xd3400000-0xd43fffff 64bit pref]
[    1.048132] pci 0000:00:1c.6: PCI bridge to [bus 08-20]
[    1.048193] pci 0000:00:1c.6:   bridge window [io  0x3000-0x5fff]
[    1.048199] pci 0000:00:1c.6:   bridge window [mem 0xb0000000-0xcfffffff]
[    1.048208] pci 0000:00:1c.6:   bridge window [mem 0xd4400000-0xd53fffff 64bit pref]
[    1.048235] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.048336] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
[    1.048376] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
[    1.048414] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
[    1.048452] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
[    1.048491] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP07._PRT]
[    1.048582] \_SB_.PCI0:_OSC invalid UUID
[    1.048583] _OSC request data:1 1f 1f 
[    1.048586]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    1.048680] \_SB_.PCI0:_OSC invalid UUID
[    1.048681] _OSC request data:1 0 1d 
[    1.048684]  pci0000:00: ACPI _OSC request failed (AE_ERROR), returned control mask: 0x1d
[    1.048758] ACPI _OSC control for PCIe not granted, disabling ASPM
[    1.051940] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 10 11 12 14 15) *7
[    1.052564] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 10 *11 12 14 15)
[    1.053135] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 10 *11 12 14 15)
[    1.053705] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 *10 11 12 14 15)
[    1.054276] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 10 11 12 14 15) *7
[    1.054895] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 10 11 12 14 15) *0, disabled.
[    1.055555] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 *10 11 12 14 15)
[    1.056129] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 *10 11 12 14 15)
[    1.056733] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    1.056813] vgaarb: loaded
[    1.056867] vgaarb: bridge control possible 0000:00:02.0
[    1.056955] PCI: Using ACPI for IRQ routing
[    1.063967] PCI: pci_cache_line_size set to 64 bytes
[    1.064147] reserve RAM buffer: 0000000000092400 - 000000000009ffff 
[    1.064150] reserve RAM buffer: 000000009ae3f000 - 000000009bffffff 
[    1.064152] reserve RAM buffer: 000000009b000000 - 000000009bffffff 
[    1.064154] reserve RAM buffer: 000000025fe00000 - 000000025fffffff 
[    1.064244] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.064653] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.066725] Switching to clocksource hpet
[    1.068288] pnp: PnP ACPI init
[    1.068354] ACPI: bus type pnp registered
[    1.068730] pnp 00:00: [bus 00-fe]
[    1.068732] pnp 00:00: [io  0x0000-0x0cf7 window]
[    1.068734] pnp 00:00: [io  0x0cf8-0x0cff]
[    1.068735] pnp 00:00: [io  0x0d00-0xffff window]
[    1.068737] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    1.068739] pnp 00:00: [mem 0x000c0000-0x000c3fff window]
[    1.068740] pnp 00:00: [mem 0x000c4000-0x000c7fff window]
[    1.068742] pnp 00:00: [mem 0x000c8000-0x000cbfff window]
[    1.068744] pnp 00:00: [mem 0x000cc000-0x000cffff window]
[    1.068745] pnp 00:00: [mem 0x000d0000-0x000d3fff window]
[    1.068747] pnp 00:00: [mem 0x000d4000-0x000d7fff window]
[    1.068748] pnp 00:00: [mem 0x000d8000-0x000dbfff window]
[    1.068750] pnp 00:00: [mem 0x000dc000-0x000dffff window]
[    1.068751] pnp 00:00: [mem 0x000e0000-0x000e3fff window]
[    1.068753] pnp 00:00: [mem 0x000e4000-0x000e7fff window]
[    1.068755] pnp 00:00: [mem 0x000e8000-0x000ebfff window]
[    1.068756] pnp 00:00: [mem 0x000ec000-0x000effff window]
[    1.068758] pnp 00:00: [mem 0x000f0000-0x000fffff window]
[    1.068760] pnp 00:00: [mem 0x9fa00000-0xfeafffff window]
[    1.068803] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    1.068871] pnp 00:01: [io  0x0000-0x001f]
[    1.068872] pnp 00:01: [io  0x0081-0x0091]
[    1.068873] pnp 00:01: [io  0x0093-0x009f]
[    1.068875] pnp 00:01: [io  0x00c0-0x00df]
[    1.068876] pnp 00:01: [dma 4]
[    1.068897] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    1.068905] pnp 00:02: [mem 0xff000000-0xffffffff]
[    1.068923] pnp 00:02: Plug and Play ACPI device, IDs INT0800 (active)
[    1.068992] pnp 00:03: [mem 0xfed00000-0xfed003ff]
[    1.069012] pnp 00:03: Plug and Play ACPI device, IDs PNP0103 (active)
[    1.069021] pnp 00:04: [io  0x00f0]
[    1.069028] pnp 00:04: [irq 13]
[    1.069047] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
[    1.069057] pnp 00:05: [io  0x002e-0x002f]
[    1.069059] pnp 00:05: [io  0x004e-0x004f]
[    1.069060] pnp 00:05: [io  0x0061]
[    1.069061] pnp 00:05: [io  0x0063]
[    1.069063] pnp 00:05: [io  0x0065]
[    1.069064] pnp 00:05: [io  0x0067]
[    1.069065] pnp 00:05: [io  0x0070]
[    1.069066] pnp 00:05: [io  0x0080]
[    1.069068] pnp 00:05: [io  0x0092]
[    1.069069] pnp 00:05: [io  0x00b2-0x00b3]
[    1.069070] pnp 00:05: [io  0x0680-0x069f]
[    1.069072] pnp 00:05: [io  0x1000-0x100f]
[    1.069073] pnp 00:05: [io  0xffff]
[    1.069074] pnp 00:05: [io  0xffff]
[    1.069075] pnp 00:05: [io  0x0400-0x0453]
[    1.069077] pnp 00:05: [io  0x0458-0x047f]
[    1.069078] pnp 00:05: [io  0x0500-0x057f]
[    1.069079] pnp 00:05: [io  0x164e-0x164f]
[    1.069081] pnp 00:05: [io  0x2000]
[    1.069082] pnp 00:05: [io  0x2004]
[    1.069121] system 00:05: [io  0x0680-0x069f] has been reserved
[    1.069182] system 00:05: [io  0x1000-0x100f] has been reserved
[    1.069242] system 00:05: [io  0xffff] has been reserved
[    1.069301] system 00:05: [io  0xffff] has been reserved
[    1.069360] system 00:05: [io  0x0400-0x0453] has been reserved
[    1.069420] system 00:05: [io  0x0458-0x047f] has been reserved
[    1.069480] system 00:05: [io  0x0500-0x057f] has been reserved
[    1.069540] system 00:05: [io  0x164e-0x164f] has been reserved
[    1.069599] system 00:05: [io  0x2000] has been reserved
[    1.069658] system 00:05: [io  0x2004] has been reserved
[    1.069717] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.069725] pnp 00:06: [io  0x0070-0x0077]
[    1.069730] pnp 00:06: [irq 8]
[    1.069749] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.069768] pnp 00:07: [io  0x0454-0x0457]
[    1.069799] system 00:07: [io  0x0454-0x0457] has been reserved
[    1.069859] system 00:07: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    1.069872] pnp 00:08: [io  0x0060]
[    1.069873] pnp 00:08: [io  0x0064]
[    1.069877] pnp 00:08: [irq 1]
[    1.069898] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.069913] pnp 00:09: [irq 12]
[    1.069934] pnp 00:09: Plug and Play ACPI device, IDs SNY9015 PNP0f13 (active)
[    1.069956] pnp 00:0a: [mem 0xfed40000-0xfed44fff]
[    1.069977] pnp 00:0a: Plug and Play ACPI device, IDs IFX0102 PNP0c31 (active)
[    1.070082] pnp 00:0b: [mem 0xfed1c000-0xfed1ffff]
[    1.070084] pnp 00:0b: [mem 0xfed10000-0xfed17fff]
[    1.070086] pnp 00:0b: [mem 0xfed18000-0xfed18fff]
[    1.070087] pnp 00:0b: [mem 0xfed19000-0xfed19fff]
[    1.070088] pnp 00:0b: [mem 0xe0000000-0xefffffff]
[    1.070090] pnp 00:0b: [mem 0xfed20000-0xfed3ffff]
[    1.070091] pnp 00:0b: [mem 0xfed90000-0xfed93fff]
[    1.070093] pnp 00:0b: [mem 0xff000000-0xffffffff]
[    1.070094] pnp 00:0b: [mem 0xfee00000-0xfeefffff]
[    1.070095] pnp 00:0b: [mem 0x9fa00000-0x9fa00fff]
[    1.070132] system 00:0b: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.070193] system 00:0b: [mem 0xfed10000-0xfed17fff] has been reserved
[    1.070254] system 00:0b: [mem 0xfed18000-0xfed18fff] has been reserved
[    1.070315] system 00:0b: [mem 0xfed19000-0xfed19fff] has been reserved
[    1.070377] system 00:0b: [mem 0xe0000000-0xefffffff] has been reserved
[    1.070438] system 00:0b: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.070499] system 00:0b: [mem 0xfed90000-0xfed93fff] has been reserved
[    1.070559] system 00:0b: [mem 0xff000000-0xffffffff] could not be reserved
[    1.070621] system 00:0b: [mem 0xfee00000-0xfeefffff] could not be reserved
[    1.070683] system 00:0b: [mem 0x9fa00000-0x9fa00fff] has been reserved
[    1.070751] system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.071283] pnp 00:0c: [mem 0x20000000-0x201fffff]
[    1.071285] pnp 00:0c: [mem 0x40000000-0x401fffff]
[    1.071337] system 00:0c: [mem 0x20000000-0x201fffff] could not be reserved
[    1.071400] system 00:0c: [mem 0x40000000-0x401fffff] could not be reserved
[    1.071462] system 00:0c: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.071477] pnp: PnP ACPI: found 13 devices
[    1.071533] ACPI: ACPI bus type pnp unregistered
[    1.078100] PCI: max bus depth: 1 pci_try_num: 2
[    1.078140] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    1.078200] pci 0000:00:1c.0:   bridge window [io  0x9000-0x9fff]
[    1.078263] pci 0000:00:1c.0:   bridge window [mem 0xd8400000-0xd93fffff]
[    1.078326] pci 0000:00:1c.0:   bridge window [mem 0xd0400000-0xd13fffff 64bit pref]
[    1.078404] pci 0000:00:1c.1: PCI bridge to [bus 03-03]
[    1.078464] pci 0000:00:1c.1:   bridge window [io  0x8000-0x8fff]
[    1.078526] pci 0000:00:1c.1:   bridge window [mem 0xd7400000-0xd83fffff]
[    1.078589] pci 0000:00:1c.1:   bridge window [mem 0xd1400000-0xd23fffff 64bit pref]
[    1.078667] pci 0000:00:1c.2: PCI bridge to [bus 04-04]
[    1.078726] pci 0000:00:1c.2:   bridge window [io  0x7000-0x7fff]
[    1.078795] pci 0000:00:1c.2:   bridge window [mem 0xd6400000-0xd73fffff]
[    1.078858] pci 0000:00:1c.2:   bridge window [mem 0xd2400000-0xd33fffff 64bit pref]
[    1.078935] pci 0000:00:1c.3: PCI bridge to [bus 05-05]
[    1.078994] pci 0000:00:1c.3:   bridge window [io  0x6000-0x6fff]
[    1.079057] pci 0000:00:1c.3:   bridge window [mem 0xd5400000-0xd63fffff]
[    1.079119] pci 0000:00:1c.3:   bridge window [mem 0xd3400000-0xd43fffff 64bit pref]
[    1.079196] pci 0000:00:1c.6: PCI bridge to [bus 08-20]
[    1.079256] pci 0000:00:1c.6:   bridge window [io  0x3000-0x5fff]
[    1.079320] pci 0000:00:1c.6:   bridge window [mem 0xb0000000-0xcfffffff]
[    1.079384] pci 0000:00:1c.6:   bridge window [mem 0xd4400000-0xd53fffff 64bit pref]
[    1.079475] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.079539] pci 0000:00:1c.0: setting latency timer to 64
[    1.079548] pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    1.079610] pci 0000:00:1c.1: setting latency timer to 64
[    1.079619] pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    1.079682] pci 0000:00:1c.2: setting latency timer to 64
[    1.079691] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    1.079755] pci 0000:00:1c.3: setting latency timer to 64
[    1.079761] pci 0000:00:1c.6: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    1.079826] pci 0000:00:1c.6: setting latency timer to 64
[    1.079830] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    1.079831] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    1.079833] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    1.079834] pci_bus 0000:00: resource 7 [mem 0x9fa00000-0xfeafffff]
[    1.079836] pci_bus 0000:02: resource 0 [io  0x9000-0x9fff]
[    1.079837] pci_bus 0000:02: resource 1 [mem 0xd8400000-0xd93fffff]
[    1.079839] pci_bus 0000:02: resource 2 [mem 0xd0400000-0xd13fffff 64bit pref]
[    1.079841] pci_bus 0000:03: resource 0 [io  0x8000-0x8fff]
[    1.079842] pci_bus 0000:03: resource 1 [mem 0xd7400000-0xd83fffff]
[    1.079844] pci_bus 0000:03: resource 2 [mem 0xd1400000-0xd23fffff 64bit pref]
[    1.079845] pci_bus 0000:04: resource 0 [io  0x7000-0x7fff]
[    1.079847] pci_bus 0000:04: resource 1 [mem 0xd6400000-0xd73fffff]
[    1.079848] pci_bus 0000:04: resource 2 [mem 0xd2400000-0xd33fffff 64bit pref]
[    1.079850] pci_bus 0000:05: resource 0 [io  0x6000-0x6fff]
[    1.079851] pci_bus 0000:05: resource 1 [mem 0xd5400000-0xd63fffff]
[    1.079853] pci_bus 0000:05: resource 2 [mem 0xd3400000-0xd43fffff 64bit pref]
[    1.079854] pci_bus 0000:08: resource 0 [io  0x3000-0x5fff]
[    1.079856] pci_bus 0000:08: resource 1 [mem 0xb0000000-0xcfffffff]
[    1.079857] pci_bus 0000:08: resource 2 [mem 0xd4400000-0xd53fffff 64bit pref]
[    1.079916] NET: Registered protocol family 2
[    1.080170] IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    1.081098] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    1.082283] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.082462] TCP: Hash tables configured (established 524288 bind 65536)
[    1.082523] TCP reno registered
[    1.082591] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    1.082681] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    1.082864] NET: Registered protocol family 1
[    1.082932] pci 0000:00:02.0: Boot video device
[    1.082952] pci 0000:00:1a.0: EHCI: BIOS handoff
[    1.098826] pci 0000:00:1d.0: EHCI: BIOS handoff
[    1.126525] PCI: CLS 64 bytes, default 64
[    1.126561] Unpacking initramfs...
[    1.274878] Freeing initrd memory: 8684k freed
[    1.275833] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.275898] Placing 64MB software IO TLB between ffff880096e34000 - ffff88009ae34000
[    1.275971] software IO TLB at phys 0x96e34000 - 0x9ae34000
[    1.276043] Simple Boot Flag at 0x44 set to 0x1
[    1.276545] audit: initializing netlink socket (disabled)
[    1.276611] type=2000 audit(1323965067.112:1): initialized
[    1.295106] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.310314] VFS: Disk quotas dquot_6.5.2
[    1.310398] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.310518] msgmni has been set to 15840
[    1.310703] alg: No test for stdrng (krng)
[    1.310787] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    1.310861] io scheduler noop registered
[    1.310916] io scheduler deadline registered
[    1.310989] io scheduler cfq registered (default)
[    1.311359] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.311418] cpcihp_zt5550: ZT5550 CompactPCI Hot Plug Driver version: 0.2
[    1.311491] cpcihp_generic: Generic port I/O CompactPCI Hot Plug Driver version: 0.1
[    1.311564] cpcihp_generic: not configured, disabling.
[    1.311635] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.311697] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    1.311971] acpiphp: Slot [1] registered
[    1.313855] acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
[    1.314017] intel_idle: MWAIT substates: 0x21120
[    1.314018] intel_idle: v0.4 model 0x2A
[    1.314019] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.314057] ERST: Table is not found!
[    1.314113] GHES: HEST is not enabled!
[    1.314219] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.491025] Linux agpgart interface v0.103
[    1.491149] agpgart-intel 0000:00:00.0: Intel Sandybridge Chipset
[    1.491261] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K total, 262144K mappable
[    1.492296] agpgart-intel 0000:00:00.0: detected 65536K stolen memory
[    1.492454] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xa0000000
[    1.492607] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    1.494871] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.494934] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.495097] mousedev: PS/2 mouse device common for all mice
[    1.495183] rtc_cmos 00:06: RTC can wake from S4
[    1.495342] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    1.496747] rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    1.496937] cpuidle: using governor ladder
[    1.497181] cpuidle: using governor menu
[    1.497364] TCP cubic registered
[    1.497506] NET: Registered protocol family 10
[    1.497971] Mobile IPv6
[    1.498025] NET: Registered protocol family 17
[    1.498083] Registering the dns_resolver key type
[    1.498285] PM: Hibernation image not present or could not be loaded.
[    1.498294] registered taskstats version 1
[    1.506283] rtc_cmos 00:06: setting system clock to 2011-12-15 16:04:28 UTC (1323965068)
[    1.506411] Initializing network drop monitor service
[    1.507295] Freeing unused kernel memory: 556k freed
[    1.507403] Write protecting the kernel read-only data: 6144k
[    1.510098] Freeing unused kernel memory: 896k freed
[    1.512495] Freeing unused kernel memory: 800k freed
[    1.520273] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.522190] udevd[58]: starting version 175
[    1.538187] thermal LNXTHERM:00: registered as thermal_zone0
[    1.538255] ACPI: Thermal Zone [TZ01] (66 C)
[    1.553323] SCSI subsystem initialized
[    1.557134] libata version 3.00 loaded.
[    1.558414] ahci 0000:00:1f.2: version 3.0
[    1.558437] ahci 0000:00:1f.2: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[    1.558554] ahci 0000:00:1f.2: irq 40 for MSI/MSI-X
[    1.558626] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3 impl RAID mode
[    1.558708] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part apst 
[    1.558788] ahci 0000:00:1f.2: setting latency timer to 64
[    1.559493] scsi0 : ahci
[    1.559711] scsi1 : ahci
[    1.559842] scsi2 : ahci
[    1.559983] scsi3 : ahci
[    1.560117] scsi4 : ahci
[    1.560259] scsi5 : ahci
[    1.560750] ata1: SATA max UDMA/133 abar m2048@0xd9407000 port 0xd9407100 irq 40
[    1.560832] ata2: SATA max UDMA/133 abar m2048@0xd9407000 port 0xd9407180 irq 40
[    1.560908] ata3: DUMMY
[    1.560967] ata4: DUMMY
[    1.561025] ata5: DUMMY
[    1.561084] ata6: DUMMY
[    1.878608] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.878709] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.879451] ata1.00: ATA-8: SAMSUNG MZRPC256HADR-000SO, CXM03S1Q, max UDMA/133
[    1.879526] ata1.00: 250069680 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.879782] ata2.00: ATA-8: SAMSUNG MZRPC256HADR-000SO, CXM03S1Q, max UDMA/133
[    1.879866] ata2.00: 250069680 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.880177] ata1.00: configured for UDMA/133
[    1.880333] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG MZRPC256 CXM0 PQ: 0 ANSI: 5
[    1.880408] ata2.00: configured for UDMA/133
[    1.880840] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG MZRPC256 CXM0 PQ: 0 ANSI: 5
[    1.884636] sd 0:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
[    1.884668] sd 1:0:0:0: [sdb] 250069680 512-byte logical blocks: (128 GB/119 GiB)
[    1.884709] sd 1:0:0:0: [sdb] Write Protect is off
[    1.884711] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.884723] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.884977] sd 0:0:0:0: [sda] Write Protect is off
[    1.885038] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.885052] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.885221]  sdb: unknown partition table
[    1.885428]  sda: unknown partition table
[    1.885450] sd 1:0:0:0: [sdb] Attached SCSI disk
[    1.885755] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.894346] device-mapper: uevent: version 1.0.3
[    1.894492] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initialised: dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    2.274453] Refined TSC clocksource calibration: 2693.885 MHz.
[    2.274545] Switching to clocksource tsc
[    2.443069] EXT4-fs (dm-4): INFO: recovery required on readonly filesystem
[    2.443134] EXT4-fs (dm-4): write access will be enabled during recovery
[    2.447091] EXT4-fs (dm-4): recovery complete
[    2.519347] EXT4-fs (dm-4): mounted filesystem with ordered data mode. Opts: (null)
[    2.855474] udevd[362]: starting version 175
[    2.912505] ACPI: AC Adapter [ADP1] (off-line)
[    2.915520] input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
[    2.915638] ACPI: Lid Switch [LID0]
[    2.915750] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input2
[    2.915829] ACPI: Power Button [PWRB]
[    2.929833] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 22 (level, low) -> IRQ 22
[    2.929994] input: PC Speaker as /devices/platform/pcspkr/input/input3
[    3.049506] usbcore: registered new interface driver usbfs
[    3.049604] usbcore: registered new interface driver hub
[    3.049908] usbcore: registered new device driver usb
[    3.052203] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    3.052304] r8169 0000:05:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    3.052442] r8169 0000:05:00.0: setting latency timer to 64
[    3.052544] r8169 0000:05:00.0: irq 41 for MSI/MSI-X
[    3.052906] r8169 0000:05:00.0: eth0: RTL8168evl/8111evl at 0xffffc90000c7c000, 54:42:49:97:a2:8a, XID 0c900800 IRQ 41
[    3.053002] r8169 0000:05:00.0: eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    3.054739] ACPI: Battery Slot [BAT1] (battery present)
[    3.054889] ACPI: Battery Slot [BAT2] (battery absent)
[    3.058396] tpm_tis 00:0a: 1.2 TPM (device-id 0xB, rev-id 16)
[    3.060866] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.060928] ehci_hcd: block sizes: qh 112 qtd 96 itd 192 sitd 96
[    3.060960] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    3.061052] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    3.061057] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    3.061123] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    3.061224] ehci_hcd 0000:00:1a.0: reset hcs_params 0x200002 dbg=2 cc=0 pcc=0 ordered !ppc ports=2
[    3.061227] ehci_hcd 0000:00:1a.0: reset hcc_params 36881 caching frame 1024 64 bit addr
[    3.061256] ehci_hcd 0000:00:1a.0: support lpm
[    3.061271] ehci_hcd 0000:00:1a.0: debug port 2
[    3.061331] ehci_hcd 0000:00:1a.0: reset command 0080002 (park)=0 ithresh=8 period=1024 Reset HALT
[    3.065225] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    3.065228] ehci_hcd 0000:00:1a.0: supports USB remote wakeup
[    3.065377] ehci_hcd 0000:00:1a.0: irq 23, io mem 0xd9409000
[    3.065435] ehci_hcd 0000:00:1a.0: reset command 0080002 (park)=0 ithresh=8 period=1024 Reset HALT
[    3.069308] ehci_hcd 0000:00:1a.0: init command 0010001 (park)=0 ithresh=1 period=1024 RUN
[    3.074175] [drm] Initialized drm 1.1.0 20060810
[    3.079127] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    3.079222] usb usb1: default language 0x0409
[    3.079229] usb usb1: udev 1, busnum 1, minor = 0
[    3.079231] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.079293] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.079360] usb usb1: Product: EHCI Host Controller
[    3.079412] usb usb1: Manufacturer: Linux 3.2.0-rc5 ehci_hcd
[    3.079465] usb usb1: SerialNumber: 0000:00:1a.0
[    3.079770] usb usb1: usb_probe_device
[    3.079773] usb usb1: configuration #1 chosen from 1 choice
[    3.079779] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[    3.079802] hub 1-0:1.0: usb_probe_interface
[    3.079803] hub 1-0:1.0: usb_probe_interface - got id
[    3.079805] hub 1-0:1.0: USB hub found
[    3.079864] hub 1-0:1.0: 2 ports detected
[    3.079921] hub 1-0:1.0: standalone hub
[    3.079922] hub 1-0:1.0: no power switching (usb 1.0)
[    3.079923] hub 1-0:1.0: individual port over-current protection
[    3.079925] hub 1-0:1.0: power on to power good time: 20ms
[    3.079928] hub 1-0:1.0: local power source is good
[    3.079929] hub 1-0:1.0: trying to enable port power on non-switchable hub
[    3.080047] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    3.080127] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    3.080130] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    3.080185] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    3.080549] ehci_hcd 0000:00:1d.0: reset hcs_params 0x200002 dbg=2 cc=0 pcc=0 ordered !ppc ports=2
[    3.080553] ehci_hcd 0000:00:1d.0: reset hcc_params 36881 caching frame 1024 64 bit addr
[    3.080564] ehci_hcd 0000:00:1d.0: support lpm
[    3.080574] ehci_hcd 0000:00:1d.0: debug port 2
[    3.080634] ehci_hcd 0000:00:1d.0: reset command 0080002 (park)=0 ithresh=8 period=1024 Reset HALT
[    3.084505] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[    3.084507] ehci_hcd 0000:00:1d.0: supports USB remote wakeup
[    3.084973] ehci_hcd 0000:00:1d.0: irq 20, io mem 0xd9408000
[    3.085030] ehci_hcd 0000:00:1d.0: reset command 0080002 (park)=0 ithresh=8 period=1024 Reset HALT
[    3.088620] xhci_hcd 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    3.088727] xhci_hcd 0000:04:00.0: setting latency timer to 64
[    3.088731] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    3.088812] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus number 3
[    3.088927] ehci_hcd 0000:00:1d.0: init command 0010001 (park)=0 ithresh=1 period=1024 RUN
[    3.088952] xhci_hcd 0000:04:00.0: xHCI capability registers at ffffc90000c70000:
[    3.088956] xhci_hcd 0000:04:00.0: CAPLENGTH AND HCIVERSION 0x960020:
[    3.088957] xhci_hcd 0000:04:00.0: CAPLENGTH: 0x20
[    3.088959] xhci_hcd 0000:04:00.0: HCIVERSION: 0x96
[    3.088962] xhci_hcd 0000:04:00.0: HCSPARAMS 1: 0x4000820
[    3.088963] xhci_hcd 0000:04:00.0:   Max device slots: 32
[    3.088965] xhci_hcd 0000:04:00.0:   Max interrupters: 8
[    3.088966] xhci_hcd 0000:04:00.0:   Max ports: 4
[    3.088969] xhci_hcd 0000:04:00.0: HCSPARAMS 2: 0x11
[    3.088971] xhci_hcd 0000:04:00.0:   Isoc scheduling threshold: 1
[    3.088972] xhci_hcd 0000:04:00.0:   Maximum allowed segments in event ring: 1
[    3.088976] xhci_hcd 0000:04:00.0: HCSPARAMS 3 0x0:
[    3.088977] xhci_hcd 0000:04:00.0:   Worst case U1 device exit latency: 0
[    3.088979] xhci_hcd 0000:04:00.0:   Worst case U2 device exit latency: 0
[    3.088982] xhci_hcd 0000:04:00.0: HCC PARAMS 0x14042cb:
[    3.088984] xhci_hcd 0000:04:00.0:   HC generates 64 bit addresses
[    3.088985] xhci_hcd 0000:04:00.0:   FIXME: more HCCPARAMS debugging
[    3.088988] xhci_hcd 0000:04:00.0: RTSOFF 0x600:
[    3.088990] xhci_hcd 0000:04:00.0: xHCI operational registers at ffffc90000c70020:
[    3.088993] xhci_hcd 0000:04:00.0: USBCMD 0x0:
[    3.088995] xhci_hcd 0000:04:00.0:   HC is being stopped
[    3.088996] xhci_hcd 0000:04:00.0:   HC has finished hard reset
[    3.088997] xhci_hcd 0000:04:00.0:   Event Interrupts disabled
[    3.088999] xhci_hcd 0000:04:00.0:   Host System Error Interrupts disabled
[    3.089000] xhci_hcd 0000:04:00.0:   HC has finished light reset
[    3.089004] xhci_hcd 0000:04:00.0: USBSTS 0x1:
[    3.089005] xhci_hcd 0000:04:00.0:   Event ring is empty
[    3.089006] xhci_hcd 0000:04:00.0:   No Host System Error
[    3.089007] xhci_hcd 0000:04:00.0:   HC is halted
[    3.089011] xhci_hcd 0000:04:00.0: ffffc90000c70420 port status reg = 0x2a0
[    3.089015] xhci_hcd 0000:04:00.0: ffffc90000c70424 port power reg = 0x0
[    3.089019] xhci_hcd 0000:04:00.0: ffffc90000c70428 port link reg = 0x0
[    3.089023] xhci_hcd 0000:04:00.0: ffffc90000c7042c port reserved reg = 0x0
[    3.089027] xhci_hcd 0000:04:00.0: ffffc90000c70430 port status reg = 0x2a0
[    3.089030] xhci_hcd 0000:04:00.0: ffffc90000c70434 port power reg = 0x0
[    3.089034] xhci_hcd 0000:04:00.0: ffffc90000c70438 port link reg = 0x0
[    3.089038] xhci_hcd 0000:04:00.0: ffffc90000c7043c port reserved reg = 0x0
[    3.089042] xhci_hcd 0000:04:00.0: ffffc90000c70440 port status reg = 0x2a0
[    3.089045] xhci_hcd 0000:04:00.0: ffffc90000c70444 port power reg = 0x0
[    3.089049] xhci_hcd 0000:04:00.0: ffffc90000c70448 port link reg = 0x0
[    3.089052] xhci_hcd 0000:04:00.0: ffffc90000c7044c port reserved reg = 0x0
[    3.089056] xhci_hcd 0000:04:00.0: ffffc90000c70450 port status reg = 0x2a0
[    3.089059] xhci_hcd 0000:04:00.0: ffffc90000c70454 port power reg = 0x0
[    3.089063] xhci_hcd 0000:04:00.0: ffffc90000c70458 port link reg = 0x0
[    3.089066] xhci_hcd 0000:04:00.0: ffffc90000c7045c port reserved reg = 0x0
[    3.089068] xhci_hcd 0000:04:00.0: // Halt the HC
[    3.089075] xhci_hcd 0000:04:00.0: Resetting HCD
[    3.089078] xhci_hcd 0000:04:00.0: // Reset the HC
[    3.089125] xhci_hcd 0000:04:00.0: Wait for controller to be ready for doorbell rings
[    3.089128] xhci_hcd 0000:04:00.0: Reset complete
[    3.089131] xhci_hcd 0000:04:00.0: Enabling 64-bit DMA addresses.
[    3.089133] xhci_hcd 0000:04:00.0: Calling HCD init
[    3.089134] xhci_hcd 0000:04:00.0: xhci_init
[    3.089135] xhci_hcd 0000:04:00.0: xHCI doesn't need link TRB QUIRK
[    3.089139] xhci_hcd 0000:04:00.0: Supported page size register = 0x1
[    3.089140] xhci_hcd 0000:04:00.0: Supported page size of 4K
[    3.089142] xhci_hcd 0000:04:00.0: HCD page size set to 4K
[    3.089145] xhci_hcd 0000:04:00.0: // xHC can handle at most 32 device slots.
[    3.089149] xhci_hcd 0000:04:00.0: // Setting Max device slots reg = 0x20.
[    3.089153] xhci_hcd 0000:04:00.0: // Device context base array address = 0x37020000 (DMA), ffff880037020000 (virt)
[    3.089156] xhci_hcd 0000:04:00.0: Allocating ring at ffff88024f27c540
[    3.089158] xhci_hcd 0000:04:00.0: Allocating priv segment structure at ffff880250454c80
[    3.089161] xhci_hcd 0000:04:00.0: // Allocating segment at ffff880037021000 (virtual) 0x37021000 (DMA)
[    3.089163] xhci_hcd 0000:04:00.0: Linking segment 0x37021000 to segment 0x37021000 (DMA)
[    3.089164] xhci_hcd 0000:04:00.0: Wrote link toggle flag to segment ffff880250454c80 (virtual), 0x37021000 (DMA)
[    3.089166] xhci_hcd 0000:04:00.0: Allocated command ring at ffff88024f27c540
[    3.089168] xhci_hcd 0000:04:00.0: First segment DMA is 0x37021000
[    3.089173] xhci_hcd 0000:04:00.0: // Setting command ring address to 0x20
[    3.089179] xhci_hcd 0000:04:00.0: // xHC command ring deq ptr low bits + flags = @00000000
[    3.089180] xhci_hcd 0000:04:00.0: // xHC command ring deq ptr high bits = @00000000
[    3.089184] xhci_hcd 0000:04:00.0: // Doorbell array is located at offset 0x800 from cap regs base addr
[    3.089186] xhci_hcd 0000:04:00.0: // xHCI capability registers at ffffc90000c70000:
[    3.089190] xhci_hcd 0000:04:00.0: // @ffffc90000c70000 = 0x960020 (CAPLENGTH AND HCIVERSION)
[    3.089191] xhci_hcd 0000:04:00.0: //   CAPLENGTH: 0x20
[    3.089193] xhci_hcd 0000:04:00.0: // xHCI operational registers at ffffc90000c70020:
[    3.089197] xhci_hcd 0000:04:00.0: // @ffffc90000c70018 = 0x600 RTSOFF
[    3.089198] xhci_hcd 0000:04:00.0: // xHCI runtime registers at ffffc90000c70600:
[    3.089202] xhci_hcd 0000:04:00.0: // @ffffc90000c70014 = 0x800 DBOFF
[    3.089203] xhci_hcd 0000:04:00.0: // Doorbell array at ffffc90000c70800:
[    3.089205] xhci_hcd 0000:04:00.0: xHCI runtime registers at ffffc90000c70600:
[    3.089208] xhci_hcd 0000:04:00.0:   ffffc90000c70600: Microframe index = 0x0
[    3.089222] xhci_hcd 0000:04:00.0: // Allocating event ring
[    3.089223] xhci_hcd 0000:04:00.0: Allocating ring at ffff88025051da40
[    3.089225] xhci_hcd 0000:04:00.0: Allocating priv segment structure at ffff880250454c60
[    3.089227] xhci_hcd 0000:04:00.0: // Allocating segment at ffff880037021400 (virtual) 0x37021400 (DMA)
[    3.089229] xhci_hcd 0000:04:00.0: Linking segment 0x37021400 to segment 0x37021400 (DMA)
[    3.089231] xhci_hcd 0000:04:00.0: TRB math tests passed.
[    3.089233] xhci_hcd 0000:04:00.0: // Allocated event ring segment table at 0x37022000
[    3.089235] xhci_hcd 0000:04:00.0: Set ERST to 0; private num segs = 1, virt addr = ffff880037022000, dma addr = 0x37022000
[    3.089239] xhci_hcd 0000:04:00.0: // Write ERST size = 1 to ir_set 0 (some bits preserved)
[    3.089241] xhci_hcd 0000:04:00.0: // Set ERST entries to point to event ring.
[    3.089242] xhci_hcd 0000:04:00.0: // Set ERST base address for ir_set 0 = 0x37022000
[    3.089253] xhci_hcd 0000:04:00.0: // Write event ring dequeue pointer, preserving EHB bit
[    3.089255] xhci_hcd 0000:04:00.0: Wrote ERST address to ir_set 0.
[    3.089259] xhci_hcd 0000:04:00.0: Allocating 0 scratchpad buffers
[    3.089269] xhci_hcd 0000:04:00.0: Ext Cap ffffc90000c70510, port offset = 1, count = 2, revision = 0x3
[    3.089275] xhci_hcd 0000:04:00.0: Ext Cap ffffc90000c70520, port offset = 3, count = 2, revision = 0x2
[    3.089277] xhci_hcd 0000:04:00.0: Found 2 USB 2.0 ports and 2 USB 3.0 ports.
[    3.089278] xhci_hcd 0000:04:00.0: USB 2.0 port at index 2, addr = ffffc90000c70440
[    3.089280] xhci_hcd 0000:04:00.0: USB 2.0 port at index 3, addr = ffffc90000c70450
[    3.089282] xhci_hcd 0000:04:00.0: USB 3.0 port at index 0, addr = ffffc90000c70420
[    3.089284] xhci_hcd 0000:04:00.0: USB 3.0 port at index 1, addr = ffffc90000c70430
[    3.089285] xhci_hcd 0000:04:00.0: Finished xhci_init
[    3.089286] xhci_hcd 0000:04:00.0: Called HCD init
[    3.089290] xhci_hcd 0000:04:00.0: Got SBRN 48
[    3.089297] xhci_hcd 0000:04:00.0: MWI active
[    3.089298] xhci_hcd 0000:04:00.0: Finished xhci_pci_reinit
[    3.089299] xhci_hcd 0000:04:00.0: supports USB remote wakeup
[    3.089315] xhci_hcd 0000:04:00.0: irq 18, io mem 0xd6400000
[    3.089374] xhci_hcd 0000:04:00.0: xhci_run
[    3.089436] xhci_hcd 0000:04:00.0: irq 42 for MSI/MSI-X
[    3.089440] xhci_hcd 0000:04:00.0: irq 43 for MSI/MSI-X
[    3.089444] xhci_hcd 0000:04:00.0: irq 44 for MSI/MSI-X
[    3.089448] xhci_hcd 0000:04:00.0: irq 45 for MSI/MSI-X
[    3.089452] xhci_hcd 0000:04:00.0: irq 46 for MSI/MSI-X
[    3.089507] xhci_hcd 0000:04:00.0: Setting event ring polling timer
[    3.089508] xhci_hcd 0000:04:00.0: Command ring memory map follows:
[    3.089510] xhci_hcd 0000:04:00.0: @0000000037021000 00000000 00000000 00000000 00000000
[    3.089512] xhci_hcd 0000:04:00.0: @0000000037021010 00000000 00000000 00000000 00000000
[    3.089514] xhci_hcd 0000:04:00.0: @0000000037021020 00000000 00000000 00000000 00000000
[    3.089516] xhci_hcd 0000:04:00.0: @0000000037021030 00000000 00000000 00000000 00000000
[    3.089518] xhci_hcd 0000:04:00.0: @0000000037021040 00000000 00000000 00000000 00000000
[    3.089519] xhci_hcd 0000:04:00.0: @0000000037021050 00000000 00000000 00000000 00000000
[    3.089521] xhci_hcd 0000:04:00.0: @0000000037021060 00000000 00000000 00000000 00000000
[    3.089523] xhci_hcd 0000:04:00.0: @0000000037021070 00000000 00000000 00000000 00000000
[    3.089525] xhci_hcd 0000:04:00.0: @0000000037021080 00000000 00000000 00000000 00000000
[    3.089526] xhci_hcd 0000:04:00.0: @0000000037021090 00000000 00000000 00000000 00000000
[    3.089528] xhci_hcd 0000:04:00.0: @00000000370210a0 00000000 00000000 00000000 00000000
[    3.089530] xhci_hcd 0000:04:00.0: @00000000370210b0 00000000 00000000 00000000 00000000
[    3.089532] xhci_hcd 0000:04:00.0: @00000000370210c0 00000000 00000000 00000000 00000000
[    3.089534] xhci_hcd 0000:04:00.0: @00000000370210d0 00000000 00000000 00000000 00000000
[    3.089535] xhci_hcd 0000:04:00.0: @00000000370210e0 00000000 00000000 00000000 00000000
[    3.089537] xhci_hcd 0000:04:00.0: @00000000370210f0 00000000 00000000 00000000 00000000
[    3.089539] xhci_hcd 0000:04:00.0: @0000000037021100 00000000 00000000 00000000 00000000
[    3.089541] xhci_hcd 0000:04:00.0: @0000000037021110 00000000 00000000 00000000 00000000
[    3.089542] xhci_hcd 0000:04:00.0: @0000000037021120 00000000 00000000 00000000 00000000
[    3.089544] xhci_hcd 0000:04:00.0: @0000000037021130 00000000 00000000 00000000 00000000
[    3.089546] xhci_hcd 0000:04:00.0: @0000000037021140 00000000 00000000 00000000 00000000
[    3.089548] xhci_hcd 0000:04:00.0: @0000000037021150 00000000 00000000 00000000 00000000
[    3.089550] xhci_hcd 0000:04:00.0: @0000000037021160 00000000 00000000 00000000 00000000
[    3.089551] xhci_hcd 0000:04:00.0: @0000000037021170 00000000 00000000 00000000 00000000
[    3.089553] xhci_hcd 0000:04:00.0: @0000000037021180 00000000 00000000 00000000 00000000
[    3.089555] xhci_hcd 0000:04:00.0: @0000000037021190 00000000 00000000 00000000 00000000
[    3.089557] xhci_hcd 0000:04:00.0: @00000000370211a0 00000000 00000000 00000000 00000000
[    3.089558] xhci_hcd 0000:04:00.0: @00000000370211b0 00000000 00000000 00000000 00000000
[    3.089560] xhci_hcd 0000:04:00.0: @00000000370211c0 00000000 00000000 00000000 00000000
[    3.089562] xhci_hcd 0000:04:00.0: @00000000370211d0 00000000 00000000 00000000 00000000
[    3.089564] xhci_hcd 0000:04:00.0: @00000000370211e0 00000000 00000000 00000000 00000000
[    3.089565] xhci_hcd 0000:04:00.0: @00000000370211f0 00000000 00000000 00000000 00000000
[    3.089567] xhci_hcd 0000:04:00.0: @0000000037021200 00000000 00000000 00000000 00000000
[    3.089569] xhci_hcd 0000:04:00.0: @0000000037021210 00000000 00000000 00000000 00000000
[    3.089571] xhci_hcd 0000:04:00.0: @0000000037021220 00000000 00000000 00000000 00000000
[    3.089573] xhci_hcd 0000:04:00.0: @0000000037021230 00000000 00000000 00000000 00000000
[    3.089574] xhci_hcd 0000:04:00.0: @0000000037021240 00000000 00000000 00000000 00000000
[    3.089576] xhci_hcd 0000:04:00.0: @0000000037021250 00000000 00000000 00000000 00000000
[    3.089578] xhci_hcd 0000:04:00.0: @0000000037021260 00000000 00000000 00000000 00000000
[    3.089580] xhci_hcd 0000:04:00.0: @0000000037021270 00000000 00000000 00000000 00000000
[    3.089581] xhci_hcd 0000:04:00.0: @0000000037021280 00000000 00000000 00000000 00000000
[    3.089583] xhci_hcd 0000:04:00.0: @0000000037021290 00000000 00000000 00000000 00000000
[    3.089585] xhci_hcd 0000:04:00.0: @00000000370212a0 00000000 00000000 00000000 00000000
[    3.089587] xhci_hcd 0000:04:00.0: @00000000370212b0 00000000 00000000 00000000 00000000
[    3.089589] xhci_hcd 0000:04:00.0: @00000000370212c0 00000000 00000000 00000000 00000000
[    3.089590] xhci_hcd 0000:04:00.0: @00000000370212d0 00000000 00000000 00000000 00000000
[    3.089592] xhci_hcd 0000:04:00.0: @00000000370212e0 00000000 00000000 00000000 00000000
[    3.089594] xhci_hcd 0000:04:00.0: @00000000370212f0 00000000 00000000 00000000 00000000
[    3.089596] xhci_hcd 0000:04:00.0: @0000000037021300 00000000 00000000 00000000 00000000
[    3.089597] xhci_hcd 0000:04:00.0: @0000000037021310 00000000 00000000 00000000 00000000
[    3.089599] xhci_hcd 0000:04:00.0: @0000000037021320 00000000 00000000 00000000 00000000
[    3.089601] xhci_hcd 0000:04:00.0: @0000000037021330 00000000 00000000 00000000 00000000
[    3.089603] xhci_hcd 0000:04:00.0: @0000000037021340 00000000 00000000 00000000 00000000
[    3.089604] xhci_hcd 0000:04:00.0: @0000000037021350 00000000 00000000 00000000 00000000
[    3.089606] xhci_hcd 0000:04:00.0: @0000000037021360 00000000 00000000 00000000 00000000
[    3.089608] xhci_hcd 0000:04:00.0: @0000000037021370 00000000 00000000 00000000 00000000
[    3.089610] xhci_hcd 0000:04:00.0: @0000000037021380 00000000 00000000 00000000 00000000
[    3.089612] xhci_hcd 0000:04:00.0: @0000000037021390 00000000 00000000 00000000 00000000
[    3.089613] xhci_hcd 0000:04:00.0: @00000000370213a0 00000000 00000000 00000000 00000000
[    3.089615] xhci_hcd 0000:04:00.0: @00000000370213b0 00000000 00000000 00000000 00000000
[    3.089617] xhci_hcd 0000:04:00.0: @00000000370213c0 00000000 00000000 00000000 00000000
[    3.089619] xhci_hcd 0000:04:00.0: @00000000370213d0 00000000 00000000 00000000 00000000
[    3.089620] xhci_hcd 0000:04:00.0: @00000000370213e0 00000000 00000000 00000000 00000000
[    3.089622] xhci_hcd 0000:04:00.0: @00000000370213f0 37021000 00000000 00000000 00001802
[    3.089624] xhci_hcd 0000:04:00.0:   Ring has not been updated
[    3.089625] xhci_hcd 0000:04:00.0: Ring deq = ffff880037021000 (virt), 0x37021000 (dma)
[    3.089627] xhci_hcd 0000:04:00.0: Ring deq updated 0 times
[    3.089628] xhci_hcd 0000:04:00.0: Ring enq = ffff880037021000 (virt), 0x37021000 (dma)
[    3.089630] xhci_hcd 0000:04:00.0: Ring enq updated 0 times
[    3.089635] xhci_hcd 0000:04:00.0: // xHC command ring deq ptr low bits + flags = @00000000
[    3.089636] xhci_hcd 0000:04:00.0: // xHC command ring deq ptr high bits = @00000000
[    3.089638] xhci_hcd 0000:04:00.0: ERST memory map follows:
[    3.089640] xhci_hcd 0000:04:00.0: @0000000037022000 37021400 00000000 00000040 00000000
[    3.089641] xhci_hcd 0000:04:00.0: Event ring:
[    3.089643] xhci_hcd 0000:04:00.0: @0000000037021400 00000000 00000000 00000000 00000000
[    3.089644] xhci_hcd 0000:04:00.0: @0000000037021410 00000000 00000000 00000000 00000000
[    3.089646] xhci_hcd 0000:04:00.0: @0000000037021420 00000000 00000000 00000000 00000000
[    3.089648] xhci_hcd 0000:04:00.0: @0000000037021430 00000000 00000000 00000000 00000000
[    3.089650] xhci_hcd 0000:04:00.0: @0000000037021440 00000000 00000000 00000000 00000000
[    3.089651] xhci_hcd 0000:04:00.0: @0000000037021450 00000000 00000000 00000000 00000000
[    3.089653] xhci_hcd 0000:04:00.0: @0000000037021460 00000000 00000000 00000000 00000000
[    3.089655] xhci_hcd 0000:04:00.0: @0000000037021470 00000000 00000000 00000000 00000000
[    3.089657] xhci_hcd 0000:04:00.0: @0000000037021480 00000000 00000000 00000000 00000000
[    3.089658] xhci_hcd 0000:04:00.0: @0000000037021490 00000000 00000000 00000000 00000000
[    3.089660] xhci_hcd 0000:04:00.0: @00000000370214a0 00000000 00000000 00000000 00000000
[    3.089662] xhci_hcd 0000:04:00.0: @00000000370214b0 00000000 00000000 00000000 00000000
[    3.089664] xhci_hcd 0000:04:00.0: @00000000370214c0 00000000 00000000 00000000 00000000
[    3.089665] xhci_hcd 0000:04:00.0: @00000000370214d0 00000000 00000000 00000000 00000000
[    3.089667] xhci_hcd 0000:04:00.0: @00000000370214e0 00000000 00000000 00000000 00000000
[    3.089669] xhci_hcd 0000:04:00.0: @00000000370214f0 00000000 00000000 00000000 00000000
[    3.089671] xhci_hcd 0000:04:00.0: @0000000037021500 00000000 00000000 00000000 00000000
[    3.089672] xhci_hcd 0000:04:00.0: @0000000037021510 00000000 00000000 00000000 00000000
[    3.089674] xhci_hcd 0000:04:00.0: @0000000037021520 00000000 00000000 00000000 00000000
[    3.089676] xhci_hcd 0000:04:00.0: @0000000037021530 00000000 00000000 00000000 00000000
[    3.089678] xhci_hcd 0000:04:00.0: @0000000037021540 00000000 00000000 00000000 00000000
[    3.089679] xhci_hcd 0000:04:00.0: @0000000037021550 00000000 00000000 00000000 00000000
[    3.089681] xhci_hcd 0000:04:00.0: @0000000037021560 00000000 00000000 00000000 00000000
[    3.089683] xhci_hcd 0000:04:00.0: @0000000037021570 00000000 00000000 00000000 00000000
[    3.089685] xhci_hcd 0000:04:00.0: @0000000037021580 00000000 00000000 00000000 00000000
[    3.089687] xhci_hcd 0000:04:00.0: @0000000037021590 00000000 00000000 00000000 00000000
[    3.089690] xhci_hcd 0000:04:00.0: @00000000370215a0 00000000 00000000 00000000 00000000
[    3.089692] xhci_hcd 0000:04:00.0: @00000000370215b0 00000000 00000000 00000000 00000000
[    3.089695] xhci_hcd 0000:04:00.0: @00000000370215c0 00000000 00000000 00000000 00000000
[    3.089698] xhci_hcd 0000:04:00.0: @00000000370215d0 00000000 00000000 00000000 00000000
[    3.089700] xhci_hcd 0000:04:00.0: @00000000370215e0 00000000 00000000 00000000 00000000
[    3.089703] xhci_hcd 0000:04:00.0: @00000000370215f0 00000000 00000000 00000000 00000000
[    3.089705] xhci_hcd 0000:04:00.0: @0000000037021600 00000000 00000000 00000000 00000000
[    3.089708] xhci_hcd 0000:04:00.0: @0000000037021610 00000000 00000000 00000000 00000000
[    3.089710] xhci_hcd 0000:04:00.0: @0000000037021620 00000000 00000000 00000000 00000000
[    3.089713] xhci_hcd 0000:04:00.0: @0000000037021630 00000000 00000000 00000000 00000000
[    3.089715] xhci_hcd 0000:04:00.0: @0000000037021640 00000000 00000000 00000000 00000000
[    3.089718] xhci_hcd 0000:04:00.0: @0000000037021650 00000000 00000000 00000000 00000000
[    3.089721] xhci_hcd 0000:04:00.0: @0000000037021660 00000000 00000000 00000000 00000000
[    3.089723] xhci_hcd 0000:04:00.0: @0000000037021670 00000000 00000000 00000000 00000000
[    3.089726] xhci_hcd 0000:04:00.0: @0000000037021680 00000000 00000000 00000000 00000000
[    3.089729] xhci_hcd 0000:04:00.0: @0000000037021690 00000000 00000000 00000000 00000000
[    3.089732] xhci_hcd 0000:04:00.0: @00000000370216a0 00000000 00000000 00000000 00000000
[    3.089734] xhci_hcd 0000:04:00.0: @00000000370216b0 00000000 00000000 00000000 00000000
[    3.089737] xhci_hcd 0000:04:00.0: @00000000370216c0 00000000 00000000 00000000 00000000
[    3.089740] xhci_hcd 0000:04:00.0: @00000000370216d0 00000000 00000000 00000000 00000000
[    3.089743] xhci_hcd 0000:04:00.0: @00000000370216e0 00000000 00000000 00000000 00000000
[    3.089745] xhci_hcd 0000:04:00.0: @00000000370216f0 00000000 00000000 00000000 00000000
[    3.089748] xhci_hcd 0000:04:00.0: @0000000037021700 00000000 00000000 00000000 00000000
[    3.089750] xhci_hcd 0000:04:00.0: @0000000037021710 00000000 00000000 00000000 00000000
[    3.089753] xhci_hcd 0000:04:00.0: @0000000037021720 00000000 00000000 00000000 00000000
[    3.089756] xhci_hcd 0000:04:00.0: @0000000037021730 00000000 00000000 00000000 00000000
[    3.089759] xhci_hcd 0000:04:00.0: @0000000037021740 00000000 00000000 00000000 00000000
[    3.089761] xhci_hcd 0000:04:00.0: @0000000037021750 00000000 00000000 00000000 00000000
[    3.089764] xhci_hcd 0000:04:00.0: @0000000037021760 00000000 00000000 00000000 00000000
[    3.089766] xhci_hcd 0000:04:00.0: @0000000037021770 00000000 00000000 00000000 00000000
[    3.089769] xhci_hcd 0000:04:00.0: @0000000037021780 00000000 00000000 00000000 00000000
[    3.089772] xhci_hcd 0000:04:00.0: @0000000037021790 00000000 00000000 00000000 00000000
[    3.089774] xhci_hcd 0000:04:00.0: @00000000370217a0 00000000 00000000 00000000 00000000
[    3.089777] xhci_hcd 0000:04:00.0: @00000000370217b0 00000000 00000000 00000000 00000000
[    3.089779] xhci_hcd 0000:04:00.0: @00000000370217c0 00000000 00000000 00000000 00000000
[    3.089782] xhci_hcd 0000:04:00.0: @00000000370217d0 00000000 00000000 00000000 00000000
[    3.089785] xhci_hcd 0000:04:00.0: @00000000370217e0 00000000 00000000 00000000 00000000
[    3.089787] xhci_hcd 0000:04:00.0: @00000000370217f0 00000000 00000000 00000000 00000000
[    3.089789] xhci_hcd 0000:04:00.0:   Ring has not been updated
[    3.089791] xhci_hcd 0000:04:00.0: Ring deq = ffff880037021400 (virt), 0x37021400 (dma)
[    3.089794] xhci_hcd 0000:04:00.0: Ring deq updated 0 times
[    3.089796] xhci_hcd 0000:04:00.0: Ring enq = ffff880037021400 (virt), 0x37021400 (dma)
[    3.089798] xhci_hcd 0000:04:00.0: Ring enq updated 0 times
[    3.089804] xhci_hcd 0000:04:00.0: ERST deq = 64'h37021400
[    3.089806] xhci_hcd 0000:04:00.0: // Set the interrupt modulation register
[    3.089812] xhci_hcd 0000:04:00.0: // Enable interrupts, cmd = 0x4.
[    3.089817] xhci_hcd 0000:04:00.0: // Enabling event ring interrupter ffffc90000c70620 by writing 0x2 to irq_pending
[    3.089821] xhci_hcd 0000:04:00.0:   ffffc90000c70620: ir_set[0]
[    3.089823] xhci_hcd 0000:04:00.0:   ffffc90000c70620: ir_set.pending = 0x2
[    3.089828] xhci_hcd 0000:04:00.0:   ffffc90000c70624: ir_set.control = 0xa0
[    3.089832] xhci_hcd 0000:04:00.0:   ffffc90000c70628: ir_set.erst_size = 0x1
[    3.089841] xhci_hcd 0000:04:00.0:   ffffc90000c70630: ir_set.erst_base = @37022000
[    3.089847] xhci_hcd 0000:04:00.0:   ffffc90000c70638: ir_set.erst_dequeue = @37021400
[    3.089850] xhci_hcd 0000:04:00.0: Finished xhci_run for USB2 roothub
[    3.089865] usb usb3: default language 0x0409
[    3.089872] usb usb3: udev 1, busnum 3, minor = 256
[    3.089874] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    3.089937] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.090015] usb usb3: Product: xHCI Host Controller
[    3.090070] usb usb3: Manufacturer: Linux 3.2.0-rc5 xhci_hcd
[    3.090156] usb usb3: SerialNumber: 0000:04:00.0
[    3.090356] usb usb3: usb_probe_device
[    3.090360] usb usb3: configuration #1 chosen from 1 choice
[    3.090363] xHCI xhci_add_endpoint called for root hub
[    3.090365] xHCI xhci_check_bandwidth called for root hub
[    3.090372] usb usb3: adding 3-0:1.0 (config #1, interface 0)
[    3.090401] hub 3-0:1.0: usb_probe_interface
[    3.090403] hub 3-0:1.0: usb_probe_interface - got id
[    3.090406] hub 3-0:1.0: USB hub found
[    3.090471] hub 3-0:1.0: 2 ports detected
[    3.090528] hub 3-0:1.0: standalone hub
[    3.090529] hub 3-0:1.0: individual port power switching
[    3.090530] hub 3-0:1.0: individual port over-current protection
[    3.090532] hub 3-0:1.0: Single TT
[    3.090533] hub 3-0:1.0: TT requires at most 8 FS bit times (666 ns)
[    3.090535] hub 3-0:1.0: power on to power good time: 20ms
[    3.090538] hub 3-0:1.0: local power source is good
[    3.090539] hub 3-0:1.0: enabling power on all ports
[    3.090546] xhci_hcd 0000:04:00.0: set port power, actual port 0 status  = 0x2a0
[    3.090554] xhci_hcd 0000:04:00.0: set port power, actual port 1 status  = 0x2a0
[    3.090596] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    3.090658] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus number 4
[    3.090731] xhci_hcd 0000:04:00.0: Enabling 64-bit DMA addresses.
[    3.090733] xhci_hcd 0000:04:00.0: supports USB remote wakeup
[    3.090736] xhci_hcd 0000:04:00.0: // Turn on HC, cmd = 0x5.
[    3.092620] xhci_hcd 0000:04:00.0: // Ding dong!
[    3.092624] xhci_hcd 0000:04:00.0: Finished xhci_run for USB3 roothub
[    3.092637] usb usb4: skipped 1 descriptor after endpoint
[    3.092641] usb usb4: default language 0x0409
[    3.092648] usb usb4: udev 1, busnum 4, minor = 384
[    3.092650] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[    3.092705] xhci_hcd 0000:04:00.0: Vendor specific event TRB type = 48
[    3.092708] xhci_hcd 0000:04:00.0: NEC firmware version 40.15
[    3.092720] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.092796] usb usb4: Product: xHCI Host Controller
[    3.092855] usb usb4: Manufacturer: Linux 3.2.0-rc5 xhci_hcd
[    3.092917] usb usb4: SerialNumber: 0000:04:00.0
[    3.093065] usb usb4: usb_probe_device
[    3.093068] usb usb4: configuration #1 chosen from 1 choice
[    3.093071] xHCI xhci_add_endpoint called for root hub
[    3.093073] xHCI xhci_check_bandwidth called for root hub
[    3.093080] usb usb4: adding 4-0:1.0 (config #1, interface 0)
[    3.093109] hub 4-0:1.0: usb_probe_interface
[    3.093111] hub 4-0:1.0: usb_probe_interface - got id
[    3.093114] hub 4-0:1.0: USB hub found
[    3.093172] hub 4-0:1.0: 2 ports detected
[    3.093225] hub 4-0:1.0: standalone hub
[    3.093227] hub 4-0:1.0: individual port power switching
[    3.093229] hub 4-0:1.0: individual port over-current protection
[    3.093231] hub 4-0:1.0: TT requires at most 8 FS bit times (666 ns)
[    3.093233] hub 4-0:1.0: power on to power good time: 20ms
[    3.093238] hub 4-0:1.0: local power source is good
[    3.093240] hub 4-0:1.0: enabling power on all ports
[    3.093248] xhci_hcd 0000:04:00.0: set port power, actual port 0 status  = 0x2a0
[    3.093257] xhci_hcd 0000:04:00.0: set port power, actual port 1 status  = 0x2a0
[    3.098108] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    3.098198] usb usb2: default language 0x0409
[    3.098205] usb usb2: udev 1, busnum 2, minor = 128
[    3.098208] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    3.098265] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.098341] usb usb2: Product: EHCI Host Controller
[    3.098401] usb usb2: Manufacturer: Linux 3.2.0-rc5 ehci_hcd
[    3.098469] usb usb2: SerialNumber: 0000:00:1d.0
[    3.098619] usb usb2: usb_probe_device
[    3.098622] usb usb2: configuration #1 chosen from 1 choice
[    3.098631] usb usb2: adding 2-0:1.0 (config #1, interface 0)
[    3.098661] hub 2-0:1.0: usb_probe_interface
[    3.098663] hub 2-0:1.0: usb_probe_interface - got id
[    3.098666] hub 2-0:1.0: USB hub found
[    3.098725] hub 2-0:1.0: 2 ports detected
[    3.098780] hub 2-0:1.0: standalone hub
[    3.098782] hub 2-0:1.0: no power switching (usb 1.0)
[    3.098784] hub 2-0:1.0: individual port over-current protection
[    3.098786] hub 2-0:1.0: power on to power good time: 20ms
[    3.098791] hub 2-0:1.0: local power source is good
[    3.098794] hub 2-0:1.0: trying to enable port power on non-switchable hub
[    3.118223] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    3.118290] i915 0000:00:02.0: setting latency timer to 64
[    3.144830] mtrr: no more MTRRs available
[    3.144892] [drm] MTRR allocation failed.  Graphics performance may suffer.
[    3.145345] i915 0000:00:02.0: irq 47 for MSI/MSI-X
[    3.145352] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    3.145416] [drm] Driver supports precise vblank timestamp query.
[    3.145691] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    3.178197] ehci_hcd 0000:00:1a.0: GetStatus port:1 status 001803 0  ACK POWER sig=j CSC CONNECT
[    3.178216] hub 1-0:1.0: port 1: status 0501 change 0001
[    3.190098] xhci_hcd 0000:04:00.0: get port status, actual port 0 status  = 0x2a0
[    3.190101] xhci_hcd 0000:04:00.0: Get port status returned 0x100
[    3.190107] xhci_hcd 0000:04:00.0: get port status, actual port 1 status  = 0x2a0
[    3.190108] xhci_hcd 0000:04:00.0: Get port status returned 0x100
[    3.190119] hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0000
[    3.190122] xhci_hcd 0000:04:00.0: get port status, actual port 0 status  = 0x2a0
[    3.190124] xhci_hcd 0000:04:00.0: Get port status returned 0x2a0
[    3.190128] xhci_hcd 0000:04:00.0: get port status, actual port 1 status  = 0x2a0
[    3.190130] xhci_hcd 0000:04:00.0: Get port status returned 0x2a0
[    3.190151] hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
[    3.198277] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001803 0  ACK POWER sig=j CSC CONNECT
[    3.198283] hub 2-0:1.0: port 1: status 0501 change 0001
[    3.278096] hub 1-0:1.0: state 7 ports 2 chg 0002 evt 0000
[    3.278122] hub 1-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
[    3.334376] ehci_hcd 0000:00:1a.0: port 1 high speed
[    3.334381] ehci_hcd 0000:00:1a.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[    3.390115] usb 1-1: new high-speed USB device number 2 using ehci_hcd
[    3.446338] ehci_hcd 0000:00:1a.0: port 1 high speed
[    3.446343] ehci_hcd 0000:00:1a.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[    3.522268] ehci_hcd 0000:00:1a.0: set dev address 2 for port 1
[    3.522279] ehci_hcd 0000:00:1a.0: LPM: no device attached
[    3.522645] usb 1-1: udev 2, busnum 1, minor = 1
[    3.522654] usb 1-1: New USB device found, idVendor=8087, idProduct=0024
[    3.522740] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.522940] usb 1-1: usb_probe_device
[    3.522944] usb 1-1: configuration #1 chosen from 1 choice
[    3.523108] usb 1-1: adding 1-1:1.0 (config #1, interface 0)
[    3.523137] hub 1-1:1.0: usb_probe_interface
[    3.523139] hub 1-1:1.0: usb_probe_interface - got id
[    3.523141] hub 1-1:1.0: USB hub found
[    3.523411] hub 1-1:1.0: 6 ports detected
[    3.523469] hub 1-1:1.0: standalone hub
[    3.523470] hub 1-1:1.0: individual port power switching
[    3.523471] hub 1-1:1.0: individual port over-current protection
[    3.523472] hub 1-1:1.0: Single TT
[    3.523474] hub 1-1:1.0: TT requires at most 8 FS bit times (666 ns)
[    3.523475] hub 1-1:1.0: power on to power good time: 100ms
[    3.523723] hub 1-1:1.0: local power source is good
[    3.523726] hub 1-1:1.0: enabling power on all ports
[    3.524472] hub 2-0:1.0: state 7 ports 2 chg 0002 evt 0000
[    3.524479] hub 2-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
[    3.578294] ehci_hcd 0000:00:1d.0: port 1 high speed
[    3.578299] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[    3.622107] hub 1-1:1.0: port 1: status 0101 change 0001
[    3.622347] hub 1-1:1.0: port 2: status 0101 change 0001
[    3.622597] hub 1-1:1.0: port 3: status 0101 change 0001
[    3.634020] usb 2-1: new high-speed USB device number 2 using ehci_hcd
[    3.690259] ehci_hcd 0000:00:1d.0: port 1 high speed
[    3.690264] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[    3.722001] usb 1-1: link qh256-0001/ffff88024f5e1540 start 1 [1/0 us]
[    3.766062] ehci_hcd 0000:00:1d.0: set dev address 2 for port 1
[    3.766073] ehci_hcd 0000:00:1d.0: LPM: no device attached
[    3.766435] usb 2-1: udev 2, busnum 2, minor = 129
[    3.766444] usb 2-1: New USB device found, idVendor=8087, idProduct=0024
[    3.766537] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.766737] usb 2-1: usb_probe_device
[    3.766741] usb 2-1: configuration #1 chosen from 1 choice
[    3.766903] usb 2-1: adding 2-1:1.0 (config #1, interface 0)
[    3.766933] hub 2-1:1.0: usb_probe_interface
[    3.766935] hub 2-1:1.0: usb_probe_interface - got id
[    3.766937] hub 2-1:1.0: USB hub found
[    3.767145] hub 2-1:1.0: 8 ports detected
[    3.767202] hub 2-1:1.0: standalone hub
[    3.767203] hub 2-1:1.0: individual port power switching
[    3.767204] hub 2-1:1.0: individual port over-current protection
[    3.767205] hub 2-1:1.0: Single TT
[    3.767207] hub 2-1:1.0: TT requires at most 8 FS bit times (666 ns)
[    3.767208] hub 2-1:1.0: power on to power good time: 100ms
[    3.767519] hub 2-1:1.0: local power source is good
[    3.767522] hub 2-1:1.0: enabling power on all ports
[    3.768545] hub 1-1:1.0: state 7 ports 6 chg 000e evt 0000
[    3.768637] hub 1-1:1.0: port 1, status 0101, change 0000, 12 Mb/s
[    3.774875] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.0, id: 0x1e2b1, caps: 0xd00123/0x850300/0x120c00
[    3.809074] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input4
[    3.838181] usb 1-1.1: new full-speed USB device number 3 using ehci_hcd
[    3.866271] hub 2-1:1.0: port 2: status 0101 change 0001
[    3.929921] usb 1-1.1: ep0 maxpacket = 8
[    3.931763] usb 1-1.1: default language 0x0409
[    3.931980] usb 1-1.1: udev 3, busnum 1, minor = 2
[    3.931986] usb 1-1.1: New USB device found, idVendor=08ff, idProduct=168f
[    3.932089] usb 1-1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    3.932160] usb 1-1.1: Product: Fingerprint Sensor
[    3.932353] usb 1-1.1: usb_probe_device
[    3.932356] usb 1-1.1: configuration #1 chosen from 1 choice
[    3.932443] usb 1-1.1: adding 1-1.1:1.0 (config #1, interface 0)
[    3.932561] hub 1-1:1.0: port 2, status 0101, change 0000, 12 Mb/s
[    3.965947] usb 2-1: link qh256-0001/ffff88024f27cec0 start 1 [1/0 us]
[    4.002115] usb 1-1.2: new full-speed USB device number 4 using ehci_hcd
[    4.098238] usb 1-1.2: udev 4, busnum 1, minor = 3
[    4.098247] usb 1-1.2: New USB device found, idVendor=8086, idProduct=0189
[    4.098330] usb 1-1.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.098524] usb 1-1.2: usb_probe_device
[    4.098527] usb 1-1.2: configuration #1 chosen from 1 choice
[    4.099173] usb 1-1.2: adding 1-1.2:1.0 (config #1, interface 0)
[    4.099233] usb 1-1.2: adding 1-1.2:1.1 (config #1, interface 1)
[    4.099408] hub 1-1:1.0: port 3, status 0101, change 0000, 12 Mb/s
[    4.170062] usb 1-1.3: new high-speed USB device number 5 using ehci_hcd
[    4.282215] usb 1-1.3: skipped 1 descriptor after configuration
[    4.282225] usb 1-1.3: skipped 5 descriptors after interface
[    4.282232] usb 1-1.3: skipped 1 descriptor after endpoint
[    4.282238] usb 1-1.3: skipped 17 descriptors after interface
[    4.282534] usb 1-1.3: default language 0x0409
[    4.284226] usb 1-1.3: udev 5, busnum 1, minor = 4
[    4.284235] usb 1-1.3: New USB device found, idVendor=05c8, idProduct=0318
[    4.284313] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    4.284386] usb 1-1.3: Product: USB2.0 Camera
[    4.284441] usb 1-1.3: Manufacturer: Ricoh Company Ltd.
[    4.284499] usb 1-1.3: SerialNumber: 145839811AP0B00003KBD30I3
[    4.284701] usb 1-1.3: usb_probe_device
[    4.284705] usb 1-1.3: configuration #1 chosen from 1 choice
[    4.284877] usb 1-1.3: adding 1-1.3:1.0 (config #1, interface 0)
[    4.285363] usb 1-1.3: adding 1-1.3:1.1 (config #1, interface 1)
[    4.285403] hub 1-1:1.0: state 7 ports 6 chg 0000 evt 0002
[    4.285604] hub 2-1:1.0: state 7 ports 8 chg 0004 evt 0000
[    4.285725] hub 2-1:1.0: port 2, status 0101, change 0000, 12 Mb/s
[    4.358007] usb 2-1.2: new low-speed USB device number 3 using ehci_hcd
[    4.463850] usb 2-1.2: skipped 1 descriptor after interface
[    4.463861] usb 2-1.2: skipped 1 descriptor after interface
[    4.465347] usb 2-1.2: default language 0x0409
[    4.475590] usb 2-1.2: udev 3, busnum 2, minor = 130
[    4.475599] usb 2-1.2: New USB device found, idVendor=046d, idProduct=c30e
[    4.475700] usb 2-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.475770] usb 2-1.2: Product: HID compliant keyboard
[    4.475827] usb 2-1.2: Manufacturer: Logitech
[    4.476018] usb 2-1.2: usb_probe_device
[    4.476022] usb 2-1.2: configuration #1 chosen from 1 choice
[    4.477325] usb 2-1.2: adding 2-1.2:1.0 (config #1, interface 0)
[    4.477400] usb 2-1.2: adding 2-1.2:1.1 (config #1, interface 1)
[    4.493288] usbhid 2-1.2:1.0: usb_probe_interface
[    4.493292] usbhid 2-1.2:1.0: usb_probe_interface - got id
[    4.503015] input: Logitech HID compliant keyboard as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0/input/input5
[    4.503105] usb 2-1.2: link qh8-0e01/ffff88024f1c89c0 start 2 [1/2 us]
[    4.503294] generic-usb 0003:046D:C30E.0001: input,hidraw0: USB HID v1.10 Keyboard [Logitech HID compliant keyboard] on usb-0000:00:1d.0-1.2/input0
[    4.503377] usbhid 2-1.2:1.1: usb_probe_interface
[    4.503379] usbhid 2-1.2:1.1: usb_probe_interface - got id
[    4.522943] input: Logitech HID compliant keyboard as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.1/input/input6
[    4.523034] usb 2-1.2: link qh8-0e01/ffff88025051d640 start 3 [1/2 us]
[    4.523216] generic-usb 0003:046D:C30E.0002: input,hidraw1: USB HID v1.10 Device [Logitech HID compliant keyboard] on usb-0000:00:1d.0-1.2/input1
[    4.523308] usbcore: registered new interface driver usbhid
[    4.523364] usbhid: USB HID core driver
[    5.091860] fbcon: inteldrmfb (fb0) is primary device
[    5.955458] Console: switching to colour frame buffer device 240x67
[    5.961053] fb0: inteldrmfb frame buffer device
[    5.961054] drm: registered panic notifier
[    5.961240] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[    5.961312] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[    5.961384] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[    5.961456] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[    5.961528] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[    5.961599] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[    5.961671] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[    5.962793] acpi device:3e: registered as cooling_device4
[    5.963020] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:09/input/input7
[    5.963194] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    5.963280] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[    5.964150] r8169 0000:05:00.0: PME# enabled
[    6.152062] EXT4-fs (dm-4): re-mounted. Opts: (null)
[    6.166590] EXT4-fs (dm-4): re-mounted. Opts: errors=remount-ro
[    6.177617] loop: module loaded
[    6.270228] Adding 7812604k swap on /dev/mapper/isw_baafheaagd_Volume03.  Priority:-1 extents:1 across:7812604k SS
[    6.784477] ip_tables: (C) 2000-2006 Netfilter Core Team
[    6.796441] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[    6.904184] fuse init (API version 7.17)
[    6.948894] usb 2-1.2: unlink qh8-0e01/ffff88025051d640 start 3 [1/2 us]
[    6.948905] usb 2-1.2: unlink qh8-0e01/ffff88024f1c89c0 start 2 [1/2 us]
[    6.948921] hub 3-0:1.0: hub_suspend
[    6.948924] usb usb3: bus auto-suspend, wakeup 1
[    6.948988] hub 4-0:1.0: hub_suspend
[    6.948990] usb usb4: bus auto-suspend, wakeup 1
[    6.949743] xhci_hcd 0000:04:00.0: // Setting command ring address to 0x37021001
[    6.949780] xhci_hcd 0000:04:00.0: hcd_pci_runtime_suspend: 0
[    6.949846] xhci_hcd 0000:04:00.0: PME# enabled
[    6.950349] usb 2-1.2: usb auto-suspend, wakeup 1
[    6.973004] usb 1-1.3: usb auto-suspend, wakeup 0
[    6.973008] usb 1-1.2: usb auto-suspend, wakeup 0
[    6.973011] usb 1-1.1: usb auto-suspend, wakeup 0
[    8.964289] hub 2-1:1.0: hub_suspend
[    8.964309] usb 2-1: unlink qh256-0001/ffff88024f27cec0 start 1 [1/0 us]
[    8.964554] usb 2-1: usb auto-suspend, wakeup 1
[    8.988291] hub 1-1:1.0: hub_suspend
[    8.988309] usb 1-1: unlink qh256-0001/ffff88024f5e1540 start 1 [1/0 us]
[    8.988493] usb 1-1: usb auto-suspend, wakeup 1
[   10.979649] hub 2-0:1.0: hub_suspend
[   10.979668] usb usb2: bus auto-suspend, wakeup 1
[   10.979675] ehci_hcd 0000:00:1d.0: suspend root hub
[   10.995650] ehci_hcd 0000:00:1d.0: PCI INT A disabled
[   10.997161] ehci_hcd 0000:00:1d.0: hcd_pci_runtime_suspend: 0
[   10.997195] ehci_hcd 0000:00:1d.0: PME# enabled
[   11.003642] hub 1-0:1.0: hub_suspend
[   11.003658] usb usb1: bus auto-suspend, wakeup 1
[   11.003663] ehci_hcd 0000:00:1a.0: suspend root hub
[   11.019643] ehci_hcd 0000:00:1a.0: PCI INT A disabled
[   11.021151] ehci_hcd 0000:00:1a.0: hcd_pci_runtime_suspend: 0
[   11.021183] ehci_hcd 0000:00:1a.0: PME# enabled
[   25.510786] NMI watchdog enabled, takes one hw-pmu counter.
[   25.512339] NMI watchdog enabled, takes one hw-pmu counter.
[   25.513831] NMI watchdog enabled, takes one hw-pmu counter.
[   25.515376] NMI watchdog enabled, takes one hw-pmu counter.
[   25.555051] ehci_hcd 0000:00:1a.0: BAR 0: set to [mem 0xd9409000-0xd94093ff] (PCI address [0xd9409000-0xd94093ff])
[   25.556602] ehci_hcd 0000:00:1a.0: restoring config space at offset 0xf (was 0x100, writing 0x10a)
[   25.556621] ehci_hcd 0000:00:1a.0: restoring config space at offset 0x1 (was 0x2900000, writing 0x2900002)
[   25.556672] ehci_hcd 0000:00:1a.0: PME# disabled
[   25.556681] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[   25.558130] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[   25.558142] ehci_hcd 0000:00:1a.0: hcd_pci_runtime_resume: 0
[   25.558145] usb usb1: usb auto-resume
[   25.558148] ehci_hcd 0000:00:1a.0: resume root hub
[   25.583059] hub 1-0:1.0: hub_resume
[   25.583082] hub 1-0:1.0: port 1: status 0507 change 0000
[   25.583111] usb 1-1: usb auto-resume
[   25.583140] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[   25.615047] ehci_hcd 0000:00:1a.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[   25.631025] usb 1-1: finish resume
[   25.631310] hub 1-1:1.0: hub_resume
[   25.631479] hub 1-1:1.0: port 1: status 0107 change 0000
[   25.631564] hub 1-1:1.0: port 2: status 0107 change 0000
[   25.631729] hub 1-1:1.0: port 3: status 0507 change 0000
[   25.632115] ehci_hcd 0000:00:1a.0: reused qh ffff88024f5e1540 schedule
[   25.632127] usb 1-1: link qh256-0001/ffff88024f5e1540 start 1 [1/0 us]
[   25.632205] hub 1-1:1.0: state 7 ports 6 chg 0000 evt 0000
[   25.633222] usb 1-1.1: usb auto-resume
[   25.679225] usb 1-1.1: finish resume
[   25.681207] usb 1-1.2: usb auto-resume
[   25.727200] usb 1-1.2: finish resume
[   25.730065] usb 1-1.3: usb auto-resume
[   25.775190] usb 1-1.3: finish resume
[   25.790936] ehci_hcd 0000:00:1d.0: BAR 0: set to [mem 0xd9408000-0xd94083ff] (PCI address [0xd9408000-0xd94083ff])
[   25.792417] ehci_hcd 0000:00:1d.0: restoring config space at offset 0xf (was 0x100, writing 0x107)
[   25.792436] ehci_hcd 0000:00:1d.0: restoring config space at offset 0x1 (was 0x2900000, writing 0x2900002)
[   25.792650] ehci_hcd 0000:00:1d.0: PME# disabled
[   25.792658] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[   25.794118] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[   25.794130] ehci_hcd 0000:00:1d.0: hcd_pci_runtime_resume: 0
[   25.794132] usb usb2: usb auto-resume
[   25.794135] ehci_hcd 0000:00:1d.0: resume root hub
[   25.819054] hub 2-0:1.0: hub_resume
[   25.819063] hub 2-0:1.0: port 1: status 0507 change 0000
[   25.819078] usb 2-1: usb auto-resume
[   25.819101] hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0000
[   25.850970] ehci_hcd 0000:00:1d.0: GetStatus port:1 status 001005 0  ACK POWER sig=se0 PE CONNECT
[   25.866947] usb 2-1: finish resume
[   25.867270] hub 2-1:1.0: hub_resume
[   25.867524] hub 2-1:1.0: port 2: status 0307 change 0000
[   25.868279] ehci_hcd 0000:00:1d.0: reused qh ffff88024f27cec0 schedule
[   25.868291] usb 2-1: link qh256-0001/ffff88024f27cec0 start 1 [1/0 us]
[   25.868390] hub 2-1:1.0: state 7 ports 8 chg 0000 evt 0000
[   25.869358] usb 2-1.2: usb auto-resume
[   25.915140] usb 2-1.2: finish resume
[   25.917423] ehci_hcd 0000:00:1d.0: reused qh ffff88024f1c89c0 schedule
[   25.917434] usb 2-1.2: link qh8-0e01/ffff88024f1c89c0 start 2 [1/2 us]
[   25.917481] ehci_hcd 0000:00:1d.0: reused qh ffff88025051d640 schedule
[   25.917483] usb 2-1.2: link qh8-0e01/ffff88025051d640 start 3 [1/2 us]
[   25.939067] xhci_hcd 0000:04:00.0: PME# disabled
[   25.939081] xhci_hcd 0000:04:00.0: setting latency timer to 64
[   25.939092] xhci_hcd 0000:04:00.0: // Setting command ring address to 0x37021001
[   25.939127] xhci_hcd 0000:04:00.0: hcd_pci_runtime_resume: 0
[   25.939130] usb usb3: usb auto-resume
[   25.939153] usb usb4: usb wakeup-resume
[   25.939154] usb usb4: usb auto-resume
[   25.954917] hub 4-0:1.0: hub_resume
[   25.954935] xhci_hcd 0000:04:00.0: get port status, actual port 0 status  = 0x2a0
[   25.954942] xhci_hcd 0000:04:00.0: Get port status returned 0x2a0
[   25.954955] xhci_hcd 0000:04:00.0: get port status, actual port 1 status  = 0x2a0
[   25.954960] xhci_hcd 0000:04:00.0: Get port status returned 0x2a0
[   25.955024] hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
[   25.955035] hub 3-0:1.0: hub_resume
[   25.955041] xhci_hcd 0000:04:00.0: get port status, actual port 0 status  = 0x2a0
[   25.955042] xhci_hcd 0000:04:00.0: Get port status returned 0x100
[   25.955047] xhci_hcd 0000:04:00.0: get port status, actual port 1 status  = 0x2a0
[   25.955049] xhci_hcd 0000:04:00.0: Get port status returned 0x100
[   25.955083] hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0000
[   25.955711] hub 4-0:1.0: hub_suspend
[   25.955716] usb usb4: bus auto-suspend, wakeup 1
[   25.955771] usb usb4: usb auto-resume
[   25.982909] hub 4-0:1.0: hub_resume
[   25.982927] xhci_hcd 0000:04:00.0: get port status, actual port 0 status  = 0x2a0
[   25.982933] xhci_hcd 0000:04:00.0: Get port status returned 0x2a0
[   25.982946] xhci_hcd 0000:04:00.0: get port status, actual port 1 status  = 0x2a0
[   25.982951] xhci_hcd 0000:04:00.0: Get port status returned 0x2a0
[   25.983014] hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
[   26.714909] ACPI: \_SB_.DOCK - docking
[   26.717134] pci 0000:08:00.0: [8086:151b] type 1 class 0x000604
[   26.717227] pci 0000:08:00.0: supports D1 D2
[   26.717228] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.717234] pci 0000:08:00.0: PME# disabled
[   26.717351] pci 0000:0a:00.0: [8086:151b] type 1 class 0x000604
[   26.717442] pci 0000:0a:00.0: supports D1 D2
[   26.717443] pci 0000:0a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.717449] pci 0000:0a:00.0: PME# disabled
[   26.717508] pci 0000:0a:03.0: [8086:151b] type 1 class 0x000604
[   26.717604] pci 0000:0a:03.0: supports D1 D2
[   26.717605] pci 0000:0a:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.717610] pci 0000:0a:03.0: PME# disabled
[   26.717660] pci 0000:0a:04.0: [8086:151b] type 1 class 0x000604
[   26.717751] pci 0000:0a:04.0: supports D1 D2
[   26.717752] pci 0000:0a:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.717757] pci 0000:0a:04.0: PME# disabled
[   26.717831] pci 0000:08:00.0: PCI bridge to [bus 0a-1d]
[   26.719281] pci 0000:08:00.0:   bridge window [io  0x3000-0x5fff]
[   26.719287] pci 0000:08:00.0:   bridge window [mem 0xb0000000-0xc03fffff]
[   26.719296] pci 0000:08:00.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
[   26.719363] pci 0000:0a:00.0: PCI bridge to [bus 0b-0b]
[   26.720785] pci 0000:0a:00.0:   bridge window [mem 0xc0300000-0xc03fffff]
[   26.720861] pci 0000:0a:03.0: PCI bridge to [bus 0c-0c]
[   26.722375] pci 0000:14:00.0: [8086:151b] type 1 class 0x000604
[   26.722529] pci 0000:14:00.0: supports D1 D2
[   26.722531] pci 0000:14:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.722538] pci 0000:14:00.0: PME# disabled
[   26.722593] pci 0000:0a:04.0: PCI bridge to [bus 14-1d]
[   26.723991] pci 0000:0a:04.0:   bridge window [io  0x3000-0x5fff]
[   26.723996] pci 0000:0a:04.0:   bridge window [mem 0xb0000000-0xc02fffff]
[   26.724005] pci 0000:0a:04.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
[   26.724162] pci 0000:15:03.0: [8086:151b] type 1 class 0x000604
[   26.724318] pci 0000:15:03.0: supports D1 D2
[   26.724319] pci 0000:15:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.724327] pci 0000:15:03.0: PME# disabled
[   26.724407] pci 0000:15:04.0: [8086:151b] type 1 class 0x000604
[   26.724563] pci 0000:15:04.0: supports D1 D2
[   26.724564] pci 0000:15:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.724572] pci 0000:15:04.0: PME# disabled
[   26.724697] pci 0000:14:00.0: PCI bridge to [bus 15-1d]
[   26.726080] pci 0000:14:00.0:   bridge window [io  0x3000-0x5fff]
[   26.726088] pci 0000:14:00.0:   bridge window [mem 0xb0000000-0xc02fffff]
[   26.726101] pci 0000:14:00.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
[   26.726252] pci 0000:16:00.0: [1002:6740] type 0 class 0x000300
[   26.726308] pci 0000:16:00.0: reg 10: [mem 0x00000000-0x0fffffff 64bit pref]
[   26.726352] pci 0000:16:00.0: reg 18: [mem 0x00000000-0x0001ffff 64bit]
[   26.726381] pci 0000:16:00.0: reg 20: [io  0x0000-0x00ff]
[   26.726437] pci 0000:16:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
[   26.726513] pci 0000:16:00.0: supports D1 D2
[   26.726602] pci 0000:16:00.1: [1002:aa90] type 0 class 0x000403
[   26.726661] pci 0000:16:00.1: reg 10: [mem 0x00000000-0x00003fff 64bit]
[   26.726871] pci 0000:16:00.1: supports D1 D2
[   26.726942] pci 0000:15:03.0: PCI bridge to [bus 16-16]
[   26.728314] pci 0000:15:03.0:   bridge window [io  0x5000-0x5fff]
[   26.728322] pci 0000:15:03.0:   bridge window [mem 0xc0200000-0xc02fffff]
[   26.728335] pci 0000:15:03.0:   bridge window [mem 0xb0000000-0xbfffffff 64bit pref]
[   26.728501] pci 0000:17:00.0: [8086:151b] type 1 class 0x000604
[   26.728719] pci 0000:17:00.0: supports D1 D2
[   26.728721] pci 0000:17:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.728731] pci 0000:17:00.0: PME# disabled
[   26.728810] pci 0000:15:04.0: PCI bridge to [bus 17-1d]
[   26.730163] pci 0000:15:04.0:   bridge window [io  0x3000-0x4fff]
[   26.730171] pci 0000:15:04.0:   bridge window [mem 0xc0000000-0xc01fffff]
[   26.730185] pci 0000:15:04.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
[   26.730392] pci 0000:18:00.0: [8086:151b] type 1 class 0x000604
[   26.730619] pci 0000:18:00.0: supports D1 D2
[   26.730620] pci 0000:18:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.730631] pci 0000:18:00.0: PME# disabled
[   26.730765] pci 0000:18:01.0: [8086:151b] type 1 class 0x000604
[   26.730986] pci 0000:18:01.0: supports D1 D2
[   26.730988] pci 0000:18:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.730998] pci 0000:18:01.0: PME# disabled
[   26.731115] pci 0000:18:02.0: [8086:151b] type 1 class 0x000604
[   26.731337] pci 0000:18:02.0: supports D1 D2
[   26.731338] pci 0000:18:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.731349] pci 0000:18:02.0: PME# disabled
[   26.731470] pci 0000:18:03.0: [8086:151b] type 1 class 0x000604
[   26.731692] pci 0000:18:03.0: supports D1 D2
[   26.731693] pci 0000:18:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.731704] pci 0000:18:03.0: PME# disabled
[   26.731829] pci 0000:18:04.0: [8086:151b] type 1 class 0x000604
[   26.732051] pci 0000:18:04.0: supports D1 D2
[   26.732052] pci 0000:18:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.732062] pci 0000:18:04.0: PME# disabled
[   26.732252] pci 0000:17:00.0: PCI bridge to [bus 18-1d]
[   26.733602] pci 0000:17:00.0:   bridge window [io  0x3000-0x4fff]
[   26.733613] pci 0000:17:00.0:   bridge window [mem 0xc0000000-0xc01fffff]
[   26.733631] pci 0000:17:00.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
[   26.733851] pci 0000:19:00.0: [10ec:8168] type 0 class 0x000200
[   26.733905] pci 0000:19:00.0: reg 10: [io  0x0000-0x00ff]
[   26.734000] pci 0000:19:00.0: reg 18: [mem 0x00000000-0x00000fff 64bit pref]
[   26.734059] pci 0000:19:00.0: reg 20: [mem 0x00000000-0x00003fff 64bit pref]
[   26.734228] pci 0000:19:00.0: supports D1 D2
[   26.734230] pci 0000:19:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   26.734242] pci 0000:19:00.0: PME# disabled
[   26.734336] pci 0000:18:00.0: PCI bridge to [bus 19-19]
[   26.735646] pci 0000:18:00.0:   bridge window [io  0x4000-0x4fff]
[   26.735674] pci 0000:18:00.0:   bridge window [mem 0xd4400000-0xd44fffff 64bit pref]
[   26.735897] pci 0000:1a:00.0: [11ab:6121] type 0 class 0x000101
[   26.735951] pci 0000:1a:00.0: reg 10: [io  0x8000-0x8007]
[   26.735989] pci 0000:1a:00.0: reg 14: [io  0x8040-0x8043]
[   26.736027] pci 0000:1a:00.0: reg 18: [io  0x8200-0x8207]
[   26.736065] pci 0000:1a:00.0: reg 1c: [io  0x8800-0x8803]
[   26.736103] pci 0000:1a:00.0: reg 20: [io  0x900000-0x90000f]
[   26.736142] pci 0000:1a:00.0: reg 24: [mem 0x00800000-0x008003ff]
[   26.736294] pci 0000:1a:00.0: supports D1
[   26.736295] pci 0000:1a:00.0: PME# supported from D0 D1 D3hot
[   26.736307] pci 0000:1a:00.0: PME# disabled
[   26.736365] pci 0000:1a:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[   26.737704] pci 0000:18:01.0: PCI bridge to [bus 1a-1a]
[   26.739075] pci 0000:18:01.0:   bridge window [io  0x3000-0x3fff]
[   26.739085] pci 0000:18:01.0:   bridge window [mem 0xc0100000-0xc01fffff]
[   26.739334] pci 0000:1b:00.0: [1033:0194] type 0 class 0x000c03
[   26.739405] pci 0000:1b:00.0: reg 10: [mem 0x00000000-0x00001fff 64bit]
[   26.739706] pci 0000:1b:00.0: PME# supported from D0 D3hot D3cold
[   26.739717] pci 0000:1b:00.0: PME# disabled
[   26.739802] pci 0000:18:02.0: PCI bridge to [bus 1b-1b]
[   26.741179] pci 0000:18:02.0:   bridge window [mem 0xc0000000-0xc00fffff]
[   26.741360] pci 0000:18:03.0: PCI bridge to [bus 1c-1c]
[   26.742925] pci 0000:18:04.0: PCI bridge to [bus 1d-1d]
[   26.745179] ACPI: Delete PCI Interrupt Routing Table for 0000:0a
[   26.745497] [Firmware Bug]: ACPI(GFXA) defines _DOD but not _DOS
[   26.747443] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:1f/device:4d/device:50/device:51/device:52/LNXVIDEO:0a/input/input8
[   26.749281] ACPI: Video Device [GFXA] (multi-head: yes  rom: no  post: no)
[   26.750838] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[   26.752790] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[   26.754290] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[   26.755769] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[   26.757225] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[   26.758682] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[   26.760112] [Firmware Bug]: Duplicate ACPI video bus devices for the same VGA controller, please try module parameter "video.allow_duplicates=1"if the current driver doesn't work.
[   26.762090] pci 0000:08:00.0: BAR 15: assigned [mem 0xb0000000-0xcbffffff pref]
[   26.763835] pci 0000:08:00.0: BAR 14: can't assign mem (size 0x10400000)
[   26.765355] pci 0000:08:00.0: BAR 13: assigned [io  0x3000-0x5fff]
[   26.766702] pci 0000:0a:04.0: BAR 15: assigned [mem 0xb0000000-0xcbffffff pref]
[   26.768037] pci 0000:0a:00.0: BAR 14: can't assign mem (size 0x100000)
[   26.769372] pci 0000:0a:04.0: BAR 14: can't assign mem (size 0x10300000)
[   26.770672] pci 0000:0a:04.0: BAR 13: assigned [io  0x3000-0x5fff]
[   26.771932] pci 0000:0a:00.0: PCI bridge to [bus 0b-0b]
[   26.773203] pci 0000:0a:03.0: PCI bridge to [bus 0c-0c]
[   26.774463] pci 0000:14:00.0: BAR 15: assigned [mem 0xb0000000-0xcbffffff pref]
[   26.775729] pci 0000:14:00.0: BAR 14: can't assign mem (size 0x10300000)
[   26.776986] pci 0000:14:00.0: BAR 13: assigned [io  0x3000-0x5fff]
[   26.778253] pci 0000:15:03.0: BAR 15: assigned [mem 0xb0000000-0xc7ffffff pref]
[   26.779533] pci 0000:15:03.0: BAR 14: can't assign mem (size 0x100000)
[   26.780812] pci 0000:15:04.0: BAR 14: can't assign mem (size 0x200000)
[   26.782086] pci 0000:15:04.0: BAR 15: assigned [mem 0xc8000000-0xc80fffff 64bit pref]
[   26.783356] pci 0000:15:03.0: BAR 13: assigned [io  0x3000-0x3fff]
[   26.784600] pci 0000:15:04.0: BAR 13: assigned [io  0x4000-0x5fff]
[   26.785829] pci 0000:16:00.0: BAR 0: assigned [mem 0xb0000000-0xbfffffff 64bit pref]
[   26.787098] pci 0000:16:00.0: BAR 0: set to [mem 0xb0000000-0xbfffffff 64bit pref] (PCI address [0xb0000000-0xbfffffff])
[   26.788379] pci 0000:16:00.0: BAR 2: can't assign mem (size 0x20000)
[   26.789661] pci 0000:16:00.0: BAR 6: assigned [mem 0xc0000000-0xc001ffff pref]
[   26.790950] pci 0000:16:00.1: BAR 0: can't assign mem (size 0x4000)
[   26.792240] pci 0000:16:00.0: BAR 4: assigned [io  0x3000-0x30ff]
[   26.793535] pci 0000:16:00.0: BAR 4: set to [io  0x3000-0x30ff] (PCI address [0x3000-0x30ff])
[   26.794841] pci 0000:15:03.0: PCI bridge to [bus 16-16]
[   26.796135] pci 0000:15:03.0:   bridge window [io  0x3000-0x3fff]
[   26.797446] pci 0000:15:03.0:   bridge window [mem 0xb0000000-0xc7ffffff pref]
[   26.798767] pci 0000:17:00.0: BAR 14: can't assign mem (size 0x200000)
[   26.800078] pci 0000:17:00.0: BAR 15: assigned [mem 0xc8000000-0xc80fffff 64bit pref]
[   26.801389] pci 0000:17:00.0: BAR 13: assigned [io  0x4000-0x5fff]
[   26.802689] pci 0000:18:00.0: BAR 15: assigned [mem 0xc8000000-0xc80fffff 64bit pref]
[   26.803985] pci 0000:18:01.0: BAR 14: can't assign mem (size 0x100000)
[   26.805290] pci 0000:18:02.0: BAR 14: can't assign mem (size 0x100000)
[   26.806570] pci 0000:18:00.0: BAR 13: assigned [io  0x4000-0x4fff]
[   26.807842] pci 0000:18:01.0: BAR 13: assigned [io  0x5000-0x5fff]
[   26.809111] pci 0000:19:00.0: BAR 4: assigned [mem 0xc8000000-0xc8003fff 64bit pref]
[   26.810423] pci 0000:19:00.0: BAR 4: set to [mem 0xc8000000-0xc8003fff 64bit pref] (PCI address [0xc8000000-0xc8003fff])
[   26.811725] pci 0000:19:00.0: BAR 2: assigned [mem 0xc8004000-0xc8004fff 64bit pref]
[   26.813040] pci 0000:19:00.0: BAR 2: set to [mem 0xc8004000-0xc8004fff 64bit pref] (PCI address [0xc8004000-0xc8004fff])
[   26.814344] pci 0000:19:00.0: BAR 0: assigned [io  0x4000-0x40ff]
[   26.815647] pci 0000:19:00.0: BAR 0: set to [io  0x4000-0x40ff] (PCI address [0x4000-0x40ff])
[   26.816940] pci 0000:18:00.0: PCI bridge to [bus 19-19]
[   26.818232] pci 0000:18:00.0:   bridge window [io  0x4000-0x4fff]
[   26.819553] pci 0000:18:00.0:   bridge window [mem 0xc8000000-0xc80fffff 64bit pref]
[   26.820885] pci 0000:1a:00.0: BAR 5: can't assign mem (size 0x400)
[   26.822207] pci 0000:1a:00.0: BAR 4: assigned [io  0x5000-0x500f]
[   26.823549] pci 0000:1a:00.0: BAR 4: set to [io  0x5000-0x500f] (PCI address [0x5000-0x500f])
[   26.824904] pci 0000:1a:00.0: BAR 0: assigned [io  0x5010-0x5017]
[   26.826276] pci 0000:1a:00.0: BAR 0: set to [io  0x5010-0x5017] (PCI address [0x5010-0x5017])
[   26.827669] pci 0000:1a:00.0: BAR 2: assigned [io  0x5018-0x501f]
[   26.829073] pci 0000:1a:00.0: BAR 2: set to [io  0x5018-0x501f] (PCI address [0x5018-0x501f])
[   26.830462] pci 0000:1a:00.0: BAR 1: assigned [io  0x5020-0x5023]
[   26.831850] pci 0000:1a:00.0: BAR 1: set to [io  0x5020-0x5023] (PCI address [0x5020-0x5023])
[   26.833243] pci 0000:1a:00.0: BAR 3: assigned [io  0x5024-0x5027]
[   26.834665] pci 0000:1a:00.0: BAR 3: set to [io  0x5024-0x5027] (PCI address [0x5024-0x5027])
[   26.836092] pci 0000:18:01.0: PCI bridge to [bus 1a-1a]
[   26.837511] pci 0000:18:01.0:   bridge window [io  0x5000-0x5fff]
[   26.838937] pci 0000:1b:00.0: BAR 0: can't assign mem (size 0x2000)
[   26.840290] pci 0000:18:02.0: PCI bridge to [bus 1b-1b]
[   26.841634] pci 0000:18:03.0: PCI bridge to [bus 1c-1c]
[   26.842987] pci 0000:18:04.0: PCI bridge to [bus 1d-1d]
[   26.844341] pci 0000:17:00.0: PCI bridge to [bus 18-1d]
[   26.845663] pci 0000:17:00.0:   bridge window [io  0x4000-0x5fff]
[   26.847023] pci 0000:17:00.0:   bridge window [mem 0xc8000000-0xc80fffff 64bit pref]
[   26.848390] pci 0000:15:04.0: PCI bridge to [bus 17-1d]
[   26.849757] pci 0000:15:04.0:   bridge window [io  0x4000-0x5fff]
[   26.851098] pci 0000:15:04.0:   bridge window [mem 0xc8000000-0xc80fffff 64bit pref]
[   26.852434] pci 0000:14:00.0: PCI bridge to [bus 15-1d]
[   26.853759] pci 0000:14:00.0:   bridge window [io  0x3000-0x5fff]
[   26.855101] pci 0000:14:00.0:   bridge window [mem 0xb0000000-0xcbffffff pref]
[   26.856433] pci 0000:0a:04.0: PCI bridge to [bus 14-1d]
[   26.857767] pci 0000:0a:04.0:   bridge window [io  0x3000-0x5fff]
[   26.859113] pci 0000:0a:04.0:   bridge window [mem 0xb0000000-0xcbffffff pref]
[   26.860458] pci 0000:08:00.0: PCI bridge to [bus 0a-1d]
[   26.861803] pci 0000:08:00.0:   bridge window [io  0x3000-0x5fff]
[   26.863159] pci 0000:08:00.0:   bridge window [mem 0xb0000000-0xcbffffff pref]
[   26.864512] pci 0000:08:00.0: no hotplug settings from platform
[   26.865856] pci 0000:0a:00.0: no hotplug settings from platform
[   26.867190] pci 0000:0a:03.0: no hotplug settings from platform
[   26.868503] pci 0000:0a:04.0: no hotplug settings from platform
[   26.869820] pci 0000:14:00.0: no hotplug settings from platform
[   26.871123] pci 0000:15:03.0: no hotplug settings from platform
[   26.872412] pci 0000:16:00.0: no hotplug settings from platform
[   26.873698] pci 0000:16:00.1: no hotplug settings from platform
[   26.874972] pci 0000:15:04.0: no hotplug settings from platform
[   26.876222] pci 0000:17:00.0: no hotplug settings from platform
[   26.877442] pci 0000:18:00.0: no hotplug settings from platform
[   26.878650] pci 0000:19:00.0: no hotplug settings from platform
[   26.879841] pci 0000:18:01.0: no hotplug settings from platform
[   26.881025] pci 0000:1a:00.0: no hotplug settings from platform
[   26.882189] pci 0000:18:02.0: no hotplug settings from platform
[   26.883336] pci 0000:1b:00.0: no hotplug settings from platform
[   26.884471] pci 0000:18:03.0: no hotplug settings from platform
[   26.885597] pci 0000:18:04.0: no hotplug settings from platform
[   26.886717] pci 0000:08:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.887831] pci 0000:08:00.0: setting latency timer to 64
[   26.887840] pci 0000:0a:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.888944] pci 0000:0a:00.0: setting latency timer to 64
[   26.888953] pci 0000:0a:03.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   26.890045] pci 0000:0a:03.0: setting latency timer to 64
[   26.890053] pci 0000:0a:04.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.891132] pci 0000:0a:04.0: setting latency timer to 64
[   26.891142] pci 0000:14:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.892220] pci 0000:14:00.0: setting latency timer to 64
[   26.892232] pci 0000:15:03.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   26.893297] pci 0000:15:03.0: setting latency timer to 64
[   26.893309] pci 0000:15:04.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.894377] pci 0000:15:04.0: setting latency timer to 64
[   26.894391] pci 0000:17:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.895448] pci 0000:17:00.0: setting latency timer to 64
[   26.895464] pci 0000:18:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.896493] pci 0000:18:00.0: setting latency timer to 64
[   26.896509] pci 0000:18:01.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[   26.897510] pci 0000:18:01.0: setting latency timer to 64
[   26.897526] pci 0000:18:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   26.898503] pci 0000:18:02.0: setting latency timer to 64
[   26.898519] pci 0000:18:03.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   26.899480] pci 0000:18:03.0: setting latency timer to 64
[   26.899496] pci 0000:18:04.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.900432] pci 0000:18:04.0: setting latency timer to 64
[   26.900504] pcieport 0000:08:00.0: setting latency timer to 64
[   26.900569] pcieport 0000:08:00.0: irq 48 for MSI/MSI-X
[   26.900738] pcieport 0000:0a:00.0: setting latency timer to 64
[   26.900799] pcieport 0000:0a:00.0: irq 49 for MSI/MSI-X
[   26.900959] pcieport 0000:0a:03.0: setting latency timer to 64
[   26.901021] pcieport 0000:0a:03.0: irq 50 for MSI/MSI-X
[   26.901180] pcieport 0000:0a:04.0: setting latency timer to 64
[   26.901241] pcieport 0000:0a:04.0: irq 51 for MSI/MSI-X
[   26.901425] pcieport 0000:14:00.0: setting latency timer to 64
[   26.901526] pcieport 0000:14:00.0: irq 52 for MSI/MSI-X
[   26.901742] pcieport 0000:15:03.0: setting latency timer to 64
[   26.901845] pcieport 0000:15:03.0: irq 53 for MSI/MSI-X
[   26.902113] pcieport 0000:15:04.0: setting latency timer to 64
[   26.902224] pcieport 0000:15:04.0: irq 54 for MSI/MSI-X
[   26.902446] vgaarb: device added: PCI:0000:16:00.0,decodes=io+mem,owns=none,locks=none
[   26.903397] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=none:owns=io+mem
[   26.904512] vgaarb: transferring owner from PCI:0000:00:02.0 to PCI:0000:16:00.0
[   26.905754] pcieport 0000:17:00.0: setting latency timer to 64
[   26.905901] pcieport 0000:17:00.0: irq 55 for MSI/MSI-X
[   26.906263] pcieport 0000:18:00.0: setting latency timer to 64
[   26.906415] pcieport 0000:18:00.0: irq 56 for MSI/MSI-X
[   26.906753] pcieport 0000:18:01.0: setting latency timer to 64
[   26.906900] pcieport 0000:18:01.0: irq 57 for MSI/MSI-X
[   26.907205] pcieport 0000:18:02.0: setting latency timer to 64
[   26.907349] pcieport 0000:18:02.0: irq 58 for MSI/MSI-X
[   26.907666] pcieport 0000:18:03.0: setting latency timer to 64
[   26.907819] pcieport 0000:18:03.0: irq 59 for MSI/MSI-X
[   26.908174] pcieport 0000:18:04.0: setting latency timer to 64
[   26.908323] pcieport 0000:18:04.0: irq 60 for MSI/MSI-X
[   26.908631] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[   26.909687] r8169 0000:19:00.0: enabling device (0000 -> 0003)
[   26.910678] r8169 0000:19:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[   26.911866] r8169 0000:19:00.0: setting latency timer to 64
[   26.912049] r8169 0000:19:00.0: irq 61 for MSI/MSI-X
[   26.912467] r8169 0000:19:00.0: eth1: RTL8168evl/8111evl at 0xffffc90000c3e000, 54:42:49:97:a2:64, XID 0c900800 IRQ 61
[   26.913617] r8169 0000:19:00.0: eth1: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[   26.914976] xhci_hcd 0000:1b:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   26.916313] xhci_hcd 0000:1b:00.0: controller already in use
[   26.916351] xhci_hcd 0000:1b:00.0: PCI INT A disabled
[   26.917766] xhci_hcd 0000:1b:00.0: init 0000:1b:00.0 fail, -16
[   26.919149] xhci_hcd: probe of 0000:1b:00.0 failed with error -16
[   26.920364] acpiphp: Slot [1-1] registered
[   26.921538] acpiphp: Slot [2] registered
[   26.922522] acpiphp: Slot [3] registered
[   26.923541] acpiphp: Slot [1-2] registered
[   26.924485] acpiphp_glue: sibling found, but _SUN doesn't match!
[   26.925541] pata_marvell 0000:1a:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[   26.925604] acpiphp: Slot [1-3] registered
[   26.925659] acpiphp: Slot [1-4] registered
[   26.925710] acpiphp: Slot [1-5] registered
[   26.929479] pata_marvell 0000:1a:00.0: setting latency timer to 64
[   26.929983] scsi6 : pata_marvell
[   26.931004] scsi7 : pata_marvell
[   26.931981] ata7: PATA max UDMA/100 cmd 0x5010 ctl 0x5020 bmdma 0x5000 irq 19
[   26.932980] ata8: PATA max UDMA/133 cmd 0x5018 ctl 0x5024 bmdma 0x5008 irq 19
[   27.295886] ata8.00: ATAPI: Optiarc DVD RW AD-7690H, 1.70, max UDMA/100
[   27.311893] ata8.00: configured for UDMA/100
[   27.316989] scsi 7:0:0:0: CD-ROM            Optiarc  DVD RW AD-7690H  1.70 PQ: 0 ANSI: 5
[   27.334382] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda caddy
[   27.335401] cdrom: Uniform CD-ROM driver Revision: 3.20
[   27.336636] sr 7:0:0:0: Attached scsi CD-ROM sr0
[   63.083149] xhci_hcd 0000:04:00.0: Poll event ring: 4294908032
[   63.083207] xhci_hcd 0000:04:00.0: op reg status = 0x0
[   63.083216] xhci_hcd 0000:04:00.0: ir_set 0 pending = 0x2
[   63.083220] xhci_hcd 0000:04:00.0: HC error bitmask = 0x4
[   63.083224] xhci_hcd 0000:04:00.0: Event ring:
[   63.083232] xhci_hcd 0000:04:00.0: @0000000037021400 37021000 00000000 01004015 0000c001
[   63.083239] xhci_hcd 0000:04:00.0: @0000000037021410 00000000 00000000 00000000 00000000
[   63.083254] xhci_hcd 0000:04:00.0: @0000000037021420 00000000 00000000 00000000 00000000
[   63.083256] xhci_hcd 0000:04:00.0: @0000000037021430 00000000 00000000 00000000 00000000
[   63.083258] xhci_hcd 0000:04:00.0: @0000000037021440 00000000 00000000 00000000 00000000
[   63.083260] xhci_hcd 0000:04:00.0: @0000000037021450 00000000 00000000 00000000 00000000
[   63.083261] xhci_hcd 0000:04:00.0: @0000000037021460 00000000 00000000 00000000 00000000
[   63.083263] xhci_hcd 0000:04:00.0: @0000000037021470 00000000 00000000 00000000 00000000
[   63.083265] xhci_hcd 0000:04:00.0: @0000000037021480 00000000 00000000 00000000 00000000
[   63.083267] xhci_hcd 0000:04:00.0: @0000000037021490 00000000 00000000 00000000 00000000
[   63.083269] xhci_hcd 0000:04:00.0: @00000000370214a0 00000000 00000000 00000000 00000000
[   63.083270] xhci_hcd 0000:04:00.0: @00000000370214b0 00000000 00000000 00000000 00000000
[   63.083272] xhci_hcd 0000:04:00.0: @00000000370214c0 00000000 00000000 00000000 00000000
[   63.083274] xhci_hcd 0000:04:00.0: @00000000370214d0 00000000 00000000 00000000 00000000
[   63.083276] xhci_hcd 0000:04:00.0: @00000000370214e0 00000000 00000000 00000000 00000000
[   63.083277] xhci_hcd 0000:04:00.0: @00000000370214f0 00000000 00000000 00000000 00000000
[   63.083279] xhci_hcd 0000:04:00.0: @0000000037021500 00000000 00000000 00000000 00000000
[   63.083281] xhci_hcd 0000:04:00.0: @0000000037021510 00000000 00000000 00000000 00000000
[   63.083283] xhci_hcd 0000:04:00.0: @0000000037021520 00000000 00000000 00000000 00000000
[   63.083285] xhci_hcd 0000:04:00.0: @0000000037021530 00000000 00000000 00000000 00000000
[   63.083286] xhci_hcd 0000:04:00.0: @0000000037021540 00000000 00000000 00000000 00000000
[   63.083288] xhci_hcd 0000:04:00.0: @0000000037021550 00000000 00000000 00000000 00000000
[   63.083290] xhci_hcd 0000:04:00.0: @0000000037021560 00000000 00000000 00000000 00000000
[   63.083292] xhci_hcd 0000:04:00.0: @0000000037021570 00000000 00000000 00000000 00000000
[   63.083293] xhci_hcd 0000:04:00.0: @0000000037021580 00000000 00000000 00000000 00000000
[   63.083295] xhci_hcd 0000:04:00.0: @0000000037021590 00000000 00000000 00000000 00000000
[   63.083297] xhci_hcd 0000:04:00.0: @00000000370215a0 00000000 00000000 00000000 00000000
[   63.083299] xhci_hcd 0000:04:00.0: @00000000370215b0 00000000 00000000 00000000 00000000
[   63.083300] xhci_hcd 0000:04:00.0: @00000000370215c0 00000000 00000000 00000000 00000000
[   63.083302] xhci_hcd 0000:04:00.0: @00000000370215d0 00000000 00000000 00000000 00000000
[   63.083304] xhci_hcd 0000:04:00.0: @00000000370215e0 00000000 00000000 00000000 00000000
[   63.083306] xhci_hcd 0000:04:00.0: @00000000370215f0 00000000 00000000 00000000 00000000
[   63.083308] xhci_hcd 0000:04:00.0: @0000000037021600 00000000 00000000 00000000 00000000
[   63.083309] xhci_hcd 0000:04:00.0: @0000000037021610 00000000 00000000 00000000 00000000
[   63.083311] xhci_hcd 0000:04:00.0: @0000000037021620 00000000 00000000 00000000 00000000
[   63.083313] xhci_hcd 0000:04:00.0: @0000000037021630 00000000 00000000 00000000 00000000
[   63.083315] xhci_hcd 0000:04:00.0: @0000000037021640 00000000 00000000 00000000 00000000
[   63.083316] xhci_hcd 0000:04:00.0: @0000000037021650 00000000 00000000 00000000 00000000
[   63.083318] xhci_hcd 0000:04:00.0: @0000000037021660 00000000 00000000 00000000 00000000
[   63.083320] xhci_hcd 0000:04:00.0: @0000000037021670 00000000 00000000 00000000 00000000
[   63.083322] xhci_hcd 0000:04:00.0: @0000000037021680 00000000 00000000 00000000 00000000
[   63.083323] xhci_hcd 0000:04:00.0: @0000000037021690 00000000 00000000 00000000 00000000
[   63.083325] xhci_hcd 0000:04:00.0: @00000000370216a0 00000000 00000000 00000000 00000000
[   63.083327] xhci_hcd 0000:04:00.0: @00000000370216b0 00000000 00000000 00000000 00000000
[   63.083329] xhci_hcd 0000:04:00.0: @00000000370216c0 00000000 00000000 00000000 00000000
[   63.083330] xhci_hcd 0000:04:00.0: @00000000370216d0 00000000 00000000 00000000 00000000
[   63.083332] xhci_hcd 0000:04:00.0: @00000000370216e0 00000000 00000000 00000000 00000000
[   63.083334] xhci_hcd 0000:04:00.0: @00000000370216f0 00000000 00000000 00000000 00000000
[   63.083336] xhci_hcd 0000:04:00.0: @0000000037021700 00000000 00000000 00000000 00000000
[   63.083338] xhci_hcd 0000:04:00.0: @0000000037021710 00000000 00000000 00000000 00000000
[   63.083339] xhci_hcd 0000:04:00.0: @0000000037021720 00000000 00000000 00000000 00000000
[   63.083341] xhci_hcd 0000:04:00.0: @0000000037021730 00000000 00000000 00000000 00000000
[   63.083343] xhci_hcd 0000:04:00.0: @0000000037021740 00000000 00000000 00000000 00000000
[   63.083345] xhci_hcd 0000:04:00.0: @0000000037021750 00000000 00000000 00000000 00000000
[   63.083346] xhci_hcd 0000:04:00.0: @0000000037021760 00000000 00000000 00000000 00000000
[   63.083348] xhci_hcd 0000:04:00.0: @0000000037021770 00000000 00000000 00000000 00000000
[   63.083350] xhci_hcd 0000:04:00.0: @0000000037021780 00000000 00000000 00000000 00000000
[   63.083352] xhci_hcd 0000:04:00.0: @0000000037021790 00000000 00000000 00000000 00000000
[   63.083354] xhci_hcd 0000:04:00.0: @00000000370217a0 00000000 00000000 00000000 00000000
[   63.083355] xhci_hcd 0000:04:00.0: @00000000370217b0 00000000 00000000 00000000 00000000
[   63.083357] xhci_hcd 0000:04:00.0: @00000000370217c0 00000000 00000000 00000000 00000000
[   63.083359] xhci_hcd 0000:04:00.0: @00000000370217d0 00000000 00000000 00000000 00000000
[   63.083361] xhci_hcd 0000:04:00.0: @00000000370217e0 00000000 00000000 00000000 00000000
[   63.083363] xhci_hcd 0000:04:00.0: @00000000370217f0 00000000 00000000 00000000 00000000
[   63.083365] xhci_hcd 0000:04:00.0: Ring deq = ffff880037021410 (virt), 0x37021410 (dma)
[   63.083366] xhci_hcd 0000:04:00.0: Ring deq updated 1 times
[   63.083368] xhci_hcd 0000:04:00.0: Ring enq = ffff880037021400 (virt), 0x37021400 (dma)
[   63.083370] xhci_hcd 0000:04:00.0: Ring enq updated 0 times
[   63.083377] xhci_hcd 0000:04:00.0: ERST deq = 64'h37021410
[   63.083378] xhci_hcd 0000:04:00.0: Command ring:
[   63.083380] xhci_hcd 0000:04:00.0: @0000000037021000 00000000 00000000 00000000 00000000
[   63.083382] xhci_hcd 0000:04:00.0: @0000000037021010 00000000 00000000 00000000 00000000
[   63.083383] xhci_hcd 0000:04:00.0: @0000000037021020 00000000 00000000 00000000 00000000
[   63.083385] xhci_hcd 0000:04:00.0: @0000000037021030 00000000 00000000 00000000 00000000
[   63.083387] xhci_hcd 0000:04:00.0: @0000000037021040 00000000 00000000 00000000 00000000
[   63.083389] xhci_hcd 0000:04:00.0: @0000000037021050 00000000 00000000 00000000 00000000
[   63.083390] xhci_hcd 0000:04:00.0: @0000000037021060 00000000 00000000 00000000 00000000
[   63.083392] xhci_hcd 0000:04:00.0: @0000000037021070 00000000 00000000 00000000 00000000
[   63.083394] xhci_hcd 0000:04:00.0: @0000000037021080 00000000 00000000 00000000 00000000
[   63.083396] xhci_hcd 0000:04:00.0: @0000000037021090 00000000 00000000 00000000 00000000
[   63.083398] xhci_hcd 0000:04:00.0: @00000000370210a0 00000000 00000000 00000000 00000000
[   63.083399] xhci_hcd 0000:04:00.0: @00000000370210b0 00000000 00000000 00000000 00000000
[   63.083401] xhci_hcd 0000:04:00.0: @00000000370210c0 00000000 00000000 00000000 00000000
[   63.083403] xhci_hcd 0000:04:00.0: @00000000370210d0 00000000 00000000 00000000 00000000
[   63.083405] xhci_hcd 0000:04:00.0: @00000000370210e0 00000000 00000000 00000000 00000000
[   63.083406] xhci_hcd 0000:04:00.0: @00000000370210f0 00000000 00000000 00000000 00000000
[   63.083408] xhci_hcd 0000:04:00.0: @0000000037021100 00000000 00000000 00000000 00000000
[   63.083410] xhci_hcd 0000:04:00.0: @0000000037021110 00000000 00000000 00000000 00000000
[   63.083412] xhci_hcd 0000:04:00.0: @0000000037021120 00000000 00000000 00000000 00000000
[   63.083413] xhci_hcd 0000:04:00.0: @0000000037021130 00000000 00000000 00000000 00000000
[   63.083415] xhci_hcd 0000:04:00.0: @0000000037021140 00000000 00000000 00000000 00000000
[   63.083417] xhci_hcd 0000:04:00.0: @0000000037021150 00000000 00000000 00000000 00000000
[   63.083419] xhci_hcd 0000:04:00.0: @0000000037021160 00000000 00000000 00000000 00000000
[   63.083420] xhci_hcd 0000:04:00.0: @0000000037021170 00000000 00000000 00000000 00000000
[   63.083422] xhci_hcd 0000:04:00.0: @0000000037021180 00000000 00000000 00000000 00000000
[   63.083424] xhci_hcd 0000:04:00.0: @0000000037021190 00000000 00000000 00000000 00000000
[   63.083426] xhci_hcd 0000:04:00.0: @00000000370211a0 00000000 00000000 00000000 00000000
[   63.083427] xhci_hcd 0000:04:00.0: @00000000370211b0 00000000 00000000 00000000 00000000
[   63.083429] xhci_hcd 0000:04:00.0: @00000000370211c0 00000000 00000000 00000000 00000000
[   63.083431] xhci_hcd 0000:04:00.0: @00000000370211d0 00000000 00000000 00000000 00000000
[   63.083433] xhci_hcd 0000:04:00.0: @00000000370211e0 00000000 00000000 00000000 00000000
[   63.083435] xhci_hcd 0000:04:00.0: @00000000370211f0 00000000 00000000 00000000 00000000
[   63.083436] xhci_hcd 0000:04:00.0: @0000000037021200 00000000 00000000 00000000 00000000
[   63.083438] xhci_hcd 0000:04:00.0: @0000000037021210 00000000 00000000 00000000 00000000
[   63.083440] xhci_hcd 0000:04:00.0: @0000000037021220 00000000 00000000 00000000 00000000
[   63.083442] xhci_hcd 0000:04:00.0: @0000000037021230 00000000 00000000 00000000 00000000
[   63.083443] xhci_hcd 0000:04:00.0: @0000000037021240 00000000 00000000 00000000 00000000
[   63.083445] xhci_hcd 0000:04:00.0: @0000000037021250 00000000 00000000 00000000 00000000
[   63.083447] xhci_hcd 0000:04:00.0: @0000000037021260 00000000 00000000 00000000 00000000
[   63.083448] xhci_hcd 0000:04:00.0: @0000000037021270 00000000 00000000 00000000 00000000
[   63.083450] xhci_hcd 0000:04:00.0: @0000000037021280 00000000 00000000 00000000 00000000
[   63.083452] xhci_hcd 0000:04:00.0: @0000000037021290 00000000 00000000 00000000 00000000
[   63.083454] xhci_hcd 0000:04:00.0: @00000000370212a0 00000000 00000000 00000000 00000000
[   63.083455] xhci_hcd 0000:04:00.0: @00000000370212b0 00000000 00000000 00000000 00000000
[   63.083457] xhci_hcd 0000:04:00.0: @00000000370212c0 00000000 00000000 00000000 00000000
[   63.083459] xhci_hcd 0000:04:00.0: @00000000370212d0 00000000 00000000 00000000 00000000
[   63.083461] xhci_hcd 0000:04:00.0: @00000000370212e0 00000000 00000000 00000000 00000000
[   63.083462] xhci_hcd 0000:04:00.0: @00000000370212f0 00000000 00000000 00000000 00000000
[   63.083464] xhci_hcd 0000:04:00.0: @0000000037021300 00000000 00000000 00000000 00000000
[   63.083466] xhci_hcd 0000:04:00.0: @0000000037021310 00000000 00000000 00000000 00000000
[   63.083467] xhci_hcd 0000:04:00.0: @0000000037021320 00000000 00000000 00000000 00000000
[   63.083469] xhci_hcd 0000:04:00.0: @0000000037021330 00000000 00000000 00000000 00000000
[   63.083471] xhci_hcd 0000:04:00.0: @0000000037021340 00000000 00000000 00000000 00000000
[   63.083473] xhci_hcd 0000:04:00.0: @0000000037021350 00000000 00000000 00000000 00000000
[   63.083474] xhci_hcd 0000:04:00.0: @0000000037021360 00000000 00000000 00000000 00000000
[   63.083476] xhci_hcd 0000:04:00.0: @0000000037021370 00000000 00000000 00000000 00000000
[   63.083478] xhci_hcd 0000:04:00.0: @0000000037021380 00000000 00000000 00000000 00000000
[   63.083479] xhci_hcd 0000:04:00.0: @0000000037021390 00000000 00000000 00000000 00000000
[   63.083481] xhci_hcd 0000:04:00.0: @00000000370213a0 00000000 00000000 00000000 00000000
[   63.083483] xhci_hcd 0000:04:00.0: @00000000370213b0 00000000 00000000 00000000 00000000
[   63.083485] xhci_hcd 0000:04:00.0: @00000000370213c0 00000000 00000000 00000000 00000000
[   63.083486] xhci_hcd 0000:04:00.0: @00000000370213d0 00000000 00000000 00000000 00000000
[   63.083488] xhci_hcd 0000:04:00.0: @00000000370213e0 00000000 00000000 00000000 00000000
[   63.083490] xhci_hcd 0000:04:00.0: @00000000370213f0 37021000 00000000 00000000 00001802
[   63.083492] xhci_hcd 0000:04:00.0: Ring deq = ffff880037021000 (virt), 0x37021000 (dma)
[   63.083493] xhci_hcd 0000:04:00.0: Ring deq updated 1 times
[   63.083495] xhci_hcd 0000:04:00.0: Ring enq = ffff880037021000 (virt), 0x37021000 (dma)
[   63.083496] xhci_hcd 0000:04:00.0: Ring enq updated 1 times
[   63.083550] xhci_hcd 0000:04:00.0: // xHC command ring deq ptr low bits + flags = @00000000
[   63.083551] xhci_hcd 0000:04:00.0: // xHC command ring deq ptr high bits = @00000000

--jRHKVT23PllUwdXP--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
