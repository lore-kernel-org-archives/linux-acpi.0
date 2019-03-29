From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Fixing the GHES driver vs not causing issues in the first place
Date: Fri, 29 Mar 2019 16:37:31 -0500
Message-ID: <9acf86ac-a065-e093-347c-e35ac4069e08@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, bp@alien8.de, "Bolen, Austin" <austin_bolen@dell.com>, Lukas Wunner <lukas@wunner.de>, Keith Busch <keith.busch@intel.com>, Jonathan Derrick <jonathan.derrick@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, Erik Schmauss <erik.schmauss@intel.com>, Robert Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

The issue of dying inside the GHES driver has popped up a few times before.
I've looked into fixing this before, but we didn't quite come to agreement
because the verbiage in the ACPI spec is vague:
     " When a fatal uncorrected error occurs, the system is
       restarted to prevent propagation of the error. "

This popped up again a couple of times recently [1]. Linus suggested that
fixing the GHES driver might pay higher dividends. I considered reviving 
an old
fix, but put it aside after hearing concerns about the unintended 
consequences,
which I'll get to soon.

A few days back, I lost an entire MD RAID1. It was during hot-removal 
testing
that I do on an irregular basis, and a kernel panic from the GHES driver had
caused the system to go down. I have seen some occasional filesystem 
corruption
in other crashes, but nothing fsck couldn't fix. The interesting part is 
that
the array that was lost was not part of the device set that was being
hot-removed. The state of things doesn't seem very joyful.

The machine in question is a Dell r740xd. It uses firmware-first (FFS)
handling for PCIe errors, and is generally good at identifying a hot-removal
and not bothering the OS about it. The events that I am testing for are
situations where, due to slow operator, tilted drive, worn connectors, 
errors
make it past FFS to the OS -- with "fatal" severity.
     In that case, the GHES driver sees a fatal hardware error and panics.
On this machine, FFS reported it as fatal in an attempt to cause the 
system to
reboot, and prevent propagation of the error.

     The "prevent propagation of the error" flow was designed around OSes
that can't do recovery. Firmware assumes an instantaneous reboot, so it does
not set itself up to report future errors. The EFI reference code does not
re-arm errors, so we suspect most OEM's firmware will work this way. Despite
the apparently enormous stupidity of crashing an otherwise perfectly good
system, there are good and well thought out reasons behind it.
     An example is reading a block of data from an NVMe drive, and
encountering a CRC error on the PCIe bus. If we didn't  do an "instantaneous
reboot" after a previous fatal error, we will not get the CRC error 
reported.
Thus, we risk silent data corruption.

     On the Linux side, we can ignore the "fatal" nature of the error, and
even recover the PCIe devices behind the error. However, this is ill 
advised for
the reason listed above.

     The counter argument is that a panic() is more likely to cause
filesystem corruption. In over one year of testing, I have not seen a single
incident of data corruption, yet I have seen the boot ask me to run fsck on
multiple occasions. And this seems to me like a tradeoff problem rather than
anything else.

     In the case of this Dell machine, there are ways to hot-swap PCIe
devices them without needing to take either of the risks above:
     1. Turn off the downstream port manually.
     2. Insert/replace drive
     3. Turn on the downstream port manually.

     What bothers me is the firmware's assumption that a fatal error must
crash the machine. I've looked at the the verbiage in the spec, and I don't
fully agree that either side respects the contract.
Our _OSC contract with the firmware says that firmware will report 
errors to us,
while we are not allowed to touch certain parts of the device. Following the
verbiage in the spec, we do need to reboot on a fatal error, but that 
reboot is
not guaranteed to be instantaneous. Firmware still has to honor the contract
and report errors to us. This may seem like a spec non-compliance issue.

     It would be great if FFS would mark the errors as recoverable, but the
level of validation required makes this unrealistic on existing 
machines. New
machines will likely move to the Containment Error Recovery model, which is
essentially FFS for DPC (PCIe Downstream Port Containment). This leaves the
current generation of servers in limbo -- I'm led to believe other 
server OEMs
have very similar issues.

     Given the dilemma above, I'm really not sure what the right 
solution is.
How do we produce a fix that addresses complaints from both sides. When 
firmware
gives us a false positive, should we panic? Should we instead print a 
message
informing the user/admin that a reboot of the machine is required. Should we
initiate a reboot automatically?

     From Linux' ability to recover, PCIe fatal errors are false positives
-- every time, all the time. However, their fatality is not there 
without any
reason. I do want to avoid opinions that FFS wants us to crash, gives us the
finger, and we should give the finger back.

     Another option that was discussed before, but was very controversial is
the fix that involves not causing the problem in the first place [1] 
[2]. On the
machines that I have access to, FFS is handled in SMM, which means that 
all CPU
cores are held up until the processing of the error is complete. On one
particular machine (dual 40-core CPU) SMM will talk to the BMC over I/O 
ports,
which takes roughly 300 milliseconds. We're losing roughly 24 
core-seconds to
a check that might have taken us a couple of clock cycles.

I'm hoping that I was able to give out a good overview of the problems 
we are
facing on FFS systems, and I hope that we can find some formula to deal with
them in a way that is both pleasant and robust. Oh, FFS!

Alex

P.S. If there's interest, I can look for system logs that show the 300+ 
ms gap
caused by the SMM handler.


[1] 
https://lore.kernel.org/lkml/20190222010502.2434-1-jonathan.derrick@intel.com/T/#u
[2] 
https://lore.kernel.org/lkml/20190222194808.15962-1-mr.nuke.me@gmail.com/
