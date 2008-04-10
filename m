From: NoWhereMan <uncommonnonsense@gmail.com>
Subject: Re: [PATCH 2.6.25-rc7 001/001] ACPI: workaround for buggy BIOS to ignore error LINK CRS method
Date: Thu, 10 Apr 2008 14:23:15 +0200
Message-ID: <f7430a760804100523t6483dc0cn144429ee7024a7f2@mail.gmail.com>
References: <f7430a760804090842s44ece7bh216d5d28e347955@mail.gmail.com>
	 <20080409161251.0c0e73e9.akpm@linux-foundation.org>
	 <1207824057.8704.12.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:21773 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbYDJMXS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Apr 2008 08:23:18 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3100012wxd.4
        for <linux-acpi@vger.kernel.org>; Thu, 10 Apr 2008 05:23:16 -0700 (PDT)
In-Reply-To: <1207824057.8704.12.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Thu, Apr 10, 2008 at 12:40 PM, Zhao Yakui <yakui.zhao@intel.com> wrote:
> On Wed, 2008-04-09 at 16:12 -0700, Andrew Morton wrote:

>  > That patch is about four months old.  Hopefully there was a reason why we
>  > dodn't proceed with it?
>  It seems that the system can work after applying the patch.
>  But the patch depends on the returned result(-ENODEV).
>  > if (ACPI_FAILURE(status)) {
>  >               ACPI_EXCEPTION((AE_INFO, status, "Evaluating _CRS"));
>  >                result = -ENODEV;
>   >               goto end;
>   >       }
>  Now I am writing another workaround patch about this problem.

I'll try to help, testing the new patch on my system
