From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v6 1/2] ACPI: introduce a function to find the first
 physical device
Date: Wed, 20 Jan 2016 23:00:10 +0600
Message-ID: <569FBD1A.5050609@linaro.org>
References: <1453300171-25473-1-git-send-email-aleksey.makarov@linaro.org>
 <1453300171-25473-2-git-send-email-aleksey.makarov@linaro.org>
 <CAHp75VcdtU6izThE+Z2ODnYoXk-uhweXzUtFwSze_jJHw3+38g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33478 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934608AbcATRAP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2016 12:00:15 -0500
Received: by mail-lf0-f46.google.com with SMTP id m198so10023593lfm.0
        for <linux-acpi@vger.kernel.org>; Wed, 20 Jan 2016 09:00:14 -0800 (PST)
In-Reply-To: <CAHp75VcdtU6izThE+Z2ODnYoXk-uhweXzUtFwSze_jJHw3+38g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Shannon Zhao <shannon.zhao@linaro.org>, Vladimir Zapolskiy <vz@mleia.com>, Len Brown <lenb@kernel.org>


Hi Andy,

On 20.01.2016 21:12, Andy Shevchenko wrote:
> On Wed, Jan 20, 2016 at 4:29 PM, Aleksey Makarov
> <aleksey.makarov@linaro.org> wrote:
>> Factor out the code that finds the first physical device
>> of a given ACPI device.  It is used in several places.
>>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>
> Hmm=E2=80=A6 Sorry, didn't notice one style issue and there is one is=
 matter
> of taste below.
>
>> --- a/drivers/acpi/acpi_platform.c
>> +++ b/drivers/acpi/acpi_platform.c
>> @@ -43,7 +43,6 @@ static const struct acpi_device_id forbidden_id_li=
st[] =3D {
>
>> +       pdevinfo.parent =3D adev->parent ?
>> +               acpi_get_first_physical_node(adev->parent) : NULL;
>
> Matter of taste, but I believe if-else looks better here even when
> consumes +2 LOC.
> Or, does it fit 80? How wide then?

It does not fit 80 chars.  And I would prefer to leave ?: here.

>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -478,24 +478,35 @@ static void acpi_device_remove_notify_handler(=
struct acpi_device *device)
>>                                Device Matching
>>      ---------------------------------------------------------------=
----------- */
>>
>> -static struct acpi_device *acpi_primary_dev_companion(struct acpi_d=
evice *adev,
>> -                                                     const struct d=
evice *dev)
>> +/**
>> + * acpi_device_fix_parent - Get first physical node of an ACPI devi=
ce
>
> 'node' -> 'device node'
> Name of the function is wrong.

I will fix the name of function.  The type of returned value is clear=20
from the function definition.

>> + * @adev: ACPI device in question
>> + */
>> +struct device *acpi_get_first_physical_node(struct acpi_device *ade=
v)
>>   {
>>          struct mutex *physical_node_lock =3D &adev->physical_node_l=
ock;
>> +       struct device *node =3D NULL;
>>
>>          mutex_lock(physical_node_lock);
>> -       if (list_empty(&adev->physical_node_list)) {
>> -               adev =3D NULL;
>> -       } else {
>> -               const struct acpi_device_physical_node *node;
>>
>> +       if (!list_empty(&adev->physical_node_list))
>>                  node =3D list_first_entry(&adev->physical_node_list=
,
>> -                                       struct acpi_device_physical_=
node, node);
>> -               if (node->dev !=3D dev)
>> -                       adev =3D NULL;
>> -       }
>> +                               struct acpi_device_physical_node, no=
de)->dev;
>
> I didn't notice this '->dev' thingy. I supposed that the function
> returns struct acpi_device_physical_node *, not struct device *.
>
> Currently the name is not aligned with returned value.

It is aligned with the returned value (but not with the type of returne=
d=20
value).  So I would prefer to leave it as is.

Thank you for review.
Aleksey Makarov

>
>> +
>>          mutex_unlock(physical_node_lock);
>> -       return adev;
>> +
>> +       return node;
>> +}
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
