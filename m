From: Daniel Drake <drake@endlessm.com>
Subject: Re: GemniLake laptops goes power off directly after performing suspend
Date: Fri, 8 Dec 2017 10:31:30 +0000
Message-ID: <CAD8Lp44KjAO_Uwb0ZPgBeL=tsbgvPoTw+vXpsqD8DFojv5f5mw@mail.gmail.com>
References: <CAB4CAwc3q+L9UyHL8W541HXOCUTG0tTx51TfZRyzn61qbyOeEA@mail.gmail.com>
 <CAJZ5v0jS=E0mcm=R2xQSftSnzZXUbzL3RjjWafSYAB=Wd7=ECQ@mail.gmail.com>
 <CAB4CAwe-uahS0HECtqcQ4Mobwb6vD-pxb-v8vPY52t6z+sT5pg@mail.gmail.com>
 <18455542.KZ7HXfzeW6@aspire.rjw.lan> <CAB4CAwdia7RYVVthWAwz-nvpEbiSH+_MFc_zQeu_V7o-uWn8xA@mail.gmail.com>
 <CAJZ5v0hrpFAffNq8SmTCeHsT0P1ULq7-D1+wA3NoqO5uEWtTaQ@mail.gmail.com> <CAB4CAwd0AGnVrWrxjLiMG_9CV610x6n6cgVXQ8UX6ou-i1JFbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:43980 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753019AbdLHKbc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Dec 2017 05:31:32 -0500
Received: by mail-oi0-f46.google.com with SMTP id f69so6902212oig.10
        for <linux-acpi@vger.kernel.org>; Fri, 08 Dec 2017 02:31:31 -0800 (PST)
In-Reply-To: <CAB4CAwd0AGnVrWrxjLiMG_9CV610x6n6cgVXQ8UX6ou-i1JFbA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Chiu <chiu@endlessm.com>, intel-gfx@lists.freedesktop.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Linux Upstreaming Team <linux@endlessm.com>

Hi,

Adding intel-gfx list in case i915 developers can help. Updated summary below.

On Thu, Dec 7, 2017 at 2:14 AM, Chris Chiu <chiu@endlessm.com> wrote:
> On Wed, Dec 6, 2017 at 9:34 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Wed, Dec 6, 2017 at 10:33 AM, Chris Chiu <chiu@endlessm.com> wrote:
> >> On Wed, Dec 6, 2017 at 5:56 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>> On Tuesday, December 5, 2017 5:19:03 PM CET Chris Chiu wrote:
> >>>> On Tue, Dec 5, 2017 at 11:01 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>>> > On Tue, Dec 5, 2017 at 11:32 AM, Chris Chiu <chiu@endlessm.com> wrote:
> >>>> >>     I have 2 GemniLake laptops from ASUS, named X441MB and X507MA,
> >>>> >> both go power off after I do "systemctl suspend" on top of kerne head
> >>>> >> fd6d2e506ce6 (Merge tag 'docs-4.15-fixes' of git://git.lwn.net/linux).
> >>>> >> I then wipe it out and install Windows RS3 instead, also goes to power
> >>>> >> off after pressing media key for suspend(S3). Then I installed intel
> >>>> >> graphic driver with the following version number, Windows has no
> >>>> >> problem on suspend resume then.
> >>>> >
> >>>> > There is a suspend-related fix missing in 4.15-rc at this point, so
> >>>> > please test 4.14.y or wait for the fix to be merged.
> >>>>
> >>>> You mean the suspend-related fix used to exist in 4.14? Could you point me
> >>>> out which commit it is? Thanks
> >>>
> >>> I mean that suspend generally works in 4.14 and is currently broken
> >>> in 4.15-rc which requires a fix to be applied.  The fix in question is at:
> >>> https://lkml.org/lkml/2017/11/30/546
> >>> This is needed due to some changes made in 4.15-rc (with respect to 4.14)
> >>> that broke resume from suspend to RAM.
> >>
> >> I think maybe for GemniLake is a different issue. I tried Ubuntu-4.14.0-11.13
> >> kernel and 4.13 kernel. Both go power off immediately.
> >
> > OK, so yes, this is a different issue.
> > Is that suspend-to-idle or suspend-to-RAM (ACPI S3)?
>
> It's ACPI S3, suspend-to RAM. Due to it power off immediately,
> difficult for me to collect useful information

Multiple new Acer and Asus consumer products based on Intel GeminiLake
N4100/N5000 fail to go into S3 suspend-to-RAM. At the point when you
would normally expect the system to go into sleep, the computer
completely powers off.

The same happens under Windows 10 RS3, until the following Intel
graphics driver is installed:

    Package: 530967
    Intel(R) Graphics Driver: 23.20.16.4849
    Intel(R) Display Audio Driver: 10.00.00.1

After installing this driver, Windows can now go into S3 suspend and
also be resumed. I'm wondering if someone can check with the Windows
gfx driver developers what this driver does to affect S3 suspend, so
that we can fix up Linux behaviour.

Thanks
Daniel
