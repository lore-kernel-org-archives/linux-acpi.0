From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/3] Fix backlight issues on some Windows 8 systems
Date: Tue, 25 Jun 2013 22:14:15 +0100
Message-ID: <20130625211415.GA2899@srcf.ucam.org>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
 <1371937599.17761.19.camel@scapa>
 <20130625160848.GA27123@srcf.ucam.org>
 <1372193037.8189.24.camel@scapa>
 <20130625205430.GA2438@srcf.ucam.org>
 <1372194611.8189.31.camel@scapa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59567 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498Ab3FYVOS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jun 2013 17:14:18 -0400
Content-Disposition: inline
In-Reply-To: <1372194611.8189.31.camel@scapa>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: linux-acpi@vger.kernel.org, seth.forshee@canonical.com, joeyli.kernel@gmail.com, daniel.vetter@ffwll.ch, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl, Henrique de Moraes Holschuh <hmh@debian.org>

On Tue, Jun 25, 2013 at 11:10:11PM +0200, Yves-Alexis Perez wrote:
> On mar., 2013-06-25 at 21:54 +0100, Matthew Garrett wrote:
> > I agree, we should standardise the behaviour. And the only way we can 
> > standardise the behaviour is to leave it up to userspace.
> > 
> It's pretty clear we disagree on this and that my opinion won't really
> matter here. But letting userspace handle that just means broken
> functionality for those who have the chance (apparently) to have an ACPI
> backlight interface.

Which, as we've already established, you don't - Lenovo broke it. Your 
Thinkpad claims to have 100 available levels, and most of them don't 
work. The kernel has no way of knowing which levels work and which 
don't, so leaving this up to the kernel won't actually fix your system 
either.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
