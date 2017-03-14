From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: docked sysfs attribute always 0
Date: Tue, 14 Mar 2017 21:42:37 +0100
Message-ID: <CAJZ5v0ggc98WuK2+q9Pyc1TgB4+-=hgHHZ9egU5xLzzzarkhbg@mail.gmail.com>
References: <20170314192654.7ezf6o6ov2v3lrdm@kevinolos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36820 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752851AbdCNUmi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Mar 2017 16:42:38 -0400
Received: by mail-ot0-f195.google.com with SMTP id i1so21542666ota.3
        for <linux-acpi@vger.kernel.org>; Tue, 14 Mar 2017 13:42:37 -0700 (PDT)
In-Reply-To: <20170314192654.7ezf6o6ov2v3lrdm@kevinolos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kevin Locke <kevin@kevinlocke.name>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>

On Tue, Mar 14, 2017 at 8:26 PM, Kevin Locke <kevin@kevinlocke.name> wrote:
> On my Lenovo ThinkPad T430 (2342-CTO) with kernel 4.10.1 (and
> presumably earlier) the "docked" sysfs file always contains 0 for all
> dock devices (ata_bay and battery_bay), even when devices are present,
> both at boot and after hotplug.  I could not find a documented API for
> this file, but from the code and use in widely-available dock
> scripts[1] I presume that this behavior is incorrect.  I found a
> similar issue reported by Pali Roh=C3=A1r[2] a few years ago which doesn'=
t
> appear to have been resolved.
>
> Assuming this behavior is a bug, should I open an issue in Bugzilla to
> track it?

Yes, won't hurt.

Please add rjw@rjwysocki.net to the CC list.

Thanks,
Rafael
