From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: Debugging video resume problems
Date: Fri, 19 Jan 2007 16:06:15 +0800
Message-ID: <3877989d0701190006u58e789c4o3aa30069b8a441db@mail.gmail.com>
References: <1169165850.3613.10.camel@hughsie-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:48310 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964928AbXASIGQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jan 2007 03:06:16 -0500
Received: by wx-out-0506.google.com with SMTP id h31so448650wxd
        for <linux-acpi@vger.kernel.org>; Fri, 19 Jan 2007 00:06:16 -0800 (PST)
In-Reply-To: <1169165850.3613.10.camel@hughsie-laptop>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: linux-acpi@vger.kernel.org

Does it respond to Ctl+Alt+Delete?
If yes, it could be just a known black screen issue. You can try
vbetool which happens to work for some lucky guys.Please google
vbetool, and take a look at video.txt in documentation/power.
if not,  you need to sort out the broken drivers. If you need help
please feel free to enter a bug in ACPI category at
bugzilla.kernel.org.

Thanks,
Luming


On 1/19/07, Richard Hughes <hughsient@gmail.com> wrote:
> Guys,
>
> I have a shiny new Lenovo 3000 N100 laptop. Hibernate works with the
> latest git tree from kernel.org, but suspend fails to resume with a
> black screen and no other flashing LED's or other activity. I've tried
> 2.6.18 and 2.6.19 and neither of those work either.
>
> This laptop has no serial ports, so I can't even see if it's oopsed
> remotely. Is there a guide (howto) that can help debug this? I've tried
> nearly all the usual combinations of acpi_sleep=s3_bios,s3_mode but I
> really need a hand with this one.
>
> As I've got no messages on the screen at resume, I really don't know
> where to begin to fix this, advice would be really appreciated.
>
> Thanks,
>
> Richard Hughes.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
