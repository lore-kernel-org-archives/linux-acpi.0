From: Andreas Mohr <andi@lisas.de>
Subject: pm: record / retain actual reason of last system wakeup??
Date: Tue, 2 Jun 2015 21:07:02 +0200
Message-ID: <20150602190702.GA9112@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:33381 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbbFBTHE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Jun 2015 15:07:04 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>

Hi,

I'm wondering whether we're actually recording / retaining
any info about the precise reason for the machine wakeup
that was responsible for having woken up the current (continued) session
(e.g. WOL, RTC, configured keyboard wakeup, ...).

See also
http://superuser.com/questions/297057/linux-how-to-get-the-reason-for-wakeup
, which comes up pretty much empty on this topic.

The reason that I'm asking is that I've got a nice (well not so nice)
PCI card which is acting up
which I'm trying to debug
(see "fw-ohci: ALi M52xx unsupported" https://bugzilla.kernel.org/show_bug.cgi?id=10935 for details)
which even prevents proper shutdown or pm-suspend of the PC
(somehow causes immediate re-launch).
Needless to say I don't see anything in dmesg (currently on 4.1-rc5 BTW)
which would hint at why exactly the re-launch occurred
i.e. through which means exactly it managed to force re-launch
(this would be important to further nail down its misbehaviour).

Rather than having such very important information
turn up temporarily in dmesg output,
it should be reliably recorded/retained in a specific sysfs attribute anyway,
in a *system-global* / generic / non-ACPI-specific manner.
I.e. there should perhaps be a kernel-global sink for such information,
to be written to by whichever component is able to indicate
why a wakeup occurred.

Pseudo code could be:
if (directly_prior_to_suspend)
    wakeup_reason_zero();

if (platform_knows_stuff)
    wakeup_reason_append(generic_knowledge);

if (special_driver_knows_stuff)
    wakeup_reason_append(very_magic_special_info);


wakeup_reason_zero()
{
    wakeup_reason_sysfs_attr_zero();
}

wakeup_reason_append(info)
{
    wakeup_reason_sysfs_attr_append(info);
}

And once (the moment that) such an implementation got created,
it should be documented,
since currently grepping of Documentation/ for wakeup|grep -i reason
does not show any hints.

Thanks,

Andreas Mohr
