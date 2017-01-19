From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v20 08/17] clocksource/drivers/arm_arch_timer: Rework
 counter frequency detection.
Date: Thu, 19 Jan 2017 17:44:46 +0800
Message-ID: <CADyBb7uGVu6Po4hCD45WOrQvWYwZgtSbE5z9rbRa7gZ1P5-4tg@mail.gmail.com>
References: <20170118132541.8989-1-fu.wei@linaro.org> <20170118132541.8989-9-fu.wei@linaro.org>
 <cafa8c7a-9c7c-51ba-5566-0cfe1fe6f764@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cafa8c7a-9c7c-51ba-5566-0cfe1fe6f764-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linaro ACPI Mailman List <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rruigrok-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, "Abdulhamid, Harb" <harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, G Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al Stone <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Hanjun,

On 19 January 2017 at 16:02, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Hi Fuwei,
>
> One comments below.
>
>
> On 2017/1/18 21:25, fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>>
>> From: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> The counter frequency detection call(arch_timer_detect_rate) combines tw=
o
>> ways to get counter frequency: system coprocessor register and MMIO time=
r.
>> But in a specific timer init code, we only need one way to try:
>> getting frequency from MMIO timer register will be needed only when we
>> init MMIO timer; getting frequency from system coprocessor register will
>> be needed only when we init arch timer.
>>
>> This patch separates paths to determine frequency:
>> Separate out the MMIO frequency and the sysreg frequency detection call,
>> and use the appropriate one for the counter.
>>
>> Signed-off-by: Fu Wei <fu.wei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 40
>> ++++++++++++++++++++++--------------
>>  1 file changed, 25 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c
>> b/drivers/clocksource/arm_arch_timer.c
>> index 6484f84..9482481 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -488,23 +488,33 @@ static int arch_timer_starting_cpu(unsigned int cp=
u)
>>         return 0;
>>  }
>>
>> -static void arch_timer_detect_rate(void __iomem *cntbase)
>> +static void __arch_timer_determine_rate(u32 rate)
>>  {
>> -       /* Who has more than one independent system counter? */
>> -       if (arch_timer_rate)
>> -               return;
>> +       /* Check the timer frequency. */
>> +       if (!arch_timer_rate) {
>> +               if (rate)
>> +                       arch_timer_rate =3D rate;
>> +               else
>> +                       pr_warn("frequency not available\n");
>> +       } else if (rate && arch_timer_rate !=3D rate) {
>
>                         ^
> Typo? I think it's "&" here.

Not a typo, It's definitely a =E2=80=9C&&=E2=80=9D  :-)

Here arch_timer_rate is not zero.

If rate is not zero(that means we got a valid rate), and
arch_timer_rate !=3D rate ,
we will print warning message.

>
> Thanks
> Hanjun



--=20
Best regards,

Fu Wei
Software Engineer
Red Hat
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
