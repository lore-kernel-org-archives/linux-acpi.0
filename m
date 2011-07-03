From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] merge 32 and 64 realmode wakeup code
Date: Sun, 3 Jul 2011 08:50:32 +0200
Message-ID: <201107030850.32457.rjw@sisk.pl>
References: <1309628621-23107-1-git-send-email-castet.matthieu@free.fr> <4E0F9C3F.8020907@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50782 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505Ab1GCGtb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 Jul 2011 02:49:31 -0400
In-Reply-To: <4E0F9C3F.8020907@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matthieu CASTET <castet.matthieu@free.fr>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, x86@kernel.org

On Sunday, July 03, 2011, H. Peter Anvin wrote:
> On 07/02/2011 10:43 AM, Matthieu CASTET wrote:
> > - this mean less ifdef in code
> > - we could remove now unused field in wakeup_header (pmode_*)
> > 
> > Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> > ---
> >  arch/x86/kernel/acpi/realmode/wakeup.S |   26 --------------------------
> >  arch/x86/kernel/acpi/sleep.c           |   27 ++++++++++-----------------
> >  arch/x86/kernel/trampoline_32.S        |    4 ----
> >  3 files changed, 10 insertions(+), 47 deletions(-)
> > 
> 
> Looks great to me.  Rafael?

I don't have any immediate complaints.  Please feel free to add my ACK
to the patches.

Thanks,
Rafael
