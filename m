From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Fri, 21 Jan 2011 16:23:17 -0800
Message-ID: <AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
 <201101212342.01646.rjw@sisk.pl> <AANLkTi=_-bMsp1K-thY+4wUMC5wDMVT+8m=fmVEx_wqE@mail.gmail.com>
 <201101220016.46227.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53426 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755123Ab1AVAYI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Jan 2011 19:24:08 -0500
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p0M0Ndxr015459
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Fri, 21 Jan 2011 16:23:39 -0800
Received: by iwn9 with SMTP id 9so2241810iwn.19
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jan 2011 16:23:37 -0800 (PST)
In-Reply-To: <201101220016.46227.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Fri, Jan 21, 2011 at 3:16 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> I wonder if you can reproduce the failure with the
>
> # echo core > /sys/power/pm_test
> # echo mem > /sys/power/state
>
> test? =A0I think you can even try to run the second command in a tigh=
t loop
> (the first one simply triggers a switch) and see what happens.

I don't think I can. I did 60 of those "echo mem > /sys/power/state"
in a row on top of current -git.

So I do think that the problem is connected to the actual sleeping part=
=2E

Or - and perhaps more likely - it's connected to the lid event, and
how that interacts with user space and then eventually triggers the
sleep event (which is quite likely - as mentioned, I think I've only
ever seen the problem when I'm physically at the machine).

                     Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
