From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: syntax error, unexpected PARSEOP_NAMESEG, expecting PARSEOP_DEFINITIONBLOCK
Date: Tue, 1 May 2007 14:08:53 +0400
Message-ID: <8f8ff01d0705010308q197c7314o1f3dd34670b58c05@mail.gmail.com>
References: <46370B26.2080704@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:9492 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031649AbXEAKIy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 May 2007 06:08:54 -0400
Received: by an-out-0708.google.com with SMTP id b33so1556842ana
        for <linux-acpi@vger.kernel.org>; Tue, 01 May 2007 03:08:54 -0700 (PDT)
In-Reply-To: <46370B26.2080704@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Markus Feldmann <feldmann_markus@gmx.de>
Cc: linux-acpi@vger.kernel.org

1. why do you think that making custom DSDT is going to help you?
2. please attach your dsdt.dsl, so we could see on what iasl barks...
>From your report it looks like you trying to fed it with some non-aml
code.

Regards,
Alex.

On 5/1/07, Markus Feldmann <feldmann_markus@gmx.de> wrote:
> Hi All,
>
> i bought a Laptop Asus A7Tc and got the first Problem with ACPI and
> suspend-to-ram.
>
> My System is Debian Etch with Kernel 2.6.21.
> Cpu is AMD Turion(tm) 64 X2 Mobile Technology TL-52
>
>
> i did the folowing to fix my dsdt Table,
>  > cat /proc/acpi/dsdt > dsdt.dat
>  > iasl -d dsdt.dat
>  > feld-bertlap:/tmp/acpi# iasl -tc dsdt.dsl
>
>  > Intel ACPI Component Architecture
>  > ASL Optimizing Compiler version 20060912 [Dec 20 2006]
>  > Copyright (C) 2000 - 2006 Intel Corporation
>  > Supports ACPI Specification Revision 3.0a
>
>  > dsdt.dsl     1: ACPI Package (0x04)
>  > Error    4094 -    ^ syntax error, unexpected PARSEOP_NAMESEG,
> expecting PARSEOP_DEFINITIONBLOCK
>
> Can anybody explain what i have to do to correct my table?
>
> bye Markus
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
