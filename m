From: vick <weasalandme-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Thunderbolt hotplug issue, was: Re: xhci errors when hotplugging a NEC uPD720200 USB hub.
Date: Thu, 15 Dec 2011 14:19:41 -0800 (PST)
Message-ID: <1323987581.55224.YahooMailNeo@web162002.mail.bf1.yahoo.com>
References: <loom.20111214T205055-477@post.gmane.org> <20111215001636.GA7840@xanatos> <1323965859.69300.YahooMailNeo@web162001.mail.bf1.yahoo.com> <20111215214834.GB6482@xanatos>
Reply-To: vick <weasalandme-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111215214834.GB6482@xanatos>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>"linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> The non-working dmesg is very odd, and I think it's a PCI hot plug or
> ACPI issue.=A0 Around 1 second in, the Thunderbolt dock is found, but=
 later
> it is hot-removed, and the PCI drivers are not notified of removal.
> Then the dock is hot-plugged again, and the PCI core attempts to
> initialized the drivers again, which fails.

Around 1 sec in,=A0 the dock was not attached yet.

>=20
>>=A0=A0[=A0 =A0 1.009781] ACPI: ACPI Dock Station Driver: 1 docks/bays=
 found
>>=A0=A0[=A0 =A0 1.009841] HEST: Table not found.
>>=A0=A0[=A0 =A0 1.009898] PCI: Using host bridge windows from ACPI; if=
 necessary, use=20
> "pci=3Dnocrs" and report a bug

I believe this message just means that there were acpi calls found that=
 suggest there is 1 bay port. I am certain the dock was not connected a=
t that time.

> The xHCI driver eventually loads for PCI device 0000:04:00.0:
>=20
>>=A0=A0[=A0 =A0 3.088620] xhci_hcd 0000:04:00.0: PCI INT A -> GSI 18 (=
level, low)=20
> -> IRQ 18
>>=A0=A0[=A0 =A0 3.088727] xhci_hcd 0000:04:00.0: setting latency timer=
 to 64
>>=A0=A0[=A0 =A0 3.088731] xhci_hcd 0000:04:00.0: xHCI Host Controller
>>=A0=A0[=A0 =A0 3.088812] xhci_hcd 0000:04:00.0: new USB bus registere=
d, assigned bus=20
> number 3
>=20

This is the NEC hub inside the laptop, the one in the docking station i=
s at 1b:00.0

> Then your dock gets re-enumerated *again* without any sort of PCI
> disconnect for the existing drivers:
>=20
>>=A0=A0[=A0=A0=A026.714909] ACPI: \_SB_.DOCK - docking
>>=A0=A0[=A0=A0=A026.717134] pci 0000:08:00.0: [8086:151b] type 1 class=
 0x000604
>>=A0=A0[=A0=A0=A026.717227] pci 0000:08:00.0: supports D1 D2

This is when the dock was actually attached I believe. About 25 sec aft=
er boot sounds about right.

[=A0=A0 26.739334] pci 0000:1b:00.0: [1033:0194] type 0 class 0x000c03
[=A0=A0 26.739405] pci 0000:1b:00.0: reg 10: [mem 0x00000000-0x00001fff=
 64bit]
[=A0=A0 26.739706] pci 0000:1b:00.0: PME# supported from D0 D3hot D3col=
d
[=A0=A0 26.739717] pci 0000:1b:00.0: PME# disabled

And this is the first mention of the  usb host in the dock


>>=A0=A0[=A0=A0=A026.914976] xhci_hcd 0000:1b:00.0: PCI INT A -> GSI 16=
 (level, low)=20
> -> IRQ 16
>>=A0=A0[=A0=A0=A026.916313] xhci_hcd 0000:1b:00.0: controller already =
in use
>>=A0=A0[=A0=A0=A026.916351] xhci_hcd 0000:1b:00.0: PCI INT A disabled
>>=A0=A0[=A0=A0=A026.917766] xhci_hcd 0000:1b:00.0: init 0000:1b:00.0 f=
ail, -16
>>=A0=A0[=A0=A0=A026.919149] xhci_hcd: probe of 0000:1b:00.0 failed wit=
h error -16

Is it possible that because there are 2 identical hubs the driver gets =
confused?
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
