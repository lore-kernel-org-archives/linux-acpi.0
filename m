From: Jean Delvare <khali@linux-fr.org>
Subject: Re: CONFIG_THERMAL_HWMON in thermal_sys.c
Date: Tue, 11 Sep 2012 11:03:35 +0200
Message-ID: <20120911110335.68009452@endymion.delvare>
References: <4D68720C2E767A4AA6A8796D42C8EB591B6F8F@BGSMSX101.gar.corp.intel.com>
	<20120911091204.24fd1510@endymion.delvare>
	<4D68720C2E767A4AA6A8796D42C8EB591B7261@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:48494 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab2IKJDz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Sep 2012 05:03:55 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591B7261@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org

On Tue, 11 Sep 2012 08:55:34 +0000, R, Durgadoss wrote:
> > -----Original Message-----
> > From: Jean Delvare [mailto:khali@linux-fr.org]
> > * Extend libsensors to be able to deal with thermal drivers directly.
> >   If thermal devices are presented with a reasonable sysfs interface,
> >   then why not.
> (...)
> Now that I know about sensors/libsensors, if the purpose of using
> this #define is to expose the thermal zones to 'sensors' command,
> then I think it's better we go with your third option (above), since
> we have the sysfs interfaces standardized (/sys/class/thermal/)

Is there a document describing this sysfs interface?

Will you write and submit the required libsensors patches, or do you
expect me to take care of that?

Note: if the same device can now be registered as both hwmon and
thermal, we will have to find a way to detect that to avoid duplicate
entries in libsensors.

-- 
Jean Delvare
