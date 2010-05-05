From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] thinkpad_acpi: Hook volume events
Date: Wed, 5 May 2010 14:20:30 +0100
Message-ID: <20100505132030.GA24372@srcf.ucam.org>
References: <1272916980-11835-1-git-send-email-mjg@redhat.com> <1272916980-11835-2-git-send-email-mjg@redhat.com> <20100505113004.GA19480@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56741 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932275Ab0EENUg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 May 2010 09:20:36 -0400
Content-Disposition: inline
In-Reply-To: <20100505113004.GA19480@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

On Wed, May 05, 2010 at 08:30:05AM -0300, Henrique de Moraes Holschuh wrote:

> The idea is sound, but it would be probably cleaner to do it only on those
> thinkpads which need it.  I don't like the idea of handling duplicate
> notifications, and the logic depends entirely on nothing messing with the
> mixer state behind our backs, I'd prefer to rely on it just when strictly
> required.

In this case the notification is purely at the ALSA level, so there's no 
harm caused by duplicate notifications.

> Also, UCMS is called for a number of reasons.  It would be best to filter
> based on the UCMS parameter before doing an expensive PC CMOS RAM read or EC
> read.  We will be dealing with a finite number of thinkpads anyway.

Passing the parameter is... difficult. That would involve rather more 
surgery to the ACPI core, since the parameters are core-internal objects 
at this point. It's an obvious feature though, so I'll look into it some 
more.

> On the same note, we need to be called *after* the UCMS method completes,
> otherwise, we will have to schedule delayed work.  I didn't study your ACPI
> patch enough to know whether this happens, but that detail is not clear from
> the description.

The call is made after executing the original method, yes.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
