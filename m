From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] efi: Work around bogus pointers in BGRT
Date: Fri, 24 May 2013 18:15:16 -0700
Message-ID: <CALCETrVz0W--YybyLatG1MW=pkdGa2PdR0d2hrfXUSXT0=K4fw@mail.gmail.com>
References: <CALCETrX2yUzVLTAabrdDM1zgZnRL+KWEJoqSu2VM5jMaArAjpg@mail.gmail.com>
 <7ccd9d84f7407ba65c1f03d144e2113dee0d797a.1368824585.git.luto@amacapital.net> <20130524053737.GB6380@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:38123 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab3EYBPh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 May 2013 21:15:37 -0400
Received: by mail-lb0-f175.google.com with SMTP id v10so5220563lbd.20
        for <linux-acpi@vger.kernel.org>; Fri, 24 May 2013 18:15:36 -0700 (PDT)
In-Reply-To: <20130524053737.GB6380@leaf>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Thu, May 23, 2013 at 10:37 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> On Fri, May 17, 2013 at 02:05:33PM -0700, Andy Lutomirski wrote:
>> The MSI MS-7760 supplies a BGRT marked "invalid" that contains a
>> pointer to nowhere.  Since an "invalid" BGRT isn't particularly
>> useful (userspace isn't supposed to use it anyway), ignore the BGRT
>> if it's marked "invalid" and the pointer points outside of EFI boot
>> services space.
>>
>> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
>
> I'd suggest generalizing the comment to not just mention the one system
> you observed it on.  In any case, I'm fine with this patch, but I seem
> to recall Matthew Garrett having some objections to ignoring the BGRT
> when the valid bit is not set.  Also, if you're going to do so, you
> might as well not expose the valid bit to userspace.

Hmm.

Not exposing the valid bit to userspace would be a bit odd -- it's
part of a bitfield which (in principle, I think) could have other bits
defined.

One option would be to still load the bgrt table if invalid but to not
try to load the image and to therefore not show that sysfs attribute.
I don't know what this would break because I don't know what userspace
programs actually use bgrt.

--Andy
