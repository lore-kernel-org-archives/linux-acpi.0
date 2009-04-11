From: Tzy-Jye Daniel Lin <ephemient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Regression: EEE PC hangs when booting off battery
Date: Sat, 11 Apr 2009 14:07:45 -0400
Message-ID: <66dc75180904111107q645fbb77i3cf927ffab7a7ef0@mail.gmail.com>
References: <49E065CF.6040408@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49E065CF.6040408-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Apr 11, 2009 at 5:41 AM, Alan Jenkins
<alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org> wrote:
> Regression #6 on latest git! (last known good is 2.6.29-rc8)
>
> Magic SysRQ keys work though. =C2=A0Unfortunately, SysRq-W / SysRq-T =
generate
> too much output, so the useful bits immediately scroll off the top of
> the screen. =C2=A0I can't press SysRq-P (even if that would help), be=
cause
> the SysRQ key on my laptop is accessed using a Fn modifier key, which
> also turns the left hand side of the keyboard into a numeric pad.

I don't own an Eee, but having played with one, the key sequence

    Alt down
    Fn down
    SysRq down, up
    Fn up
    P down, up
    Alt up

should work just fine.  As long as you keep holding Alt, you don't
need to continue holding SysRq after the initial keypress.

> Magic SysRQs on my USB keyboard generate no response. =C2=A0(Sometime=
s the
> numlock key seems to work though. =C2=A0I can't tell on the laptop ke=
yboard
> because the laptop doesn't have a numlock led).

SysRq over USB has never worked.  On PC hardware, Magic SysRq depends
on features of the built-in i8042 controller, which only handles PS/2
input.
