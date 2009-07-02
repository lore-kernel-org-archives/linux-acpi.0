From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Work around negative s16 battery current on Acer
Date: Thu, 2 Jul 2009 15:56:42 -0700
Message-ID: <20090702155642.0d55ee57.akpm@linux-foundation.org>
References: <4A4BA8F9.9070803@marcansoft.com>
	<20090701112958.1d24e06f.akpm@linux-foundation.org>
	<4A4C2EDC.6070209@marcansoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57159 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754812AbZGBW5y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2009 18:57:54 -0400
In-Reply-To: <4A4C2EDC.6070209@marcansoft.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hector Martin <hector@marcansoft.com>
Cc: astarikovskiy@suse.de, lenb@kernel.org, linux-acpi@vger.kernel.org

On Thu, 02 Jul 2009 05:51:56 +0200
Hector Martin <hector@marcansoft.com> wrote:

> Andrew Morton wrote:
> > acpi_battery has no field `current_now' in 2.6.30 or 2.6.31-rc1.  Which
> > kernel version are you patching here?
> 
> Updated patch for 2.6.30 attached. current_now got renamed to rate_now.

The patch has no changelog.

We could go fishing through the mailing list to find the original
changelog, but perhaps it is no longer accurate.  Or we could type in a
new changelog but that also has accuracy problems.

So please always resend the full changelog (possibly after revising it)
with each version of a patch.

