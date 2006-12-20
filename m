From: "Balaji Rao" <balajirrao@gmail.com>
Subject: Re: Power States
Date: Thu, 21 Dec 2006 00:21:27 +0530
Message-ID: <569c97d20612201051la543b85r11a789affe356e1@mail.gmail.com>
References: <569c97d20612201033g69b7d345i657dc6f62f591854@mail.gmail.com>
	 <45898257.5060004@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:45786 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030269AbWLTSv2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Dec 2006 13:51:28 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2324537uga
        for <linux-acpi@vger.kernel.org>; Wed, 20 Dec 2006 10:51:27 -0800 (PST)
In-Reply-To: <45898257.5060004@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

But, acpidump doest give me anything saying SSDT..
Actually the problem is, only one power state(C1) is being shown up in
my Core 2 Duo (E6300) box.

Also, power management is reported as not available.

Where can i look for a solution?


On 12/21/06, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com> wrote:
> Balaji Rao wrote:
> > Hello all,
> >
> > Are the various power levels supported by the processor provided only
> > through the DSDT? Or is there any other table for this purpose?
> > When i disassembled my DSDT, i could not find any _PSS Packages.
> >
> > From where does the kernel read values into the frequency table?
> >
> > Also, which is the mechanism that decides to load the appropriate
> > cpufreq driver?
> >
> > warm regards
> >
> > Balaji Rao
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Check SSDTs as well.
>
> Regards,
>     Alex.
>


-- 
regards

Balaji Rao
