From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] i915: Fix opregion notifications
Date: Tue, 12 Jul 2011 23:30:01 +0100
Message-ID: <20110712223000.GA16307@srcf.ucam.org>
References: <1310507496-20116-1-git-send-email-mjg@redhat.com>
 <yunhb6rjg48.fsf@aiko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41514 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756025Ab1GLWaI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jul 2011 18:30:08 -0400
Content-Disposition: inline
In-Reply-To: <yunhb6rjg48.fsf@aiko.keithp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Keith Packard <keithp@keithp.com>
Cc: intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org

On Tue, Jul 12, 2011 at 03:20:23PM -0700, Keith Packard wrote:

> Seriously? It's some kind of magic non-switch switch event? And you can
> tell by checking magic bits within the event?

The Intel drivers on Windows appear to have used 0x80 as a generic 
"Something's chanegd" notification, overloading it for docking, lid 
state change and display switch press. As a result of that right now 
we're sending a display switch event whenever one of these occurs. Less 
than ideal. Opregion gives us a magic field in shared OS/firmware memory 
that can be used to distinguish between these events.

> How can I test this and know if it works?

Tested on a Thinkpad X200. Make sure suspend is disabled, then close the 
lid. Open it again. The ACPI video input device will send a display 
switch event. Add this patch and repeat and the event will vanish. The 
display switch itself will still generate an event.

I'll send v2 now.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
