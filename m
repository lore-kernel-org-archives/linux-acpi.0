From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH] Override DSDT and SSDTs via initramfs
Date: Fri, 01 Feb 2008 14:07:24 +0300
Message-ID: <47A2FD6C.4090403@gmail.com>
References: <4798E2A5.6020804@users.sf.net>	 <1201714051.1222.131.camel@queen.suse.de>	 <47A0FBD4.6090603@tremplin-utc.net>  <200801311417.57469.lenb@kernel.org> <1201859637.14573.41.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:4766 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801AbYBALIO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Feb 2008 06:08:14 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1019985fkz.5
        for <linux-acpi@vger.kernel.org>; Fri, 01 Feb 2008 03:08:10 -0800 (PST)
In-Reply-To: <1201859637.14573.41.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Len Brown <lenb@kernel.org>, =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

Thomas Renninger wrote:
> On Thu, 2008-01-31 at 14:17 -0500, Len Brown wrote:
>   
> [skipped]
> Those tables have the same OEM id then the original ones, right?
> Tables with the same OEM id (the original ones) should get ignored later
> automatically. IIRC I had some problems with dynamically loaded tables,
> don't know anymore, they are not that often used and theoretically it
> should just work for them also.
>   
Comparing SSDT by their OEM ID is proved to not work. Right now,
code checks the whole length of the table to be the same, and only then
does not load it. It is not the case with any of modified tables, so
original tables will be tried to load as well.
> I haven't tried too much here, but SSDTs are used more and more often (I
> saw a machine with 12 SSDTs, especially on IA64 there might be dozens in
> the future). We should think about the problem now, before we have bugs
> and need to write down half a book how the reporter finally could
> provide some useful information.
>
>   
> Have I overseen something?
>
>     Thomas
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

