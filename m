From: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: ACPI: EC: GPE storm detected, disabling EC GPE
Date: Tue, 10 Jun 2008 18:37:35 +0000
Message-ID: <dd18b0c30806101137o4219b923mea7ba6c9b8751c52@mail.gmail.com>
References: <dd18b0c30806062321x2918f6feq7c817bde52ba0c4c@mail.gmail.com>
	 <20080606235526.783acc83.akpm@linux-foundation.org>
	 <alpine.LFD.1.10.0806101128390.14381@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:35801 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbYFJShn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jun 2008 14:37:43 -0400
Received: by an-out-0708.google.com with SMTP id d40so636816and.103
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jun 2008 11:37:42 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806101128390.14381@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>

On Tue, Jun 10, 2008 at 3:30 PM, Len Brown <lenb@kernel.org> wrote:
>
>
>> Could someone from acpi land please help here?
>
> Alexey maintains the EC, and he's supplied 3 patches to test
> in the bug report.  The 3rd is awaiting word from Justin.
>
> cheers,
> -Len
>
>> Justin, has this machine always had this problem or is it something
>> which earlier kernels handled correctly?
>
> note that the EC storm detection is new -- so the failure may
> have simply been different in older kernels -- such as a huge
> number of ACPI interrupts.
>
> cheers,
> -len
>
>

Hello; O.K. I applied the patch. after rebooting I was still seeing
this message, also I noticed HAL daemon was taking longer
to start. when unplugging the A/C adapter with pommed the screen
wouldn't dim, and under dmesg nothing about the battery.
when unplugging and plugging in. also with suspend the screen took
longer than normal to recover. So feeling uncomfortable
with how this patch was causing the system to react, I reverted back
just to be safe. After reverting it took a few reboots to bring the
battery
back to a good state. I'm not sure if this was because of ec.c or not.
Now before this patch The only chage that I had done was change 5 to
20,
after a few day's I did notice this message to dissipate. Maybe this
is just something with a macbook pro, and not other computers, with
this patch.
regards;

-- 
Justin P. Mattock
