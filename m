From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH 4/5] trace, eMCA: Add a knob to adjust where to save event log
Date: Thu, 3 Apr 2014 16:46:53 -0700
Message-ID: <CA+8MBbKxeSB9oubne9p2YJYcEZYt1gKDuZf3K-CEDjpk-K_Kdw@mail.gmail.com>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
	<1395985981-20476-5-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:42252 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325AbaDCXqx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Apr 2014 19:46:53 -0400
Received: by mail-ob0-f179.google.com with SMTP id va2so2796470obc.10
        for <linux-acpi@vger.kernel.org>; Thu, 03 Apr 2014 16:46:53 -0700 (PDT)
In-Reply-To: <1395985981-20476-5-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, "m.chehab@samsung.com" <m.chehab@samsung.com>, Steven Rostedt <rostedt@goodmis.org>, linux-acpi <linux-acpi@vger.kernel.org>, "arozansk@redhat.com" <arozansk@redhat.com>

> +static int extlog_trace_show(struct seq_file *m, void *v)
> +{
> +       atomic_inc(&trace_on);
> +       return 0;
> +}
> +
> +static int trace_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, extlog_trace_show, NULL);
> +}

Shouldn't this atomic_inc() be inside the trace_open() function
... not the extlog_trace_show()?

-Tony
