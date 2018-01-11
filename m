From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/1] ACPICA: Log Exceptions and Errors as warning while loading extra tables
Date: Thu, 11 Jan 2018 20:28:40 +0100
Message-ID: <20180111192841.7951-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754535AbeAKT2q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 11 Jan 2018 14:28:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, devel@acpica.org

Hi All,

So this is a rebased resend of an old patch of mine, which back then was
rejected because all the ugly ACPI errors scaring the user during boot
would need to be resolved in either the ACPICA code or in the BIOS /
firmware in question.

It is a year later now and as all the people commenting on:
https://bugzilla.kernel.org/show_bug.cgi?id=198167
show (33 comments and counting in a short time), people experience these
kinda errors as a real problem. Note this bug is (mostly) about a new bunch
of ACPI error messages which are not fixed by this patch actually, but it
does nicely illustrate that people experience these errors as a real problem /
a real nuisance and I agree with them.

https://bugzilla.kernel.org/show_bug.cgi?id=198167#c33
also shows that the chances of ever getting these errors fixed in the case
where the problem is in the DSDT is very close to 0, so rejecting this
patch with an "ask your vendor to fix the firmware" is really not a useful
answer, people have tried and this is simply not going to happen.

Given all the effort distros have done with splash-screens to give
users a nice clean boot experience, we really want dmesg --level=err
to not print anything unless there is a real problem with either the
hardware or the kernel. And in this case neither is not true and these
unfixable and therefor useless errors only lead to a very jarring boot
experience (hence all the users complaining in bug 198167).

Note this patch does not silence or removes the messages about these
problems in the ACPI tables, it merely lowers their log level from
error to warning so that the messages do not show on the console, they
will still show in dmesg and other logs.

Regards,

Hans

