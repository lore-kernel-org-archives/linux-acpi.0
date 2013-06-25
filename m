From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] ACPI/Processor: Clear unuseful variable count in the acpi_processor_preregister_performance()
Date: Tue, 25 Jun 2013 13:15:59 +0530
Message-ID: <CAKohpo=jdP-WF4D+XO=Z9cYVvJpbM9EG6hKSCgURNMVBTGut5g@mail.gmail.com>
References: <1372126006-4950-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44345 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab3FYHqA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jun 2013 03:46:00 -0400
Received: by mail-oa0-f46.google.com with SMTP id h1so12958845oag.5
        for <linux-acpi@vger.kernel.org>; Tue, 25 Jun 2013 00:45:59 -0700 (PDT)
In-Reply-To: <1372126006-4950-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: rjw@sisk.pl, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org

On 25 June 2013 07:36, Lan Tianyu <tianyu.lan@intel.com> wrote:
> The variable count in the acpi_processor_preregister_performance() is only initalized
> as one for one cpu and increased by one when find another cpu that share same dependency
> domain. Otherwise, it isn't referenced somewhere else.
>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  drivers/acpi/processor_perflib.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
