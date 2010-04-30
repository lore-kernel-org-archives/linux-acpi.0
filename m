From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: MacBookPro2,2 unable too boot with the latest HEAD
Date: Fri, 30 Apr 2010 22:14:51 +0100
Message-ID: <20100430211451.GA21791@srcf.ucam.org>
References: <i2vdd18b0c31004140812i6a0e9430u68ab49b24273fe9b@mail.gmail.com> <20100419142804.3cd53666.akpm@linux-foundation.org> <4BCCCCDF.4010605@gmail.com> <20100419145741.95688467.akpm@linux-foundation.org> <alpine.LFD.2.00.1004201011050.2402@sony> <4BD999C8.7090602@gmail.com> <20100430204912.GA21240@srcf.ucam.org> <4BDB47A7.8080200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35569 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab0D3VOz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Apr 2010 17:14:55 -0400
Content-Disposition: inline
In-Reply-To: <4BDB47A7.8080200@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Fri, Apr 30, 2010 at 02:12:07PM -0700, Justin P. Mattock wrote:

> The first issue is there's no entries
> in /proc/acpi/* and /sys/class/power_supply

It's a desktop. There shouldn't be.

> as for the defaulting to battery this is something
> nvidia is doing because of the no entries in either of
> the two places.
> heres what I'm looking at:
> two machines: both iMac9,1
> 
> 1= NVIDIA GPU GeForce 9400 (C79)
> 2= NVIDIA GPU GrForce GT 130 (G94)
> 
> the 9400 defaults to battery when looking
> at nvidia-settings and the other goes to A/C.
> both have no entries in the dsdt of A/C if this is
> supposed to happen.

Sounds like a bug with nvidia's drivers. This isn't a problem with the 
kernel.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
