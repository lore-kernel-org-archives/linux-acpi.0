From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND] [PATCH] fujitsu-laptop: better handling of P8010
	hotkey events
Date: Thu, 9 Oct 2008 01:13:15 -0400
Message-ID: <20081009051314.GC11477@anvil.corenet.prv>
References: <200810090106.m99168bI030891@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:30716 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbYJIFNT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Oct 2008 01:13:19 -0400
Received: by wx-out-0506.google.com with SMTP id h27so988873wxd.4
        for <linux-acpi@vger.kernel.org>; Wed, 08 Oct 2008 22:13:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200810090106.m99168bI030891@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Hi Jonatan,

On Thu, Oct 09, 2008 at 10:36:08AM +0930, Jonathan Woithe wrote:
> Hi Len
> 
> Another resend in case this has been lost for some reason.
> 
> 
> This patch (mostly from Peter Gruber) against 2.6.27-rc4 (but with the
> interim P8010 patch from 2.6.27-rc6 applied) improves the handling of the
> hotkeys for P8010 laptops by passing more accurate input events back to
> userspace.  This is needed because the P8010 labels these buttons quite
> differently to earlier laptops.  As part of this, a P8010-specific DMI
> callback check has been implemented.

How about implementing getkeycode() and setkeycode() methods in the
driver and then using HAL to load appropriate keymap?

-- 
Dmitry
