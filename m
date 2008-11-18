From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [PATCH 2/4] ACPI hibernate: Add a mechanism to save/restore ACPI NVS memory
Date: Tue, 18 Nov 2008 17:14:56 +0100
Message-ID: <20081118161456.GA3466@atrey.karlin.mff.cuni.cz>
References: <200810222249.20629.rjw@sisk.pl> <200810222252.11625.rjw@sisk.pl> <20081026120838.GB1607@ucw.cz> <200810261323.21293.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49651 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528AbYKRQO5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Nov 2008 11:14:57 -0500
Content-Disposition: inline
In-Reply-To: <200810261323.21293.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

Hi!

> > >  #else /* CONFIG_HIBERNATION */
> > >  static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
> > >  static inline void swsusp_set_page_free(struct page *p) {}
> > > @@ -241,6 +246,14 @@ static inline void swsusp_unset_page_fre
> > >  static inline void hibernation_set_ops(struct platform_hibernation_ops *ops) {}
> > >  static inline int hibernate(void) { return -ENOSYS; }
> > >  static inline bool system_entering_hibernation(void) { return false; }
> > > +static inline int hibernate_nvs_register(unsigned long a, unsigned long b)
> > > +{
> > > +	return 0;
> > > +}
> > > +static inline int hibernate_nvs_alloc(void) { return 0; }
> > > +static inline void hibernate_nvs_free(void) {}
> > > +static inline void hibernate_nvs_save(void) {}
> > > +static inline void hibernate_nvs_restore(void) {}
> > >  #endif /* CONFIG_HIBERNATION */
> > 
> > Can someone call these for !hibernation case?
> 
> Not at the moment, but why not to add them?

Well, someone may call them, expecting them to save / restore nvs,
except that they will not be there. I'd prefer inlines not to exist
(so mistake is caught at compile time) or them to contain BUG(), so
that mistake is obvious.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
