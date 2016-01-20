From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 1/2] ACPI: introduce a function to find the first
 physical device
Date: Wed, 20 Jan 2016 19:25:19 +0200
Message-ID: <CAHp75Vdedr9L_VPpbyKbDpqzheaovOh9bni_P5xyWH9djYFjoA@mail.gmail.com>
References: <1453300171-25473-1-git-send-email-aleksey.makarov@linaro.org>
	<1453300171-25473-2-git-send-email-aleksey.makarov@linaro.org>
	<CAHp75VcdtU6izThE+Z2ODnYoXk-uhweXzUtFwSze_jJHw3+38g@mail.gmail.com>
	<569FBD1A.5050609@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36728 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934015AbcATRZU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2016 12:25:20 -0500
In-Reply-To: <569FBD1A.5050609@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Shannon Zhao <shannon.zhao@linaro.org>, Vladimir Zapolskiy <vz@mleia.com>, Len Brown <lenb@kernel.org>

On Wed, Jan 20, 2016 at 7:00 PM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> On 20.01.2016 21:12, Andy Shevchenko wrote:
>>
>> On Wed, Jan 20, 2016 at 4:29 PM, Aleksey Makarov
>> <aleksey.makarov@linaro.org> wrote:
>>>
>>> Factor out the code that finds the first physical device
>>> of a given ACPI device.  It is used in several places.
>>>
>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

=46or all your comments, I have to withdraw my tag. You may return it
back if Rafael and / or Mika will be okay with these changes.
Sorry for inconvenience.

>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>>
>>
>> Hmm=E2=80=A6 Sorry, didn't notice one style issue and there is one i=
s matter
>> of taste below.

--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
