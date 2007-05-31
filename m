From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] ACPI Debug - for test, devel and possibly even for production kernels
Date: Thu, 31 May 2007 21:57:10 +0300
Message-ID: <84144f020705311157n6bede2c7ga234d70823d5869f@mail.gmail.com>
References: <1180624839.10908.71.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:29080 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757219AbXEaS5L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 May 2007 14:57:11 -0400
Received: by wa-out-1112.google.com with SMTP id j4so126628wah
        for <linux-acpi@vger.kernel.org>; Thu, 31 May 2007 11:57:10 -0700 (PDT)
In-Reply-To: <1180624839.10908.71.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>

On 5/31/07, Thomas Renninger <trenn@suse.de> wrote:
> (This should efficiently be the same as the proposed big patch a year
> ago from Pekka Enberg, just a bit smaller and should make ACPICA and
> kernel/linux people happy:
> http://marc.info/?l=linux-kernel&m=113699535303722&w=2)

No, you're keeping these obfuscating macros around:

+#define return_VOID                     return
+#define return_ACPI_STATUS(s)           return(s)
+#define return_VALUE(s)                 return(s)
+#define return_UINT8(s)                 return(s)

Making the ACPI code look like regular Linux kernel code (or even
regular C for that matter) was the whole point of my patch. Your patch
doesn't change that.
