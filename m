From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Question of " 202317a : ACPI / scan: Add acpi_device objects for all device nodes in the namespace" commit
Date: Wed, 03 Sep 2014 23:45:46 +0200
Message-ID: <2732790.G3YqdG8end@vostro.rjw.lan>
References: <54052305.9060308@jp.fujitsu.com> <1936799.NYvsvtc9DH@vostro.rjw.lan> <5406796A.30303@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59102 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756622AbaICV00 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 17:26:26 -0400
In-Reply-To: <5406796A.30303@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com, rafael@kernel.org, linux-acpi@vger.kernel.org

On Wednesday, September 03, 2014 11:14:02 AM Yasuaki Ishimatsu wrote:
> Hi Rafael,

Hi,

> Thank you for your explanation.
> 
> (2014/09/03 6:29), Rafael J. Wysocki wrote:
> > On Tuesday, September 02, 2014 10:53:09 AM Yasuaki Ishimatsu wrote:
> >> Hi Rafael,
> >
> > Hi,
> >
> >> Why is _SUN method decoded and the sun sysfs created even if _STA reports
> >> that the device is not present and not functional?
> >
> > sun sysfs is created for stuff that has _SUN.  It should be empty for devices
> > that aren't present, though, apparently.
> >
> >> By this commit, "202317a : ACPI / scan: Add acpi_device objects for all
> >> device nodes in the namespace", all device nodes in the namespace are
> >> shown under /sys/bus/acpi/devices direcotry even if the devices are not
> >> present and not functional.
> >>
> >> But ACPI specification says against return value information of _STA:
> >> A device can only decode its hardware resources if both bits 0 and 1 are set.
> >> If the device is not present (bit 0 cleared) or not enabled (bit 1 cleared),
> >> then the device must not decode its resources.
> >
> > But _SUN is not about hardware resources, is it?
> 
> I think so. But ACPI spec does not define what the hardware resources are.
> So someone says _SUN is about hardware resrouces.

Well, that is a very far fetched interpretation that I can't see any kind of
support for in the spec or elsewhere.

Nevertheless, it is not required that the return value of _SUN be the same
every time it is evaluated, so caching it is questionable.

> >
> >> In my understanding, when the device is not present and not functional,
> >> _SUN of the device must not be decoded. Is my understanding worng?
> >
> > If my understanding of the _INI section of the spec is correct, you have a
> > point, but the dependency is rather indirect as far as I can say.  If the
> > device is not present, we are not supposed to execute _INI for it and _SUN
> > can only be executed after _INI.
> 
> I know the spec. According to the _INI section of the spec, it says:
> 
> "If the _STA method indicates that the device is not present and is not
> functional, OSPM will not run the _INI and will not examine the children
> of the device for _INI methods."
> 
> In my understanding, if a device has both _SUN and _INI method, and _STA
> method indicates that the deviceis not present and is not functional,
> _SUN method cannot be executed.
> 
> If a device has _SUN method and does not have _INI method, and _STA
> method indicates that the deviceis not present and is not functional,
> can we execute _SUN method?

I'd think so.  I don't see anything preventing us from doing that in the spec.

Rafael

