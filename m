From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Tue, 25 Apr 2017 01:01:55 +0200
Message-ID: <CAJZ5v0jaGnoCjiU6VuHLyy9Kug8nHzxPxP8tuy3kphtfgmW38w@mail.gmail.com>
References: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0gtLajqCsw0HTS=sL_=cU1aSFzUk6e_kAPAfreuCpak7g@mail.gmail.com> <bf1ce91f-b232-4dce-5ed7-597b0ef46f92@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34133 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S977064AbdDXXB4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2017 19:01:56 -0400
In-Reply-To: <bf1ce91f-b232-4dce-5ed7-597b0ef46f92@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Apr 22, 2017 at 12:48 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 4/21/2017 6:43 PM, Rafael J. Wysocki wrote:
>>> +late_initcall(ged_init);
>> Does this fix the problem?
>>
>> What about if the module in question is loaded after running late_initcalls?
>
> This fixed the issue for me where I had dependencies for QUP I2C driver and GHES
> drivers. Both of them are modules and get probed via normal module execution path.
>
> However, I'm open to improvements.  Do you have a better suggestion? I can try
> to add some _DEP stuff if it is present, but I remember Linux doesn't like _DEP
> stuff too much.

My point is that nothing guarantees a specific ordering or timing of
module loading in general, so moving stuff to different initcall
levels does not really help 100% of the time.

Thanks,
Rafael
