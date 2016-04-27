From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: fix Thunderbolt hotplug
Date: Wed, 27 Apr 2016 14:33:48 +0200
Message-ID: <CAJZ5v0hdnQDZt2ur5R0xVH-985+pj5yQSxRBS+LgJZ_Ykk9Uww@mail.gmail.com>
References: <1461760019-12930-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1461760019-12930-1-git-send-email-prarit@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mario_Limonciello@dell.com, Stable <stable@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 27, 2016 at 2:26 PM, Prarit Bhargava <prarit@redhat.com> wrote:
> Rafael, this patch is in the acpica.git tree as 7a3bd2d ("Dispatcher: Update
> thread ID for recursive method calls").  I've had many positive testing
> results from hardware vendors and users with this patch and this resolves
> many of the problems seen here:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=115121
>
> This does not fix the problems with the TB docking station.  Although this
> patch will also be required, the docking station issues require a FW update.
> Updated FW should be coming soon to resolve those problems.

Lv is going to send me patches for the current ACPICA release shortly.

I'll pick up this one from that series.  Hopefully, that's not a problem.

Thanks,
Rafael
