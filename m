From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / EC: Clear stale EC events on Samsung systems
Date: Thu, 27 Feb 2014 02:15:05 +0100
Message-ID: <348372796.ZazosLsa0U@vostro.rjw.lan>
References: <1393429360-4344-1-git-send-email-clancy.kieran@gmail.com> <1670100.tBHUbYFGo0@vostro.rjw.lan> <CAGf84QK75jsXdnehwDNr8g+dCvdQKQ7+bgXmsbF_YFMKKYoGGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60876 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754362AbaB0BAE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Feb 2014 20:00:04 -0500
In-Reply-To: <CAGf84QK75jsXdnehwDNr8g+dCvdQKQ7+bgXmsbF_YFMKKYoGGw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kieran Clancy <clancy.kieran@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lan Tianyu <tianyu.lan@intel.com>, Juan Manuel Cabo <juanmanuel.cabo@gmail.com>, Dennis Jansen <dennis.jansen@web.de>

On Thursday, February 27, 2014 11:15:05 AM Kieran Clancy wrote:
> On Thu, Feb 27, 2014 at 10:15 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Thursday, February 27, 2014 02:12:40 AM Kieran Clancy wrote:
> >> Signed-off-by: Kieran Clancy <clancy.kieran@gmail.com>
> >> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> >> Signed-off-by: Juan Manuel Cabo <juanmanuel.cabo@gmail.com>
> >> Signed-off-by: Dennis Jansen <dennis.jansen@web.de>
> >
> > There are too many sign-offs under this patch.  I suppose some of them
> > should be Acked-by or Reviewed-by.
> >
> > Are you the author?
> 
> Sorry about that, I wasn't sure of the best way to acknowledge the
> people involved.
> 
> I am the primary author, but I based the loop which calls
> acpi_ec_query_unlocked() on a patch by Lan Tianyu. Juan provided the
> initial idea (userspace workaround), and Dennis and Lan Tianyu
> reviewed and suggested some changes to the code.
> 
> What would you usually do this kind of situation?

I usually add acknowledgements to the changelog without using any tags,
like "This patch is based on previous work by <somebody>."  And then you
can give a link to that work in References:.

> I suppose I could put something such as:
>
> Signed-off-by: Kieran Clancy <clancy.kieran@gmail.com>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> Suggested-by: Juan Manuel Cabo <juanmanuel.cabo@gmail.com>
> Reviewed-by: Lan Tianyu <tianyu.lan@intel.com>
> Reviewed-by: Dennis Jansen <dennis.jansen@web.de>
> 
> Would this be preferable?

Yes, that'd be fine by me.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
