From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPI not working since 2.6.14
Date: Wed, 8 Feb 2006 15:56:44 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3006002649@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:34539 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751120AbWBHU4x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2006 15:56:53 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ps <Ps_Mail@freenet.de>, linux-acpi@vger.kernel.org

> >NFORCE-CK804

Please file a bug here:

http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
pick Component "Config-interrupts"

For the last known working kernel please
1. attach complete output from dmesg -s64000
2. paste copy of /proc/interrupts
3. attach output from lspci -vv

also, please attach your acpidump output there.

For latest (failing) kernel, please capture the "debug" serial console,
or if you can get far enough the full dmesg and /proc/interrutps

Please try booting the latest kernel with "noapic"
or "acpi=noirq" and report what you see with dmesg and /proc/interrupts

thanks,
-Len
