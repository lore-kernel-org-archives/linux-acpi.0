From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [linux-pm] [RFC PATCH 2/4] ACPI: introduce the mechanism to
	save/restore ACPI NVS memory
Date: Wed, 9 Jul 2008 11:58:50 -0300
Message-ID: <20080709145850.GA18230@khazad-dum.debian.net>
References: <1215051874.5628.34.camel@rzhang-dt.sh.intel.com> <200807040134.15094.rjw@sisk.pl> <20080708193558.GC8694@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:53235 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751834AbYGIO66 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jul 2008 10:58:58 -0400
Content-Disposition: inline
In-Reply-To: <20080708193558.GC8694@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, linux-kernel <linux-kernel@zh-kernel.org>

On Tue, 08 Jul 2008, Pavel Machek wrote:
> > >  static int acpi_hibernation_begin(void)
> > >  {
> > >  	acpi_target_sleep_state = ACPI_STATE_S4;
> > >  
> > > -	return 0;
> > > +	/* allocate pages for ACPI NVS memory before swsusp_shrink_memory */
> > > +	return acpi_allocate_nvs_pages();
> > 
> > I think we shouldn't abort hibernation because of that.
> > 
> > This may be an emergency hibernation due to critical battery status and we
> > surely don't want to about that.
> 
> I disagree here. If spec says 'you must save this', and we don't, we
> are asking for subtle, dangerous, and very hard to repoduce problems.

Indeed.  Especially after we start doing the right thing, and vendors WILL
expect us to do the right thing (save the NVS memory) *always*, not just
"almost always".

If you don't want the hibernate path to fail because of OOM, have whatever
memory it needs pre-allocated, set aside and protected at startup so that it
will always be there when you need to hibernate.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
