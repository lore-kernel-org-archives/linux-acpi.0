From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Subject: Re: [PATCH] acpi, numa, ia64: Parse all entries of SRAT memory
 affinity table
Date: Tue, 21 Nov 2017 22:40:53 +0530
Message-ID: <CAKTKpr4n2154Ep1541mjzFntyWxVtMWvxJf87UYQT-1XP37CZA@mail.gmail.com>
References: <20171115172902.20083-1-ganapatrao.kulkarni@cavium.com>
 <3908561D78D1C84285E8C5FCA982C28F779F2D18@ORSMSX110.amr.corp.intel.com>
 <CAKTKpr4xh8Taw82ikBHonjWSB-Ob_-LupC_QJiH=5GqnssAmfg@mail.gmail.com> <CAJZ5v0in=eK9RT5ODGYp8FEggCOKeRdxKdD3JkiAoxqTuveuWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45013 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbdKURKz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Nov 2017 12:10:55 -0500
In-Reply-To: <CAJZ5v0in=eK9RT5ODGYp8FEggCOKeRdxKdD3JkiAoxqTuveuWA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "guohanjun@huawei.com" <guohanjun@huawei.com>, "jnair@caviumnetworks.com" <jnair@caviumnetworks.com>, "gpkulkarni@gmail.com" <gpkulkarni@gmail.com>, "Robert.Richter@cavium.com" <Robert.Richter@cavium.com>

On Tue, Nov 21, 2017 at 6:22 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Nov 21, 2017 at 5:16 AM, Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
>> On Thu, Nov 16, 2017 at 12:16 AM, Luck, Tony <tony.luck@intel.com> wrote:
>>>> This check is already added in x86 and extending same to ia64.
>>>
>>> Looks OK.
>>>
>>> Acked-by: Tony Luck <tony.luck@intel.com>
>>
>> thanks Tony.
>>
>> ACPI Maintainers,
>> any comments on this patch? i can send rebasing to 4.15-rc1?
>
> I've queued it up already.

thanks Rafael.
>
> Is there any urgent need for that to go into 4.15?

not really.
>
> Thanks,
> Rafael

thanks
Ganapt
