From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] x86: Allow MMCONFIG above 4GB on x86_64
Date: Sun, 13 Jul 2008 17:36:18 +0200
Message-ID: <87r69xzthp.fsf@basil.nowhere.org>
References: <20080709204127.1458.5727.77728@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out04.alice-dsl.net ([88.44.63.6]:50493 "EHLO
	smtp-out04.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700AbYGMPgV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Jul 2008 11:36:21 -0400
In-Reply-To: <20080709204127.1458.5727.77728@attica.americas.sgi.com> (John Keller's message of "Wed,  9 Jul 2008 15:41:27 -0500 (CDT)")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Keller <jpk@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, takayoshi.kochi@gmail.com

John Keller <jpk@sgi.com> writes:
>
> A similar patch was submitted over a year ago, but apparently was not
> merged in.

There's no reason at all to make this 64bit only. A PAE 32bit kernel
can also access data above 4GB. So an ifdef is the wrong way.

The reason the check is there is that there are lots of 
x86 BIOS that report wrong mmconfig and this way there's another
sanity check.

You'll need either to find a way to preserve this check
on kernels not running on your system or show that the 
sanity check is not needed anymore. The later would 
be likely tricky.

-Andi

