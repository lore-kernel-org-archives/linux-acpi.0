From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 12 Oct 2016 13:25:32 +0200
Message-ID: <CAJZ5v0hzZuRCrhKYAjq55adVHS-Pg-ZvaduQa6=Uw6WG+yKfDw@mail.gmail.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon> <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon> <20161005153229.GO1765@lahna.fi.intel.com>
 <20161011123532.GC24347@remoulade> <20161012090003.GR2774@lahna.fi.intel.com>
 <20161012102836.wng5g4lb5ouvc3lc@sirena.org.uk> <20161012111230.GX2774@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35610 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753670AbcJLLZe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Oct 2016 07:25:34 -0400
Received: by mail-qk0-f172.google.com with SMTP id z190so25076305qkc.2
        for <linux-acpi@vger.kernel.org>; Wed, 12 Oct 2016 04:25:34 -0700 (PDT)
In-Reply-To: <20161012111230.GX2774@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Wed, Oct 12, 2016 at 1:12 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Wed, Oct 12, 2016 at 12:28:36PM +0200, Mark Brown wrote:
>> On Wed, Oct 12, 2016 at 12:00:03PM +0300, Mika Westerberg wrote:
>>
>> > The _DEP method should be used for Operation Region dependencies but
>> > here it is used for functional dependencies so that the audio machine
>> > driver can find the corresponding codec. Why Microsoft used it like this
>> > and not pushed it to ASWG to be added to the ACPI spec? Should we now
>> > refuse to support it in Linux on the basis that it has not been
>> > discussed with ASWG and it abuses _DEP?
>>
>> The fact that the ACPI community hasn't been doing a good job of working
>> together is essentially the issue that people are pushing back on here.
>> We appear to not even be trying to set a better standard for how to do
>> things here.
>
> Why using _DSD and the existing, well tested, DT properties (remote
> endpoints) is not even considered making a better standard?
>
>> Sitting externally to the group at Intel doing this it really looks like
>> there's been a decision to mirror DT into ACPI en masse.
>
> There has been no such decision as far as I can tell.

And this is the whole point really.

I'm not aware of any decision of this kind either and (as we have
pointed out for several times already) there are technical obstacles
to doing that even if someone wanted to do that.  But again, nobody
wants AFAICS.

Moreover, I don't really like the direction it is going into.  We
should be collaborating instead of accusing our respective employers
of doing nasty things in this forum.

Let's focus on the technical side then or the discussion is over.

Thanks,
Rafael
