From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: How can I solve these DSL warnings?
Date: Wed, 9 May 2007 11:04:54 +0400
Message-ID: <8f8ff01d0705090004u2ee9348ex499d89e9cae747e2@mail.gmail.com>
References: <464170AE.2000607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:7320 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967876AbXEIHEz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 May 2007 03:04:55 -0400
Received: by an-out-0708.google.com with SMTP id d18so22239and
        for <linux-acpi@vger.kernel.org>; Wed, 09 May 2007 00:04:54 -0700 (PDT)
In-Reply-To: <464170AE.2000607@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frittella Laurento <laurento.frittella@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 5/9/07, Frittella Laurento <laurento.frittella@gmail.com> wrote:
> Hi all,
> I'm trying to fix these warnings that appears during dsl compile:
>
>   dsdt.dsl  2341:                 Method (_S0D, 0, NotSerialized)
>   Warning  1097 -      Unknown reserved name ^  (_S0D)
Remove underscore from name ('_S0D'->'S0D') or just ignore...
>
> Code (part of interest):
>   Method (_S0D, 0, NotSerialized)
>   {
>       Store (SMI (0x85, 0x00), Local0)
>       And (Local0, 0x01, Local0)
>       If (LEqual (Local0, 0x00))
>       {
>         Return (0x03)
>       }
>       Else
>       {
>         Return (0x00)
>       }
>   }
>
>
> The other kind of warning is:
>
>   dsdt.dsl  3040:                         And (Local0, 0x0F)
Change to And(Local0, 0x0F, Local0). This form will store result of
operator back to Local0, probable intention of the statement...
>   Warning  1104 -                                   ^ Result is not
> used, operator has no effect
>
> Code (part of interest):
>   If (LLess (Local0, 0x80))
>   {
>     And (Local0, 0x0F)
>     Store (0x01, Local1)
>     ShiftLeft (Local1, Local0, Local1)
>     Store (Local1, IRA)
>   }
>
>
> Another one:
>   dsdt.dsl  3818:                     Return (Package (0x00) {})
Ignore.
>   Remark   5070 -    Effective AML package length is zero ^
>
>   Method (_DOD, 0, NotSerialized)
>   {
>      Return (Package (0x00) {})
>   }
>
> The last ;)
>   dsdt.dsl  4044:                             Wait (EJTD, 0xA000)
Ignore, or change to 0xFFFF.
>   Warning  1103 -         Possible operator timeout is ignored ^
>
>   Method (_EJ0, 1, NotSerialized)
>   {
>     Store (SMI (0x87, 0x00), MIS7)
>     If (MIS7)
>     {
>       SMI (0xA6, 0x02)
>       SMI (0x49, 0x01)
>       Wait (EJTD, 0xA000)
>       SMI (0x49, 0x00)
>     }
>
>     Return (0x00)
>   }
>
>
> I searched for them on the acpi website but I haven't find these warning
> codes.
>
> Regards,
> Laurento
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
