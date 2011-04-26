From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: Re: power_meter driver location
Date: Tue, 26 Apr 2011 10:44:54 -0700
Message-ID: <20110426174454.GC22189@tux1.beaverton.ibm.com>
References: <20110426182543.0c102e55@endymion.delvare>
Reply-To: djwong@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:51868 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757538Ab1DZRpO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Apr 2011 13:45:14 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3QHSjdw017732
	for <linux-acpi@vger.kernel.org>; Tue, 26 Apr 2011 11:28:45 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p3QHjrb8069356
	for <linux-acpi@vger.kernel.org>; Tue, 26 Apr 2011 11:45:53 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p3QHipjD015606
	for <linux-acpi@vger.kernel.org>; Tue, 26 Apr 2011 11:44:51 -0600
Content-Disposition: inline
In-Reply-To: <20110426182543.0c102e55@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>

On Tue, Apr 26, 2011 at 06:25:43PM +0200, Jean Delvare wrote:
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

I don't have a problem with either; if I had to choose I'd pick the first
option.

--D
> 
> -- 
> Jean Delvare
