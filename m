From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH 4/4] gma500: opregion and ACPI
Date: Thu, 3 May 2012 09:15:23 +0100
Message-ID: <CAPM=9tw3+tz1Bd7kimQcyehhQ6UjJ=hH0M5_JGSOX5kVDncn6g@mail.gmail.com>
References: <20120501133037.1682.58297.stgit@bluebook>
	<20120501133223.1682.73707.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:33796 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752647Ab2ECIPY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 May 2012 04:15:24 -0400
Received: by ghrr11 with SMTP id r11so1505162ghr.19
        for <linux-acpi@vger.kernel.org>; Thu, 03 May 2012 01:15:24 -0700 (PDT)
In-Reply-To: <20120501133223.1682.73707.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

On Tue, May 1, 2012 at 2:33 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> From: Alan Cox <alan@linux.intel.com>
>
> Add the opregion support and bring us in line with the opregion functionality in the
> reference driver code. We can't share this with i915 currently because there are
> hardcoded assumptions about dev_priv etc in both versions.

This isn't applying to my -next tree cleanly, do I need some previous patches?

I saw some acpi video ones going by but I wasn't sure what tree they
were to be merged via.

Dave.
