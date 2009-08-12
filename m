From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH]AC/DC notifier
Date: Wed, 12 Aug 2009 01:55:32 +0100
Message-ID: <20090812005532.GA31003@srcf.ucam.org>
References: <FFAE0590FF35E441901B67BD8BA62E950245ABD9@storexmb3.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57968 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbZHLAze (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Aug 2009 20:55:34 -0400
Content-Disposition: inline
In-Reply-To: <FFAE0590FF35E441901B67BD8BA62E950245ABD9@storexmb3.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Tippett, Matthew" <Matthew.Tippett@amd.com>
Cc: "Langsdorf, Mark" <mark.langsdorf@amd.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Li, Samuel" <Samuel.Li@amd.com>

On Tue, Aug 11, 2009 at 08:51:49PM -0400, Tippett, Matthew wrote:

>    From a graphics perspective (your area of expertise), this will allow KMS
>    drivers to do some more intelligent actions based on the ac/dc state. 
>    Some examples of this could be improving the power consumption of the
>    graphics hardware through adapting clock memory/engine settings for
>    reduced power consumption, reducing refresh rate of the display to reduce
>    scanout memory access, adjusting backlight brightness, etc.

Right. As you say, my concern is that most of this should belong in 
userspace. Where we risk hardware damage there's an obvious argument for 
doing this in kernel, but we should ensure that that's limited to 
whatever coarse-grain handling is absolutely required rather than doing 
things like touching display brightness.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
