From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI processor module with Atom N270 causes DMA errors
Date: Mon, 26 Oct 2009 00:45:49 +0300
Message-ID: <4AE4C70D.2020600@gmail.com>
References: <20091025210754.55abdbe6@boulder.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:47891 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbZJYVpr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Oct 2009 17:45:47 -0400
Received: by fg-out-1718.google.com with SMTP id d23so881513fga.1
        for <linux-acpi@vger.kernel.org>; Sun, 25 Oct 2009 14:45:51 -0700 (PDT)
In-Reply-To: <20091025210754.55abdbe6@boulder.homenet>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Vine <chris@cvine.freeserve.co.uk>
Cc: linux-acpi@vger.kernel.org

Hi Chris,

Please open new bug report against ACPI/Processor in bugzilla.kernel.or=
g
attach outputs from dmesg, acpidump and dmidecode. Kernel config file=20
might appear useful too.

Regards,
Alex.

Chris Vine =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hi,
>
> I have a Levono S-12 netbook which uses an Atom N270 processor.
> Loading the ACPI 'processor' module clobbers my DMA, specifically whe=
n
> using the b43 driver for a Broadcom BCM4312 802.11b/g [14e4:4315] low
> power phy wireless device.  The b43 driver works correctly if the
> processor ACPI module is blacklisted.
>
> This is with kernel 2.6.32-rc5, but the same occurs with earlier
> pre-2.6.32 kernels.
>
> Please let me know what further information would be helpful (for
> example, the output of dmesg, lspci or lsmod, or other hardware
> information).
>
> Chris
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
