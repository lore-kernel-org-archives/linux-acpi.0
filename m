From: Nikolaus Rath <Nikolaus@rath.org>
Subject: Re: Help with debugging intermittent crash on resume from hibernation
Date: Fri, 17 Apr 2015 21:13:14 -0700
Message-ID: <87bnimhy5h.fsf@vostro.rath.org>
References: <8761a3s1vq.fsf@vostro.rath.org> <87vbhwwdzz.fsf@vostro.rath.org>
	<1426823821.3150.4.camel@gmail.com> <5531CC47.9000008@rath.org>
	<1429329703.4034.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ebox.rath.org ([23.92.25.96]:43501 "EHLO ebox.rath.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbbDRFSN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Apr 2015 01:18:13 -0400
In-Reply-To: <1429329703.4034.4.camel@gmail.com> (Mike Galbraith's message of
	"Sat, 18 Apr 2015 06:01:43 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>

On Apr 17 2015, Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
> On Fri, 2015-04-17 at 20:15 -0700, Nikolaus Rath wrote:
>>=20
>> Is there anything I can do to help debug this issue?
>
> You could try to bisect it, but judging from the problem description,=
=20
> that could be more like a career than a troubleshooting session.

=46urthermore, I have yet to find a kernel version that does *not* exhi=
bit
the problem (I went back to 3.14).

Best,
-Nikolaus

--=20
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
=46ingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=
=C2=AB
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
