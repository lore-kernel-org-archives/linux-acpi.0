From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc6-mm1 -- acpi_processor-0731 [00]
 processor_preregister_: Error while parsing _PSD domain information.
 Assuming no coordination
Date: Wed, 7 Jun 2006 23:24:52 -0700
Message-ID: <20060607232452.3829233b.akpm@osdl.org>
References: <a44ae5cd0606072232u40998475wd24c882b56f38f68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:31633 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932493AbWFHGY4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jun 2006 02:24:56 -0400
In-Reply-To: <a44ae5cd0606072232u40998475wd24c882b56f38f68@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miles Lane <miles.lane@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wed, 7 Jun 2006 22:32:17 -0700
"Miles Lane" <miles.lane@gmail.com> wrote:

> Hello,
> 
> I am not sure whether this is an error that needs following up on.
> My machine is a HP dv1240us (Pavillion laptop).  I ran "dmesg | grep -i acpi":
> 
>  BIOS-e820: 000000003dee0000 - 000000003deec000 (ACPI data)
>  BIOS-e820: 000000003deec000 - 000000003df00000 (ACPI NVS)
> ACPI: RSDP (v000 HP                                    ) @ 0x000f7e00
> ...
>

I assume this behaviour is different from 2.6.17-rc6?

I'm confused that the dmesg output which you provide does not include the
error message in the Subject:.

Does the machine actually misbehave in any fashion with 2.6.17-rc6-mm1?

