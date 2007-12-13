From: Joshua Wise <joshua@joshuawise.com>
Subject: Re: [PATCH 3/5] tc1100-wmi: Add driver for HP Compaq TC1100 Tablets
Date: Thu, 13 Dec 2007 16:06:18 -0500 (EST)
Message-ID: <Pine.LNX.4.63.0712131606060.19698@dashnine.joshuawise.com>
References: <200712120201.45478.carlos@strangeworlds.co.uk>
 <200712120208.46400.carlos@strangeworlds.co.uk>
 <Pine.LNX.4.63.0712120224340.19698@dashnine.joshuawise.com>
 <200712131641.46641.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 18.208-100-46.steadfast.net ([208.100.46.18]:37473 "EHLO
	dev.x-plane.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755731AbXLMVG0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Dec 2007 16:06:26 -0500
In-Reply-To: <200712131641.46641.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On Thu, 13 Dec 2007, Carlos Corbacho wrote:
> Is this a mistake then from the original tc1100-wmi (the 'bluetooth' file
> never controlled bluetooth, it always controlled the jog dial), or a mistake
> in my patch (it should control bluetooth, but is changing the jog dial
> instead)?

This is, as far as I know, a mistake in the original tc1100-wmi.

joshua

>
> -Carlos
> -- 
> E-Mail: carlos@strangeworlds.co.uk
> Web: strangeworlds.co.uk
> GPG Key ID: 0x23EE722D
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
