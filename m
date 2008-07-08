From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [RFC PATCH 2/4] ACPI: introduce the mechanism to save/restore ACPI NVS memory
Date: Tue, 8 Jul 2008 21:35:59 +0200
Message-ID: <20080708193558.GC8694@ucw.cz>
References: <1215051874.5628.34.camel@rzhang-dt.sh.intel.com> <200807040134.15094.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1139 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753492AbYGIOiX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Jul 2008 10:38:23 -0400
Content-Disposition: inline
In-Reply-To: <200807040134.15094.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, linux-kernel <linux-kernel@zh-kernel.org>

Hi!

> >  static int acpi_hibernation_begin(void)
> >  {
> >  	acpi_target_sleep_state = ACPI_STATE_S4;
> >  
> > -	return 0;
> > +	/* allocate pages for ACPI NVS memory before swsusp_shrink_memory */
> > +	return acpi_allocate_nvs_pages();
> 
> I think we shouldn't abort hibernation because of that.
> 
> This may be an emergency hibernation due to critical battery status and we
> surely don't want to about that.

I disagree here. If spec says 'you must save this', and we don't, we
are asking for subtle, dangerous, and very hard to repoduce problems.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
