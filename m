From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 0/9] PM / Domains: Generic OF-based support
Date: Tue, 9 Sep 2014 14:45:52 +0200
Message-ID: <CAPDyKFr8OM3k0iJROvFOPN=UG=XfwJ7HBu1Yms8Yo=0C0fvW0A@mail.gmail.com>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
	<1410262570-22785-1-git-send-email-ulf.hansson@linaro.org>
	<20140909115446.GW2601@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:43203 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756564AbaIIMpx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2014 08:45:53 -0400
Received: by mail-qc0-f173.google.com with SMTP id w7so17131329qcr.18
        for <linux-acpi@vger.kernel.org>; Tue, 09 Sep 2014 05:45:52 -0700 (PDT)
In-Reply-To: <20140909115446.GW2601@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>

On 9 September 2014 13:54, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 09, 2014 at 01:36:01PM +0200, Ulf Hansson wrote:
>> Changes in v4:
>>       - Rebased patch "PM / Domains: Add generic OF-based PM domain look-up" -
>>         and updated the author and the commit message.
>>       - Adopted review comments for "PM / Domains: Add APIs to attach/detach
>>         a PM domain for a device".
>>       - Updated author and commit message for "ARM: exynos: Move to generic
>>         PM domain DT bindings".
>>       - Added some acks and reviewed by tags.
>>       - Started to use the "--in-reply-to" option to git-send-email. It should
>>         provide the option to show a better diffstat per patch.
>
> Please don't send serieses in reply to earlier versions, it buries
> things in the middle of old discussions which can mean they don't get
> noticed, especially when you're sending multiple large patch serieses at
> the same time.

Sorry, I just thought that it simplified life in this particular case. :-)

If additional versions needs to be posted I will follow your advise. Thanks!

Kind regards
Uffe
