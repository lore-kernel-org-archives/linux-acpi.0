From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Resuming from hibernation on T61 with nvidia
Date: Tue, 15 Nov 2011 19:58:32 +0000
Message-ID: <20111115195832.GA9384@srcf.ucam.org>
References: <op.v4z4ihs2wcw97g@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52127 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077Ab1KOT6f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Nov 2011 14:58:35 -0500
Content-Disposition: inline
In-Reply-To: <op.v4z4ihs2wcw97g@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dienet <dienet@poczta.fm>
Cc: linux-acpi@vger.kernel.org

On Tue, Nov 15, 2011 at 08:02:31PM +0100, dienet wrote:

> Was is the problem? In my T61 I have 01:00.0 VGA compatible
> controller:  nVidia Corporation G84M [Quadro NVS 140M] (rev a1) and
> I am using nvidia  drivers (also checked quite a few versions
> without any luck). Suspending  to disk is working without any
> problem. The problem is when I want to  resume. The resume process
> is stopping at some point (I think after the  pages are red) for
> about 60 seconds. After that time, the resume process  is
> continuing, and after few sec, I am back in X11.

Does the same thing happen if you use nouveau rather than the nvidia 
drivers?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
