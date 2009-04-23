From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI Exception
Date: Thu, 23 Apr 2009 08:56:17 +0800
Message-ID: <1240448177.7661.515.camel@rzhang-dt>
References: <fab5b76e0904220858x71bf226dn19071ddc5692e7ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:64157 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420AbZDWAzx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Apr 2009 20:55:53 -0400
In-Reply-To: <fab5b76e0904220858x71bf226dn19071ddc5692e7ec@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcin Gozdalik <gozdal@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

does the ACPI Exception happen during or after the boot time?
please attach the acpidump and full dmesg output.

please attach the output of "grep . /sys/class/thermal/*/*"

thanks,
rui

On Wed, 2009-04-22 at 23:58 +0800, Marcin Gozdalik wrote:
> Hi
> 
> I am seeing the following in logs:
> 
> Apr 22 16:00:07 myth kernel: [   39.354031] ACPI Exception
> (thermal-0479): AE_ERROR, ACPI thermal trip point state changed
> Apr 22 16:00:07 myth kernel: [   39.354040] Please send acpidump to
> linux-acpi@vger.kernel.org
> Apr 22 16:00:07 myth kernel: [   39.354045]  [20080926]
> 
> I am using Ubuntu 9.04:
> 
> root@myth:/home/gozdal# uname -a
> Linux myth 2.6.28-11-generic #42-Ubuntu SMP Fri Apr 17 01:58:03 UTC
> 2009 x86_64 GNU/Linux
> 
> Motherboard is Abit AN-M2HD(MCP68) flashed with the latest BIOS.
> 
> The machine powers down sometimes because of an ACPI trip point:
> 
> Apr 22 17:27:19 myth kernel: [ 5272.004934] ACPI: Critical trip point
> Apr 22 17:27:19 myth kernel: [ 5272.004952] Critical temperature
> reached (121 C), shutting down.
> Apr 22 17:27:19 myth kernel: [ 5272.004973] ACPI: Unable to turn
> cooling device [ffff88006f841800] 'on'
> Apr 22 17:27:26 myth kernel: [ 5278.204238] Critical temperature
> reached (34 C), shutting down.
> 
> although I believe this is an error in measurement, as the temperature
> probably wouldn't cool in 7 seconds from 121 to 34 Celsius.
> 
> Best regards
> 
> --
> Marcin Gozdalik <gozdal@gmail.com>

