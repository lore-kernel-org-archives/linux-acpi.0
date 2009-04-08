From: Rodrigo Luiz <rodrigo@gus-mg.org>
Subject: Re: [PATCH] ACPICA: delete check for AML access to port 0x81-83
Date: Tue, 7 Apr 2009 22:20:18 -0300
Message-ID: <7a3045780904071820n7b9206e2nfc88b32522b83d1f@mail.gmail.com>
References: <7a3045780904051727o3780c7d3hebb26028a1b4eba5@mail.gmail.com>
	 <alpine.LFD.2.00.0904071754230.4799@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:25781 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755675AbZDHBUT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 21:20:19 -0400
Received: by yx-out-2324.google.com with SMTP id 31so2918613yxl.1
        for <linux-acpi@vger.kernel.org>; Tue, 07 Apr 2009 18:20:18 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904071754230.4799@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org

On Tue, Apr 7, 2009 at 18:56, Len Brown <lenb@kernel.org> wrote:
> From: Len Brown <len.brown@intel.com>
>
> Sony laptops apparently write 4-bytes (rather than 1 byte)
> to debug port 0x80, which spews error messages:
>
> Denied AML access to port 0x00000080/4 (DMA1 0x0081-0x0083) [20090320]
>
> http://bugzilla.kernel.org/show_bug.cgi?id=13036
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>
> Rodrigo,
> Please verify that this makes the warnings go away.
>

Ok! There is no more warnings!

-- 
[]'s
Rodrigo Luiz
