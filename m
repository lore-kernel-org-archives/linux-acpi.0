From: Luming Yu <luming.yu@gmail.com>
Subject: Re: PME via interrupt or SCI mechanism?
Date: Tue, 27 Sep 2011 23:10:53 -0400
Message-ID: <CAJRGBZyig5gfyhhPaBZotutvPhQcOi_X2vx82=+pkD8dcseRGA@mail.gmail.com>
References: <20110912171003.GA7939@xanatos>
	<20110926234835.GA9551@xanatos>
	<CAJRGBZxTakHn-BQTrLXsccriGAOERDox0pORMP+vrazzqAA-kQ@mail.gmail.com>
	<201109272232.06389.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54863 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307Ab1I1DKy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Sep 2011 23:10:54 -0400
In-Reply-To: <201109272232.06389.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, robert.moore@intel.com, Shaohua Li <shaohua.li@intel.com>

On Tue, Sep 27, 2011 at 4:32 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, September 27, 2011, Luming Yu wrote:
>> On Tue, Sep 27, 2011 at 7:48 AM, Sarah Sharp
>> <sarah.a.sharp@linux.intel.com> wrote:
>> >
>> > Ok. =C2=A0Do you have suggestions for any tests I can run or debug=
ging
>> > statements to add? =C2=A0I'm really not an ACPI expert and I've be=
en
>> > basically fumbling in the dark.
>>
>> The following patch from Shaohua might be useful to help debugging t=
he problem.
>> http://kerneltrap.org/mailarchive/linux-usb/2009/7/30/6251245
>
> You probably don't realize that the patch is neither applicable nor
> relevant any more, but it would be nice to check that before
> recommending it to anyone, don't you think?
>

As long as ACPI is involved in some aspect of the bug, I do believe
the patch I pointed out can point you to some interesting interfaces
in ACPI Linux and CA that could be useful to diagnose this type of
problem. At least it pointed out how things begun :)
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
