From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Question of " 202317a : ACPI / scan: Add acpi_device objects for all device nodes in the namespace" commit
Date: Tue, 02 Sep 2014 23:29:45 +0200
Message-ID: <1936799.NYvsvtc9DH@vostro.rjw.lan>
References: <54052305.9060308@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54444 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755193AbaIBVK1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Sep 2014 17:10:27 -0400
In-Reply-To: <54052305.9060308@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com, rafael@kernel.org, linux-acpi@vger.kernel.org

On Tuesday, September 02, 2014 10:53:09 AM Yasuaki Ishimatsu wrote:
> Hi Rafael,

Hi,

> Why is _SUN method decoded and the sun sysfs created even if _STA reports
> that the device is not present and not functional?

sun sysfs is created for stuff that has _SUN.  It should be empty for devices
that aren't present, though, apparently.

> By this commit, "202317a : ACPI / scan: Add acpi_device objects for all
> device nodes in the namespace", all device nodes in the namespace are
> shown under /sys/bus/acpi/devices direcotry even if the devices are not
> present and not functional.
> 
> But ACPI specification says against return value information of _STA:
> A device can only decode its hardware resources if both bits 0 and 1 are set.
> If the device is not present (bit 0 cleared) or not enabled (bit 1 cleared),
> then the device must not decode its resources.

But _SUN is not about hardware resources, is it?

> In my understanding, when the device is not present and not functional,
> _SUN of the device must not be decoded. Is my understanding worng?

If my understanding of the _INI section of the spec is correct, you have a
point, but the dependency is rather indirect as far as I can say.  If the
device is not present, we are not supposed to execute _INI for it and _SUN
can only be executed after _INI.

> In our box, when the device is not present and not functional, _SUN method
> of the device returns wrong value. And the values is cached to
> acpi_device->pnp.sun. So when hot adding the device and changing _SUN value,
> the information is not reflected to acpi_device->pnp.sun.

I see.

> I think the issue is solved by not caching sun value. But at first, I want
> to know whether current implementation is correct or not.

No, it isn't, but there are two ways to fix it.

A short term fix would be to evaluate _STA and print an empty string in
acpi_device_sun_show() if we don't like the return value.  If we do like it,
evaluate _SUN and print the result.

A long term fix would require us to track the execution of _INI and decide
what to print on this basis (and probably avoid to execute some other methods
too if _INI has not been executed).  I'll try to do something along these lines,
but I can't promise any particular time frame, sorry about that.

KR,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
