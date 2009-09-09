From: Lin Ming <lin@minggr.cn>
Subject: Re: Index is beyond end of object; Method parse/execution failed
Date: Wed, 9 Sep 2009 10:31:27 +0800
Message-ID: <d3f22a0909081931i5c71a804yc2cb405f9b050ea2@mail.gmail.com>
References: <1252437365.5669.14.camel@simon-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f177.google.com ([209.85.216.177]:57373 "EHLO
	mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbZIIDAA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Sep 2009 23:00:00 -0400
Received: by pxi7 with SMTP id 7so3869355pxi.1
        for <linux-acpi@vger.kernel.org>; Tue, 08 Sep 2009 20:00:03 -0700 (PDT)
In-Reply-To: <1252437365.5669.14.camel@simon-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: skitching@apache.org
Cc: linux-acpi@vger.kernel.org

On Wed, Sep 9, 2009 at 3:16 AM, Simon Kitching<skitching@apache.org> wrote:
> Hi All,
>
> Suspend-to-mem and resume seem to work fine, but I get a few odd ACPI
> messages in dmesg. Is this of interest to anyone?
>
> [  188.914261] ACPI Exception: AE_AML_PACKAGE_LIMIT, Index (000000005)
> is beyond end of object 20090521 exoparg2-445
> [  188.914278] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.C248] (Node f701a6d8), AE_AML_PACKAGE_LIMIT
> [  188.914344] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.C002.C0DE.C354._STM] (Node f701d780), AE_AML_PACKAGE_LIMIT
> [  188.914415] ata5: ACPI set timing mode failed (status=0x300b)
>
>
> Kernel: 2.6.31-rc9
> Distro: ubuntu 09.04
> Hardware: Compaq nc8430 laptop
> CPU: core duo T2500
>
> These messages are generated every time I run
>   echo "mem" > /sys/power/state
> although otherwise the suspend/resume seems 100% ok.
>
> I'm happy to provide more info or run tests if anyone wants me to.

Could you attach the acpidump output?

Lin Ming
