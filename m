From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: FSB scaling for ASUS EeePC 1000H
Date: Sun, 15 Mar 2009 19:05:59 +0000
Message-ID: <20090315190557.GA4324@srcf.ucam.org>
References: <49BD1843.7050502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52248 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171AbZCOTGG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Mar 2009 15:06:06 -0400
Content-Disposition: inline
In-Reply-To: <49BD1843.7050502@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Francesco Lattanzio <franz.lattanzio@gmail.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>

On Sun, Mar 15, 2009 at 04:01:23PM +0100, Francesco Lattanzio wrote:
> The following patch (against the current "linux-acpi-2.6" source tree) 
> adds the capability of the ASUS EeePC 1000H (and maybe other models as 
> well) to scale the FSB frequency and core voltage. Do not confuse this 
> with cpufreq (SpeedStep and other similar mechanisms): cpufreq changes 
> the internal CPU clock multiplier (and eventually the core voltage too) 
> leaving the FSB frequency untouched.

No, there's no requirement that cpufreq be limited to clock-multiplier 
based methods. It's the right interfae to use for CPU speed control.

(snip patch)

Is this different to the cpufreq driver suggested at 
http://lkml.org/lkml/2008/11/23/115 , other than the latter having 
hardcoded speed values?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
