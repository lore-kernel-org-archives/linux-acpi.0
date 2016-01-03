From: Olle Englund <realdiskdoc@gmail.com>
Subject: Re: [HP Compaq 6715s] Updating kernel renders system unbootable
Date: Mon, 4 Jan 2016 01:51:16 +0200
Message-ID: <CAHii-dGm27WvZ1iCU-4P6v8SmqZMGKQECmjMA2Yhq2rSCydqWw@mail.gmail.com>
References: <CAHii-dEo0D9QkmpXaQoz-XKai8omx_TrGgHcmk3t7AwE8+DZ8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35537 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbcACXv4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2016 18:51:56 -0500
Received: by mail-ig0-f173.google.com with SMTP id to4so233402373igc.0
        for <linux-acpi@vger.kernel.org>; Sun, 03 Jan 2016 15:51:56 -0800 (PST)
In-Reply-To: <CAHii-dEo0D9QkmpXaQoz-XKai8omx_TrGgHcmk3t7AwE8+DZ8Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lv.zheng@intel.com, rafael.j.wysocki@intel.com, robert.moore@intel.com
Cc: linux-acpi@vger.kernel.org

[1] Summary

[HP Compaq 6715s] Updating kernel renders system unbootable

[2] Description

On 4.4.0-040400rc7:

- Message about loading image.
- Screen goes black.
- Fan goes to full speed.
- HD light lit for about 15 seconds or so, then goes dark.

Disect:

between 3.19.0-25.26 and 3.19.0-26.27 in the Ubuntu kernel tree:

commit 19114b5458510b757cd2801e64094e4062e4067f
Author: Lv Zheng <lv.zheng@intel.com>
Date: Wed Jul 1 14:43:34 2015 +0800

    ACPICA: Tables: Enable default 64-bit FADT addresses favor

    BugLink: http://bugs.launchpad.net/bugs/1479048

    commit 0ea61381788a37d864f9841b0fe97d40f7058f3b upstream.

    ACPICA commit 4da56eeae0749dfe8491285c1e1fad48f6efafd8

    The following commit temporarily disables correct 64-bit FADT addresses
    favor during the period the root cause of the bug is not fixed:
     Commit: 85dbd5801f62b66e2aa7826aaefcaebead44c8a6
     ACPICA: Tables: Restore old behavor to favor 32-bit FADT addresses.

    With enough protections, this patch re-enables 64-bit FADT addresses by
    default. If regressions are reported against such change, this patch should
    be bisected and reverted.
    Note that 64-bit FACS favor and 64-bit firmware waking vector favor are
    excluded by this commit in order not to break OSPMs. Lv Zheng.

    Link: https://bugzilla.kernel.org/show_bug.cgi?id=74021
    Link: https://github.com/acpica/acpica/commit/4da56eea
    Reported-and-tested-by: Oswald Buddenhagen <ossi@kde.org>
    Signed-off-by: Lv Zheng <lv.zheng@intel.com>
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Signed-off-by: Kamal Mostafa <kamal@canonical.com>
    Signed-off-by: Luis Henriques <luis.henriques@canonical.com>

:040000 040000 0b002dc7d6e5abe0ded978926361d88efd5a0f88
27c36ea102b1622ded7beecbca477f62fa33922a M include

[7] Environment

Description:    Ubuntu 14.04.3 LTS
Release:    14.04

[X] Notes

Please forgive any oversights in my report, it is my first in this
format. I left out many sections/numbers since I could not boot with
the latest mainline kernel. Also, I had to send the report again since
Google apparently hid some HTML in my mail.

Original report: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1529381

Thanks,

Carl
