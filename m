From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] Thermal: Fix synchronization issues in thermal_sys.c
Date: Thu, 27 Sep 2012 08:25:11 +0200
Message-ID: <CA+icZUWUtbbLwutsKaKL3WAD2hdSido6FfW5PQcezVzYzQdrTQ@mail.gmail.com>
References: <1348726083-8540-1-git-send-email-durgadoss.r@intel.com>
	<1348726484.10877.278.camel@rui.sh.intel.com>
	<4D68720C2E767A4AA6A8796D42C8EB591D3D4E@BGSMSX101.gar.corp.intel.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38429 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab2I0GZM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Sep 2012 02:25:12 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591D3D4E@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "hughd@google.com" <hughd@google.com>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>

On Thu, Sep 27, 2012 at 8:21 AM, R, Durgadoss <durgadoss.r@intel.com> w=
rote:
> Hi Rui,
>
>> -----Original Message-----
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> owner@vger.kernel.org] On Behalf Of Zhang Rui
>> Sent: Thursday, September 27, 2012 11:45 AM
>> To: R, Durgadoss
>> Cc: lenb@kernel.org; linux-acpi@vger.kernel.org;
>> dan.carpenter@oracle.com; hughd@google.com; linux-
>> next@vger.kernel.org
>> Subject: Re: [PATCH] Thermal: Fix synchronization issues in thermal_=
sys.c
>>
>> On =E5=9B=9B, 2012-09-27 at 11:38 +0530, Durgadoss R wrote:
>> > This patch fixes the following mutex and NULL pointer
>> > problems in thermal_sys.c:
>> >  * mutex_unlock fix in update_temperature function
>> >  * mutex_unlock/NULL check fix in bind_cdev function
>> >  * NULL check fix in bind_tz function
>> >
>> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
>> > ---
>> >  drivers/thermal/thermal_sys.c |    9 +++++----
>> >  1 file changed, 5 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/therm=
al_sys.c
>> > index 4f77d89..848553d 100644
>> > --- a/drivers/thermal/thermal_sys.c
>> > +++ b/drivers/thermal/thermal_sys.c
>> > @@ -252,8 +252,8 @@ static void bind_cdev(struct thermal_cooling_d=
evice
>> *cdev)
>> >             }
>> >
>> >             tzp =3D pos->tzp;
>> > -           if (!tzp->tbp)
>> > -                   return;
>> > +           if (!tzp || !tzp->tbp)
>> > +                   continue;
>> >
>> >             for (i =3D 0; i < tzp->num_tbps; i++) {
>> >                     if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
>> > @@ -289,7 +289,7 @@ static void bind_tz(struct thermal_zone_device=
 *tz)
>> >             goto exit;
>> >     }
>> >
>> > -   if (!tzp->tbp)
>> > +   if (!tzp || !tzp->tbp)
>> >             goto exit;
>> >
>> actually, this is not a problem.
>> I checked the code just now, tzp can not be NULL if the code runs he=
re.
>
> I agree, I saw a similar kind of change needed in bind_tz, and hence
> added it here. Should we carry it as such ? or you want me to refresh=
 by
> changing it ?
>
> Thanks for looking into this quickly.
>

Looks like you will sent a v2 of this patch.
=46eel free to add a...

        Reported-by: Sedat Dilek <sedat.dilek@gmail.com>

,,, and don't forget Hugh :-).

- Sedat -

> Thanks,
> Durga
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
