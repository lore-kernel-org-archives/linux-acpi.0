From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: Why is it so hard to (get) help on ACPI?
Date: Thu, 17 May 2007 22:58:33 +0400
Message-ID: <8f8ff01d0705171158q3412f0f1o4465562bb961d774@mail.gmail.com>
References: <200705172005.47845.matija.suklje@rutka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:64275 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbXEQS6d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 May 2007 14:58:33 -0400
Received: by an-out-0708.google.com with SMTP id d18so156124and
        for <linux-acpi@vger.kernel.org>; Thu, 17 May 2007 11:58:33 -0700 (PDT)
In-Reply-To: <200705172005.47845.matija.suklje@rutka.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?WINDOWS-1252?Q?Matija_=8Auklje?= <matija.suklje@rutka.net>
Cc: linux-acpi@vger.kernel.org

Hi,

=46irst of all, why do you want/need to change your DSDT?
Second, patching DSDT is meant to be a last resort if any other
method, like finding error in our implementation of ACPI or drivers.

So "better" DSDT patch is patch of zero length -- don't touch it, fix
ACPI or drivers.

Regards,
Alex.

On 5/17/07, Matija =8Auklje <matija.suklje@rutka.net> wrote:
> Hi,
>
> what do I have to do to upload my DSDT patch and find help on how to =
make it
> better?
>
> I've already tried registering on http://acpi.sourceforge.net/dsdt/ ,=
 but my
> account just doesn't show up on the list.
> I've already sent my DSDT patch to this mailing list (after joining i=
t, of
> course) with connected questions, but it didn't get through?
>
> Why is it so hard to help or get help on ACPI? What am I doing wrong?
>
> regards,
> Matija =8Auklje
>
> --
> gsm: +386 41 849 552
> e-mail: matija.suklje@rutka.net
> www: http://matija.suklje.name
>
> aim: hookofsilver
> icq: 110183360
> jabber/g-talk: matija.suklje@jabber.com
> msn: matija.suklje@rutka.net
> yahoo: matija_suklje
>
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
