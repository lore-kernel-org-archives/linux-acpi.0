From: Anisse Astier <anisse@astier.eu>
Subject: Re: [stable] [PATCH] ACPI: Add Toshiba Satellite C650D to DMI
	blacklist for corrupting DSDT
Date: Wed, 11 Aug 2010 20:13:29 +0000
Message-ID: <AANLkTi=oNhXEEAWNbKCMh8a8nj87Q4T-f+MD26w4oqYG@mail.gmail.com>
References: <1281112818-19388-1-git-send-email-anisse@astier.eu>
	<20100806190618.78d061bd@destiny.ordissimo> <20100811195041.GE23566@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62528 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758616Ab0HKUNt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Aug 2010 16:13:49 -0400
Received: by pzk26 with SMTP id 26so185091pzk.19
        for <linux-acpi@vger.kernel.org>; Wed, 11 Aug 2010 13:13:49 -0700 (PDT)
In-Reply-To: <20100811195041.GE23566@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-acpi@vger.kernel.org, stable@kernel.org, Lin Ming <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>

AFAICT, it's not upstream yet.
Len and Lin didn't have the time to review the patch for now.

Regards,

Anisse

On Wed, Aug 11, 2010 at 7:50 PM, Greg KH <greg@kroah.com> wrote:
> On Fri, Aug 06, 2010 at 07:06:18PM +0200, Anisse Astier wrote:
>> On Fri, =A06 Aug 2010 18:40:18 +0200, Anisse Astier <anisse@astier.e=
u>
>> wrote :
>>
>> > This machine has a BIOS that corrupts the DSDT, and adding
>> > acpi=3Dcopy_dsdt on cmdline fixes it. This feature and the corresp=
onding
>> > blacklist was added in commit aa2110cb1a7510f9b834adfb39b05d4843a3=
5d35
>> >
>> > Cc: Len Brown <lenb@kernel.org>
>> > Cc: Lin Ming <ming.m.lin@intel.com>
>> > ---
>> > =A0drivers/acpi/bus.c | =A0 =A08 ++++++++
>> > =A01 files changed, 8 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> > index c1d23cd..fe7d7b9 100644
>> > --- a/drivers/acpi/bus.c
>> > +++ b/drivers/acpi/bus.c
>> > @@ -99,6 +99,14 @@ static struct dmi_system_id dsdt_dmi_table[] __=
initdata =3D {
>> > =A0 =A0 =A0 =A0 =A0 =A0 DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L50=
5D"),
>> > =A0 =A0 =A0 =A0 =A0 =A0 },
>> > =A0 =A0 },
>> > + =A0 {
>> > + =A0 =A0.callback =3D set_copy_dsdt,
>> > + =A0 =A0.ident =3D "TOSHIBA Satellite C650D",
>> > + =A0 =A0.matches =3D {
>> > + =A0 =A0 =A0 =A0 =A0 DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
>> > + =A0 =A0 =A0 =A0 =A0 DMI_MATCH(DMI_PRODUCT_NAME, "Satellite C650D=
"),
>> > + =A0 =A0 =A0 =A0 =A0 },
>> > + =A0 },
>> > =A0 =A0 {}
>> > =A0};
>> > =A0#else
>>
>> Other users experiencing problems as reference:
>> https://bugs.launchpad.net/ubuntu/+bug/612341
>>
>> Also, I'm cc-ing stable as it might interest Greg for 35.1 (not earl=
ier
>> versions since the feature was added by Lin Ming in .35).
>
> What is the git commit id of this patch in Linus's tree?
>
> thanks,
>
> greg k-h
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
