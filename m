From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [Debian-eeepc-devel] Debian on the ASUS EeePC 1005PE
Date: Fri, 19 Feb 2010 16:10:39 +0000
Message-ID: <9b2b86521002190810if166725ob21c005f250bf152@mail.gmail.com>
References: <87y6iqy58p.fsf@marvin.43-1.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:45040 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab0BSQKm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 11:10:42 -0500
Received: by bwz1 with SMTP id 1so196256bwz.21
        for <linux-acpi@vger.kernel.org>; Fri, 19 Feb 2010 08:10:41 -0800 (PST)
In-Reply-To: <87y6iqy58p.fsf@marvin.43-1.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ansgar Burchardt <ansgar@43-1.org>, Corentin Chary <corentincj@iksaif.net>
Cc: debian-eeepc-devel@lists.alioth.debian.org, debian-users@lists.debian.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 2/18/10, Ansgar Burchardt <ansgar@43-1.org> wrote:
> Hi,
>
> I got an ASUS EeePC 1005PE a few days ago and am trying to install
> Debian testing on it.
>
> There have been several problems so far:

<snip>
> 2. The Ethernet card disappeared completely.  It did no longer show up
> in the output from lspci, nor was it accessible in Windows.  This
> problem persisted over shutdowns as well.  Removing the battery and
> disconnecting the power supply luckily made the card show up again.
>
> A patch was available for this issue on a different EeePC model [3].
> This one was not so easy to backport, so I just changed it to disable
> hot-plug always (patch attached).  This solved this issue for me: the
> Ethernet card does no longer disappear.
>
> [3] http://bugzilla.kernel.org/show_bug.cgi?id=14570

My suggestion for this problem would be to contact the eeepc-laptop
maintainer :-).

I guess we're too late to add a blacklist entry for 2.6.33, but we
should be able to get a fix into 2.6.33.1.

Please confirm that the wireless toggle key (possibly fn+f2) works
correctly for you after disabling hotplug.  That is, it doesn't break
if you disable the wireless and enable it again (and you don't see
anything too scary in the kernel log).

Thanks
Alan
