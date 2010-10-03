From: Allan Kelly <allankelly@gmail.com>
Subject: Re: Toshiba C650-194 ACPI bug - regression
Date: Sun, 3 Oct 2010 15:53:11 +0100
Message-ID: <AANLkTinLJnRQ=PZAzpAvW=Hu_OroeiCnpPc1TRLtwxsL@mail.gmail.com>
References: <AANLkTin3mtDm9x=8E_b_0FDWdwzbU570x1Ok-btMBPiF@mail.gmail.com>
	<AANLkTi=j75zW-8NFtt8w-z8zQrL7Y_esQD6iLEcCyP00@mail.gmail.com>
	<alpine.LFD.2.00.1010012243430.2293@localhost.localdomain>
	<AANLkTi=Jn7kRpDvE4YUgLZe1yxBCZdcFYo0oUpov+PXx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38159 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502Ab0JCOxO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Oct 2010 10:53:14 -0400
Received: by qyk32 with SMTP id 32so1071150qyk.19
        for <linux-acpi@vger.kernel.org>; Sun, 03 Oct 2010 07:53:13 -0700 (PDT)
In-Reply-To: <AANLkTi=Jn7kRpDvE4YUgLZe1yxBCZdcFYo0oUpov+PXx@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

I realise the question regarding acpi=copy_dsdt is rather lazy of me,
so I tried it with the stock 2.6.36-rc2.

I can confirm it works as expected. So, even if later kernels ship
without the Toshiba Satellite detection, copy_dsdt can be used.

The only significant difference in the 2 dmesg outputs (Toshiba patch
versus acpi=copy_dsdt) is the absence of the 1st line below for
acpi-copy_dsdt. Both dmesg contain the second line.

        TOSHIBA Satellite detected - force copy of DSDT to local memory
        ACPI: Forced DSDT copy: length 0x094DE copied locally, original unmapped

Cheers, al.

On 2 October 2010 21:46, Allan Kelly <allankelly@gmail.com> wrote:
> Glad to help Len.
>
> BTW, what is going on here? Is there a thread where this is explained?
> Seems the BIOS deliberately alters the DSDT after initialisation. Do
> we know why? Does it do it for Win OSs?
>
> Also, I see that for kernels >= 2.6.35 the boot argument
> acpi=copy_dsdt is available which it sounds like it should cause the
> same behaviour as this patch. Is that right? In which case I can start
> to use that with standard distros once the appropriate kernel level is
> distributed for Ubuntu.
>
> Many thanks, al.
>
> On 2 October 2010 03:45, Len Brown <lenb@kernel.org> wrote:
>> Thanks for confirming the patch works, Allan,
>>
>> It shipped upstream in 2.6.36-rc6-git2
>> and I just sent a note for Greg to consider it for .stable
>>
>> cheers,
>> Len Brown, Intel Open Source Technology Center
>>
>>
>
