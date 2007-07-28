From: "Andika Triwidada" <andika@gmail.com>
Subject: Re: Battery 'present rate' display weirdness
Date: Sat, 28 Jul 2007 17:32:48 +0700
Message-ID: <7e0bae390707280332n6c91e7aaw6e64b5df00383a1@mail.gmail.com>
References: <7e0bae390707270823v3e80b72cmc0f4c665c3ce907f@mail.gmail.com>
	 <46AB033B.80608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:44488 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbXG1Kcu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jul 2007 06:32:50 -0400
Received: by nf-out-0910.google.com with SMTP id g13so78364nfb
        for <linux-acpi@vger.kernel.org>; Sat, 28 Jul 2007 03:32:49 -0700 (PDT)
In-Reply-To: <46AB033B.80608@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 7/28/07, Alexey Starikovskiy <aystarik@gmail.com> wrote:
> Hello Andika,
>
> Acer was long user of smart battery system (SBS), which allows for
> negative values of the current (it is signed 16 bit value in SBS).
> If your Acer exports battery directly with SBS, there is a bug in drivers/acpi/sbs.c
> If it exports battery with ACPI control methods (CM), then there is a need of
> workaround in drivers/acpi/battery.c (CM uses 64 bit value to store current,
> so this is not a matter of getting absolute value of it).
>
> Could you please open bug against ACPI/Battery and attach acpidump output
> to it?
>
> Thanks,
> Alex.

http://bugzilla.kernel.org/show_bug.cgi?id=8820

sbs doesn't seems to recogniza the battery, loaded ok but nothing new
under /proc/acpi. How do I make sure?

Let me know if you need more info.

Thanks.
Andika
