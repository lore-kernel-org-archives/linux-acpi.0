From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] hwmon: (asus_atk0110) Don't load if ACPI  resources
 aren't enforced
Date: Tue, 30 Mar 2010 21:47:32 +0200
Message-ID: <20100330214732.42f488ba@hyperion.delvare>
References: <20100309135636.373a40a9@hyperion.delvare>
	<20100330120319.627e8f9a@hyperion.delvare>
	<20100330132132.GA16657@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bamako.nerim.net ([62.4.17.28]:57326 "EHLO bamako.nerim.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144Ab0C3Trf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Mar 2010 15:47:35 -0400
In-Reply-To: <20100330132132.GA16657@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, Len Brown <lenb@kernel.org>

Hi Matthew,

On Tue, 30 Mar 2010 14:21:32 +0100, Matthew Garrett wrote:
> On Tue, Mar 30, 2010 at 12:03:19PM +0200, Jean Delvare wrote:
> > ACPI people,
> > 
> > Do you have any objection to the patch below, or can I push it upstream?
> 
> If you pass that boot option, you're already indicating that you don't 
> care about multiple things accessing the same resources simultaneously. 
> I think it's reasonable to leave things up to the user to configure at 
> that point.

The asus_atk0110 driver loads automatically. The user doesn't configure
anything, and it just loads. That's the problem. If the driver didn't
load automatically, I wouldn't care. If you know of any way to prevent
the asus_atk0110 driver from auto-loading as soon as
acpi_enforce_resouce=lax or =no is passed, I am fine with this as well.
This is what I wanted to do originally, but I couldn't find a way to do
it, which is why I went for the more radical option of preventing the
asus_atk0110 driver from loading.

Thanks,
-- 
Jean Delvare
