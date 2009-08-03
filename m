From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH update] PM: Introduce core framework for run-time PM of
	I/O devices (rev. 11)
Date: Mon, 3 Aug 2009 12:26:14 +0900
Message-ID: <aec7e5c30908022026t2fa8f328s27424073c9ff560b@mail.gmail.com>
References: <200907221701.50449.rjw@sisk.pl> <200907222110.47701.rjw@sisk.pl>
	 <aec7e5c30907310732u35faa15fpab070025f596463e@mail.gmail.com>
	 <200907312053.17914.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:54785 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbZHCD0O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Aug 2009 23:26:14 -0400
In-Reply-To: <200907312053.17914.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

Hi again Rafael,

On Sat, Aug 1, 2009 at 3:53 AM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> On Friday 31 July 2009, Magnus Damm wrote:
>> [Runtime PM v11]

>> > @@ -202,7 +203,9 @@ int driver_probe_device(struct device_dr
>> > =A0 =A0 =A0 =A0pr_debug("bus: '%s': %s: matched device %s with dri=
ver %s\n",
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv->bus->name, __func__, dev_name=
(dev), drv->name);
>> >
>> > + =A0 =A0 =A0 pm_runtime_get_noresume(dev);
>> > =A0 =A0 =A0 =A0ret =3D really_probe(dev, drv);
>> > + =A0 =A0 =A0 pm_runtime_put_noidle(dev);
>> >
>> > =A0 =A0 =A0 =A0return ret;
>> > =A0}
>>
>> This creates problems when drivers want to performing runtime resume
>> from within probe(). For more details please have a look at "[PATCH
>> 04/04] video: Runtime PM hack for SuperH LCDC driver".
>
> Ah, I see. =A0You'd like to call pm_runtime_get_sync() from .probe(),=
 but that
> sees the usage counter different from zero and exits immediately.

Exactly.

> OTOH, I think we should prevent suspends from racing with .probe() at=
 the core
> level. =A0Hmm.

Doesn't it make more sense to allow runtime suspend and resume to
happen after the pm_runtime_enable() call? What case are you trying to
protect against?

> One possible approach could be to call pm_runtime_resume() from
> sh_mobile_lcdc_probe() instead of pm_runtime_put_noidle(). =A0Then, t=
he platform
> code will have a chance to turn the device on and the later pm_runtim=
e_get*()
> and pm_runtime_put*() calls will be balanced. =A0Of course, in that c=
ase the
> pm_runtime_get_noresume() in sh_mobile_lcdc_probe() won't be necessar=
y any
> more. =A0Am I overlooking anything?

So for drivers that want to access hardware from .probe(), calling
pm_runtime_resume() after pm_runtime_enable() in should be enough?

Thanks for your help!

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
