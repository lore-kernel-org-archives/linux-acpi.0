From: "John H." <mistamaila@gmail.com>
Subject: Re: Suspend/resume waiting for a key ?
Date: Wed, 25 Jan 2006 23:00:22 -0600
Message-ID: <5b9417770601252100w5521ace9h178d16d459410373@mail.gmail.com>
References: <20060123060743.GA22878@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:53526 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751293AbWAZFAX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jan 2006 00:00:23 -0500
Received: by zproxy.gmail.com with SMTP id 14so284899nzn
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jan 2006 21:00:22 -0800 (PST)
In-Reply-To: <20060123060743.GA22878@tangens.sinus.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Troller <patrol@sinus.cz>, linux-acpi@vger.kernel.org

is this a compaq 2110us or 2100us by chance?

On 1/23/06, Pavel Troller <patrol@sinus.cz> wrote:
> Hi!
>   Yesterday I was installing Linux to my friend's notebook. It was a Compaq
> model; sorry but just now I don't remember exact ID.
>   When I tried STD, in principle it worked, but there were some strange things
> happening. Especially, it wrote a bunch of obvious messages (mostly about
> various devices on a PCI bus) and then it stopped. I was waiting about 30
> seconds and then tried to switch the consoles. As soon as I pressed Alt, the
> process continued smoothly and the machine suspended itself.
>   During resuming, the same was observed. To resume quickly, repeated pressing
> of any key was of a great help. Otherwise resuming process hang in various
> phases, but pressing a key helped.
>   It has to be said that even switching from X server to text console during
> normal operation sometimes behaves similarly; the graphics screen remains
> visible until any key is pressed, after that, it immediately turns to the text
> console.
>   I've tried ec_burst=1, but the machine was unable to suspend then.
>   All this was tested with 2.6.15.1 kernel.
>   There weren't any unusual mesages in the syslog/suspending console.
>   I don't have access to the machine now, but some tuning is still neccessary,
> so I will see it in a near future. I would like to gain some ideas before, to
> retry my attempts with STD. So any ideas what to try are greatly appreciated
> :-).
>                      With regards, Pavel Troller
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
