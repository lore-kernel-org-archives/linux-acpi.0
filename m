From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V9 1/2] ACPI, PCI, irq: remove interrupt count restriction
Date: Mon, 4 Jan 2016 11:01:05 +0200
Message-ID: <CAHp75VfKeJodVtTLUS=dzzOgjydsRSEiLyLRbLQn5SW=CyVFnw@mail.gmail.com>
References: <1449677909-12432-1-git-send-email-okaya@codeaurora.org>
	<56842DDF.6040109@codeaurora.org>
	<CAHp75VePLCAP8L3ve4F4745Nnes+kYa5QHHKQos4=0iHw0Ah0Q@mail.gmail.com>
	<6338540.F7x0ET9vtV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35831 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbcADJBH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2016 04:01:07 -0500
In-Reply-To: <6338540.F7x0ET9vtV@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sinan Kaya <okaya@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, jcm@redhat.com, helgaas@kernel.org, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jan 1, 2016 at 2:48 AM, Rafael J. Wysocki <rjw@rjwysocki.net> w=
rote:
> On Wednesday, December 30, 2015 09:55:35 PM Andy Shevchenko wrote:
>> On Wed, Dec 30, 2015 at 9:17 PM, Sinan Kaya <okaya@codeaurora.org> w=
rote:
>> > On 12/30/2015 8:28 AM, Andy Shevchenko wrote:
>> >> Yep, I meant not to use an additional variable.
>> >>
>> >>> > BTW, I suggest you spend some time around checkpatch for contr=
ibutions. I could
>> >>> > have caught most of the issues you are generally concerned bef=
ore submitting a patch.
>> >> Is it a question?
>> >
>> > It is a request not a question. I hate wasting your time and my ti=
me with things that I could
>> > have fixed before submitting a patch.
>> >
>> > I ran the checkpatch and it said I'm good to go. But, obviously I'=
m not.
>>
>> Hmm=E2=80=A6 checkpatch.pl is just a small helper to fix style issue=
s. Here is
>> just a common sense rule, or kind of Occam's razor: no need to have
>> more variables then needed if it doesn't improve something really
>> significantly.
>
> That said, compilers optimize things anyway, so using an extra local =
variable
> shouldn't matter for the resulting machine code.

I'm not totally against that, but is the additional variable helpful he=
re?


--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
