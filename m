From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Generic battery interface
Date: Fri, 28 Jul 2006 00:05:35 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601168B34@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22876 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751858AbWG1EFl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Jul 2006 00:05:41 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shem Multinymous <multinymous@gmail.com>
Cc: Pavel Machek <pavel@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org


>On 7/28/06, Brown, Len <len.brown@intel.com> wrote:
>> I'm not religious about /dev vs. /sys.

Tho I'm starting to feel like I've touched off some religion in
others:-)

>I would greatly prefer a sysfs interface.

Understood.

>Having a clean, textual sysfs API that's easily accessed from shell
>has been extremely conductive for the development of the tp_smapi
>driver -- users can easily test and script the driver without extra
>programming and userspace components. Since tp_smapi is (AFAIK) the
>most feature-rich battery driver we now have, this is some to
>consider.

> clean

well, one man's "clean" is another man's "dirty", I guess this is
subjective.

> textual

good for shell scripts, not clear it is better for C programs
that have to open a bunch of files by name.

> sysfs was great for develping tp_smapi

Wonderful, but isn't the key here how simple it is for HAL
or X to understand and use the kernel API rather than the
developers of the kernel driver that implements the API?

If X were a shell script, I'd say a file per value would
clearly be the way to go, but it isn't.

-Len
