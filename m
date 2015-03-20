From: Nikolaus Rath <Nikolaus@rath.org>
Subject: Re: Help with debugging intermittent crash on resume from hibernation
Date: Thu, 19 Mar 2015 20:21:04 -0700
Message-ID: <87vbhwwdzz.fsf@vostro.rath.org>
References: <8761a3s1vq.fsf@vostro.rath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ebox.rath.org ([23.92.25.96]:43375 "EHLO ebox.rath.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbbCTDVG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2015 23:21:06 -0400
In-Reply-To: <8761a3s1vq.fsf@vostro.rath.org> (Nikolaus Rath's message of
	"Fri, 13 Mar 2015 20:02:45 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Mar 13 2015, Nikolaus Rath <Nikolaus@rath.org> wrote:
> Hello,
>
> In about one out of 10 resumes from hibernation, my system resets aft=
er
> the hibernation image has been loaded. I am hibernating using
>
> # echo platform > /sys/power/disk
> # echo disk > /sys/power/state
>
> When testing hibernation using
>
> # echo core > /sys/power/pm_test
> # echo platform > /sys/power/disk
> # echo disk > /sys/power/state
>
> I was not able to produce the same failure.
>
> I then tried attaching a serial console and booted with
> console=3DttyS0,115200n8 no_console_suspend. For the failed attempt, =
the
> last messages before the reset are:
[...]

I reproduced the same problem with 4.0.0-rc3. Is there anything I can d=
o
to get more debugging information?

Thanks,
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
