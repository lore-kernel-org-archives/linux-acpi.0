From: Frans Pop <elendil@planet.nl>
Subject: [Bug 13865] Can only resume with HP_WMI selected on compaq nc6000 when 4c395bdd3f2ca8f7e8efad881e16071182c3b8ca is reverted
Date: Wed, 29 Jul 2009 23:31:32 +0200
Message-ID: <200907292331.34214.elendil@planet.nl>
References: <bug-13865-10028@http.bugzilla.kernel.org/> <200907292257.41573.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpm-eml104.kpnxchange.com ([195.121.3.8]:59184 "EHLO
	CPSMTPM-EML104.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753768AbZG2Vbf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jul 2009 17:31:35 -0400
In-Reply-To: <200907292257.41573.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: cedric@belbone.be
Cc: bugzilla-daemon@bugzilla.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Wednesday 29 July 2009, Rafael J. Wysocki wrote:
> On Wednesday 29 July 2009, you wrote:
> > Just for testing I enabled HP_WMI. But from then, I could not resume
> > anymore. I just reverted the last git commit on the
> > 'drivers/platform/x86/hp-wmi.c' code
> > (4c395bdd3f2ca8f7e8efad881e16071182c3b8ca) and now I can resume. The
> > problem still persists on .31-rc serie
>
> Frans, that's something for you to take care of.

I'll at least give it a try.

Cedric, as a start, can you please provide the output of the following 
commands after the system is booted and with hp-wmi loaded:
$ grep . /sys/devices/platform/hp-wmi/*
$ ls -l /dev/input/*
$ cat /proc/bus/input/devices

Does an unload and reload of the module work correctly? What gets output 
in dmesg by that?

The strange thing is that the resume function does not do anything that's 
not also done in hp_wmi_input_setup(). The only thing I can think of is 
that we might need to test for wmi_has_guid(HPWMI_EVENT_GUID) because 
that model simply does not support input events.

Cheers,
FJP
