From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [2.6.31-rc6] ACPI region conflict regression...
Date: Sun, 16 Aug 2009 10:52:19 -0600
Message-ID: <4A883943.5050508@gmail.com>
References: <6278d2220908160259v38c34c4ck6db2853ae886492@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:5889 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbZHPQ7w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Aug 2009 12:59:52 -0400
In-Reply-To: <6278d2220908160259v38c34c4ck6db2853ae886492@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On 08/16/2009 03:59 AM, Daniel J Blueman wrote:
> When booting 2.6.31-rc6 on some x86-64 hardware with fan control and
> monitoring via the Winbond 83627 chip, 2.6.31-rc6 prevents the module
> using an I/O region [1] described in the ACPI DSDT table [2] - which
> didn't occur in -rc5.
>
> Is there a way to relax this, or does it require adding
> acpi_bus_register_driver(struct acpi_driver) and the needed code this
> late in the game?
>
> Thanks,
>    Daniel
>
> --- [1]
>
> w83627ehf: Found W83627EHG chip at 0x290
> ACPI: I/O resource w83627ehf [0x295-0x296] conflicts with ACPI region
> SEN1 [0x295-0x296]
> ACPI: Device needs an ACPI driver

This is only a warning, it doesn't prevent reserving the region by 
default, does it?

>
> --- [2]
>
>      OperationRegion (SEN1, SystemIO, 0x0295, 0x02)
>      Field (SEN1, ByteAcc, NoLock, Preserve)
>      {
>          SEI0,   8,
>          SED0,   8
>      }

