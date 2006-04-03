From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: 2.6.16 not booting due to ACPI  revision 20060127
Date: Mon, 3 Apr 2006 10:18:11 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E04DF359B@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:44610 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932338AbWDCRS0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2006 13:18:26 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>, "Brown, Len" <len.brown@intel.com>, Xavier.Bru@bull.net
Cc: linux-ia64-owner@vger.kernel.org, linux-acpi@vger.kernel.org, "Therien, Guy" <guy.therien@intel.com>


We changed the device initialization sequence to improve boot
performance by not executing _STA unless an _INI is actually present.

The change to selectively run _STA was made in 20051216, from the
release notes:

"Implemented an optimization to the initialization sequence that can
improve boot time. During ACPI device initialization, the _STA method is
now run if and only if the _INI method exists. The _STA method is used
to determine if the device is present; An _INI can only be run if _STA
returns present, but it is a waste of time to run the _STA method if the
_INI does not exist."


It is my understanding of the ACPI spec that there is no requirement
that _STA be run, ever. There is only a requirement that _INI be run if
the device is present and _INI exists.
 
Therefore, the optimization above was implemented because we were only
running _STA to determine whether or not to run _INI. If there is no
_INI present, it is pointless to run the _STA.


> >Having a look to ACPI specification, I could find nowhere the 
> >restriction that _STA method is called only when an _INI method is 
> >provided for the device:
> >

Yes, there is no restriction on when or if _STA can be run. However, I
do not think that there a *requirement* to run _STA, only _INI.

I don't understand why running _STA fixes the problem. Exactly what or
who is depending on _STA to be run?

Bob


> -----Original Message-----
> From: Luck, Tony
> Sent: Monday, April 03, 2006 7:01 AM
> To: Moore, Robert; Brown, Len
> Subject: FW: 2.6.16 not booting due to ACPI revision 20060127
> 
> Bob, Len: Can you comment on this please?
> 
> -Tony
> 
> >-----Original Message-----
> >From: linux-ia64-owner@vger.kernel.org
> >[mailto:linux-ia64-owner@vger.kernel.org] On Behalf Of xb
> >Sent: Monday, April 03, 2006 4:40 AM
> >To: linux-ia64@vger.kernel.org
> >Subject: 2.6.16 not booting due to ACPI revision 20060127
> >
> >Hi all,
> >
> >We have platforms that do not boot in 2.6.16, but boot OK with 2.6.15
> >(loop in ACPI code).
> >After some investigations, I found this is due to pci buses that are
> >described in the configuration, but not available in limited
> >configurations.
> >These buses have a _STA method, but no _INI method.
> >With 2.6.15, the _STA method is run, and as the bus is not
> >present, the
> >bus and all devices behind it are ignored.
> >With 2.6.16, as no _INI method is provided for the bus, _STA method
is
> >not run, and then we loop when executing methods for devices
> >behind the
> >not present bus.
> >
> >Having a look to ACPI specification, I could find nowhere the
> >restriction that _STA method is called only when an _INI method is
> >provided for the device:
> >
> >"6.5.1 _INI (Init)
> >...
> >If the _STA method indicates that the device is present, OSPM will
> >evaluate the _INI for the device (if the _INI method exists) and will
> >examine each of the children of the device for _INI methods.
> >If the _STA
> >method indicates that the device is not present, OSPM will not run
the
> >_INI and will not examine the children of the device for _INI
> >methods. "
> >
> >
> >traces -----------------------------------------------
> >
> >
> > Device PC11
> >000060e4:  02 . .  Name _HID
> >000060e9:  03 . . .  PNP0A03  PCI Bus  0x030ad041
> >000060ee:  02 . .  Name _UID
> >000060f3:  03 . . .  0x0b
> >000060f5:  02 . .  Name _ADR
> >000060fa:  03 . . .  0x00
> >000060fc:  02 ---- 'PCI bus number setup by the BIOS'  Method _BBN
> >00006102:  03 . . .  0x00
> >00006103:  03 . . .  Return
> >00006104:  04 . . . .  path: \_SB_.CSFF.IO15.B1__
> >00006117:  02 ---- 'Dynamic_Statu'  Method _STA
> >0000611d:  03 . . .  0x00
> >0000611e:  03 . . .  If
> >00006120:  04 . . . .  LEqual
> >00006121:  05 . . . . .  path: \_SB_.CSFF.IO11.HUBD
> >00006134:  05 . . . . .  0x00
> >00006136:  04 . . . .  Return
> >00006137:  05 . . . . .  0x0f
> >00006139:  03 . . .  Return
> >0000613a:  04 . . . .  0x00
> >0000613c:  02 ---- 'Current Resource Setting'  Method _CRS
> >00006142:  03 . . .  0x00
> >00006143:  03 . . .  Return
> >00006144:  04 . . . .  path: \_SB_.HLRS
> >0000614e:  03 . . .  0x01
> >00006150:  03 . . .  0x01
> >00006152:  02
> >
> >
