From: Joshua Wise <joshua@joshuawise.com>
Subject: Re: [PATCH 3/5] tc1100-wmi: Add driver for HP Compaq TC1100 Tablets
Date: Wed, 12 Dec 2007 02:26:24 -0500 (EST)
Message-ID: <Pine.LNX.4.63.0712120224340.19698@dashnine.joshuawise.com>
References: <200712120201.45478.carlos@strangeworlds.co.uk>
 <200712120208.46400.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 18.208-100-46.steadfast.net ([208.100.46.18]:45840 "EHLO
	dev.x-plane.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754618AbXLLHvh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Dec 2007 02:51:37 -0500
In-Reply-To: <200712120208.46400.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

On Wed, 12 Dec 2007, Carlos Corbacho wrote:
> +	case TC1100_INSTANCE_BLUETOOTH:
> +		*out = (tmp == 1) ? 1 : 0;
> +		return 0;

This doesn't actually control Bluetooth.  This controls whether the jog dial
is in normal mode or brightness select mode.

joshua
