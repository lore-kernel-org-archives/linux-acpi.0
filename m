From: "Sunil Naidu" <akula2.shark@gmail.com>
Subject: Re: Linux 2.6.21-rc7 - ACPI issues? (Namespace lookup failure, AE_NOT_FOUND)
Date: Sun, 22 Apr 2007 20:16:15 +0530
Message-ID: <8355959a0704220746k7ffb9ba1k89695e27760e915d@mail.gmail.com>
References: <8355959a0704210703n35b0dc35wcad04e5723eaec7@mail.gmail.com>
	 <200704212147.47926.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:62546 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030933AbXDVOqQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Apr 2007 10:46:16 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1092030nze
        for <linux-acpi@vger.kernel.org>; Sun, 22 Apr 2007 07:46:16 -0700 (PDT)
In-Reply-To: <200704212147.47926.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On 4/22/07, Len Brown <lenb@kernel.org> wrote:
>
> This is an AML run-time error from a PCI Interrupt Link
> trying to find its "Present Resource Settings" --
> ie. the current IRQ for a programmable IRQ.
>
> Please open up a bug report here:
> http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

Yep, raised a Bug report: #8360

> For 2.6.20.stable and the latest 2.6.21, please
> build with CONFIG_ACPI_DEBUG=y, and
> attach the complete output from dmesg -s64000
> and paste the /proc/interrupts.

Sure, shall test with 2.6.20.7 & 2.6.21-rc7.

> Also, please attach the output from acpidump
> and lspci -vv taken from either boot.

Shall do it ASAP ;-)

> -Len

Thanks,
~Akula2
