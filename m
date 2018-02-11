From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/2] ACPI / osi: add DMI quirk for Dell systems
Date: Sun, 11 Feb 2018 14:45:10 +0100
Message-ID: <20180211134510.GB1521@wunner.de>
References: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
 <1517388005-14852-2-git-send-email-alex.hung@canonical.com>
 <20180205141447.6e1442ac@endymion>
 <1517840100.22495.25.camel@linux.intel.com>
 <5de252ed95ee48eab3bd8deeea5c610a@ausx13mpc120.AMER.DELL.COM>
 <20180205224531.GA46524@dtor-ws>
 <e30274b31bda47c5972621607cf3b605@ausx13mpc120.AMER.DELL.COM>
 <1517924731.22495.51.camel@linux.intel.com>
 <CAJZ5v0gpkBkuSV8rvvgVq8Cr7cWUr0PfeuGD5tG7GU+jWsTkqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:51473 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbeBKNur (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Feb 2018 08:50:47 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gpkBkuSV8rvvgVq8Cr7cWUr0PfeuGD5tG7GU+jWsTkqg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <Mario.Limonciello@dell.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <jdelvare@suse.de>, Alex Hung <alex.hung@canonical.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Miller <davem@davemloft.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, karniksayli1995@gmail.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, 2018-02-06 at 00:45 +0000, Mario.Limonciello@dell.com wrote:
> Windows expects to use RTD3 on the NVIDIA GPU but Linux drivers
> don't.  It leads to system hangs on the Linux side.

So I'm on a Mac and thus indifferent to this issue, but I happen
to know a thing or two about hybrid graphics and I'm wondering
what the claim above is supposed to mean.

RTD3, that's runtime D3, right?  Because nouveau does runtime suspend
to D3cold and has been doing so since 2013.

The commit message is extremely terse as to what exact problem
the commit is trying to solve, and I haven't seen anything more
specific in this thread other than handwaving. ("waiting on NVIDIA
releasing something Nouveau needs" -- what exactly?)

So please state clearly what the problem is and why solving it
this way is the best or only solution.

Thanks,

Lukas
