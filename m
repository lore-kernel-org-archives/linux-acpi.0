From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: No cpufreq on a Celeron 550
Date: Sun, 7 Sep 2008 11:29:50 +0100
Message-ID: <20080907102950.GA4227@srcf.ucam.org>
References: <Pine.LNX.4.64.0809071122100.3981@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49498 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987AbYIGK3z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Sep 2008 06:29:55 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0809071122100.3981@axis700.grange>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Sun, Sep 07, 2008 at 11:46:10AM +0200, Guennadi Liakhovetski wrote:
> I cannot use cpufreq on an ACER Extensa 5220 laptop with a Celeron 550 @ 
> 2GHz CPU. Reading various posts and articles, I saw that some kernel 
> versions have been able to use acpi-cpufreq on these CPUs and some cannot. 
> Currently using 2.6.26. acpidump output, cpuinfo, dmesg, lspci are at 
> http://home.arcor.de/g.liakhovetski/extensa5220/. Is there any chance to 
> get cpufreq fixed on this system?

Celerons don't support speedstep. So, no.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
