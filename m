From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: Battery life difference
Date: Sat, 5 Jul 2008 22:44:35 +0300
Message-ID: <31e679430807051244k55efa331rdb57673db5ac37cf@mail.gmail.com>
References: <31e679430807050617u3fc706fasee9bb43a151c501f@mail.gmail.com>
	 <20080705082352.4b6be669@infradead.org>
	 <31e679430807050844r30ff74fby7e15641573b42d82@mail.gmail.com>
	 <20080705085432.2f9b2964@infradead.org>
	 <31e679430807051041w6dd9b917xc51f31f66fbd65d3@mail.gmail.com>
	 <20080705123438.15c8de40@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:11361 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbYGETof (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jul 2008 15:44:35 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1052424waf.23
        for <linux-acpi@vger.kernel.org>; Sat, 05 Jul 2008 12:44:35 -0700 (PDT)
In-Reply-To: <20080705123438.15c8de40@infradead.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Hi,

On Sat, Jul 5, 2008 at 10:34 PM, Arjan van de Ven <arjan@infradead.org> wrote:
> actually.. it needs to/is moving into the driver. This sort of decision
> needs to just happen locally in the driver; the idea that you can make
> power decisions (rather than policy decisions) on a global level is
> just no longer true (if it ever was).

Got your point. Just like in omap, we're putting everything in the driver
itself.

> Actually I thought this was already in the 2.6.26-rc kernel series
> driver...

At least powertop still complains about it. Maybe it's queued for
2.6.27 ?

btw, do you know if any company is selling x-series power adapters
to be attached to controlled power supplies or would I have to cut one of
my power supply cords (not willing to do that :-p)?

-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
