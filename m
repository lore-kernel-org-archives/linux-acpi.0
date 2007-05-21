From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.22-rc1-mm1 [cannot change thermal trip points]
Date: Mon, 21 May 2007 15:29:48 +0200
Message-ID: <20070521132948.GD8332@elf.ucw.cz>
References: <20070515201914.16944e04.akpm@linux-foundation.org> <200705171517.14087.lenb@kernel.org> <1179604609.16465.83.camel@sublime.suse.de> <200705202350.45145.lenb@kernel.org> <20070521121048.GA8332@elf.ucw.cz> <20070521132711.GA7540@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41079 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755554AbXEUN34 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 May 2007 09:29:56 -0400
Content-Disposition: inline
In-Reply-To: <20070521132711.GA7540@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, trenn@suse.de, Chuck Ebbert <cebbert@redhat.com>, len.brown@intel.com, Maciej Rutecki <maciej.rutecki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org

Hi!

> > > For folks with the reverse problem -- active cooling where the
> > > fans kick in early than they'd like, they should just turn off
> > > the fans via /proc/acpi/fan and not mess with the trip points at
> > > all.
> > 
> > No. Manually turning off fans is even worse hack.
> 
> It's significantly more correct.

Significantly more correct? It forces you to do all the thermal
management in userspace!
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
