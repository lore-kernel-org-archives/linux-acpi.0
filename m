From: Lin Ming <lin@minggr.cn>
Subject: Re: als driver build error
Date: Thu, 3 Sep 2009 11:18:38 +0800
Message-ID: <d3f22a0909022018u3dde2bdfid62b258f3e3b4301@mail.gmail.com>
References: <d3f22a0909022006v64473b58l231e9a7213f2e834@mail.gmail.com>
	 <1251947411.3483.272.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f204.google.com ([209.85.216.204]:55571 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbZICDSg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Sep 2009 23:18:36 -0400
Received: by pxi42 with SMTP id 42so1355391pxi.20
        for <linux-acpi@vger.kernel.org>; Wed, 02 Sep 2009 20:18:38 -0700 (PDT)
In-Reply-To: <1251947411.3483.272.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

On Thu, Sep 3, 2009 at 11:10 AM, Zhang Rui<rui.zhang@intel.com> wrote:
> You're building the -next tree, aren't you?

linux-acpi-2.6/test branch.

>
> please refer to this thread,
> http://patchwork.kernel.org/patch/44989/

Build OK with this patch applied.

Thanks.
Lin Ming

>
> thanks,
> rui
>
> On Thu, 2009-09-03 at 11:06 +0800, Lin Ming wrote:
>> drivers/acpi/als.c: In function =91acpi_als_get_mappings=92:
>> drivers/acpi/als.c:173: error: expected =91)=92 before =91PREFIX=92
>> drivers/acpi/als.c: In function =91acpi_als_add=92:
>> drivers/acpi/als.c:347: error: expected =91)=92 before =91PREFIX=92
>> make[2]: *** [drivers/acpi/als.o] Error 1
>> make[2]: *** Waiting for unfinished jobs....
>> make[1]: *** [drivers/acpi] Error 2
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
