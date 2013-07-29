From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] APEI/ERST: Fix error message formatting
Date: Mon, 29 Jul 2013 08:50:19 -0600
Message-ID: <CAErSpo69wNc1h6PyJhFfhdFzz0GOiM=SCCfrm-WO5XDFTFzcHw@mail.gmail.com>
References: <1374526866-6813-1-git-send-email-bp@alien8.de>
 <20130724171347.GB29756@naverao1-tp.watson.ibm.com> <1374686598.18818.18.camel@joe-AO722>
 <51F10AA8.2050901@linux.vnet.ibm.com> <CAErSpo5vLbsM5BXjrCVy1AKBxRRSH33TthyyK3O35Mghqw81nQ@mail.gmail.com>
 <20130729135812.GD6634@pd.tnic> <CAErSpo6fbMmicX95j_wYkJRnQeJEZ_jQSm76j9ZN4sHP0C2Yhg@mail.gmail.com>
 <20130729144046.GE6634@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:51918 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab3G2Ouk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jul 2013 10:50:40 -0400
Received: by mail-oa0-f54.google.com with SMTP id o17so4050543oag.13
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jul 2013 07:50:40 -0700 (PDT)
In-Reply-To: <20130729144046.GE6634@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>

On Mon, Jul 29, 2013 at 8:40 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Jul 29, 2013 at 08:28:05AM -0600, Bjorn Helgaas wrote:
>> > @@ -186,7 +186,7 @@ static int erst_exec_stall(struct apei_exec_context *ctx,
>> >
>> >         if (ctx->value > FIRMWARE_MAX_STALL) {
>> >                 if (!in_nmi())
>> > -                       pr_warning(FW_WARN ERST_PFX
>> > +                       pr_warn(FW_WARN
>> >                         "Too long stall time for stall instruction: %llx.\n",
>>
>> You didn't change this part, but this and similar messages look less
>> useful than they could be.  We're printing in hex, but there's no
>> indication in the output (no "0x" prefix).  And there's no instruction
>> pointer or anything to help connect this back to the source of the
>> problem.
>
> Sounds like we don't want to print ctx->value at all but simply signal
> about the stall? Or?

If I were the firmware developer and got a report about this message,
I think the information I would want is ctx->ip, so I could identify
the corresponding source code.  But I don't know much about the ERST
interpreter, so I don't know if "ctx->ip" is the right place to look.
Maybe there's a method name or table name that would be needed in
addition.

It just seems like "ERST: Too long stall time for stall instruction:
4732." all by itself doesn't really contain any actionable
information.

Bjorn
