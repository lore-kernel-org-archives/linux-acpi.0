From: Len Brown <len.brown@intel.com>
Subject: Re: [patch 13/14] ACPI: Correctly recover from a failed S3 attempt
Date: Wed, 16 Aug 2006 17:55:08 -0400
Message-ID: <200608161755.08809.len.brown@intel.com>
References: <200608150537.k7F5bVsB011566@shell0.pdx.osdl.net> <200608160027.12335.len.brown@intel.com> <44E35CCB.5010109@amd.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55425 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932267AbWHPVxY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Aug 2006 17:53:24 -0400
In-Reply-To: <44E35CCB.5010109@amd.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: William Morrow <William.Morrow@amd.com>
Cc: Len Brown <lenb@kernel.org>, akpm@osdl.org, linux-acpi@vger.kernel.org, jordan.crouse@amd.com, luming.yu@intel.com

On Wednesday 16 August 2006 13:58, William Morrow wrote:

> >>This was discovered on a broken BIOS that simply returned from its suspend
> >>procedure, appearing to the OS as a failed S3 attempt.

> > [  acpi_enter_sleep_state() ]...
>  does not actually bail out, it just returns do_suspend_lowlevel as if 
> it did sleep.   It did sleep, but did not restart and return the call by the accepted 
> software mechanism.
> The machine resumes execution in protected mode with the original 
> machine state  largely intact, but it fails to restore the sysenter/exit registers.

> >Does S3 work on windows on this box?
> >
> Yes (XP).  This is the excuse - and is the force which is driving this  solution.
> There is no test group to re-test all of the ACPI aware OSs S3 recovery.
> So if they change (correct) the S3 strategy, it cant be well tested 
> here.  Since it  was tested in the errant form and appeared to pass (on XP), there is 
> considerable  pressure to not correct the bios.

William,
This is an excellent discovery.

It is proof that Windows handles this deviant case -- and so if we fix Linux to handle it,
then we may fix other failing systems.

thanks,
-Len

