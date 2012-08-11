From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Kernel stops at "PM: Preparing system for mem sleep", never makes it to "Freezing user space processes ... "
Date: Sun, 12 Aug 2012 00:08:47 +0200
Message-ID: <201208120008.47633.rjw@sisk.pl>
References: <CACfp4335KJQ8Zjj0TJNj65Va9K-t_iEHLEGEi8QuWyQj5dVT0g@mail.gmail.com> <CACfp431RNXmp_453ZU999bQzdBgiU20FEehvLH+DxnZbALAc3A@mail.gmail.com> <CACfp432=M5XkqRXpKfzstvQo59tytHGoV1_r15DtV3ZhYvGwoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:34201 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633Ab2HKWCw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Aug 2012 18:02:52 -0400
In-Reply-To: <CACfp432=M5XkqRXpKfzstvQo59tytHGoV1_r15DtV3ZhYvGwoA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Athlion <athlion@gmail.com>
Cc: linux-pm@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Saturday, August 11, 2012, Athlion wrote:
> Ok, this thing happened again! Whatsmore, this happened on pm-suspend
> while on [core].
> 
> The kernel output this:

The majority of the messages below are not from the kernel.  The
kernel's messages contain the string "kernel:".

> Aug 11 17:59:16 localhost logger: LID closed
> Aug 11 17:59:16 localhost kernel: [32512.391116] EXT4-fs (sda1):
> re-mounted. Opts: discard,barrier=0,commit=0
> Aug 11 17:59:17 localhost kernel: [32512.520905] wlan0:
> deauthenticating from 00:13:33:a1:23:46 by local choice (reason=3)
> Aug 11 17:59:17 localhost kernel: [32512.530786] cfg80211: Calling
> CRDA to update world regulatory domain
> Aug 11 17:59:17 localhost NetworkManager[794]: <info> (wlan0): now unmanaged
> Aug 11 17:59:17 localhost NetworkManager[794]: <info> (wlan0): device
> state change: activated -> unmanaged (reason 'removed') [100 10 36]
> Aug 11 17:59:17 localhost NetworkManager[794]: <info> (wlan0):
> deactivating device (reason 'removed') [36]
> Aug 11 17:59:17 localhost dhcpcd[12635]: received SIGTERM, stopping
> Aug 11 17:59:17 localhost dhcpcd[12635]: wlan0: removing interface
> Aug 11 17:59:17 localhost dhcpcd[12635]: wlan0: del_route: No such device
> Aug 11 17:59:17 localhost dhcpcd[12635]: del_address: No such device
> Aug 11 17:59:17 localhost kernel: [32512.607181] ehci_hcd
> 0000:00:1d.0: remove, state 1
> Aug 11 17:59:17 localhost kernel: [32512.607212] usb usb2: USB
> disconnect, device number 1
> Aug 11 17:59:17 localhost kernel: [32512.607214] usb 2-1: USB
> disconnect, device number 2
> Aug 11 17:59:17 localhost kernel: [32512.612488] ehci_hcd
> 0000:00:1d.0: USB bus 2 deregistered
> Aug 11 17:59:17 localhost kernel: [32512.612528] ehci_hcd
> 0000:00:1a.0: remove, state 1
> Aug 11 17:59:17 localhost kernel: [32512.612533] usb usb1: USB
> disconnect, device number 1
> Aug 11 17:59:17 localhost kernel: [32512.612534] usb 1-1: USB
> disconnect, device number 2
> Aug 11 17:59:17 localhost kernel: [32512.617226] ehci_hcd
> 0000:00:1a.0: USB bus 1 deregistered
> Aug 11 17:59:17 localhost NetworkManager[794]: <info> (wlan0):
> canceled DHCP transaction, DHCP client pid 12635
> Aug 11 17:59:17 localhost NetworkManager[794]: <warn> (44) failed to
> find interface name for index
> Aug 11 17:59:17 localhost NetworkManager[794]:
> nm_system_iface_flush_routes: assertion `iface != NULL' failed
> Aug 11 17:59:17 localhost NetworkManager[794]: <warn> (44) failed to
> find interface name for index
> Aug 11 17:59:17 localhost NetworkManager[794]: <info> (wlan0): cleaning up...
> Aug 11 17:59:17 localhost NetworkManager[794]: <warn> (44) failed to
> find interface name for index
> Aug 11 17:59:17 localhost NetworkManager[794]:
> (nm-system.c:685):nm_system_iface_get_flags: runtime check failed:
> (iface != NULL)
> Aug 11 17:59:17 localhost NetworkManager[794]: <error>
> [1344697157.261251] [nm-system.c:687] nm_system_iface_get_flags():
> (unknown): failed to get interface link object
> Aug 11 17:59:17 localhost dbus[406]: [system] Activating service
> name='org.freedesktop.nm_dispatcher' (using servicehelper)
> Aug 11 17:59:17 localhost NetworkManager[794]: <info> radio killswitch
> /sys/devices/pci0000:00/0000:00:1c.1/0000:03:00.0/ieee80211/phy33/rfkill41
> disappeared
> Aug 11 17:59:17 localhost NetworkManager[794]: <warn> (pid 12635)
> unhandled DHCP event for interface wlan0
> Aug 11 17:59:17 localhost dbus[406]: [system] Successfully activated
> service 'org.freedesktop.nm_dispatcher'
> Aug 11 17:59:17 localhost kernel: [32512.842664] PM: Syncing
> filesystems ... done.
> Aug 11 17:59:17 localhost kernel: [32512.844894] PM: Preparing system
> for mem sleep

This seems to be the last kernel message you've got.

It looks like there's a problem with a power management notifier within
the kernel.  Perhaps a race condition, since it is not reproducible 100%
of the time.

Does it happen if you don't use the lid to trigger suspend?

Rafael
