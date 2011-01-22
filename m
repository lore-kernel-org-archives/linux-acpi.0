From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to iomaps management
Date: Sat, 22 Jan 2011 13:54:49 +0800
Message-ID: <AANLkTimEoAhO9TRx4Aq7NnTTt6G-u+cHJRyAMjSAJgTm@mail.gmail.com>
References: <201101201226.41021.rjw@sisk.pl>
	<201101210104.43641.rjw@sisk.pl>
	<AANLkTi=3JZUa3AtfcxnSuS36ORZLbS2-M+fJAR6_Moof@mail.gmail.com>
	<201101212206.37469.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50964 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab1AVFyu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Jan 2011 00:54:50 -0500
In-Reply-To: <201101212206.37469.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

2011/1/22 Rafael J. Wysocki <rjw@sisk.pl>:
> On Friday, January 21, 2011, Jeff Chua wrote:
>> 2011/1/21 Rafael J. Wysocki <rjw@sisk.pl>:
>> > Thanks, but unfortunately this wasn't conclusive. =A0Please apply =
the patch below
>> > instead of the previous one (on top of [1/11] - [11/11]) and colle=
ct dmesg
> So, below is a replacement for [11/11]. =A0Please test it on top of
> [1/11] - [10/11] (the current Linus' tree already contains [1/11] and=
 [2/11])
> and let me know if it works for you (in either case, please attach dm=
esg
> output containing a suspend attempt).
>
> If it works, I'll remove the diagnostic messages and submit along wit=
h the
> rest of the patchset.

Rafael,

dmesg attached. This time, it worked!

I discovered CONFIG_THINKPAD_ACPI caused suspend-to-disk to hang. I
need the Thinkpad ACPI to control the fan and bluetooth. It looks like
the thinkpad acpi is trying acquire locks while suspending.  Disabling
cmos, light, led and hotkeys makes suspend-to-disk works again.

Thanks,
Jeff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
