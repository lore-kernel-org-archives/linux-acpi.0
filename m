From: Chris Chiu <chiu@endlessm.com>
Subject: Re: [Intel-gfx] GemniLake laptops goes power off directly after
 performing suspend
Date: Wed, 13 Dec 2017 16:57:58 +0800
Message-ID: <CAB4CAweNQuvPy8UHn8DGo2z6ArM1-3LKDQof0K-cH1kV49C_Fg@mail.gmail.com>
References: <CAB4CAwc3q+L9UyHL8W541HXOCUTG0tTx51TfZRyzn61qbyOeEA@mail.gmail.com>
 <CAJZ5v0jS=E0mcm=R2xQSftSnzZXUbzL3RjjWafSYAB=Wd7=ECQ@mail.gmail.com>
 <CAB4CAwe-uahS0HECtqcQ4Mobwb6vD-pxb-v8vPY52t6z+sT5pg@mail.gmail.com>
 <18455542.KZ7HXfzeW6@aspire.rjw.lan> <CAB4CAwdia7RYVVthWAwz-nvpEbiSH+_MFc_zQeu_V7o-uWn8xA@mail.gmail.com>
 <CAJZ5v0hrpFAffNq8SmTCeHsT0P1ULq7-D1+wA3NoqO5uEWtTaQ@mail.gmail.com>
 <CAB4CAwd0AGnVrWrxjLiMG_9CV610x6n6cgVXQ8UX6ou-i1JFbA@mail.gmail.com>
 <CAD8Lp44KjAO_Uwb0ZPgBeL=tsbgvPoTw+vXpsqD8DFojv5f5mw@mail.gmail.com> <20171212133201.tp6g3plnzxrbdkb6@ideak-desk.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:42923 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbdLMI6A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Dec 2017 03:58:00 -0500
Received: by mail-wm0-f68.google.com with SMTP id b199so3458355wme.1
        for <linux-acpi@vger.kernel.org>; Wed, 13 Dec 2017 00:57:59 -0800 (PST)
In-Reply-To: <20171212133201.tp6g3plnzxrbdkb6@ideak-desk.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: imre.deak@intel.com
Cc: Daniel Drake <drake@endlessm.com>, intel-gfx@lists.freedesktop.org, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, Len Brown <lenb@kernel.org>

On Tue, Dec 12, 2017 at 9:32 PM, Imre Deak <imre.deak@intel.com> wrote:
> On Fri, Dec 08, 2017 at 10:31:30AM +0000, Daniel Drake wrote:
>> Hi,
>>
>> Adding intel-gfx list in case i915 developers can help. Updated summary below.
>>
>> On Thu, Dec 7, 2017 at 2:14 AM, Chris Chiu <chiu@endlessm.com> wrote:
>> > On Wed, Dec 6, 2017 at 9:34 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> > > On Wed, Dec 6, 2017 at 10:33 AM, Chris Chiu <chiu@endlessm.com> wrote:
>> > >> On Wed, Dec 6, 2017 at 5:56 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > >>> On Tuesday, December 5, 2017 5:19:03 PM CET Chris Chiu wrote:
>> > >>>> On Tue, Dec 5, 2017 at 11:01 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> > >>>> > On Tue, Dec 5, 2017 at 11:32 AM, Chris Chiu <chiu@endlessm.com> wrote:
>> > >>>> >>     I have 2 GemniLake laptops from ASUS, named X441MB and X507MA,
>> > >>>> >> both go power off after I do "systemctl suspend" on top of kerne head
>> > >>>> >> fd6d2e506ce6 (Merge tag 'docs-4.15-fixes' of git://git.lwn.net/linux).
>> > >>>> >> I then wipe it out and install Windows RS3 instead, also goes to power
>> > >>>> >> off after pressing media key for suspend(S3). Then I installed intel
>> > >>>> >> graphic driver with the following version number, Windows has no
>> > >>>> >> problem on suspend resume then.
>> > >>>> >
>> > >>>> > There is a suspend-related fix missing in 4.15-rc at this point, so
>> > >>>> > please test 4.14.y or wait for the fix to be merged.
>> > >>>>
>> > >>>> You mean the suspend-related fix used to exist in 4.14? Could you point me
>> > >>>> out which commit it is? Thanks
>> > >>>
>> > >>> I mean that suspend generally works in 4.14 and is currently broken
>> > >>> in 4.15-rc which requires a fix to be applied.  The fix in question is at:
>> > >>> https://lkml.org/lkml/2017/11/30/546
>> > >>> This is needed due to some changes made in 4.15-rc (with respect to 4.14)
>> > >>> that broke resume from suspend to RAM.
>> > >>
>> > >> I think maybe for GemniLake is a different issue. I tried Ubuntu-4.14.0-11.13
>> > >> kernel and 4.13 kernel. Both go power off immediately.
>> > >
>> > > OK, so yes, this is a different issue.
>> > > Is that suspend-to-idle or suspend-to-RAM (ACPI S3)?
>> >
>> > It's ACPI S3, suspend-to RAM. Due to it power off immediately,
>> > difficult for me to collect useful information
>>
>> Multiple new Acer and Asus consumer products based on Intel GeminiLake
>> N4100/N5000 fail to go into S3 suspend-to-RAM. At the point when you
>> would normally expect the system to go into sleep, the computer
>> completely powers off.
>>
>> The same happens under Windows 10 RS3, until the following Intel
>> graphics driver is installed:
>>
>>     Package: 530967
>>     Intel(R) Graphics Driver: 23.20.16.4849
>>     Intel(R) Display Audio Driver: 10.00.00.1
>>
>> After installing this driver, Windows can now go into S3 suspend and
>> also be resumed. I'm wondering if someone can check with the Windows
>> gfx driver developers what this driver does to affect S3 suspend, so
>> that we can fix up Linux behaviour.
>
> To check this from the GFX side, could you open a bug at [1]? Please try
> suspend/resume without the graphics driver loaded (booting with
> nomodeset) and if that works suspend/resume with first setting one of
> the test phases in /sys/power/state. Trying the drm-tip branch from [2]
> would be also helpful. Please provide the dmesg logs at each run when
> GFX is enabled, booting with drm.debug=0xe. Using netconsole or
> pstore could help gathering the log when the machine just powers off.
>
> Thanks,
> Imre
>
> [1] https://bugs.freedesktop.org/enter_bug.cgi?product=DRI
> [2] git://anongit.freedesktop.org/drm-tip
>
>
>>
>> Thanks
>> Daniel
>> _______________________________________________
>> Intel-gfx mailing list
>> Intel-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

Hi Imre,
    Thanks for your feedback. I've opened a bug on
https://bugs.freedesktop.org/show_bug.cgi?id=104235 and attach a dmesg
log which shows the Linux does go into sleep while booting with
"nomodeset". I will try drm-tip then and update the ticket if anything
interesting

Chris.
