From: "Guilherme Salgado" <gsalgado@gmail.com>
Subject: Re: Thinkpad suspend-to-disk regression
Date: Fri, 4 May 2007 10:39:52 -0300
Message-ID: <3d7cf86d0705040639u31cd50dcv9fa5e827d450c2be@mail.gmail.com>
References: <3d7cf86d0704241129i23da1b9fq93876573618e9dcd@mail.gmail.com>
	 <200705041107.45968.rjw@sisk.pl>
	 <3d7cf86d0705040537n7bd6dfabocf5210a2f32ddc3b@mail.gmail.com>
	 <200705041533.05146.lists@naasa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:45337 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755195AbXEDNjx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 May 2007 09:39:53 -0400
Received: by an-out-0708.google.com with SMTP id b33so830246ana
        for <linux-acpi@vger.kernel.org>; Fri, 04 May 2007 06:39:52 -0700 (PDT)
In-Reply-To: <200705041533.05146.lists@naasa.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jplatte@naasa.net
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

On 5/4/07, Joerg Platte <lists@naasa.net> wrote:
> Am Freitag, 4. Mai 2007 schrieb Guilherme Salgado:
>
> > This is what my hibernation script does, but I did it manually hoping
> > that waiting a few seconds between changing /sys/power/disk and
> > /sys/power/state could solve the problem. Unfortunately, it didn't; I
> > still get no sound after resuming.
>
> I had a similar problem with a recent kernel (but not with 2.6.21-rc7) on my
> T40p. Sound was lost after suspend-to-disk but could be re-activated by
> suspending to RAM. I did not further debug this, because I'm using suspend to
> disk regularly. You can try to suspend to RAM to see if it helps.
>

Yeah, I've heard reports that suspending to RAM brings the sound back,
but that's not really a solution to the problem. The last kernel I
tried was 2.6.21-rc4 and it has the problem; I'll pull the most recent
one and give it a try.

Thanks,
