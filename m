From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI crash on lid close - SMP race?
Date: Mon, 10 Nov 2008 17:29:46 +0000
Message-ID: <20081110172946.GA3512@srcf.ucam.org>
References: <20081110161105.GA2041@srcf.ucam.org> <1226337995.5292.25.camel@segulix.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60253 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729AbYKJR3u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Nov 2008 12:29:50 -0500
Content-Disposition: inline
In-Reply-To: <1226337995.5292.25.camel@segulix.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Nov 10, 2008 at 05:26:35PM +0000, Sergio Monteiro Basto wrote:
> Hi, About this _DOS , I reported this problem a long time ago, which now
> is on http://bugzilla.kernel.org/show_bug.cgi?id=6001
> Could you put yours comment on it ? 
> 
> On fedora stock kernel, appears one patch, (Now I see that you are the
> author :) ) 
> 
> I tested your patch and it works for me ! 

Yeah, that's the "safe" patch which stops us executing the codepath that 
breaks, but also means I don't get display switch events. Having it set 
to 1 means executing BIOS code that's likely to interfere with the rest 
of the system, so a crash isn't surprising. But a setting of 0 *should* 
be safe, and I'm quite confused as to why it's exploding.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
