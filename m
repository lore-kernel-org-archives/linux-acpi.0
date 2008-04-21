From: NoWhereMan <uncommonnonsense@gmail.com>
Subject: Re: [PATCH 2.6.25-rc7 001/001] ACPI: workaround for buggy BIOS to ignore error LINK CRS method
Date: Mon, 21 Apr 2008 15:13:40 +0200
Message-ID: <f7430a760804210613h69e4b560q774301a1152ef77d@mail.gmail.com>
References: <f7430a760804090842s44ece7bh216d5d28e347955@mail.gmail.com>
	 <20080409161251.0c0e73e9.akpm@linux-foundation.org>
	 <1207824057.8704.12.camel@yakui_zhao.sh.intel.com>
	 <f7430a760804100523t6483dc0cn144429ee7024a7f2@mail.gmail.com>
	 <1208267385.12372.11.camel@yakui_zhao.sh.intel.com>
	 <f7430a760804150121ndfaf065j332ebf1cee3c572@mail.gmail.com>
	 <f7430a760804151538v410f7c64m21d90cb9da8e9baa@mail.gmail.com>
	 <f7430a760804161154o77dd7fc5g622d3bbe4fa1183b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:21381 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757134AbYDUNNn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Apr 2008 09:13:43 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1320726wxd.4
        for <linux-acpi@vger.kernel.org>; Mon, 21 Apr 2008 06:13:40 -0700 (PDT)
In-Reply-To: <f7430a760804161154o77dd7fc5g622d3bbe4fa1183b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

patch is working; cc'ing to ML

On Wed, Apr 16, 2008 at 8:54 PM, NoWhereMan <uncommonnonsense@gmail.com> wrote:
> FYI it wasn't latest git but still rc7; I've fast-forwarded now to
>  rc9, but if no significant changes were made on that part of acpi I'm
>  sure it will work anyway
>
>
>
>  On Wed, Apr 16, 2008 at 12:38 AM, NoWhereMan <uncommonnonsense@gmail.com> wrote:
>  > hi Zhao,
>  >
>  >  I've applied the patch to latest linus git, boot went flawlessly
>  >  (except the usual error messages about _CRS method) and both wireless
>  >  and USB work, so I'm assuming it worked.
>  >
>  >  I'm attaching my dmesg just for reference. I've enabled ACPI debugging
>  >  in my kernel config.
>  >
>  >  thank you a lot for your efforts with this bug
>  >
>  >
>  >
>  >  On Tue, Apr 15, 2008 at 10:21 AM, NoWhereMan <uncommonnonsense@gmail.com> wrote:
>  >  > On Tue, Apr 15, 2008 at 3:49 PM, Zhao Yakui <yakui.zhao@intel.com> wrote:
>  >  >
>  >  >  >  Will you please try the workaround patch and see whether the problem can
>  >  >  >  be fixed?
>  >  >  >  Thanks.
>  >  >
>  >  >  I will as soon as possible, thank you for your efforts!
>  >  >
>  >
>
