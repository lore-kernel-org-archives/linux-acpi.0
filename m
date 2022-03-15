Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BBAC433FE
	for <linux-acpi@archiver.kernel.org>; Tue, 15 Mar 2022 09:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346773AbiCOJtp (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 15 Mar 2022 05:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243306AbiCOJtp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Mar 2022 05:49:45 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A4A1AF24;
        Tue, 15 Mar 2022 02:48:32 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id EC2FECACB5;
        Tue, 15 Mar 2022 09:41:35 +0000 (UTC)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 6B61E40011;
        Tue, 15 Mar 2022 09:41:30 +0000 (UTC)
Message-ID: <4813c7f6f997d8b494bff6d73ee6331599bf2173.camel@hadess.net>
Subject: Re: [discuss] Split /sys/firmware/acpi/platform_profile into ac and
 battery profiles?
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Pearson <markpearson@lenovo.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Cc:     linux-acpi <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Date:   Tue, 15 Mar 2022 10:41:29 +0100
In-Reply-To: <03b7d1dc-42af-7964-ab7a-bdcc6644cc71@redhat.com>
References: <03b7d1dc-42af-7964-ab7a-bdcc6644cc71@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 2022-03-15 at 10:16 +0100, Hans de Goede wrote:
> Hi All,
> 
> AMD based ThinkPads (1) have separate ac (connected to an external
> powersource) and on battery tuned versions of the low-power, balanced
> and
> performance profiles. So in essence they have six profiles: low-
> power-ac,
> low-power-battery, balanced-ac, balanced-battery, performance-ac and
> performance-battery.
> 
<snip>
> Also even if no UI changes are deemed necessary this will still
> require
> userspace changes to save+restore the two separate "last selected"
> profile settings over reboots.
> 
> Please let me know what you think of this, and of course another
> completely different approach is welcome too.

From the power-profiles-daemon, and the GNOME UI side, we're unlikely
to expose those separate profiles as that's not how we envisioned the
profiles being used (there's an API to force a power-saving, or
performance profile temporarily, and the desktop implements power-
saving policies based upon that).

We have priors when it comes to specific profiles behaving slightly
differently depending on external factors, for example the performance
profile on some Intel Lenovo laptops being throttled down when a lap is
detected, or our attempt at using the "balance_power" intel pstate
preference when on battery (later reverted because this preference is
incredibly aggressive...).

I think that keeping the external API would be best for user-space,
we'd just want to have a way to know how it's behaving internally, eg.
exposing that it has separate profiles for AC and battery, and whether
an AC or battery variant is selected at this time.

Cheers

