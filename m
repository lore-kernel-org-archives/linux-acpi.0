From: Hans de Goede <j.w.r.degoede@hhs.nl>
Subject: Re: [lm-sensors] The new thermal management sysfs class, and hwmon
Date: Fri, 22 Feb 2008 11:54:06 +0100
Message-ID: <47BEA9CE.7030802@hhs.nl>
References: <20080203022622.GA995@khazad-dum.debian.net>	 <1202031072.3042.54.camel@acpi-sony.sh.intel.com>	 <20080203164410.GL20687@jupiter.solarsys.private>	 <20080203175006.GB9159@khazad-dum.debian.net>	 <05B550FD4BD2014E841D83547B626008029899FE@bgsmsx411.gar.corp.intel.com>	 <20080205135725.GO20687@jupiter.solarsys.private>	 <05B550FD4BD2014E841D83547B626008029BF29B@bgsmsx411.gar.corp.intel.com>	 <1202915450.7977.607.camel@queen.suse.de>	 <20080214140855.GB12412@srcf.ucam.org>	 <1203659229.3210.45.camel@localhost.localdomain>  <47BE8105.30301@hhs.nl> <1203669206.3210.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from frosty.hhs.nl ([145.52.2.15]:41375 "EHLO frosty.hhs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755536AbYBVLA6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Feb 2008 06:00:58 -0500
Received: from exim (helo=frosty)
	by frosty.hhs.nl with local-smtp (Exim 4.62)
	(envelope-from <j.w.r.degoede@hhs.nl>)
	id 1JSVe8-0001vU-Td
	for linux-acpi@vger.kernel.org; Fri, 22 Feb 2008 12:00:53 +0100
In-Reply-To: <1203669206.3210.68.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Thomas, Sujith" <sujith.thomas@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Len Brown <lenb@kernel.org>, Richard Hughes <hughsient@gmail.com>

Zhang, Rui wrote:
> Hi, Hans,
> 
> On Fri, 2008-02-22 at 16:00 +0800, Hans de Goede wrote:
> 
>> I think all that is really needed and asked for is for the new thermal
>> ACPI
>> code to:
>> 1) provide temp readings in the same format as hwmon (so milli degrees
>> celcius,
>> not degrees celcius
> Agree.
>> 2) provide a hwmon interface so that tools like (but not limited too):
>> * net-snmp
>> * mrtg
>> * sensors
>> * sensors-applet (gnome)
>> * xfce-sensors-applet
>> * ksysguard
>> * ksensors
>> * gkrellm
>>
>> Can provide temp and fan readings without having to be modified.
> hmm, for fan device, maybe something like this?
> pwm[1-*]_enable = 1 : manual fan control (using pwm[1-*])
> 		  2+: automatic fan control (by acpi thermal driver)
> pwm[1-*] = 0  : fan is off.
> pwm[1-*] = 255: fan is on.
> pwm[1-*] has only two valid values as ACPI fan only support 
> two states, ON/OFF. and it doesn't need fan[1-*]_input because the fan
> speed is not available.
> Yes, it can work for ACPI fan although I don't think the existing pwm
> hwmon I/F maps well to what we need and it seems like a "forced fit" to
> use it. Any better ideas? :)
> 

I wouldn't expose a pwm interface, doing so isn't that important as none of the 
above listed apps actually use it, the pwm interface really only is for people 
who want to manually tweak their fan speed and / or use some scripts to control 
the fan speed based on temp when the hardware doesn't support it, as such it 
doesn't get widely used, also since there isn't a really good mapping between 
acpi thermalzone stuff and the hwmon pwm interface I wouldn't add a pwm 
interface to a hwmon interface the the thermal zone code.

And if fan speeds aren't available (aren't they?) then I would only add a hwmon 
  class reference to a sysfs dir containing tempX_input's and a name atrribute 
and leave it at that.

But thats just my 2 euro-cents

Regards,

Hans

