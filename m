From: emisca <emisca.ml@gmail.com>
Subject: Re: i810, mergedfb and lid switch and acpi video
Date: Wed, 17 Jan 2007 16:08:52 +0100
Message-ID: <414cba4e0701170708s188b72feube3b50293df201ed@mail.gmail.com>
References: <1C601A6A3344064EB423D0C1E83B717BE6FD77@pdsmsx411.ccr.corp.intel.com>
	 <1169043819.6273.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:49552 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbXAQPIy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jan 2007 10:08:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2008998uga
        for <linux-acpi@vger.kernel.org>; Wed, 17 Jan 2007 07:08:53 -0800 (PST)
In-Reply-To: <1169043819.6273.10.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: xorg@lists.freedesktop.org, linux-acpi@vger.kernel.org

I've also seen that windows vista document... perhaps it's a
requirement to pass vista certification to have the _BCQ method.
In addition when I compile the dsdt with iasl it complains about _BCQ
as unknown............ Microsoft decided to change that name and hp
followed them?
Yesterday I've seen that there is a new bios for my machine, version
F0A. Does anyone experimented with it? I will try it on the weekend...
For now I'll try to change the DSDT file, I use the patch to replace
DSDT on linux and I'll report if it works.

Regarding the lid switch, is there something I could try?

Bye

2007/1/17, Peter Clifton <pcjc2@cam.ac.uk>:
> SORRY - sent back to Luming by mistake - meant to send to all.
>
> On Wed, 2007-01-17 at 12:20 +0800, Yu, Luming wrote:
>
> > But there is NO _BQC. Instead of _BQC, there do have a _BCQ in DSDT.
> > Is this a bug of BIOS? Acpi video drvier needs _BQC to get the
> > current brightness level, and to get the next level to set on
> receiving
> > notification of 0x86 (Increase Brightness) , 0x87 (decrease
> Brightness).
>
> I can ACK that my HP had a similar typo / feature with its intel based
> video:
>
> 00:02.0 VGA compatible controller: Intel Corporation Mobile
> 945GM/GMS/940GML Express Integrated Graphics Controller (rev 03)
>
> The _BQC is absent, but a strange _BCQ is there - which looks to give
> the correct functionality.
>
> The ONLY place I can find any reference to _BCQ is in a couple of
> Windows Vista design documents about making display brightness work with
> Vista.
>
> Thank you Microsoft, for that typo - presuming thats what it is!
>
> Peter Clifton
>
>
>
