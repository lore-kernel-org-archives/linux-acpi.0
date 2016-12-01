From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 02/11] ACPICA: Back port of "ACPICA: Dispatcher: Tune
 interpreter lock around AcpiEvInitializeRegion()"
Date: Thu, 1 Dec 2016 14:29:39 +0100
Message-ID: <CAJZ5v0hB2UTqOzLC0RU0rbPkE84=8ytsL3gaBEE3nTRcd1Xz9w@mail.gmail.com>
References: <cover.1480490191.git.lv.zheng@intel.com> <26416a54d74f43b07e27cf6f79d6b8f2976f84bb.1480490191.git.lv.zheng@intel.com>
 <CAJZ5v0gvXuvKSkgMqUYw+7OhqohA1rXx-tM2DfvtC-CG7BT0gA@mail.gmail.com> <1AE640813FDE7649BE1B193DEA596E886A297686@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32874 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755703AbcLAN3m (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Dec 2016 08:29:42 -0500
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A297686@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Thu, Dec 1, 2016 at 8:50 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi, Rafael
>
>> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of Rafael J. Wysocki
>> Subject: Re: [PATCH 02/11] ACPICA: Back port of "ACPICA: Dispatcher: Tune interpreter lock around
>> AcpiEvInitializeRegion()"
>>
>> On Wed, Nov 30, 2016 at 8:20 AM, Lv Zheng <lv.zheng@intel.com> wrote:
>> > ACPICA commit bc481e758e54f7644fd0b657119ca7763d8b6a9c
>> >
>> > This is a back port result of the following commit:
>> >   Commit: 8633db6b027952449e155a316f4ae3a530bbe18f
>> >   Subject: ACPICA: Dispatcher: Fix interpreter locking around acpi_ev_initialize_region()
>> >
>> > Link: https://github.com/acpica/acpica/commit/bc481e75
>> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
>> > Signed-off-by: Bob Moore <robert.moore@intel.com>
>> > ---
>> >  drivers/acpi/acpica/dsinit.c |    4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
>> > index 54d48b9..5de3f10 100644
>> > --- a/drivers/acpi/acpica/dsinit.c
>> > +++ b/drivers/acpi/acpica/dsinit.c
>> > @@ -221,8 +221,8 @@
>> >          */
>> >         status =
>> >             acpi_ns_walk_namespace(ACPI_TYPE_ANY, start_node, ACPI_UINT32_MAX,
>> > -                                  0, acpi_ds_init_one_object, NULL, &info,
>> > -                                  NULL);
>> > +                                  ACPI_NS_WALK_NO_UNLOCK,
>> > +                                  acpi_ds_init_one_object, NULL, &info, NULL);
>> >         if (ACPI_FAILURE(status)) {
>> >                 ACPI_EXCEPTION((AE_INFO, status, "During WalkNamespace"));
>> >         }
>> > --
>>
>> This isn't necessary IMO, the current code linux-next code looks like
>> the change has been made in there already AFAICS (please double check,
>> though).
>
> The fix was in Linux, however, when it is back ported to ACPICA, Bob asked me to do this change.
> Using ACPI_NS_WALK_NO_UNLOCK instead of meaningless 0.
> So during this release cycle, this change is detected out as the only difference of the back ported commit.
>
>>
>> I'm skipping this patch.
>
> If this is skipped, it leaves us 14 lines divergences.
> Hope we can have this kind of divergences eliminated.

OK, my bad.

I forgot to merge back the revert I made before into the acpica branch.

Sorry for the noise, everything applies now.

Thanks,
Rafael
