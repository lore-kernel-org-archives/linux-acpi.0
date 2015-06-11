From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 RESEND] mailbox: add ACPI support for mailbox framework
Date: Thu, 11 Jun 2015 02:18:48 +0200
Message-ID: <3651207.H4iW8oXRCh@vostro.rjw.lan>
References: <1428537507-30561-1-git-send-email-fkan@apm.com> <2931755.BICyILJPre@vostro.rjw.lan> <CABb+yY0NA44eHqxVK=B5Y57Rxa18L-542KHdnUz15Bgen39gxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABb+yY0NA44eHqxVK=B5Y57Rxa18L-542KHdnUz15Bgen39gxA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Feng Kan <fkan@apm.com>, patches <patches@apm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, April 29, 2015 08:22:37 AM Jassi Brar wrote:
> On Wed, Apr 22, 2015 at 7:34 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, April 21, 2015 04:53:14 PM Jassi Brar wrote:
> >> On Tue, Apr 21, 2015 at 6:28 AM, Feng Kan <fkan@apm.com> wrote:
> >> >
> >> > Just want to ping this. I haven't gotten any response from mailbox
> >> > maintainer for this
> >> > patch or any of my other mailbox patches.
> >> >
> >> Sorry I had been busy and still need to have a critical look at the
> >> new api. It would sooth my nerves to see an ACK from some acpi god.
> >
> > I'm far from one, but I'll be looking at this is detail next week if
> > that helps (this week I'm traveling).
> >
> No, you are one on my list :)   Your review from acpi perspective will
> be greatly helpful.

The code changes look reasonable to me, but it would be good to point to
the DT property definition this is supposed to follow in the changelog
(ie. where exactly this is defined for DT).

The "mboxes" _DSD property will need to be registered at some point in the
future too when the infrastructure for that is ready.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
