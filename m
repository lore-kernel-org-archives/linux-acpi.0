From: "Anderson, Brandon" <Brandon.Anderson@amd.com>
Subject: RE: [PATCH V2 0/4] ACPI/ARM: AMBA bus ACPI module
Date: Fri, 22 Nov 2013 19:44:53 +0000
Message-ID: <CE40542A5D952D47989966E71788B184037DE89A@satlexdag05.amd.com>
References: <1385143964-22938-1-git-send-email-brandon.anderson@amd.com>
 <CAOesGMhA=Ne9HvPFGZF1ESaP7HP6s2=0YochkWrM3KtjxgP=Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:27576 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755723Ab3KVTpE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Nov 2013 14:45:04 -0500
In-Reply-To: <CAOesGMhA=Ne9HvPFGZF1ESaP7HP6s2=0YochkWrM3KtjxgP=Aw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Olof,
I apologize for posting confusing patches to the linux-acpi list.

These patches are on top of the Linaro ACPI work, http://git.linaro.org/git-ro/arm/acpi/leg-kernel.git

Brandon


-----Original Message-----
From: Olof Johansson [mailto:olof@lixom.net] 
Sent: Friday, November 22, 2013 1:04 PM
To: Anderson, Brandon
Cc: Russell King - ARM Linux; Rafael J. Wysocki; linaro-acpi@lists.linaro.org; linux-acpi@vger.kernel.org
Subject: Re: [PATCH V2 0/4] ACPI/ARM: AMBA bus ACPI module

Hi,

On Fri, Nov 22, 2013 at 10:12 AM, Brandon Anderson <brandon.anderson@amd.com> wrote:
> This patch series requires the fixed-clock patches from Hanjun Guo.

I don't see them posted anywhere? Please don't post patches that don't apply to mainline (or to publicly posted dependencies).

>  arch/arm64/boot/dts/foundation-v8-acpi.dts        |   10 +-
>  arch/arm64/boot/dts/rtsm_ve-aemv8a-acpi.dts       |    4 +
>  arch/arm64/boot/dts/rtsm_ve-motherboard-acpi.dtsi |    8 +

These files don't exist in mainline, nor in linux-next.


-Olof


