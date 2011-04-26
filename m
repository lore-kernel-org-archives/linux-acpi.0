From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: power_meter driver location
Date: Tue, 26 Apr 2011 10:54:08 -0700
Message-ID: <1303840448.31666.103.camel@groeck-laptop>
References: <20110426182543.0c102e55@endymion.delvare>
Reply-To: guenter.roeck@ericsson.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from imr3.ericy.com ([198.24.6.13]:50008 "EHLO imr3.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757756Ab1DZR6g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Apr 2011 13:58:36 -0400
In-Reply-To: <20110426182543.0c102e55@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Darrick J. Wong" <djwong@us.ibm.com>

On Tue, 2011-04-26 at 12:25 -0400, Jean Delvare wrote:
> Hi Len, hi all,
> 
> Currently the ACPI power meter driver lives in drivers/acpi, and
> depends on HWMON. I don't think it makes sense because, in the
> configuration menu, the user sees the ACPI options first, and HWMON
> comes later, so if HWMON is disabled, the user has no idea that the
> ACPI power meter driver exists. It happens that CONFIG_HWMON currently
> defaults to y so this scenario won't happen on new configurations, but
> it could still happen when people upgrade an old configuration. It
> could also happen that a user selects the ACPI power meter, then looks
> at the driver list under CONFIG_HWMON and decides that he/she doesn't
> need anything there and deselects HWMON, and disables the ACPI power
> meter driver as a result. Lastly, there is no guarantee that
> CONFIG_HWMON will default to y forever, I admit I'm unsure why it is
> that way.
> 
> I think that it would make more sense to:
> * either move the ACPI power meter driver to drivers/hwmon, and treat
>   it like any other hardware monitoring driver, with a dependency on
>   ACPI;
> * or leave the ACPI power meter driver in drivrs/acpi, but turn the
>   "depends on HWMON" into "select HWMON", so it can't be hidden or
>   unselected by accident.
> 
> Opinion anyone?
> 
Both are ok, though I would prefer the first option. If you choose the
second option, you might want to add a note to ACPI_POWER_METER,
explaining that enabling it also enables HWMON.

Guenter


