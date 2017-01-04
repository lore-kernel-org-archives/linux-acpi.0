From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [GIT PULL] More ACPI updates for v4.10-rc1
Date: Thu, 5 Jan 2017 00:15:34 +0100
Message-ID: <CAJZ5v0hqsoFXvhhyzFAcoi238-dDPesm1-HkGuogJgxLfy2d3g@mail.gmail.com>
References: <CAJZ5v0iq8z-cdja46o2z__Pfs9M+j2q4SXFu=7cS4LHY3XqL4g@mail.gmail.com>
 <CA+55aFxB_vuENriLFT6S+HMfWouKvrOaaM3NYgeYGnmTYsKU=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35197 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966680AbdADXPg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jan 2017 18:15:36 -0500
In-Reply-To: <CA+55aFxB_vuENriLFT6S+HMfWouKvrOaaM3NYgeYGnmTYsKU=g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Jan 4, 2017 at 6:46 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Dec 22, 2016 at 6:18 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> Please pull from the tag
>>
>>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>>  acpi-extra-4.10-rc1
>
> I only just noticed that this apparently introduces a new warning:
>
>   ACPI Warning: Table ffffffff9fe6c0a0, Validation count is zero
> before decrement
>
> the bug may be old, it looks like just the check is new to commit 174cc7187e6f.
>
> But it does seem like something is putting a table that wasn't properly gotten.
>
> Hmm?

It certainly seems so, but acpi_tb_put_table() and acpi_put_table()
are only used in a few places and all of them look correct by
inspection.  Nothing obvious at least.

Is this on HW or emulation?

Thanks,
Rafael
