From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: cpufreq support still broken on some laptops
Date: Sat, 9 Jun 2007 00:33:08 +0400
Message-ID: <8f8ff01d0706081333q4d44daeg7633838de5207502@mail.gmail.com>
References: <A2B2EBD3-64AE-457A-92C3-4E0462A35E2B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:16135 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbXFHUdJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jun 2007 16:33:09 -0400
Received: by wx-out-0506.google.com with SMTP id t15so829257wxc
        for <linux-acpi@vger.kernel.org>; Fri, 08 Jun 2007 13:33:08 -0700 (PDT)
In-Reply-To: <A2B2EBD3-64AE-457A-92C3-4E0462A35E2B@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tobias Neumann <tobias.neumann@gmail.com>
Cc: linux-acpi@vger.kernel.org

Please take a look at bugzilla.kernel.org $8558

Regards,
Alex
On 6/2/07, Tobias Neumann <tobias.neumann@gmail.com> wrote:
> Hi,
> on my Thinkpad T60 (2007-FUG), with kernel 2.6.21.1 I have the same
> problem Ingo Molnar had in January and successfully fixed for his model:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/
> linux-2.6.git;a=commit;h=e4233dec749a3519069d9390561b5636a75c7579
>
> "Recently cpufreq support on my laptop (Lenovo T60) broke completely:
> when
> it's plugged into AC it would never go higher than 1 GHz - neither
> 1.3 GHz
> nor 1.83 GHz is possible - no matter which governor (userspace, speed or
> ondemand) is used."
>
> 2.6.21 and 2.6.20 include this patch and should not have this problem
> anymore.
>
> Is there any way I can see when ACPI calls for _PPC happen (via
> ACPI_DEBUG) and which _PPC values get returned? Which debug_level do
> I need?
>
> Here are some more people with the same problem on 2.6.20 and 2.6.21
> (which includes that patch too):
> https://bugs.beta.launchpad.net/ubuntu/+source/linux-source-2.6.20/
> +bug/88899
>
> Thanks,
>    Tobias
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
