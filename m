From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH] acpi: mv models with win8 brightness problems from win8 blacklist to use_native_backlight
Date: Thu, 01 May 2014 20:51:58 +0200
Message-ID: <2095093.jbbehouB3C@vostro.rjw.lan>
References: <1398865726-15264-1-git-send-email-hdegoede@redhat.com> <1830718.4HYQu7bYo0@vostro.rjw.lan> <536220E7.7010805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52154 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750836AbaEASf0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 May 2014 14:35:26 -0400
In-Reply-To: <536220E7.7010805@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Vincent Gerris <vgerris@gmail.com>, linux-acpi@vger.kernel.org

On Thursday, May 01, 2014 12:24:39 PM Hans de Goede wrote:
> Hi,
> 
> On 04/30/2014 09:56 PM, Rafael J. Wysocki wrote:
> > On Wednesday, April 30, 2014 03:48:46 PM Hans de Goede wrote:
> >> When the windows8 related backlight problems became evident, 2 approaches
> >> were follow in paralellel, one was to stop claiming to be windows 8 / 2012,
> >> the other was to tell acpi_video to stop registering a backlight driver.
> >>
> >> I've read all the threads and it seems that which approach ended up being
> >> applied to which model laptop was never really a concious decision (AFAIK).
> >>
> >> So lets move all the models which are only on the win8 blacklist because of
> >> brightness issues to the use_native_backlight list, which is the smaller
> >> hammer to use to solve the backlight issues.
> >>
> >> Note: this is not tested on any of the affected models, this just seems like
> >> the sensible thing to do.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Since commit 170269a9d3c0 (ACPI / video: Default to using native backlight
> > control on Windows 8 systems) in linux-next is effectively removing the black
> > list from video.c, I guess what you really would like to do would be to drop
> > the items from blacklist.c.  If so, please submit a patch to remove them on
> > top of commit 170269a9d3c0.
> 
> Right, the RFC was mostly for discussing what to do in case commit 170269a9d3c0
> does not work out well and ends up being reverted (as this was tried before and
> got reverted pretty quickly).
> 
> I'll send a patch just removing all the entries for -next for now, and I'll try
> to remember that we need a patch like this RFC if we end up reverting.

OK, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
