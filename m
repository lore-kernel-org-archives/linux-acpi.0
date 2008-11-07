From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH 21/21] ACPI: EC: make kernel messages more useful when
 GPE storm is detected
Date: Fri, 07 Nov 2008 09:18:44 +0000
Message-ID: <491407F4.4090404@tuffmail.co.uk>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org> <be11b915c297a6ccea17356d689d60734967f5f6.1226032677.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fallback-out1.mxes.net ([216.86.168.190]:4176 "EHLO
	fallback-in1.mxes.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751007AbYKGJam (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Nov 2008 04:30:42 -0500
Received: from mxout-08.mxes.net (mxout-08.mxes.net [216.86.168.183])
	by fallback-in1.mxes.net (Postfix) with ESMTP id 88EC41648C2
	for <linux-acpi@vger.kernel.org>; Fri,  7 Nov 2008 04:21:22 -0500 (EST)
In-Reply-To: <be11b915c297a6ccea17356d689d60734967f5f6.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, stable@kernel.org

Len Brown wrote:
> From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
>
> Make sure we can tell if the GPE storm workaround gets activated,
> and avoid flooding the logs afterwards.
>
> http://bugzilla.kernel.org/show_bug.cgi?id=11841
> "plenty of line "ACPI: EC: non-query interrupt received,
>  switching to interrupt mode" in dmesg"
>
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> Signed-off-by: Len Brown <len.brown@intel.com>
>   
I see the EC patches that cause this issue are part of 2.6.27-stable. 
So I think this patch should also be applied to the -stable tree.

Thanks
Alan
