From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Add Intel ACPI IGD OpRegion support
Date: Wed, 6 Aug 2008 01:13:01 +0100
Message-ID: <20080806001301.GA10630@srcf.ucam.org>
References: <20080805183725.GA4468@srcf.ucam.org> <1217965470.5449.4.camel@hidalgo> <1217972874.4540.3.camel@hidalgo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59420 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755852AbYHFANF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Aug 2008 20:13:05 -0400
Content-Disposition: inline
In-Reply-To: <1217972874.4540.3.camel@hidalgo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Aug 05, 2008 at 11:47:54PM +0200, Yves-Alexis Perez wrote:

> In booted into X (with hal, powersaved, dbus etc. running), and then,
> tada, brightness keys work. There is a 750ms (I guess) delay, and I
> don't know who is really responsible, I guess X is. (and thus I guess
> the opregion is the one needed, and X manages the brightness. If the
> kernel was, it would be working even in single user)

The 750ms delay is from thinkpad-acpi. I sent a patch to Henrique which 
makes it go away, but I'm not entirely sure what the ACPI method 
concerned is supposed to be doing. The opregion code won't currently run 
until X is started because the drm layer requires X to be the foreground 
vt before handling IRQs.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
