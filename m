From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] hwmon: (asus_atk0110) Don't load if ACPI  resources
	aren't enforced
Date: Tue, 30 Mar 2010 20:48:36 +0100
Message-ID: <20100330194835.GA32322@srcf.ucam.org>
References: <20100309135636.373a40a9@hyperion.delvare> <20100330120319.627e8f9a@hyperion.delvare> <20100330132132.GA16657@srcf.ucam.org> <20100330214732.42f488ba@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47833 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab0C3Tsi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Mar 2010 15:48:38 -0400
Content-Disposition: inline
In-Reply-To: <20100330214732.42f488ba@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-acpi@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, Len Brown <lenb@kernel.org>

On Tue, Mar 30, 2010 at 09:47:32PM +0200, Jean Delvare wrote:

> The asus_atk0110 driver loads automatically. The user doesn't configure
> anything, and it just loads. That's the problem. If the driver didn't
> load automatically, I wouldn't care. If you know of any way to prevent
> the asus_atk0110 driver from auto-loading as soon as
> acpi_enforce_resouce=lax or =no is passed, I am fine with this as well.
> This is what I wanted to do originally, but I couldn't find a way to do
> it, which is why I went for the more radical option of preventing the
> asus_atk0110 driver from loading.

echo blacklist asus_atk0110 >/etc/modprobe.d/hwmon_blacklist.conf

-- 
Matthew Garrett | mjg59@srcf.ucam.org
