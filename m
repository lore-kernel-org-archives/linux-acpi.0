From: "Mattia Dongili" <malattia@linux.it>
Subject: Re: [PATCH 1/2] Add new sony laptop drivers maintainer
Date: Fri, 9 Feb 2007 15:01:29 +0100 (CET)
Message-ID: <56393.85.47.20.193.1171029689.squirrel@picard.linux.it>
References: <11709622011964-git-send-email-malattia@linux.it>
    <11709622013582-git-send-email-malattia@linux.it>
    <200702090144.13237.lenb@kernel.org>
    <1171028098.6387.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from picard.linux.it ([213.254.12.146]:54114 "EHLO picard.linux.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946465AbXBIOBb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Feb 2007 09:01:31 -0500
In-Reply-To: <1171028098.6387.15.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stelian Pop <stelian@popies.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Fri, February 9, 2007 2:34 pm, Stelian Pop said:
> Le vendredi 09 f=E9vrier 2007 =E0 01:44 -0500, Len Brown a =E9crit :
>> On Thursday 08 February 2007 14:16, malattia@linux.it wrote:
>> > From: Mattia Dongili <malattia@linux.it>
>> >
>> > Signed-off-by: Mattia Dongili <malattia@linux.it>
>> > ---
>> >  MAINTAINERS |    2 ++
>> >  1 files changed, 2 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index efca26a..ec97723 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -3012,6 +3012,8 @@ S:	Maintained
>> >  SONY VAIO CONTROL DEVICE DRIVER
>> >  P:	Stelian Pop
>> >  M:	stelian@popies.net
>> > +P:	Mattia Dongili
>> > +M:	malattia@linux.it
>> >  W:	http://popies.net/sonypi/
>> >  S:	Maintained
>>
>> Stelian, are you still actively maintaining Sony support,
>
> Actively definately not, though I still answer a lot of support
> questions about sonypi.
>
> I even receive patches from time to time :)
>
>> or should we simply replace your name here with Mattia?
>
>>From what I recall, Mattia took over sony_acpi but didn't want to han=
dle
> sonypi as well, at least not for the time being.
>
> If he changed his mind I'm hapily handing over the maintenance to him=
=2E
>
> If not, maybe the MAINTAINERS entry should be clarified to say that
> Mattia maintains sony_acpi and sonypi is currently not maintained.

Well, I'd hate losing possibly useful patches because the driver result=
s
unmaintained. :)
Sooo... updated MAINTAINERS patch will follow soon.

One question though: which subsystem should sonypi patches flow through=
?

--=20
mattia
:wq!


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
