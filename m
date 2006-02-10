From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: some new unaligned access while booting ia64 (HP rx2620)
Date: Fri, 10 Feb 2006 14:58:31 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F05AD5C61@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr22.intel.com ([143.183.121.14]:23523 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751390AbWBJW6j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2006 17:58:39 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Thomas Renninger <trenn@suse.de>, "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org

> That looks good. You'll probably need to increase your dmesg buffer
> or send the output to a serial port, since you will get megabytes
> of info.

I only have a serial port on this machine ... but all the interesting
output happens before it is enabled ... i.e. is buffered up in log_buf
until the serial console is brought online.

I made log_buf as big as I could (2^21 bytes is the biggest it would
let me go), and that is not enough for all the ACPI messages ... so the
initial part where the unaligned messages were printed was lost in the
wraparound before anything could be dumped to the serial port.

Now I've got network problems in the lab ... when I can reconnect to
my systems, I'll change lib/Kconfig.debug to allow a bigger log_buf
and try again.

-Tony
