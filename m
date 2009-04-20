From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: drivers for Lenovo 3000 series?
Date: Tue, 21 Apr 2009 03:12:36 +0800
Message-ID: <037F493892196B458CD3E193E8EBAD4F13C826BA@pdsmsx502.ccr.corp.intel.com>
References: <d0cc17060904120051h11e44079u5cf8174466b4e71e@mail.gmail.com>
	 <1239586069.5564.9.camel@localhost.localdomain>
	 <d0cc17060904141231k6613d79cldbb124162b3f57f7@mail.gmail.com>
	 <20090414193340.GA8304@srcf.ucam.org>
	 <d0cc17060904141252q721daf9cp1f3a6a6667394f9a@mail.gmail.com>
	 <1239759896.7661.302.camel@rzhang-dt>
	 <d0cc17060904180417i2cec7ebckddf31bed36606cde@mail.gmail.com>
	 <1240205713.7661.416.camel@rzhang-dt>
 <d0cc17060904201121q5dbeb92g90d168ae1e93ef7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56337 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753602AbZDTTMw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Apr 2009 15:12:52 -0400
In-Reply-To: <d0cc17060904201121q5dbeb92g90d168ae1e93ef7a@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andika Triwidada <andika@startrek.or.id>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

This is a duplicate of bug http://bugzilla.kernel.org/show_bug.cgi?id=13048
So, no need to create a new bug report.

Thanks,
rui

>-----Original Message-----
>From: Andika Triwidada [mailto:andika@startrek.or.id]
>Sent: Tuesday, April 21, 2009 2:22 AM
>To: Zhang, Rui
>Cc: Matthew Garrett; Zhao, Yakui; linux-acpi@vger.kernel.org
>Subject: Re: drivers for Lenovo 3000 series?
>
>On Mon, Apr 20, 2009 at 12:35 PM, Zhang Rui <rui.zhang@intel.com> wrote:
>> On Sat, 2009-04-18 at 19:17 +0800, Andika Triwidada wrote:
>>> using latest (?) git tree (my network link is quite slow, latest I
>>> have is v2.6.30-rc1)
>>> is worst, no /sys/class/backlight
>>>
>>> furthermore,
>>
>> please apply this patch
>> http://marc.info/?l=linux-kernel&m=123982845406021&w=2
>> on top of 2.6.30-rc1 and see if /sys/class/backlight/acpi_video0/ comes
>> back again.
>
>Yes, it does come back
>
>>
>> If it doesn't help, please file a new bug report at
>> http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
>> so that we can track this bug better.
>>
>> thanks,
>> rui
>
>No need to file bug report then?
>
>--
>andika
