From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI/APEI: Add BERT data driver
Date: Thu, 17 Aug 2017 21:28:53 +0200
Message-ID: <CAJZ5v0hgnbR7AbObAYDEYRpG-WjgW-qd=Qieh5a4XLa=ZGpxTg@mail.gmail.com>
References: <20170814165613.25561-1-tony.luck@intel.com> <87k225p1v5.fsf@e105922-lin.cambridge.arm.com>
 <20170815211556.nnnnbtlvorgc3ijh@intel.com> <87a82zpsd7.fsf@e105922-lin.cambridge.arm.com>
 <3908561D78D1C84285E8C5FCA982C28F61340302@ORSMSX114.amr.corp.intel.com>
 <8760dmpk30.fsf@e105922-lin.cambridge.arm.com> <20170817174920.d5jeltjcbhmhxvge@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:37649 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbdHQT2z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Aug 2017 15:28:55 -0400
In-Reply-To: <20170817174920.d5jeltjcbhmhxvge@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Boris Petkov <bp@suse.de>, Tyler Baicar <tbaicar@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Aug 17, 2017 at 7:49 PM, Luck, Tony <tony.luck@intel.com> wrote:
> On Thu, Aug 17, 2017 at 11:25:23AM +0100, Punit Agrawal wrote:
>> Though, I am OK with "table-data/BERT" as well.
>
> So I coded this up ... and it looks much better than I thought
> it might.  A bit larger than the previous version that modified
> drivers/acpi/apei/bert.c. But on the plus side easy to extend if
> there are other ACPI tables that point at interesting data.
>
> It doesn't handle dynamic tables. That would add a lot of complexity
> and BERT isn't dynamic.  Could be a later patch if someone has a
> need for it.
>
> All names negotiable.

OK

What about /sys/firmware/acpi/tables/data/ and then one file per table
under it with the same name as the table file under tables/ ?

So in particular for BERT the data would be in
/sys/firmware/acpi/tables/data/BERT ?

Thanks,
Rafael
