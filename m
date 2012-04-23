From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [RESEND PATCH V2] ACPI, APEI: Add validation check before GHES
 error is recorded
Date: Mon, 23 Apr 2012 10:09:20 +0800
Message-ID: <4F94B9D0.5070001@linux.intel.com>
References: <1334913860-24651-1-git-send-email-gong.chen@linux.intel.com> <3908561D78D1C84285E8C5FCA982C28F170E703B@ORSMSX104.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:55359 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753062Ab2DWCJX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Apr 2012 22:09:23 -0400
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F170E703B@ORSMSX104.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

=E4=BA=8E 2012/4/21 7:13, Luck, Tony =E5=86=99=E9=81=93:
> arch/x86/kernel/cpu/mcheck/mce-apei.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> This patch seems to be in cross-over territory between ACPI and MCE
>
> ... I just applied it to the RAS tree.
>
> -Tony
>
OK, thx a lot, Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
