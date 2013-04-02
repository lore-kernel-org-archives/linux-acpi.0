From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Tue, 02 Apr 2013 17:02:42 +0200
Message-ID: <515AF312.1010507@fold.natur.cuni.cz>
References: <2282655.IicBMMa6jN@vostro.rjw.lan> <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com> <51548C9E.9090703@fold.natur.cuni.cz> <2990024.LMTIBUbM3d@vostro.rjw.lan> <51564804.9000700@fold.natur.cuni.cz> <CAC=cRTMJH+40oPSM9pFzkb5x6Q42rWR8BPtUOxJn_3WopmOSvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:44370 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932131Ab3DBPCp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Apr 2013 11:02:45 -0400
In-Reply-To: <CAC=cRTMJH+40oPSM9pFzkb5x6Q42rWR8BPtUOxJn_3WopmOSvQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: huang ying <huang.ying.caritas@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

Hi Ying,

huang ying wrote:
> Hi, Martin,
> 
> On Sat, Mar 30, 2013 at 10:03 AM, Martin Mokrejs
> <mmokrejs@fold.natur.cuni.cz> wrote:
>> Rafael J. Wysocki wrote:

>>> If it doesn't make all of them go away, does it make *some* of them go away?
>>
>> Yes, repeated inserts and removals of devices into xHCI slot work fine, no need
>> to use "lsusb -vv" to wakeup devices.
>>
>> Aside from some minor USB errors (won't mess them here) what is important is the fact
>> that the eSATA card hotplug works well or perfectly. I just sent to you and other pci devs
>> much more detailed report under the "Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI"
>> thread although this particular testing was done on 3.8.3.
>>
>> I think I can stop replying to this thread which is about the patch from Sarah.
>> My dead XHCI port issue is a power management issue, incidentally also fixed by the
>> very same patch from Huang Ying. Cool! ;-)
> 
> Sorry, which patch do you mean?  Or to be more clear, could you test
> the patch attached? For the XHCI dead port issue?

So I tested your port_dbg.patch on 3.8.3. Or did you want me to do it on 3.8.5?


# lspci -tv
-[0000:00]-+-00.0  Intel Corporation 2nd Generation Core Processor Family DRAM Controller
           +-02.0  Intel Corporation 2nd Generation Core Processor Family Integrated Graphics Controller
           +-16.0  Intel Corporation 6 Series/C200 Series Chipset Family MEI Controller #1
           +-1a.0  Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #2
           +-1b.0  Intel Corporation 6 Series/C200 Series Chipset Family High Definition Audio Controller
           +-1c.0-[03-04]--
           +-1c.1-[05-06]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168 PCI Express Gigabit Ethernet controller
           +-1c.3-[09-0a]----00.0  Intel Corporation Centrino Wireless-N 1030 [Rainbow Peak]
           +-1c.4-[0b-0c]----00.0  Texas Instruments TUSB73x0 SuperSpeed USB 3.0 xHCI Host Controller
           +-1c.7-[11-16]----00.0  Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
           +-1d.0  Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #1
           +-1f.0  Intel Corporation HM67 Express Chipset Family LPC Controller
           +-1f.2  Intel Corporation 6 Series/C200 Series Chipset Family 6 port SATA AHCI Controller
           \-1f.3  Intel Corporation 6 Series/C200 Series Chipset Family SMBus Controller
#


After a cold boot 1c.4 is active whereas 0b:00 is "suspended?".
Attaching a mouse wakes up 0b:00 and the mouse works (I did not try USB3 device in the
xhci socket in this test). Did you anticipate that?
After its unplug 0b:00 falls asleep again, but also 1c.4 does.
That makes the xhci port appear dead and it does NOT detected a device
was plugged back in again. Doing echo on  > /sys/bus/pci/devices/0000:0b:00.0/power/control
wakes up the 0b:00 and it correctly also wakes up upstream 1c.4. So the socket detects
a device is already plugged in and things start to work.


