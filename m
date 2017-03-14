From: Kevin Locke <kevin@kevinlocke.name>
Subject: docked sysfs attribute always 0
Date: Tue, 14 Mar 2017 13:26:54 -0600
Message-ID: <20170314192654.7ezf6o6ov2v3lrdm@kevinolos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from praxis.kevinlocke.name ([205.185.125.39]:39494 "EHLO
        praxis.kevinlocke.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbdCNTgC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Mar 2017 15:36:02 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>

On my Lenovo ThinkPad T430 (2342-CTO) with kernel 4.10.1 (and
presumably earlier) the "docked" sysfs file always contains 0 for all
dock devices (ata_bay and battery_bay), even when devices are present,
both at boot and after hotplug.  I could not find a documented API for
this file, but from the code and use in widely-available dock
scripts[1] I presume that this behavior is incorrect.  I found a
similar issue reported by Pali Rohár[2] a few years ago which doesn't
appear to have been resolved.

Assuming this behavior is a bug, should I open an issue in Bugzilla to
track it?  I'm not familiar with the mailing-list vs Bugzilla
etiquette, but didn't find an issue for the previous report.

If there's anything else I can do to help debug, let me know.

Thanks,
Kevin

P.S.  Please CC me in replies as I am not subscribed to linux-acpi.

1.  http://www.thinkwiki.org/wiki/How_to_hotswap_Ultrabay_devices#Script_for_Ultrabay_eject
2.  https://marc.info/?t=139880262200003&r=1&w=2

-- 
Kevin Locke  |  kevin@kevinlocke.name    | XMPP: kevin@kevinlocke.name
             |  https://kevinlocke.name  | IRC:   kevinoid on freenode
