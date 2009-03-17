From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: FSB scaling for ASUS EeePC 1000H
Date: Tue, 17 Mar 2009 11:34:15 +0000
Message-ID: <20090317113415.GA7806@srcf.ucam.org>
References: <49BD1843.7050502@gmail.com> <20090315190557.GA4324@srcf.ucam.org> <49BF5E9E.8050404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53944 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688AbZCQLeV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Mar 2009 07:34:21 -0400
Content-Disposition: inline
In-Reply-To: <49BF5E9E.8050404@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Francesco Lattanzio <franz.lattanzio@gmail.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>

On Tue, Mar 17, 2009 at 09:26:06AM +0100, Francesco Lattanzio wrote:

> It is exactly the same thing, done differently. Now I ask you, should we 
> put this feature inside some eeepc-specific cpufreq module, or inside 
> the eeepc-laptop module? Keep in mind that the 1000H model allows me to 
> combine the effects of both the cpufreq (through Atom SpeedStep feature) 
> and these ACPI methods.

Putting it in eeepc-laptop is probably easier. I'd recommend doing it 
with cpufreq, but making sure that the transition latency is large 
enough that ondemand won't try to mess with it. There's actually an 
interesting question of what to do with making sure performance doesn't 
bind and push you to a speed you don't want by default. I'll talk to 
Dave about that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
