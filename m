From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI: EC: GPE storm detected, transactions will use polling mode
Date: Sun, 16 Nov 2008 12:49:34 +0300
Message-ID: <491FECAE.6050005@gmail.com>
References: <1226722577.3104.4.camel@LiNuX> <491EBB2D.70106@tuffmail.co.uk>	 <dd18b0c30811151039i4a5e295euc4aaa52382d47bb1@mail.gmail.com>	 <200811152019.31744.rjw@sisk.pl> <1226817681.3133.7.camel@LiNuX>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:31538 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbYKPJtj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Nov 2008 04:49:39 -0500
Received: by ug-out-1314.google.com with SMTP id 39so201748ugf.37
        for <linux-acpi@vger.kernel.org>; Sun, 16 Nov 2008 01:49:37 -0800 (PST)
In-Reply-To: <1226817681.3133.7.camel@LiNuX>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

Justin P. Mattock wrote:
> Well; reverting:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=06cf7d3c7af902939cd1754abcafb2464060cba8
> is keeping the system from having a gpe storm
> (for at least four hours now);
> haven't had a chance to drain the battery and see
> the affects from that scenario.
>
>   
Justin, by decreasing threshold, we just change how often _detection_ of 
the storm fires, not the storm itself.

Regards,
Alex.
