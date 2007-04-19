From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: HP nx8220 psmouse vs ACPI at boot up
Date: Thu, 19 Apr 2007 09:08:18 -0400
Message-ID: <d120d5000704190608kcf76f87p832d870af1bf737a@mail.gmail.com>
References: <1176986698.1231.390.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:3022 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S637744AbXDSNIT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Apr 2007 09:08:19 -0400
Received: by wr-out-0506.google.com with SMTP id 76so598379wra
        for <linux-acpi@vger.kernel.org>; Thu, 19 Apr 2007 06:08:19 -0700 (PDT)
In-Reply-To: <1176986698.1231.390.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi <linux-acpi@vger.kernel.org>, kssingvo@suse.de

Hi Thomas,

On 4/19/07, Thomas Renninger <trenn@suse.de> wrote:
> Hi,
>
> I first thought it's the "unload psmouse" or "cleanup psmouse ports"
> at shutdown problem again.
>
> I think this time EC gets confused at boot time.
> Compiling psmouse as module helps again.
>
> Symptom:
> AC adapter status is wrong if booted with AC unplugged.
> Replugging helps.
> This sounds like a minor bug, but ACPI errors at other places
> with AE_TIME errors also happen and theoretically all kind of
> ACPI breakage could happen...
>
> I can reproduce this with a 2.6.18 and a 2.6.16 kernel.
> Latest 2.6.21-rc7 does not show the problem.
> I wonder whether this really got fixed or whether this
> is just because psmouse gets activated at some earlier or later
> time because of other changes in the kernel.
>

I don't think so, unless you changed your .config.

> This looks a bit related to the
> "Could the k8temp driver be interfering with ACPI"
> discussion. It seems as if mouse ports should not get touched
> when ACPI is accessing the EC on HP laptops (and others?) in general?
>
> I can't access the machine anymore, I possibly can have it for
> some more tests.
> I just want to point out that there still could be trouble.
>
>   Thomas
>
> I thought that attached patch helps (exclude psmouse init and ACPI
> interpreter). But it seems that not.

You want to take the lock in psmouse_connect() and
psmouse_disconnect() and bunch of other places. Because all probing
work is offloaded to kseriod you did not really change anything when
protecting psmouse_init.

-- 
Dmitry
