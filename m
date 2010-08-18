From: trapDoor <trapdoor6@gmail.com>
Subject: Re: [REGRESSION] [SUSPEND] Opps during suspend to disk (probably also
 during to ram)
Date: Wed, 18 Aug 2010 20:16:22 +0100
Message-ID: <AANLkTik3S91w+92rz-KdHd_U=yfuSPbDWWhD_Vu_rDR9@mail.gmail.com>
References: <201008182102.03201.maciej.rutecki@gmail.com>
Reply-To: trapdoor6@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201008182102.03201.maciej.rutecki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: maciej.rutecki@gmail.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 18, 2010 at 8:02 PM, Maciej Rutecki
<maciej.rutecki@gmail.com> wrote:
> Last known good kernel: 2.6.35
> Failing kernel: 2.6.36-rc1
>
> When I try suspend to disk under 2.6.36-rc1 ("no_console_suspend" option
> enabled) system hangs on this message:
> http://unixy.pl/maciek/download/kernel/2.6.36-
> rc1/zlom/suspend_issue/dsc_0001.jpg
>
Hello,

I see on the screenshot some messages related to HID so perhaps you
have the same issue I came across recently. If it happens so this
commit should fix it:
http://git.kernel.org/?p=linux/kernel/git/jikos/hid.git;a=commitdiff;h=9c9e54a8df0be48aa359744f412377cc55c3b7d2

For more details please refer to:
https://bugzilla.kernel.org/show_bug.cgi?id=16615
or:
http://lkml.org/lkml/2010/8/18/92   #currently dead



-- 
Regards
Tomasz B.
