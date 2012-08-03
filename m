From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH/RFC] drm/radeon: ACPI: veto the keypress on ATIF events
Date: Thu, 2 Aug 2012 21:45:01 -0400
Message-ID: <CADnq5_OMyoc8LjZ15E_wxGFLJVoEHYyKA1iovneVy4WCt8Y7kw@mail.gmail.com>
References: <20120729130644.GA12378@growl>
	<CADnq5_OdKXsiVnFbkBNB2ue4df6tGaZ7bVMP+TvetFcy0faKog@mail.gmail.com>
	<20120730202449.GA5600@growl>
	<CADnq5_NP9Rw8DhmS+Q5G1PaUqcHQtVA6KoCGH5MME6DEd-Lw7Q@mail.gmail.com>
	<CAKPcRGpL6JBx5MnWk6fFVOYCPQGeeDC-ytOwA+J+gEEZS+4SuA@mail.gmail.com>
	<CADnq5_NN8OcmyKDemO=Mv0as-02sYEHxxbn2G4XtSmpzEsnR0w@mail.gmail.com>
	<20120731200520.GA5425@growl>
	<CADnq5_Meh0nW90PZ=kAJdK=WjZKTdr7+5vN=vza+PzyJnEWKAA@mail.gmail.com>
	<20120801134900.GA7909@growl>
	<1343868330.1682.502.camel@rui.sh.intel.com>
	<20120802134612.GA30802@growl>
	<1343958035.1682.558.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34623 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab2HCBpD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Aug 2012 21:45:03 -0400
Received: by weyx8 with SMTP id x8so100413wey.19
        for <linux-acpi@vger.kernel.org>; Thu, 02 Aug 2012 18:45:01 -0700 (PDT)
In-Reply-To: <1343958035.1682.558.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, airlied@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, joeyli <jlee@suse.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Thu, Aug 2, 2012 at 9:40 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> On =E5=9B=9B, 2012-08-02 at 15:46 +0200, Luca Tettamanti wrote:
>> On Thu, Aug 02, 2012 at 08:45:30AM +0800, Zhang Rui wrote:
>> > On =E4=B8=89, 2012-08-01 at 15:49 +0200, Luca Tettamanti wrote:
>> > > AMD ACPI interface may overload the standard event
>> > > ACPI_VIDEO_NOTIFY_PROBE (0x81) to signal AMD-specific events. In=
 such
>> > > cases we don't want to send the keypress (KEY_SWITCHVIDEOMODE) t=
o the
>> > > userspace because the user did not press the mode switch key (th=
e
>> > > spurious keypress confuses the DE which usually changes the
>> > > display configuration and messes up a dual-screen setup).
>> > > This patch gives the radeon driver the chance to examine the eve=
nt and
>> > > block the keypress if the event is an "AMD event".
>> > >
>> > > Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
>> > > ---
>> > > Any comment from ACPI front?
>> > >
>> > it looks good to me.
>> > But I'm wondering if we can use the following code for ACPI part, =
which
>> > looks cleaner.
>> > I know this may change the behavior of other events, but in theory=
, we
>> > should not send any input event if we know something wrong in kern=
el.
>> >
>> > what do you think?
>>
>> I like it, it's cleaner.
>> I've split the patch in two pieces (one for video, the other for
>> radeon) and adopted your suggestion.
>>
> Great.
> Acked-by: Zhang Rui <rui.zhang@intel.com>
>
> hmm, who should take these two patches?

I'm happy to take the patches.

> and which tree the second patch is based on?

I've got a tree with all the radeon ACPI patches on the acpi_patches
branches of my git tree:
git://people.freedesktop.org/~agd5f/linux

Alex

>
> thanks,
> rui
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
