From: =?iso-8859-1?Q?Fr=E9d=E9ric?= Gobry <frederic.gobry-p8DiymsW2f8@public.gmane.org>
Subject: t41, suspend on ram, power consumption
Date: Fri, 13 Jan 2006 10:56:34 +0100
Message-ID: <20060113095634.GA7112@mnementh.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On my Thinkpad T41, I try to use ACPI (Debian unstable, kernel 2.6.15)
to suspend the system on RAM. It works quite well (ie, it goes to sleep
and resumes properly), but I guess that some hardware parts are not
actually stopped properly, as:

  - the autonomy of the mode is very short (a few hours for a fully
    charged battery), whereas I managed to get at least one day of
    autonomy when APM used to work.

  - the laptop gets warm

Do you have an idea what could cause this behavior, or alternatively ho=
w
I could start tracking it down myself?

thanks,

=46r=E9d=E9ric


Jan 13 10:06:45 mnementh kernel: Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D|
Jan 13 10:06:45 mnementh kernel: ACPI: PCI interrupt for device 0000:02=
:02.0 disabled
Jan 13 10:06:45 mnementh kernel: ACPI: PCI interrupt for device 0000:02=
:01.0 disabled
Jan 13 10:06:45 mnementh kernel: ACPI: PCI interrupt for device 0000:02=
:00.1 disabled
Jan 13 10:06:45 mnementh kernel: ACPI: PCI interrupt for device 0000:02=
:00.0 disabled
Jan 13 10:06:45 mnementh kernel: ACPI: PCI interrupt for device 0000:00=
:1f.6 disabled
Jan 13 10:06:45 mnementh kernel: ACPI: PCI interrupt for device 0000:00=
:1f.5 disabled
Jan 13 10:06:45 mnementh kernel: ACPI: PCI interrupt for device 0000:00=
:1d.7 disabled
Jan 13 10:06:45 mnementh kernel: ACPI: PCI interrupt for device 0000:00=
:1d.2 disabled
Jan 13 10:06:45 mnementh kernel: ACPI: PCI interrupt for device 0000:00=
:1d.1 disabled
Jan 13 10:06:45 mnementh kernel: ACPI: PCI interrupt for device 0000:00=
:1d.0 disabled
Jan 13 10:06:45 mnementh kernel: Intel machine check architecture suppo=
rted.
Jan 13 10:06:45 mnementh kernel: Intel machine check reporting enabled =
on CPU#0.
Jan 13 10:06:45 mnementh kernel: PCI: Enabling device 0000:00:1d.0 (000=
0 -> 0001)
Jan 13 10:06:45 mnementh kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] ->=
 Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Jan 13 10:06:45 mnementh kernel: PCI: Enabling device 0000:00:1d.1 (000=
0 -> 0001)
Jan 13 10:06:45 mnementh kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] ->=
 Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
Jan 13 10:06:45 mnementh kernel: PCI: Enabling device 0000:00:1d.2 (000=
0 -> 0001)
Jan 13 10:06:45 mnementh kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] ->=
 Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
Jan 13 10:06:45 mnementh kernel: PCI: Enabling device 0000:00:1d.7 (000=
0 -> 0002)
Jan 13 10:06:45 mnementh kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] ->=
 Link [LNKH] -> GSI 11 (level, low) -> IRQ 11
Jan 13 10:06:45 mnementh kernel: ehci_hcd 0000:00:1d.7: debug port 1
Jan 13 10:06:45 mnementh kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started=
, EHCI 1.00, driver 10 Dec 2004
Jan 13 10:06:45 mnementh kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] ->=
 Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
Jan 13 10:06:45 mnementh kernel: ACPI: PCI Interrupt 0000:00:1f.5[B] ->=
 Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
Jan 13 10:06:45 mnementh kernel: ACPI: PCI Interrupt 0000:00:1f.6[B] ->=
 Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
Jan 13 10:06:45 mnementh kernel: ACPI: PCI Interrupt 0000:01:00.0[A] ->=
 Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Jan 13 10:06:45 mnementh kernel: ACPI: PCI Interrupt 0000:02:00.0[A] ->=
 Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Jan 13 10:06:45 mnementh kernel: ACPI: PCI Interrupt 0000:02:00.1[B] ->=
 Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
Jan 13 10:06:45 mnementh kernel: ACPI: PCI Interrupt 0000:02:01.0[A] ->=
 Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Jan 13 10:06:45 mnementh kernel: ACPI: PCI Interrupt 0000:02:02.0[A] ->=
 Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
Jan 13 10:06:45 mnementh kernel: e1000: eth0: e1000_watchdog_task: NIC =
Link is Up 100 Mbps Full Duplex
Jan 13 10:06:45 mnementh kernel: Restarting tasks...<3>hub 2-0:1.0: ove=
r-current change on port 1
Jan 13 10:06:45 mnementh kernel:  done
Jan 13 10:06:45 mnementh kernel: agpgart: Found an AGP 2.0 compliant de=
vice at 0000:00:00.0.
Jan 13 10:06:45 mnementh kernel: agpgart: Putting AGP V2 device at 0000=
:00:00.0 into 1x mode
Jan 13 10:06:45 mnementh kernel: agpgart: Putting AGP V2 device at 0000=
:01:00.0 into 1x mode
Jan 13 10:15:26 mnementh kernel: usb 3-1: new full speed USB device usi=
ng uhci_hcd and address 2
Jan 13 10:15:26 mnementh kernel: Bluetooth: HCI USB driver ver 2.9
Jan 13 10:15:26 mnementh kernel: usbcore: registered new driver hci_usb
Jan 13 10:15:29 mnementh kernel: usb 3-1: USB disconnect, address 2


 =20
--=20
=46r=E9d=E9ric Gobry    Infoscience
                  SISB / EPFL
                  Tel: +41216932288
http://people.epfl.ch/frederic.gobry

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
