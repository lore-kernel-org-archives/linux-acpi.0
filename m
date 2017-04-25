From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Tue, 25 Apr 2017 13:03:03 +0200
Message-ID: <CAJZ5v0iVOmkgU5tBZzocTgPjcAQzY8mFrzBiMJ_kmHvh3Lhgww@mail.gmail.com>
References: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0gtLajqCsw0HTS=sL_=cU1aSFzUk6e_kAPAfreuCpak7g@mail.gmail.com>
 <bf1ce91f-b232-4dce-5ed7-597b0ef46f92@codeaurora.org> <CAJZ5v0jaGnoCjiU6VuHLyy9Kug8nHzxPxP8tuy3kphtfgmW38w@mail.gmail.com>
 <0601c14c-ce5c-a181-0801-4a64a0a3c7be@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34078 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1172415AbdDYLDE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Apr 2017 07:03:04 -0400
In-Reply-To: <0601c14c-ce5c-a181-0801-4a64a0a3c7be@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Apr 25, 2017 at 3:43 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>
>> My point is that nothing guarantees a specific ordering or timing of
>> module loading in general, so moving stuff to different initcall
>> levels does not really help 100% of the time.
>>
>
> Are you talking about init vs. probe in general?

Yes.

Generally speaking, if the initialization of built-in code depends on
a loadable module to be present, it has to explicitly wait for that
module to advertise itself, this way or another, or it has to poll.

> Sorry, I'm trying to decode what you mean to see if there is some other behavior
> that I'm not aware of in ACPI.

Sorry for being unclear.

Thanks,
Rafael
