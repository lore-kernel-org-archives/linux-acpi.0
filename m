From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Tue, 25 Apr 2017 09:01:54 +0200
Message-ID: <20170425070154.GC9999@wunner.de>
References: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0gtLajqCsw0HTS=sL_=cU1aSFzUk6e_kAPAfreuCpak7g@mail.gmail.com>
 <bf1ce91f-b232-4dce-5ed7-597b0ef46f92@codeaurora.org>
 <CAJZ5v0jaGnoCjiU6VuHLyy9Kug8nHzxPxP8tuy3kphtfgmW38w@mail.gmail.com>
 <3f0f2853-d2e5-be32-2bde-47e72c51a0a6@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:55805 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1167833AbdDYHB4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Apr 2017 03:01:56 -0400
Content-Disposition: inline
In-Reply-To: <3f0f2853-d2e5-be32-2bde-47e72c51a0a6@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Apr 22, 2017 at 12:48 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 4/21/2017 6:43 PM, Rafael J. Wysocki wrote:
> > +late_initcall(ged_init);
> > Does this fix the problem?
> >
> > What about if the module in question is loaded after running
> > late_initcalls?
>
> This fixed the issue for me where I had dependencies for QUP I2C driver
> and GHES drivers. Both of them are modules and get probed via normal
> module execution path.
>
> However, I'm open to improvements.  Do you have a better suggestion?
> I can try to add some _DEP stuff if it is present, but I remember Linux
> doesn't like _DEP stuff too much.

Would it be possible to solve this by just returning -EPROBE_DEFER from the
->probe hook if the devices you depend on are not bound yet?

Alternatively, would it be possible to solve it with a struct device_link?

Thanks,

Lukas
