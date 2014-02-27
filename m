From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / EC: Clear stale EC events on Samsung systems
Date: Thu, 27 Feb 2014 02:16:41 +0100
Message-ID: <2283771.eQo0eImXtS@vostro.rjw.lan>
References: <1393429360-4344-1-git-send-email-clancy.kieran@gmail.com> <CAGf84QK75jsXdnehwDNr8g+dCvdQKQ7+bgXmsbF_YFMKKYoGGw@mail.gmail.com> <CAGf84QK=YDN6MHTzEEc-1rbWHyGkBSbSdobaUwXV18d++EO+eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60440 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753115AbaB0BBk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Feb 2014 20:01:40 -0500
In-Reply-To: <CAGf84QK=YDN6MHTzEEc-1rbWHyGkBSbSdobaUwXV18d++EO+eg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kieran Clancy <clancy.kieran@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lan Tianyu <tianyu.lan@intel.com>, Juan Manuel Cabo <juanmanuel.cabo@gmail.com>, Dennis Jansen <dennis.jansen@web.de>

On Thursday, February 27, 2014 11:29:53 AM Kieran Clancy wrote:
> On Thu, Feb 27, 2014 at 11:15 AM, Kieran Clancy <clancy.kieran@gmail.com> wrote:
> >
> > I am the primary author, but I based the loop which calls
> > acpi_ec_query_unlocked() on a patch by Lan Tianyu. Juan provided the
> > initial idea (userspace workaround), and Dennis and Lan Tianyu
> > reviewed and suggested some changes to the code.
> 
> Oh, and I should add that Juan and Dennis both helped to test the
> patch extensively.

You can use Tested-by or Reported-and-tested-by for that.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
