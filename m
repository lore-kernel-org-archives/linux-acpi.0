From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 01/15] ACPICA: Disassembler: Enhance resource descriptor detection
Date: Mon, 5 Jun 2017 22:55:09 +0200
Message-ID: <CAJZ5v0jExmFeYwbq2CwCGEetf=JJevePcUJNarb6OKnf0Bb0GQ@mail.gmail.com>
References: <cover.1493194142.git.lv.zheng@intel.com> <fe4a8655a06221df851d5781609058f16aa65e93.1493194142.git.lv.zheng@intel.com>
 <59357F55.8050707@hpe.com> <361261e5-ce98-9d33-f2de-88286288e2e1@hpe.com>
 <CAJZ5v0hUaiwZwi1a78zSO_hqp_QNdv9gYce-wwNESz1rnPs+sg@mail.gmail.com> <9f2f3edd-74e9-e108-0eff-56564c94147b@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:37146 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbdFEUzK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2017 16:55:10 -0400
Received: by mail-it0-f44.google.com with SMTP id m47so89320178iti.0
        for <linux-acpi@vger.kernel.org>; Mon, 05 Jun 2017 13:55:10 -0700 (PDT)
In-Reply-To: <9f2f3edd-74e9-e108-0eff-56564c94147b@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linda Knippers <linda.knippers@hpe.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, "David E . Box" <david.e.box@intel.com>, Lv Zheng <zetalog@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, Jun 5, 2017 at 10:51 PM, Linda Knippers <linda.knippers@hpe.com> wrote:
> On 6/5/2017 4:42 PM, Rafael J. Wysocki wrote:
> <snip>
>
>>> I talked to our FW team and we do generate checksums and not a zero for
>>> at
>>> least some
>>> of the AML. Please revert this change until you can also validate
>>> a checksum.  Or shall I post a patch to remove the check?
>>
>>
>> I'll skip this patch, no need to do anything else.  Thanks for your
>> report!
>
>
> Thanks.  This patch is already in as of 4.12rc1 and not part of the most
> recent
> ACPICA drop.

Ah, OK.

I should have checked I guess. :-)

Anyway, I'll revert it, then.

>> Bob, can you revert this upstream, please?  It looks like the
>> assumption it is based on doesn't hold.
>
> Bob, I'm happy to test something if there is a new patch that looks for zero
> or a valid checksum.  TBH, I'm not 100% certain that our checksums are
> correct because nothing has ever tried to verify them.

Well, that's part of the problem here I guess.  If they have never
been tested, they cannot be trusted.

Still, the commit in question clearly assumed that value to always be
0 and it clearly is not the case here.

Thanks,
Rafael
