From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [lm-sensors] [PATCH] hwmon: (asus_atk0110) Don't load if ACPI
	resources aren't enforced
Date: Tue, 30 Mar 2010 23:45:46 +0200
Message-ID: <68676e01003301445v1b3ee070nfc0f0b53716c4740@mail.gmail.com>
References: <20100309135636.373a40a9@hyperion.delvare>
	 <20100330120319.627e8f9a@hyperion.delvare>
	 <20100330132132.GA16657@srcf.ucam.org>
	 <20100330214732.42f488ba@hyperion.delvare>
	 <20100330194835.GA32322@srcf.ucam.org>
	 <20100330223251.76c6b000@hyperion.delvare>
	 <20100330211049.GA1524@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:37218 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962Ab0C3Vps (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Mar 2010 17:45:48 -0400
Received: by fxm23 with SMTP id 23so704803fxm.21
        for <linux-acpi@vger.kernel.org>; Tue, 30 Mar 2010 14:45:47 -0700 (PDT)
In-Reply-To: <20100330211049.GA1524@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jean Delvare <khali@linux-fr.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On Tue, Mar 30, 2010 at 11:10 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Tue, Mar 30, 2010 at 10:32:51PM +0200, Jean Delvare wrote:
>
>> Sure, but why do you insist on having the user configure this manually
>> when we can automate this at the kernel level? When
>> acpi_enforce_resouce=yes, the kernel doesn't let non-ACPI driver be
>> loaded, so I fail to see why we let ACPI drivers (for which we also
>> have native drivers) load when acpi_enforce_resouce=no.
>
> Because the situation with the asus driver loaded isn't obviously any
> worse than not having it loaded. The user is telling us that they're
> happy with racy access to their hwmon hardware.

"lax" option is typically used when the user wants to load the native
driver; in this case we know that it's not safe to load asus driver.

Luca
