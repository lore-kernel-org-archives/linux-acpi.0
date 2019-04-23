From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
Date: Tue, 23 Apr 2019 10:07:40 +0200
Message-ID: <CAJZ5v0j9U20cFbRx6QKeQv6wyDg6nL71L0U_Rec5+W1JoD8-=w@mail.gmail.com>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com> <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
 <feb1808d-542c-83c2-5c70-9228473bb8d0@redhat.com> <0a770539-dfe9-2eb6-a90a-82f065a23a3f@uwyo.edu>
 <f6db39bc-b8d1-fda8-ad37-a8b050ef0027@redhat.com> <37aee883-1253-adad-82b4-4a578cc72825@uwyo.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <37aee883-1253-adad-82b4-4a578cc72825@uwyo.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: "Robert R. Howell" <RHowell@uwyo.edu>
Cc: Hans de Goede <hdegoede@redhat.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Apr 20, 2019 at 12:44 AM Robert R. Howell <RHowell@uwyo.edu> wrote:
>
> On 4/18/19 5:42 AM, Hans de Goede wrote:
>
> >> On 4/8/19 2:16 AM, Hans de Goede wrote:>
> >>>
> >>> Hmm, interesting so you have hibernation working on a T100TA
> >>> (with 5.0 + 02e45646d53b reverted), right ?
> >>>
>
> > Still since my patch is regressing things for you I will try to
> > take a look at this and see if I can reproduce and come up with
> > a fix. But this is not going to be a high priority thing for me to
> > work on.
> >
> > In the mean time I've gone ahead and submitted my version of the
> > fix for the problem Kai-Heng was seeing, since that does not seem
> > to make your problem worse; and it will be good to get that problem
> > fixed.
> >
> > Regards,
> >
> > Hans
> >
>
> I've managed to find a way around the i2c_designware timeout issues
> on the T100TA's.  The key is to NOT set DPM_FLAG_SMART_SUSPEND,
> which was added in the 02e45646d53b commit.
>
> To test that I've started with a 5.1-rc5 kernel, applied your recent patch
> to acpi_lpss.c, then apply the following patch of mine, removing
> DPM_FLAG_SMART_SUSPEND.  (For the T100 hardware I need to apply some
> other patches as well but those are not related to the i2c-designware or
> acpi issues addressed here.)
>
> On a resume from hibernation I still see one error:
>   "i2c_designware 80860F41:00: Error i2c_dw_xfer called while suspended"
> but I no longer get the i2c_designware timeouts, and audio does now work
> after the resume.
>
> Removing DPM_FLAG_SMART_SUSPEND may not be what you want for other
> hardware, but perhaps this will give you a clue as to what is going
> wrong with hibernate/resume on the T100TA's.

What if you drop DPM_FLAG_LEAVE_SUSPENDED alone instead?
