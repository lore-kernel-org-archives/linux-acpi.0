From: simon@mungewell.org
Subject: ACPI blocking I2C driver - Poulsbo
Date: Wed, 6 Apr 2011 11:02:23 -0400
Message-ID: <67d3106409027af35531bf7b42ca462c.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:47745 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab1DFQEg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Apr 2011 12:04:36 -0400
Received: from localhost ([127.0.0.1] helo=host171.canaca.com)
	by host171.canaca.com with esmtpa (Exim 4.69)
	(envelope-from <simon@mungewell.org>)
	id 1Q7UFT-0005a2-JC
	for linux-acpi@vger.kernel.org; Wed, 06 Apr 2011 11:02:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,
I am chasing a problem on a Poulsbo based board where the ACPI subsystem
is blocking a chunk of memory and preventing the Poulsbo I2C driver
loading.

> --
> [  403.809826] ACPI: resource (null) [io  0x0480-0x04bf] conflicts with
> ACPI region PHO_ [io 0x4bc-0x4bc]
> [  403.809834] ACPI: If an ACPI driver is available for this device, you
> should use it instead of the native driver
> [  403.809921] lpc_sch: probe of 0000:00:1f.0 failed with error -16
> --

If I boot with 'acpi=off' kernel option, then I2C can function as expected.

As far as I can see there is no reason why ACPI should be holding onto
this address block, this block is shown in '/proc/ioports' but no driver
listed.

The board also contains a IET IT8516 SuperIO which interfaces to the
charger/batteries/etc.

dmidecode and acpidump logs under the original posting:
http://thread.gmane.org/gmane.linux.drivers.i2c/8154/focus=8171

Thanks in advance,
Simon.

