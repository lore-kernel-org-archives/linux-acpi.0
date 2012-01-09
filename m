From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: /sys/class/power_supply/BAT0/ charge_ vs energy_
Date: Mon, 9 Jan 2012 13:37:22 +0000
Message-ID: <20120109133722.GA9981@srcf.ucam.org>
References: <CA+z-pWGrhtT3m=tOXcCDph3TC6AcbTVQJTF35V-o5MHeAB=HCg@mail.gmail.com>
 <CA+z-pWHyhVO16AGz-fxmDhTyO0xXGfOB-_pPQZjMqf4vBUZw_g@mail.gmail.com>
 <CA+z-pWHPj-_ZA0v+siLaVtwFtyd-tDFM5+71s3j6ng3=pWGu0Q@mail.gmail.com>
 <CA+z-pWGJ_sFh138kgZh-oX=rwv3t_LRDvgCvdGxuxnMDegxgaA@mail.gmail.com>
 <CA+z-pWEtiW9Rc9yjXNZSc7daFRwDieYb3Bnxt6=m+G+k_ELL8g@mail.gmail.com>
 <CA+z-pWGmiRvpYQWQwb-f9TjH18k1pvu1rbOPUuF1t9-m3HvHqA@mail.gmail.com>
 <CA+z-pWE9LmEiYDxVAbdR7GhO=C5fiDf1QozO2n4v0fQ4V6hrNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49276 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763Ab2AINhZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2012 08:37:25 -0500
Content-Disposition: inline
In-Reply-To: <CA+z-pWE9LmEiYDxVAbdR7GhO=C5fiDf1QozO2n4v0fQ4V6hrNQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jamie Kitson <jamie@kitten-x.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

On Mon, Jan 09, 2012 at 12:10:00PM +0000, Jamie Kitson wrote:

> If I boot with AC plugged in the /sys/class/power_supply/BAT0/
> directory is populated with charge_*, but if I boot on battery the
> directory is populated with energy_*.
> 
> Disconnecting/connecting the power after boot does not effect the file names.
> 
> Is this a bug or a feature? It makes scripts harder to write than necessary.

It's the way Lenovo's firmware works. It's not clear why.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
