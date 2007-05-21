From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.22-rc1-mm1 [cannot change thermal trip points]
Date: Mon, 21 May 2007 14:27:12 +0100
Message-ID: <20070521132711.GA7540@srcf.ucam.org>
References: <20070515201914.16944e04.akpm@linux-foundation.org> <200705171517.14087.lenb@kernel.org> <1179604609.16465.83.camel@sublime.suse.de> <200705202350.45145.lenb@kernel.org> <20070521121048.GA8332@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:51259 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334AbXEUN2x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 May 2007 09:28:53 -0400
Content-Disposition: inline
In-Reply-To: <20070521121048.GA8332@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>, trenn@suse.de, Chuck Ebbert <cebbert@redhat.com>, len.brown@intel.com, Maciej Rutecki <maciej.rutecki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org

On Mon, May 21, 2007 at 02:10:48PM +0200, Pavel Machek wrote:

> > nope, the OS can't reliably override the processor passive trip point.
> > That is what _SCP and cooling_mode are for.
> 
> Yes, it is reliable if you turn on thermal polling.

As Len says, the system can force a reevaluation of the trip points at 
any time which will wipe out the local settings. Either you ignore the 
spec and the notifications (potentially risking misbehaving hardware) or 
you end up in a perpetual race.

> > if you want to change the state of the fans,
> > then poke /proc/acpi/fan/ directly.
> 
> Heh, you suggest this? It is even less functional than current
> solution -- which works okay as long as you keep thermal polling
> working.

If there are problems with the fan behaviour, why don't we fix them?

> > For folks with the reverse problem -- active cooling where the
> > fans kick in early than they'd like, they should just turn off
> > the fans via /proc/acpi/fan and not mess with the trip points at
> > all.
> 
> No. Manually turning off fans is even worse hack.

It's significantly more correct.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
