From: "John H." <mistamaila@gmail.com>
Subject: Re: compaq 2110us and suspend to ram
Date: Tue, 17 Jan 2006 18:11:27 -0600
Message-ID: <5b9417770601171611m626e60bdnbe81dc83bbfaefb6@mail.gmail.com>
References: <5b9417770601171500q5939d01at3414e993ca8415e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.195]:10173 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964930AbWARAL2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2006 19:11:28 -0500
Received: by zproxy.gmail.com with SMTP id 14so1493267nzn
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2006 16:11:27 -0800 (PST)
In-Reply-To: <5b9417770601171500q5939d01at3414e993ca8415e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-laptop@mobilix.org, linux-acpi@vger.kernel.org

hmm, more confusing.  It seems to only work occassionally.

What seems to happen no matter what is, it does not actually turn off,
apparently, but if I hit an acpi key again, it reboots the computer?


On 1/17/06, John H. <mistamaila@gmail.com> wrote:
> In reply to pavel's last comments:
>
> Ok, I was reading video.txt.
> I have a radeon 320m/mobility u1, but I didn't have access to my
> keyboard after "resume," either, not just video.  I am using
> video=radeon:ywrap,mtrr,font.... in grub.conf, so i should be using
> radeonfb(but i can not use fb if necessary).I wanted to ask,
> quickly...
>
> you said that with your patch, it will not resume properly anyway, so,
> at this point, can I really even test the various options in
> video.txt?  I mean, regardless of what grub.conf parameters I specify
> that are mentioned in video.txt, as long as your patch is what I am
> booting off of, it shouldn't work anyway, right?
>
> -------------
> compaq 2110us and
> fc4
> athlon xp processor
>
> EVEN with acpid not running, I get a power off when I try to resume
> from suspend to ram by hitting an acpid button, which I am desperately
> trying to get working.  It works fine in XP.
>
> The only way I can prevent poweroff is using this modifcation to
> wakeup.S which was provided by pavlov, but it obviously does not allow
> correct resume.  It does, however, show something.
>
> ----------------
> #define BEEP \
>        inb     $97, %al;       \
>        outb    %al, $0x80;     \
>        movb    $3, %al;        \
>        outb    %al, $97;       \
>        outb    %al, $0x80;     \
>        movb    $-74, %al;      \
>        outb    %al, $67;       \
>        outb    %al, $0x80;     \
>        movb    $-119, %al;     \
>        outb    %al, $66;       \
>        outb    %al, $0x80;     \
>        movb    $15, %al;       \
>        outb    %al, $66;
>
> ALIGN
>         .align  4096
> ENTRY(wakeup_start)
> wakeup_code:
>         wakeup_code_start = .
>         .code16
> BEEP
> 1:
>         jmp 1b
>
>         movw    $0xb800, %ax
>         movw    %ax,%fs
>         movw    $0x0e00 + 'L', %fs:(0x10)
>
> ---------------------------
>
>
> So what does this mean?  Obviously this patch is going to prevent a
> successful resume, but when I use it, the all the lights return to
> normal but I get no key usage nor video usage on resume.  If I do NOT
> use these modifications, pressing any acpi button powers off the
> computer, even if acpid is stopped.
>
