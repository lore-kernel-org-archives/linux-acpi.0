From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: Power States
Date: Wed, 20 Dec 2006 21:35:03 +0300
Message-ID: <45898257.5060004@linux.intel.com>
References: <569c97d20612201033g69b7d345i657dc6f62f591854@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:6612 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030278AbWLTSos (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Dec 2006 13:44:48 -0500
In-Reply-To: <569c97d20612201033g69b7d345i657dc6f62f591854@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Balaji Rao <balajirrao@gmail.com>
Cc: linux-acpi@vger.kernel.org

Balaji Rao wrote:
> Hello all,
>
> Are the various power levels supported by the processor provided only
> through the DSDT? Or is there any other table for this purpose?
> When i disassembled my DSDT, i could not find any _PSS Packages.
>
> From where does the kernel read values into the frequency table?
>
> Also, which is the mechanism that decides to load the appropriate
> cpufreq driver?
>
> warm regards
>
> Balaji Rao
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Check SSDTs as well.

Regards,
    Alex.
