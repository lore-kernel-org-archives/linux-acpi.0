From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Sat, 13 Jan 2007 22:24:59 -0700
Message-ID: <200701132224.59596.bjorn.helgaas@hp.com>
References: <beb91d720701110549r346991beh95547e912f68d98f@mail.gmail.com> <1e2af89e0701130533o7cdead43g9ab79b71f852ac71@mail.gmail.com> <45A9001F.1040008@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:45072 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbXANFZI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 Jan 2007 00:25:08 -0500
In-Reply-To: <45A9001F.1040008@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Matthew Brett <matthew.brett@gmail.com>, "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>, Salatiel Filho <salatiel.filho@gmail.com>, linux-acpi@vger.kernel.org

On Saturday 13 January 2007 08:51, Alexey Starikovskiy wrote:
> Matthew Brett wrote:
> >> If BIOS does not export fan controls to OS via DSDT, it means that BIOS
> >> wants to control fans via its own means (hardware), this doesn't mean
> >> that your machine is at risk, it only means that you are not allowed to
> >> tamper with it...
> >
> > Well, except the original poster complained that linux but not windows
> > was shutting down the fan - meaning - surely - that somehow linux is
> > tampering with the fan when it should not.
> >
> As it was said above, Linux has no means to do that. At least through 
> ACPI framework.

I think there are two things being confused here:

  1) Matthew's report, which clearly says that loading fan.ko
     turns off the fan, and it doesn't come back on when it should.
     His BIOS provides a PNP0C0B fan device and an _AC0 trip point,
     so Linux *should* be able to control the fan.

  2) Salatiel's report, which is rather vague: "I think my fans
     are not working in Linux."  I haven't seen Salatiel's acpidump,
     but Konstantin says it has no fan devices and no active trip
     points.  Since Salatiel has no PNP0C0B device, his problem is
     unrelated to the fan.ko driver.

So let's concentrate on Matthew's problem first.  Loading fan.ko
turns off the fan.  If the machine is cool, as it likely is at
boot-time, this might be appropriate.

When the system gets hot, the thermal driver is supposed to turn
the fan(s) on, and this doesn't seem to happen.  But the experiments
Konstantin suggested showed that the thermal driver did notice the
temperature above the active trip point, it switched to active
cooling, and ACPI claims the fan is on, thought it apparently is
not.

Are there any messages in dmesg about problems turning on cooling
devices?

With 2.6.17, loading fan.ko leaves the fan on.  Manually turning
off the fan works.  But manually turning it back on again fails,
which looks suspiciously like the 2.6.20-rc3 problem where the
thermal driver can't turn the fan on again.

Maybe there's some firmware or mechanical problem such that the
fan can only be turned on via reset or a power cycle?  Does the
fan *ever* turn off and then back on again under 2.6.17?  I don't
suppose you can try this under Windows?  Vacuum out the dust
bunnies?  Try a different fan?

Bjorn
