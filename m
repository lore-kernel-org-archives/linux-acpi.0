From: Phil Endecott <phil_hmpau_endecott@chezphil.org>
Subject: Re: Toggling VGA out on Eee 901
Date: Wed, 17 Sep 2008 11:52:37 +0100
Message-ID: <48D0E175.4080107@chezphil.org>
References: <1221601392651@dmwebmail.dmwebmail.chezphil.org>
	<1221630423.3441.147.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from japan.chezphil.org ([77.240.5.4]:5044 "EHLO japan.chezphil.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbYIQKwl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Sep 2008 06:52:41 -0400
Received: from localhost ([127.0.0.1] helo=chezphil.org)
	by japan.chezphil.org with esmtp (Exim 4.69)
	(envelope-from <phil_hmpau_endecott@chezphil.org>)
	id 1KfueF-0004hV-Lt
	for linux-acpi@vger.kernel.org; Wed, 17 Sep 2008 11:52:39 +0100
In-Reply-To: <1221630423.3441.147.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Hi Rui,

Zhang Rui wrote:
> Hi, phil,
>=20
> On Tue, 2008-09-16 at 22:43 +0100, Phil Endecott wrote:
>> Dear Experts,
>>
>> I'm trying to work out how to get console video out toggling working=
 on=20
>> my ASUS EEE 901 (running Debian).  I get the feeling that I may be t=
he=20
>> first person to try to do this, and I knew almost nothing about ACPI=
=20
>> until a couple of hours ago.  Can anyone help?
>> Output toggling for X works fine, but that doesn't use ACPI.

> =EF=BB=BFwell, ACPI control method for video output switching seldom =
works.
> And we use xrandr to switch the display in X.
> I'm not sure but I'm afraid we don't have the plan to support video
> output switch in console mode.

As far as I can see, the code already exists in the kernel to support=20
this.  The problem is that this BIOS doesn't define the necessary=20
methods (unless I've misunderstood something).  When you say "don't pla=
n=20
to support", do you mean that the existing kernel functionality is now=20
deprecated, or something?

Thanks,  Phil.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
