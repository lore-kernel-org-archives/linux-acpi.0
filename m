From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: No cpufreq on a Celeron 550
Date: Sun, 7 Sep 2008 12:58:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0809071256330.3981@axis700.grange>
References: <Pine.LNX.4.64.0809071122100.3981@axis700.grange>
 <20080907102950.GA4227@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:41878 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752757AbYIGKuV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 7 Sep 2008 06:50:21 -0400
In-Reply-To: <20080907102950.GA4227@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On Sun, 7 Sep 2008, Matthew Garrett wrote:

> On Sun, Sep 07, 2008 at 11:46:10AM +0200, Guennadi Liakhovetski wrote:
> > I cannot use cpufreq on an ACER Extensa 5220 laptop with a Celeron 550 @ 
> > 2GHz CPU. Reading various posts and articles, I saw that some kernel 
> > versions have been able to use acpi-cpufreq on these CPUs and some cannot. 
> > Currently using 2.6.26. acpidump output, cpuinfo, dmesg, lspci are at 
> > http://home.arcor.de/g.liakhovetski/extensa5220/. Is there any chance to 
> > get cpufreq fixed on this system?
> 
> Celerons don't support speedstep. So, no.

Indeed, I was confused by the contradictory articles I found on the Net:-( 
Looks like only Allendale-512 supports speedstep.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