> 
> Please test this patch with laptop-mode-tool installed and enabled.  And
> before/after test, please get PCI devices runtime status with:
> 
> grep . /sys/bus/pci/devices/*/power/runtime_status

Initial after cold boot, no mouse attached:

/sys/bus/pci/devices/0000:00:00.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:02.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:16.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.3/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.4/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.7/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_status:suspended
/sys/bus/pci/devices/0000:05:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:09:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:0b:00.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:11:00.0/power/runtime_status:active


Dead port with mouse attached:

/sys/bus/pci/devices/0000:00:00.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:02.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:16.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.3/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.4/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1c.7/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_status:suspended
/sys/bus/pci/devices/0000:05:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:09:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:0b:00.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:11:00.0/power/runtime_status:active


Rescued port after "echo on":

/sys/bus/pci/devices/0000:00:00.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:02.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:16.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1a.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1b.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.0/power/runtime_status:suspended
/sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.3/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.4/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1c.7/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1d.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.0/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.2/power/runtime_status:active
/sys/bus/pci/devices/0000:00:1f.3/power/runtime_status:suspended
/sys/bus/pci/devices/0000:05:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:09:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:0b:00.0/power/runtime_status:active
/sys/bus/pci/devices/0000:11:00.0/power/runtime_status:active


> 
> And please give me the full dmesg for boot and incremental dmesg for
> operations.


The incremental bits here, the full dmesg will send only directly to your email, due to its size.

--- dmesg_initial.txt   2013-04-02 14:36:24.000000000 +0200
+++ dmesg_initial__mouse_attached.txt   2013-04-02 14:37:03.000000000 +0200
@@ -1033,3 +1033,35 @@
 [   41.688341] r8169 0000:05:00.0 eth0: link up
 [   42.796053] r8169 0000:05:00.0 eth0: link down
 [   45.152871] r8169 0000:05:00.0 eth0: link up
+[   98.482665] xhci_hcd 0000:0b:00.0: PME# disabled
+[   98.482676] xhci_hcd 0000:0b:00.0: enabling bus mastering
+[   98.482753] xhci_hcd 0000:0b:00.0: hcd_pci_runtime_resume: 0
+[   98.482822] usb usb3: usb wakeup-resume
+[   98.482827] usb usb3: usb auto-resume
+[   98.482856] hub 3-0:1.0: hub_resume
+[   98.482922] hub 3-0:1.0: port 2: status 0301 change 0001
+[   98.482956] usb usb4: usb wakeup-resume
+[   98.482958] usb usb4: usb auto-resume
+[   98.482972] hub 4-0:1.0: hub_resume
+[   98.483226] hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
+[   98.483284] hub 4-0:1.0: hub_suspend
+[   98.483289] usb usb4: bus auto-suspend, wakeup 1
+[   98.592406] hub 3-0:1.0: state 7 ports 2 chg 0004 evt 0000
+[   98.592456] hub 3-0:1.0: port 2, status 0301, change 0000, 1.5 Mb/s
+[   98.712244] usb 3-2: new low-speed USB device number 2 using xhci_hcd
+[   98.750683] usb 3-2: skipped 1 descriptor after interface
+[   98.753594] usb 3-2: default language 0x0409
+[   98.766647] usb 3-2: udev 2, busnum 3, minor = 257
+[   98.766650] usb 3-2: New USB device found, idVendor=0458, idProduct=0036
+[   98.766652] usb 3-2: New USB device strings: Mfr=2, Product=1, SerialNumber=0
+[   98.766653] usb 3-2: Product: NetScroll + Mini Traveler
+[   98.766654] usb 3-2: Manufacturer: Genius
+[   98.767287] usb 3-2: usb_probe_device
+[   98.767289] usb 3-2: configuration #1 chosen from 1 choice
+[   98.767337] usb 3-2: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
+[   98.770540] usb 3-2: Successful Endpoint Configure command
+[   98.771564] usb 3-2: adding 3-2:1.0 (config #1, interface 0)
+[   98.771792] usbhid 3-2:1.0: usb_probe_interface
+[   98.771793] usbhid 3-2:1.0: usb_probe_interface - got id
+[   98.783875] input: Genius NetScroll + Mini Traveler as /devices/pci0000:00/0000:00:1c.4/0000:0b:00.0/usb3/3-2/3-2:1.0/input/input13
+[   98.785500] hid-generic 0003:0458:0036.0001: input,hidraw0: USB HID v1.10 Mouse [Genius NetScroll + Mini Traveler] on usb-0000:0b:00.0-2/input0


Mouse unplug resulting in a suicide of the xhci socket due to xhci_hcd shutting it down:

--- dmesg_initial__mouse_attached.txt   2013-04-02 14:37:03.000000000 +0200
+++ dmesg_initial__mouse_attached__unplugged.txt        2013-04-02 14:37:48.000000000 +0200
@@ -1065,3 +1065,18 @@
 [   98.771793] usbhid 3-2:1.0: usb_probe_interface - got id
 [   98.783875] input: Genius NetScroll + Mini Traveler as /devices/pci0000:00/0000:00:1c.4/0000:0b:00.0/usb3/3-2/3-2:1.0/input/input13
 [   98.785500] hid-generic 0003:0458:0036.0001: input,hidraw0: USB HID v1.10 Mouse [Genius NetScroll + Mini Traveler] on usb-0000:0b:00.0-2/input0
+[  142.025637] hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0004
+[  142.025722] hub 3-0:1.0: port 2, status 0100, change 0001, 12 Mb/s
+[  142.025725] usb 3-2: USB disconnect, device number 2
+[  142.025726] usb 3-2: unregistering device
+[  142.025728] usb 3-2: unregistering interface 3-2:1.0
+[  142.026303] xhci_hcd 0000:0b:00.0: shutdown urb ffff880405d60a20 ep1in-intr
+[  142.124442] usb 3-2: usb_disable_device nuking all URBs
+[  142.131315] usb 3-2: Successful Endpoint Configure command
+[  142.292672] hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
+[  142.292691] hub 3-0:1.0: hub_suspend
+[  142.292699] usb usb3: bus auto-suspend, wakeup 1
+[  142.292808] xhci_hcd 0000:0b:00.0: hcd_pci_runtime_suspend: 0
+[  142.292900] xhci_hcd 0000:0b:00.0: PME# enabled
+[  153.974259] pcieport 0000:00:1c.4: PME# enabled
+[  154.014363] pcieport 0000:00:1c.4: PME# disabled

Re-attaching the same mouse does not wakeup dead 0b:00, only 1c.4 is being woken up:

--- dmesg_initial__mouse_attached__unplugged.txt        2013-04-02 14:37:48.000000000 +0200
+++ dmesg_initial__mouse_attached__unplugged__reattached_but_port_dead.txt      2013-04-02 14:38:27.000000000 +0200
@@ -1080,3 +1080,7 @@
 [  142.292900] xhci_hcd 0000:0b:00.0: PME# enabled
 [  153.974259] pcieport 0000:00:1c.4: PME# enabled
 [  154.014363] pcieport 0000:00:1c.4: PME# disabled
+[  154.024237] pcieport 0000:00:1c.4: PME# enabled
+[  192.077120] pcieport 0000:00:1c.4: PME# disabled
+[  192.087074] pcieport 0000:00:1c.4: PME# enabled
+[  192.127475] pcieport 0000:00:1c.4: PME# disabled


Doing echo on > ..../...0b:00.../control rescues the port:

--- dmesg_initial__mouse_attached__unplugged__reattached_but_port_dead.txt      2013-04-02 14:38:27.000000000 +0200
+++ dmesg_initial__mouse_attached__unplugged__reattached_but_port_dead__echo_on_0b:00_wakes_up_port.txt 2013-04-02 14:39:52.000000000 +0200
@@ -1084,3 +1084,37 @@
 [  192.077120] pcieport 0000:00:1c.4: PME# disabled
 [  192.087074] pcieport 0000:00:1c.4: PME# enabled
 [  192.127475] pcieport 0000:00:1c.4: PME# disabled
+[  192.136892] pcieport 0000:00:1c.4: PME# enabled
+[  248.761936] pcieport 0000:00:1c.4: PME# disabled
+[  248.781922] xhci_hcd 0000:0b:00.0: PME# disabled
+[  248.781937] xhci_hcd 0000:0b:00.0: enabling bus mastering
+[  248.782109] xhci_hcd 0000:0b:00.0: hcd_pci_runtime_resume: 0
+[  248.782318] usb usb3: usb wakeup-resume
+[  248.782321] usb usb3: usb auto-resume
+[  248.782340] hub 3-0:1.0: hub_resume
+[  248.782397] hub 3-0:1.0: port 2: status 0301 change 0001
+[  248.782426] usb usb4: usb wakeup-resume
+[  248.782428] usb usb4: usb auto-resume
+[  248.782442] hub 4-0:1.0: hub_resume
+[  248.782496] hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
+[  248.782553] hub 4-0:1.0: hub_suspend
+[  248.782557] usb usb4: bus auto-suspend, wakeup 1
+[  248.891635] hub 3-0:1.0: state 7 ports 2 chg 0004 evt 0000
+[  248.891712] hub 3-0:1.0: port 2, status 0301, change 0000, 1.5 Mb/s
+[  249.011519] usb 3-2: new low-speed USB device number 3 using xhci_hcd
+[  249.049943] usb 3-2: skipped 1 descriptor after interface
+[  249.052853] usb 3-2: default language 0x0409
+[  249.065876] usb 3-2: udev 3, busnum 3, minor = 258
+[  249.065880] usb 3-2: New USB device found, idVendor=0458, idProduct=0036
+[  249.065881] usb 3-2: New USB device strings: Mfr=2, Product=1, SerialNumber=0
+[  249.065883] usb 3-2: Product: NetScroll + Mini Traveler
+[  249.065884] usb 3-2: Manufacturer: Genius
+[  249.066481] usb 3-2: usb_probe_device
+[  249.066483] usb 3-2: configuration #1 chosen from 1 choice
+[  249.066526] usb 3-2: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
+[  249.069656] usb 3-2: Successful Endpoint Configure command
+[  249.070823] usb 3-2: adding 3-2:1.0 (config #1, interface 0)
+[  249.071052] usbhid 3-2:1.0: usb_probe_interface
+[  249.071054] usbhid 3-2:1.0: usb_probe_interface - got id
+[  249.082981] input: Genius NetScroll + Mini Traveler as /devices/pci0000:00/0000:00:1c.4/0000:0b:00.0/usb3/3-2/3-2:1.0/input/input14
+[  249.084093] hid-generic 0003:0458:0036.0002: input,hidraw0: USB HID v1.10 Mouse [Genius NetScroll + Mini Traveler] on usb-0000:0b:00.0-2/input0




Martin

