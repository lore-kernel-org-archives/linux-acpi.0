From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 3/5] tc1100-wmi: Add driver for HP Compaq TC1100 Tablets
Date: Thu, 13 Dec 2007 16:41:46 +0000
Message-ID: <200712131641.46641.carlos@strangeworlds.co.uk>
References: <200712120201.45478.carlos@strangeworlds.co.uk> <200712120208.46400.carlos@strangeworlds.co.uk> <Pine.LNX.4.63.0712120224340.19698@dashnine.joshuawise.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:48711 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762443AbXLMQn0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Dec 2007 11:43:26 -0500
In-Reply-To: <Pine.LNX.4.63.0712120224340.19698@dashnine.joshuawise.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joshua Wise <joshua@joshuawise.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On Wednesday 12 December 2007 07:26:24 Joshua Wise wrote:
> On Wed, 12 Dec 2007, Carlos Corbacho wrote:
> > +	case TC1100_INSTANCE_BLUETOOTH:
> > +		*out = (tmp == 1) ? 1 : 0;
> > +		return 0;
>
> This doesn't actually control Bluetooth.  This controls whether the jog
> dial is in normal mode or brightness select mode.

Is this a mistake then from the original tc1100-wmi (the 'bluetooth' file 
never controlled bluetooth, it always controlled the jog dial), or a mistake 
in my patch (it should control bluetooth, but is changing the jog dial 
instead)?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
