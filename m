From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Dell XPS13 9360 - 1,000ms acpi_pm_finish()
Date: Wed, 29 Nov 2017 15:34:38 +0100
Message-ID: <CAJZ5v0iii=ZSnz8NwiA_TN0Uk0=dUcw2CH_0VO+_UsipO3i+3w@mail.gmail.com>
References: <CAJvTdK=gJk3N+75G97QpXiTnw9FDJPQiuR66sGgyc6e_zcesHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f173.google.com ([74.125.82.173]:42959 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752772AbdK2Oej (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Nov 2017 09:34:39 -0500
Received: by mail-ot0-f173.google.com with SMTP id i1so3156686oth.9
        for <linux-acpi@vger.kernel.org>; Wed, 29 Nov 2017 06:34:39 -0800 (PST)
In-Reply-To: <CAJvTdK=gJk3N+75G97QpXiTnw9FDJPQiuR66sGgyc6e_zcesHQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>

On Wed, Nov 29, 2017 at 7:06 AM, Len Brown <lenb@kernel.org> wrote:
> Rafael,
>
> Per our discussion...
>
> As of Linux-4.14, acpi_pm_finish() takes over 1,000 ms on the Dell
> XPS13.  This routine accounts for 50% of the total resume time of this
> machine.
>
> So I commented _WAK out of acpi_hw_legacy_wake(), and  that 1000ms
> became 2ms.  (and the system also seemed to resume fine without _WAK,
> though I didn't test it extensively)
>
> So I effectively pre-pended acpi_pm_finish() to acpi_pm_end() with the
> hack patch below, and that seems to work fine.
>
> (Note that it seems that the relative ordering of enabling run-time
> GPEs and invoking _WAK is already correct in acpi_hw_legacy_wake() --
> the GPEs are enabled first.)

The ordering is correct, but the GPEs should be enabled before the SCI
is enabled by resume_device_irqs().  Arguably, they may just be
enabled as soon as the kernel gets control back as the SCI won't
trigger anyway before resume_device_irqs().

> So the question becomes...  How early does _WAK really need to be?

On this system, apparently, it may go late in the resume path.  There
are systems on which moving it after the PCI resume introduced issues,
which is why the default ordering is what it is IIRC (but that was
bundled with the GPE stuff then, so there could be effects of that
too).

In any case, we may play with the ordering, but that's fragile.  Or we
can enable the EC polling just for the time of executing _WAK (which
should avoid the thermal issues on Lenovo and similar).

Thanks,
Rafael
