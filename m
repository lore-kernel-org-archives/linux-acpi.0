From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH RESEND] ACPI: Blacklist Win8 OSI for some HP laptop
 2013 models
Date: Tue, 14 Jan 2014 16:12:44 +0000
Message-ID: <20140114161244.GD4307@srcf.ucam.org>
References: <1389611658-19424-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60082 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbaANQMs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jan 2014 11:12:48 -0500
Content-Disposition: inline
In-Reply-To: <1389611658-19424-1-git-send-email-tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Oliver Neukum <oneukum@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 13, 2014 at 12:14:18PM +0100, Takashi Iwai wrote:
> The BIOS on recent HP laptops behaves differently with Win8 OSI,
> e.g. no backlight control and no rfkill are available.  List them in
> the blacklist as a workaround.

What's the plan for fixing this properly?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
