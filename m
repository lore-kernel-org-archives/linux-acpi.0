From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V9 1/2] ACPI, PCI, irq: remove interrupt count restriction
Date: Wed, 30 Dec 2015 21:55:35 +0200
Message-ID: <CAHp75VePLCAP8L3ve4F4745Nnes+kYa5QHHKQos4=0iHw0Ah0Q@mail.gmail.com>
References: <1449677909-12432-1-git-send-email-okaya@codeaurora.org>
	<1449677909-12432-2-git-send-email-okaya@codeaurora.org>
	<CAHp75VeW7wizf_FUc=O5+PEdfibYRL1G7gqpdDxUALwXJsnBAA@mail.gmail.com>
	<56686037.70109@codeaurora.org>
	<56686171.5060102@codeaurora.org>
	<5683DAD3.4080006@codeaurora.org>
	<CAHp75Ve5x3xmHpC4Ku4OXiXW6UHQqi1vLyzE7XSBhh+=zeeGgQ@mail.gmail.com>
	<56842DDF.6040109@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34937 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbbL3Tzg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2015 14:55:36 -0500
In-Reply-To: <56842DDF.6040109@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Christopher Covington <cov@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, jcm@redhat.com, helgaas@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Dec 30, 2015 at 9:17 PM, Sinan Kaya <okaya@codeaurora.org> wrot=
e:
> On 12/30/2015 8:28 AM, Andy Shevchenko wrote:
>> Yep, I meant not to use an additional variable.
>>
>>> > BTW, I suggest you spend some time around checkpatch for contribu=
tions. I could
>>> > have caught most of the issues you are generally concerned before=
 submitting a patch.
>> Is it a question?
>
> It is a request not a question. I hate wasting your time and my time =
with things that I could
> have fixed before submitting a patch.
>
> I ran the checkpatch and it said I'm good to go. But, obviously I'm n=
ot.

Hmm=E2=80=A6 checkpatch.pl is just a small helper to fix style issues. =
Here is
just a common sense rule, or kind of Occam's razor: no need to have
more variables then needed if it doesn't improve something really
significantly.

--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
