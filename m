From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Possible memory leak in function (acpi_video_init_brightness) not freeing (br->levels)
Date: Thu, 20 Nov 2014 12:52:41 -0800
Message-ID: <6365500.LpSqC8t0zh@dtor-glaptop>
References: <CAFZT-jL=2mDEQ-T69xUMGmb-MnPJAEAQbXjb8fNd=x04As7Esg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:37194 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932259AbaKTUwp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Nov 2014 15:52:45 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so3619607iec.15
        for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2014 12:52:44 -0800 (PST)
In-Reply-To: <CAFZT-jL=2mDEQ-T69xUMGmb-MnPJAEAQbXjb8fNd=x04As7Esg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ahmed Tamrawi <ahmedtamrawi@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday, November 19, 2014 08:13:13 PM Ahmed Tamrawi wrote:
> Bug Report Filed: https://bugzilla.kernel.org/show_bug.cgi?id=88531
> Linux Version [3.17-rc1]
> Configuration: Default configuration for x86
> 
> Reference to source code:
> http://lxr.free-electrons.com/source/drivers/acpi/video.c#L1033
> 
> In function (acpi_video_init_brightness) in file (drivers/acpi/video.c):
> 
> The function allocates (br->levels) pointer at line (1033) and frees
> it on some paths at line (1137). However, the problem occurs when the
> function returns from line (1134) where the pointer (br->levels) is
> not freed. Thus, causing a memory leak when the function returns from
> line (1134).

That is success path for the function and so we retain br->levels. If you
notice, we do not free 'br' itself there either.

Thanks.

-- 
Dmitry
