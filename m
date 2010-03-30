From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] hwmon: (asus_atk0110) Don't load if ACPI  resources
	aren't enforced
Date: Tue, 30 Mar 2010 22:10:49 +0100
Message-ID: <20100330211049.GA1524@srcf.ucam.org>
References: <20100309135636.373a40a9@hyperion.delvare> <20100330120319.627e8f9a@hyperion.delvare> <20100330132132.GA16657@srcf.ucam.org> <20100330214732.42f488ba@hyperion.delvare> <20100330194835.GA32322@srcf.ucam.org> <20100330223251.76c6b000@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38888 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668Ab0C3VKx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Mar 2010 17:10:53 -0400
Content-Disposition: inline
In-Reply-To: <20100330223251.76c6b000@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-acpi@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, Len Brown <lenb@kernel.org>

On Tue, Mar 30, 2010 at 10:32:51PM +0200, Jean Delvare wrote:

> Sure, but why do you insist on having the user configure this manually
> when we can automate this at the kernel level? When
> acpi_enforce_resouce=yes, the kernel doesn't let non-ACPI driver be
> loaded, so I fail to see why we let ACPI drivers (for which we also
> have native drivers) load when acpi_enforce_resouce=no.

Because the situation with the asus driver loaded isn't obviously any 
worse than not having it loaded. The user is telling us that they're 
happy with racy access to their hwmon hardware. Automatically blocking 
the loading of the ACPI driver does nothing other than imply to the user 
that things are safe, when in reality they're anything but.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
