From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: Regression: 18996f2db918 ("ACPICA: Events: Stop unconditionally
 clearing ACPI IRQs during suspend/resume" breaks resume from suspend
Date: Tue, 21 Aug 2018 16:34:21 +0200
Message-ID: <20180821163421.3208af59@kitsune.suse.cz>
References: <20180820182906.48f7743f@kitsune.suse.cz>
        <CAJZ5v0hMZ_bmCy7vQBfzu6RNVkCX0V9qRtqYVNmFOefc1TnGCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hMZ_bmCy7vQBfzu6RNVkCX0V9qRtqYVNmFOefc1TnGCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Schmauss, Erik" <erik.schmauss@intel.com>, Lv <lv.zheng@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, 21 Aug 2018 08:50:36 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Mon, Aug 20, 2018 at 6:29 PM Michal Suchánek <msuchanek@suse.de>
> wrote:
> >
> > Hello,
> >
> > after commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
> > clearing ACPI IRQs during suspend/resume") I am no longer able to
> > resume from suspend.
> >
> > Reported in bugzilla
> > https://bugzilla.kernel.org/show_bug.cgi?id=200841
> >
> > Reverting this on top of 4.18 fixes the issue. acpidump output is
> > attaches in the bugzilla.
> >
> > Is there anything else that can be done to diagnose the issue?  
> 
> Can you please test the patch at
> https://patchwork.kernel.org/patch/10563631/ to start with?
> 

Yes, that works for me.

Thanks

Michal
