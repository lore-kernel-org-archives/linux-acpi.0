From: Frans Pop <elendil@planet.nl>
Subject: Re: [2.6.23-rc7] main.c: undefined reference to `acpi_sleep_prepare'
Date: Sun, 23 Sep 2007 15:08:06 +0200
Message-ID: <200709231508.07674.elendil@planet.nl>
References: <200709230152.31120.elendil@planet.nl> <46F60AA2.1060500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hpsmtp-eml11.kpnxchange.com ([213.75.38.111]:15470 "EHLO
	hpsmtp-eml11.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754018AbXIWNIM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Sep 2007 09:08:12 -0400
In-Reply-To: <46F60AA2.1060500@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sunday 23 September 2007, Alexey Starikovskiy wrote:
> Frans Pop wrote:
> > drivers/built-in.o: In function `acpi_power_off_prepare':
> > main.c:(.text+0x32282): undefined reference to `acpi_sleep_prepare'
> > drivers/built-in.o: In function `acpi_hibernation_prepare':
> > main.c:(.text+0x3228c): undefined reference to `acpi_sleep_prepare'
>
> yep... acpi_sleep_prepare was put under CONFIG_SUSPEND spanning half of
> the file... this patch moves it out.

Compiles and works fine with that patch applied. Thanks.


One thing I noticed after booting with the kernel without CONFIG_SUSPEND.
/proc/acpi/sleep no longer lists S3 (as expected), but /proc/acpi/wakeup 
does still list the device status for S3, which seems somewhat 
inconsistent:

Device	S-state	  Status   Sysfs node
VIY0	  S3	 disabled  pci:0000:01:0b.0
USB1	  S3	 disabled  pci:0000:00:1d.0
USB2	  S3	 disabled  pci:0000:00:1d.1
USB4	  S3	 disabled  pci:0000:00:1d.7
AMDM	  S3	 disabled  pci:0000:00:1f.6
LID	  S4	*enabled   
PWRB	  S4	*enabled   

Not sure if it's worth fixing though.

Cheers,
FJP
