From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [linux-pm] [RFC PATCH 2/4] ACPI: introduce the mechanism to
	save/restore ACPI NVS memory
Date: Thu, 10 Jul 2008 09:06:41 +0800
Message-ID: <1215652001.32617.2.camel@rzhang-dt>
References: <1215051874.5628.34.camel@rzhang-dt.sh.intel.com>
	 <20080708193558.GC8694@ucw.cz>
	 <20080709145850.GA18230@khazad-dum.debian.net>
	 <200807092226.12195.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63178 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752955AbYGJBHf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Jul 2008 21:07:35 -0400
In-Reply-To: <200807092226.12195.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Pavel Machek <pavel@suse.cz>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, linux-kernel <linux-kernel@zh-kernel.org>

On Wed, 2008-07-09 at 22:26 +0200, Rafael J. Wysocki wrote:
> On Wednesday, 9 of July 2008, Henrique de Moraes Holschuh wrote:
> > On Tue, 08 Jul 2008, Pavel Machek wrote:
> > > > >  static int acpi_hibernation_begin(void)
> > > > >  {
> > > > >  	acpi_target_sleep_state = ACPI_STATE_S4;
> > > > >  
> > > > > -	return 0;
> > > > > +	/* allocate pages for ACPI NVS memory before swsusp_shrink_memory */
> > > > > +	return acpi_allocate_nvs_pages();
> > > > 
> > > > I think we shouldn't abort hibernation because of that.
> > > > 
> > > > This may be an emergency hibernation due to critical battery status and we
> > > > surely don't want to about that.
> > > 
> > > I disagree here. If spec says 'you must save this', and we don't, we
> > > are asking for subtle, dangerous, and very hard to repoduce problems.
> > 
> > Indeed.  Especially after we start doing the right thing, and vendors WILL
> > expect us to do the right thing (save the NVS memory) *always*, not just
> > "almost always".
> > 
> > If you don't want the hibernate path to fail because of OOM, have whatever
> > memory it needs pre-allocated, set aside and protected at startup so that it
> > will always be there when you need to hibernate.
> 
> Okay, so be it.

You mean allocate enough pages during startup and never release them?

> 
> However, speaking of vendors, I'd like us to be able to switch that off using
> an 'acpi_sleep=' option (s4_no_nvs comes to mind) and/or blacklist broken
> BIOSes.

sound good, I'll do that. :)

thanks,
rui

