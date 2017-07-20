From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Modern Suspend on Dell Latitude 5285 does not resume
Date: Thu, 20 Jul 2017 23:03:55 +0200
Message-ID: <CAJZ5v0iPxpDJ-J872jrcAQN4cqiESeMmNytFj3ZKxqbobW3toA@mail.gmail.com>
References: <87k233nfz0.fsf@ungleich.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:38479 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935802AbdGTVD4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jul 2017 17:03:56 -0400
In-Reply-To: <87k233nfz0.fsf@ungleich.ch>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nico Schottelius <nico.schottelius@ungleich.ch>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Limonciello Mario <Mario_Limonciello@dell.com>, Tom Lanyon <tom@oneshoeco.com>, =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Zheng Lv <lv.zheng@intel.com>

On Thu, Jul 20, 2017 at 8:24 PM, Nico Schottelius
<nico.schottelius@ungleich.ch> wrote:
>
> Hello,
>
> following up the recent patch [0] to enable modern suspend on Dell notebooks, I
> can report that this patch does *not* fix the situation on Dell Latitude
> 5285. I have tested with v4.12-10845-g74cbd96 and when closing the "lid"
> or triggering sleep by echo mem > /sys/power/state, the system suspends,
> but never wakes up again. Trying to resume with the power button does
> not have any affect, as it is the case with 4.12.1.
>
> A long power button press to forcefully shutdown the system is
> necessary, at which point the notebook responds with blinking
> the power LED (3x red, 5x white), which seems not to be defined in
> the user manual.
>
> Is there anything I can do to test what is going on?

Have you tried "echo freeze > /sys/power/state" instead of "mem"?

Thanks,
Rafael
