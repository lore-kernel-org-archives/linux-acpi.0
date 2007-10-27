From: Anton Vorontsov <cbou@mail.ru>
Subject: Re: [PATCH] 2.6.24-rc1: ensure "present" sysfs attribute even if
	battery is absent
Date: Sat, 27 Oct 2007 23:50:25 +0400
Message-ID: <20071027195025.GA3263@zarina>
References: <200710272054.31160.arvidjaar@mail.ru> <20071027184249.GA2982@zarina> <1193513524.2915.18.camel@shinybook.infradead.org>
Reply-To: cbou@mail.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx39.mail.ru ([194.67.23.35]:49982 "EHLO mx39.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349AbXJ0TwT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 27 Oct 2007 15:52:19 -0400
Content-Disposition: inline
In-Reply-To: <1193513524.2915.18.camel@shinybook.infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, davidz@redhat.com, rhughes@redhat.com

On Sat, Oct 27, 2007 at 03:32:04PM -0400, David Woodhouse wrote:
> On Sat, 2007-10-27 at 22:42 +0400, Anton Vorontsov wrote:
> > Well, PROP_PRESENT wasn't my idea, currently it's used by pmu and
> > olpc drivers becuase it's not trivial to register/unregister their
> > batteries on physical insertion/removal. I have some plans to teach
> > at least pmu batteries to not use PROP_PRESENT. I don't have any
> > OLPC, thus I can't convert it.
> 
> Actually it's not hard to do that.

I didn't say it's hard. But we don't have any interrupts for the
battery events, thus we have to implement polling.

> It was done this way in response to a
> request from the userspace side. IIRC.

Oh. Userspace tried to do something weird then, I think. Generally
it's just sane to unregister absent hardware.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
