From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Make sure the FADT is at least rev 2 before
	using the reset register
Date: Mon, 13 Dec 2010 00:21:38 +0000
Message-ID: <20101213002138.GA5164@srcf.ucam.org>
References: <1292003871-13979-1-git-send-email-mjg@redhat.com> <1292199396.1715.143.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40377 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570Ab0LMAVu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Dec 2010 19:21:50 -0500
Content-Disposition: inline
In-Reply-To: <1292199396.1715.143.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Dec 13, 2010 at 08:16:36AM +0800, Zhang Rui wrote:
> On Sat, 2010-12-11 at 01:57 +0800, Matthew Garrett wrote:
> > The reset register was only introduced with version 2 of the FADT, so we
> > should check that the FADT revision before trusting its contents.
> > 
> does the current code break anything?
> I'm curious about how you found this bug. :)

No, it just seems to be a sensible sanity check.
