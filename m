From: Kevin Locke <kevin@kevinlocke.name>
Subject: Re: docked sysfs attribute always 0
Date: Tue, 14 Mar 2017 16:11:40 -0600
Message-ID: <20170314221140.26fuj56dsjrzlekg@kevinolos>
References: <20170314192654.7ezf6o6ov2v3lrdm@kevinolos>
 <CAJZ5v0ggc98WuK2+q9Pyc1TgB4+-=hgHHZ9egU5xLzzzarkhbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from praxis.kevinlocke.name ([205.185.125.39]:41626 "EHLO
        praxis.kevinlocke.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752118AbdCNWLo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Mar 2017 18:11:44 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ggc98WuK2+q9Pyc1TgB4+-=hgHHZ9egU5xLzzzarkhbg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>

On Tue, 2017-03-14 at 21:42 +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 14, 2017 at 8:26 PM, Kevin Locke <kevin@kevinlocke.name> wrote:
>> On my Lenovo ThinkPad T430 (2342-CTO) with kernel 4.10.1 (and
>> presumably earlier) the "docked" sysfs file always contains 0 for all
>> dock devices (ata_bay and battery_bay), even when devices are present,
>> both at boot and after hotplug. [...]
>>
>> Assuming this behavior is a bug, should I open an issue in Bugzilla to
>> track it?
> 
> Yes, won't hurt.
> 
> Please add rjw@rjwysocki.net to the CC list.

Done.  I created https://bugzilla.kernel.org/show_bug.cgi?id=194885

-- 
Thanks,      |  kevin@kevinlocke.name    | XMPP: kevin@kevinlocke.name
Kevin        |  https://kevinlocke.name  | IRC:   kevinoid on freenode
