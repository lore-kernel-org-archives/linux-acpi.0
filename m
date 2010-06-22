From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 1/2] ACPI: Save/Restore NVS area on
	suspend/resume too
Date: Tue, 22 Jun 2010 13:06:27 +0100
Message-ID: <20100622120627.GB15944@srcf.ucam.org>
References: <1275077971.20606.20.camel@maxim-laptop> <1275078137-21139-1-git-send-email-maximlevitsky@gmail.com> <20100621155313.GA1447@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41203 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756416Ab0FVMGg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jun 2010 08:06:36 -0400
Content-Disposition: inline
In-Reply-To: <20100621155313.GA1447@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59-kernel@srcf.ucam.org>

On Mon, Jun 21, 2010 at 05:53:15PM +0200, Pavel Machek wrote:
> On Fri 2010-05-28 23:22:16, Maxim Levitsky wrote:
> > Although this is clear violation of ACPI spec. the other OS does that...
> >
> 
> So you are adding bugs... what about having them optional, probably
> quirk-driven?

What's the benefit of having an incomplete quirk table over just doing 
what the hardware expects?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
