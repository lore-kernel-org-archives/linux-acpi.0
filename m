From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [RFC 0/2] ACPI Platform Communication Channel driver
Date: Tue, 27 May 2014 16:29:57 -0400
Message-ID: <1401222599-12416-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:56204 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbaE0UaJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 May 2014 16:30:09 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so9831754pbb.25
        for <linux-acpi@vger.kernel.org>; Tue, 27 May 2014 13:30:08 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, patches@linaro.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Hello,

This patchset adds initial support for the PCC (Platform Communication Channel)
interface as described in the current ACPI 5.0a spec. See Section 14 of the
ACPI spec - http://acpi.info/DOWNLOADS/ACPI_5_Errata%20A.pdf for more details on
how PCC works.

In brief PCC (Platform Communication Channel) is a generic means for PCC clients,
to talk to the firmware. The PCC register space is typically memory mapped IO and
uses a doorbell mechanism to communicate synchronously from the OS to the firmware.
The PCC driver is completely agnostic to the protocol implemented by the PCC clients.
It only implements the enumeration of PCC channels and the low level transport mechanism
and leaves the rest to the PCC clients.

The PCC is meant to be useable in the future by clients such as CPPC
(Collaborative Processor Performance Control), RAS (Reliability,
Availability and Serviceability) and MPST (Memory Power State Tables) and possibly others.

While the PCC clients will come as following patches whenever they're ready, I wanted
to get feedback on this common driver and hope that it could be merged upstream. This
should hopefully help various folks that are working on drivers that rely on the PCC
interface.

Cheers,
Ashwin

=== Testing Methodology ===

The PCC test driver in [2/2] is a simple driver that was used to
demonstrate how PCC clients would use the PCC driver. The PCC driver was
tested by sending multiple PCC READS and PCC WRITES across a shared memory
region on an MSM ARMv7 platform. This memory is shared between an apps processor
and a power controller processor. So, one end of the PCC channel is the PCC test driver
running on the apps processor and the other end is a debugger script
(running on a JTAG debugger) thats attached to the power processor. The debugger
script is busy looping on the doorbell address waiting for a bit to flip. This bit
indicates a synchronous communication from the apps processor. The doorbell is rung
when the OS sends a PCC READ or PCC WRITE command. The PCC communication channel
is simply a few fake 32 bit registers that are incremented by the OS and the debugger
script. The OS increments the registers and then sends the PCC WRITE command. On a PCC
READ, the script increments these registers and then OS reads them back. The values
are always incremented by 1 by either end, so we know what value to expect for each
PCC READ/WRITE.

Ashwin Chaugule (2):
  ACPI: Add support for Platform Communication Channel
  PCC Test driver

 drivers/acpi/Kconfig    |  10 +++
 drivers/acpi/Makefile   |   2 +-
 drivers/acpi/pcc-test.c | 172 +++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/pcc.c      | 192 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 375 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/pcc-test.c
 create mode 100644 drivers/acpi/pcc.c

-- 
1.8.3.2

