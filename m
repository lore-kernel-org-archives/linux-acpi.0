From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/2] acpi/button: revert v4.10 behavior
Date: Thu, 11 May 2017 11:33:50 +0200
Message-ID: <20170511093350.GE30987@mail.corp.redhat.com>
References: <20170510161240.13229-1-benjamin.tissoires@redhat.com>
 <CAJZ5v0jX82ueSVEHzMZngnJUf=yYJ+TN2efQ0BgwxcQd=bb0_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753492AbdEKJd5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 11 May 2017 05:33:57 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jX82ueSVEHzMZngnJUf=yYJ+TN2efQ0BgwxcQd=bb0_g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>, Jiri Eischmann <jeischma@redhat.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Rafael,

On May 11 2017 or thereabouts, Rafael J. Wysocki wrote:
> On Wed, May 10, 2017 at 6:12 PM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > The new default 'open' behavior for acpi_lid_initialize_state() is just
> > wrong. It breaks professional laptops with a docking station [1].
> >
> > Booting the laptop with the LID closed is something common and now there
> > is no way of knowing the actual state of the LID switch at boot. Please
> > use a user-space solution as described in 2/2 if you really don't want to
> > add quirks in the kernel.
> >
> > Cheers,
> > Benjamin
> >
> > [1] https://bugzilla.gnome.org/show_bug.cgi?id=782380
> >
> > Benjamin Tissoires (2):
> >   Revert "ACPI / button: Remove lid_init_state=method mode"
> >   Revert "ACPI / button: Change default behavior to lid_init_state=open"
> >
> >  Documentation/acpi/acpi-lid.txt | 16 ++++++++++++----
> >  drivers/acpi/button.c           | 11 ++++++++++-
> >  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> Well, have you seen the recent series
> (http://marc.info/?l=linux-acpi&m=149431335204701&w=2 and the
> following) from Lv?
> 

Yeah, sorry I saw it right after sending mine.

> He evidently agrees with you that "ACPI / button: Remove
> lid_init_state=method mode" should be reverted, but then there are
> differences.

I still believe the second patch should be reverted (I'll try to
convince Lv in the other replies).

> 
> Can you please have a look at that and let me know what's wrong with
> it in your view?  I'd like to have a full picture if poss.

Sure.

A "short" summary could be the following (I'll go in deeper details in
the other replies I'll send):
- it's true that some devices are broken in term of LID switch, but we
  never managed to get an accurate estimate of how many devices are
  affected. Last time we spoke only 3 devices were affected, 1 being 4
  years old or more, one other having a in-kernel solution already.
- the change in the default setting breaks many more devices (all the
  thinkpads from Lenovo, most professional Dell laptops too), and the
  distributions solution would be to set the default setting back to
  "method", so we are back to square one
- changing the default setting to "open" prevents user space to fix the
  kernel by adding heuristics
- the only viable solution is to have a list of problematic devices that
  don't report the correct LID switch state at boot (and later). Whether
  this list is in the kernel or in user-space, I don't care, but the
  current v4.11 code (and probably the second series Lv sent) prevents a
  user-space database to be set.

Cheers,
Benjamin

> 
> Thanks,
> Rafael
