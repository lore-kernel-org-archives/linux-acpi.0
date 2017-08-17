From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI/APEI: Add BERT data driver
Date: Thu, 17 Aug 2017 22:41:23 +0200
Message-ID: <CAJZ5v0gML6bX2QW65Kv+huJtM4ZUjhw6PC=52hh8NiK-9Uqpzg@mail.gmail.com>
References: <20170814165613.25561-1-tony.luck@intel.com> <87k225p1v5.fsf@e105922-lin.cambridge.arm.com>
 <20170815211556.nnnnbtlvorgc3ijh@intel.com> <87a82zpsd7.fsf@e105922-lin.cambridge.arm.com>
 <3908561D78D1C84285E8C5FCA982C28F61340302@ORSMSX114.amr.corp.intel.com>
 <8760dmpk30.fsf@e105922-lin.cambridge.arm.com> <20170817174920.d5jeltjcbhmhxvge@intel.com>
 <CAJZ5v0hgnbR7AbObAYDEYRpG-WjgW-qd=Qieh5a4XLa=ZGpxTg@mail.gmail.com> <20170817202954.v7v6eoh7vdearxlx@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:35422 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbdHQUlY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Aug 2017 16:41:24 -0400
In-Reply-To: <20170817202954.v7v6eoh7vdearxlx@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Punit Agrawal <punit.agrawal@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Boris Petkov <bp@suse.de>, Tyler Baicar <tbaicar@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Aug 17, 2017 at 10:29 PM, Luck, Tony <tony.luck@intel.com> wrote:
> On Thu, Aug 17, 2017 at 09:28:53PM +0200, Rafael J. Wysocki wrote:
>> What about /sys/firmware/acpi/tables/data/ and then one file per table
>> under it with the same name as the table file under tables/ ?
>
> "data" works. ACPI table names are all upper-case, so it
> can't conflict. Any programs that scan the whole directory
> have to already skip "dynamic", so they likely would not
> be confused by the appearance of a second directory.
>
> For BERT there is only one blob of data. So naming it the
> same as the table is fine.  Maybe other tables might have
> more than one thing? If so, they could use the table name
> as a prefix, or make a subdirectory. We can cross that
> bridge if anyone finds additional useful things to add.

Actually, there already are multiple SSDTs on the majority of systems
and the corresponding files under tables/ are called SSDT1, SSDT2
etc., so we just need to follow the existing convention.

Thanks,
Rafael
