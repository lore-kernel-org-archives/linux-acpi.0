From: Lin Ming <lin@minggr.cn>
Subject: Re: ACPI explodes in -next (ACPI video it seems)
Date: Wed, 26 Aug 2009 09:43:04 +0800
Message-ID: <d3f22a0908251843i1975c6a0n246b0fd5e1c94142@mail.gmail.com>
References: <20090825154037.675e8848@lxorguk.ukuu.org.uk>
	 <d3f22a0908251824p9711c0eie1e8609f50e5f192@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:55566 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075AbZHZBnD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Aug 2009 21:43:03 -0400
Received: by pxi12 with SMTP id 12so3867336pxi.22
        for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2009 18:43:05 -0700 (PDT)
In-Reply-To: <d3f22a0908251824p9711c0eie1e8609f50e5f192@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-acpi@vger.kernel.org, rui.zhang@intel.com

On Wed, Aug 26, 2009 at 9:24 AM, Lin Ming<lin@minggr.cn> wrote:
> On Tue, Aug 25, 2009 at 10:40 PM, Alan Cox<alan@lxorguk.ukuu.org.uk> wrote:
>>
>> Trace is during a modprobe
>>
>> strcmp of NULL pointer from
>
> Looks like the HID/UID NULL pointer issue that was fixed by
> acpi-fix-null-bug-for-hid-uid-string-2.patch in -mm tree

The original report here:
http://lkml.org/lkml/2009/7/20/422

And the patch:
http://userweb.kernel.org/~akpm/mmotm/broken-out/acpi-fix-null-bug-for-hid-uid-string-2.patch

Lin Ming
