From: Andi Kleen <ak@linux.intel.com>
Subject: Re: Avoid critical temp shutdowns on specific ThinkPad T4x(p) and
 R50p
Date: Wed, 30 Jul 2008 09:17:48 -0700
Message-ID: <4890942C.3080007@linux.intel.com>
References: <200807301556.01815.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:62728 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752486AbYG3QRm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jul 2008 12:17:42 -0400
In-Reply-To: <200807301556.01815.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Thomas Renninger wrote:
> This came in in OpenSUSE 10.3. When we still had overriden thermal polling
> frequency (what we probably will do again soon). It has been tested that
> specific ThinkPads do not throw a thermal event when exceeding the passive
> trip point. Even thermal polling was not enough...
> As no other solution has been found meanwhile and it seems Windows is also
> using a virtual passive trip point:

Ok that would be good evidence.


> +	if (dmi_check_system(thermal_psv_dmi_table)) {
> +		if (tz->trips.passive.flags.valid &&
> +		    tz->trips.passive.temperature > CELSIUS_TO_KELVIN(85)) {
> +			printk (KERN_INFO "Adjust passive trip point from %lu"
> +				" to %lu\n",
> +				KELVIN_TO_CELSIUS(tz->trips.passive.temperature),
> +				KELVIN_TO_CELSIUS(tz->trips.passive.temperature - 150));
> +			tz->trips.passive.temperature -= 150;

The hardcoded temperature numbers make me a little uneasy. Also 85 - 150 
is potentially negative, which is probably not good?

-Andi

