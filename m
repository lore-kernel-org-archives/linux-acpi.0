From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: ACPI: Introduce CPU performance controls using CPPC
Date: Fri, 23 Oct 2015 04:42:14 -0400
Message-ID: <CAJ5Y-ebz5vL7KYFatcNYpdR=z1JkqPpq-8L=pkUXXDYpA132Mg@mail.gmail.com>
References: <20151022194928.GA24403@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34497 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbbJWImf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Oct 2015 04:42:35 -0400
Received: by lfaz124 with SMTP id z124so75706935lfa.1
        for <linux-acpi@vger.kernel.org>; Fri, 23 Oct 2015 01:42:34 -0700 (PDT)
In-Reply-To: <20151022194928.GA24403@mwanda>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Rafael Wysocki <rafael@kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Hi Dan,

On 22 October 2015 at 15:49, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Hello Ashwin Chaugule,
>
> The patch 337aadff8e45: "ACPI: Introduce CPU performance controls
> using CPPC" from Oct 2, 2015, leads to the following static checker
> warning:
>
>         drivers/acpi/cppc_acpi.c:527 acpi_cppc_processor_probe()
>         warn: overwrite may leak 'cpc_ptr'
>
> drivers/acpi/cppc_acpi.c
>    426          cpc_ptr = kzalloc(sizeof(struct cpc_desc), GFP_KERNEL);
>    427          if (!cpc_ptr) {
>    428                  ret = -ENOMEM;
>    429                  goto out_buf_free;
>    430          }
>    431
>    432          /* First entry is NumEntries. */
>    433          cpc_obj = &out_obj->package.elements[0];
>    434          if (cpc_obj->type == ACPI_TYPE_INTEGER) {
>    435                  num_ent = cpc_obj->integer.value;
>    436          } else {
>    437                  pr_debug("Unexpected entry type(%d) for NumEntries\n",
>    438                                  cpc_obj->type);
>    439                  goto out_free;
>    440          }
>
> [ snip ]
>
>    523          kfree(output.pointer);
>    524          return 0;
>    525
>    526  out_free:
>    527          cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);
>
> Why do we have this line?  Maybe it is left over and should be deleted?

Gah! You're right. This is a left over and should be deleted. I can
send the fix to Rafael, if you dont have one ready to send?

Thanks,
Ashwin.
