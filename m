From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: als driver build error
Date: Thu, 03 Sep 2009 11:10:11 +0800
Message-ID: <1251947411.3483.272.camel@rzhang-dt>
References: <d3f22a0909022006v64473b58l231e9a7213f2e834@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22026 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753963AbZICDMp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Sep 2009 23:12:45 -0400
In-Reply-To: <d3f22a0909022006v64473b58l231e9a7213f2e834@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <lin@minggr.cn>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

You're building the -next tree, aren't you?

please refer to this thread,
http://patchwork.kernel.org/patch/44989/

thanks,
rui

On Thu, 2009-09-03 at 11:06 +0800, Lin Ming wrote:
> drivers/acpi/als.c: In function =E2=80=98acpi_als_get_mappings=E2=80=99=
:
> drivers/acpi/als.c:173: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98PREFIX=E2=80=99
> drivers/acpi/als.c: In function =E2=80=98acpi_als_add=E2=80=99:
> drivers/acpi/als.c:347: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98PREFIX=E2=80=99
> make[2]: *** [drivers/acpi/als.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [drivers/acpi] Error 2

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
