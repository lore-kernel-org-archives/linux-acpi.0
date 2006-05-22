From: "David Giddy" <d.giddy@bigpond.com>
Subject: RE: Help request on S3 resume problems
Date: Mon, 22 May 2006 23:11:21 +1000
Message-ID: <001301c67da1$3e95a900$0400a8c0@vic.bigpond.net.au>
References: <446E5F0D.9080105@acmelabs.de>
Reply-To: <d.giddy@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:643 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750811AbWEVNLi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 May 2006 09:11:38 -0400
Received: from NewPC ([155.143.208.3]) by omta01ps.mx.bigpond.com with SMTP
          id <20060522131136.ZKOI4761.omta01ps.mx.bigpond.com@NewPC>
          for <linux-acpi@vger.kernel.org>; Mon, 22 May 2006 13:11:36 +0000
In-Reply-To: <446E5F0D.9080105@acmelabs.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Andreas,

Thank you for the pointers below. This seems to have solved my problem!
Enabling X86_UP_IOAPIC was sufficient in my case for success (it seems to
work OK with USB enabled in the BIOS - haven't tried with connected USB
devices yet though...)

Interesting that my hardware is quite different to yours, yet the symptoms
were the same:
- Gigabyte GA-8IPE1000-G motherboard (Intel 865PE chipset)
- Realtek 8110 Gigabit LAN chip on board
- Intel PRO1000/MT PCI card
- NVIDIA AGP video card
- Debian Sarge with kernel 2.6.16.16 latest ACPI patch set(with NVIDIA
driver added and an e1000 module WOL patch)

Maybe something around the code related to X86_UP_IOAPIC needs looking at by
ACPI experts ? Unfortunately I don't understand the kernel anywhere near
well enough to help.

Works successfully with both on board and PCI LAN interfaces and now works
from both S3 and S4 (using swsusp2).

One happy camper!

Regards,

David.


-----Original Message-----
From: linux-acpi-owner@vger.kernel.org
[mailto:linux-acpi-owner@vger.kernel.org]On Behalf Of Andreas Saur
Sent: Saturday, 20 May 2006 10:13 AM
To: linux-acpi@vger.kernel.org
Subject: RE: Help request on S3 resume problems


Hello,

same here! (nForce2 chipset).

After many many trial and error scenarios, I cannot remember exactly what
I've done to get it work (resume from s3 on WOL) at least partitially.

1) In a sort of combination of using X86_UP_IOAPIC with USB turned off in
BIOS, the system always woke up after sending the magic packet.
2) After turning on USB in BIOS the system woke up exactly 3 times. The
forth time always led to a dead keyboard and a black screen, no ping.
3) Turning off X86_UP_IOAPIC in the kernel leads always to a dead keyboard
and black screen, no ping.

Except WOL, S3 works fine here using the PowerButton or Keyboard.

I've studied all the the logs I've turned on in kernel, but there is nothing
of interest concerning this error, at least for me.
Btw. It didn't make a difference whether doing the test in single user mode
or not. Results were the same. I've also turned off all devices I could in
the BIOS to minimize the IRQ impact. Didn't make a difference either.

It's a pitty, I was so close to a very cool MediaCenterPC for my
living-room. But at the moment I ran out of ideas. If anybody is interested
in my specs, can look into a bugzilla report I've posted earlier (another
problem), the hardware didn't change, except the kernel. It's 2.6.17-rc3 at
the moment. the last three mm patches led to kernel panics. (here my specs:
http://bugzilla.kernel.org/show_bug.cgi?id=6326)

Regards,

Andreas

>Len,
>
>Thanks for the quick response. Unfortunately, I think in this instance that
>the failure on resume IS related to the method of waking. Here are the
>results of testing as you imply below:
>
>Resume from S3 using power button	  -> 100% functional, both ttyS0 serial
>console and NVIDIA video card console
>Resume from S3 using WOL magic packet -> Fans run, disk activity, NO NVIDIA
>video card console response, NO ttyS0 serial console response, NO ping
>response
>Resume from S5 using power button	  -> Normal boot
>Resume from S5 using WOL magic packet -> Normal boot
>
>I haven't tried wake from S4 as I don't currently have a swap partition
>large enough to try it (1GB RAM).
>
>Regards,
>
>David.

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

