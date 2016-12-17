From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] acpi: Fix format string type mistakes
Date: Sat, 17 Dec 2016 03:12:17 +0100
Message-ID: <CAJZ5v0i=+MW4dCFWTgsmQWOj0+rETz9ry3tmDCjhcZGXgphfZg@mail.gmail.com>
References: <20161216215137.GA96800@beast> <CAJZ5v0h-xUXNHgr5x4ZYRAvsUZDip65aYCPVPeZ3E9=djcpQnA@mail.gmail.com>
 <CAGXu5jKc35OzaPCR-f34THEkmE4ZbPP-cW2BVFzTgPYVmT_5dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:33137 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbcLQCMU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Dec 2016 21:12:20 -0500
In-Reply-To: <CAGXu5jKc35OzaPCR-f34THEkmE4ZbPP-cW2BVFzTgPYVmT_5dw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Emese Revfy <re.emese@gmail.com>, "devel@acpica.org" <devel@acpica.org>

On Sat, Dec 17, 2016 at 12:04 AM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Dec 16, 2016 at 2:36 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Fri, Dec 16, 2016 at 10:51 PM, Kees Cook <keescook@chromium.org> wrote:
>>> From: Emese Revfy <re.emese@gmail.com>
>>>
>>> This adds the missing __printf attribute which allows compile time
>>> format string checking (and will be used by the coming initify gcc
>>> plugin). Additionally, this fixes the warnings exposed by the attribute.
>>>
>>> Signed-off-by: Emese Revfy <re.emese@gmail.com>
>>> [kees: split scsi/acpi, merged attr and fix, new commit messages]
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> This modifies code that we get from an external projiect (ACPICA) and
>> the bugs should be fixed in there in the first place.
>
> Who should get CCed?

Fortunately, the right people are in the CC list already. :-)

>> Moreover, I'm not sure if adding __printf in acpiosxf.h is a good idea.
>
> Why not?

Because it would cause that file to diverge from its upstream
counterpart which would be sort of a problem.

> This is going to be needed by the initify plugin to do
> correct detection of what's being passed around to functions...

I guess the question is what we will miss if we don't do that
specifically for ACPICA.

Thanks,
Rafael
