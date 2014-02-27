From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / EC: Clear stale EC events on Samsung systems
Date: Thu, 27 Feb 2014 23:02:38 +0100
Message-ID: <10729829.62LVQtDGOg@vostro.rjw.lan>
References: <1393429360-4344-1-git-send-email-clancy.kieran@gmail.com> <2283771.eQo0eImXtS@vostro.rjw.lan> <CAGf84Q+kHgfx6OaiEWFKs6kMmj_JiHLooeRxpXs7a64iC40zFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62690 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752347AbaB0Vrf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Feb 2014 16:47:35 -0500
In-Reply-To: <CAGf84Q+kHgfx6OaiEWFKs6kMmj_JiHLooeRxpXs7a64iC40zFw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kieran Clancy <clancy.kieran@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lan Tianyu <tianyu.lan@intel.com>, Juan Manuel Cabo <juanmanuel.cabo@gmail.com>, Dennis Jansen <dennis.jansen@web.de>

On Thursday, February 27, 2014 11:39:42 AM Kieran Clancy wrote:
> On Thu, Feb 27, 2014 at 11:46 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Thursday, February 27, 2014 11:29:53 AM Kieran Clancy wrote:
> >>
> >> Oh, and I should add that Juan and Dennis both helped to test the
> >> patch extensively.
> >
> > You can use Tested-by or Reported-and-tested-by for that.
> 
> Is it okay to have someone listed as both 'Reviewed-by' and
> 'Tested-by', or both 'Suggested-by' and 'Tested-by'?

Yes, these are different things essentially and each of them requires time
and effort on its own.

> Thank you for your help. Once I fix up these things, I will send a patch v2.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
