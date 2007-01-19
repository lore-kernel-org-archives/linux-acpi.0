From: emisca <emisca.ml@gmail.com>
Subject: Re: Fan speeds on HP nc6400 and nc8430
Date: Fri, 19 Jan 2007 15:41:01 +0100
Message-ID: <414cba4e0701190641x4e5c5747j3edf4ead90d805a2@mail.gmail.com>
References: <C3FA62B1A90D7440B9B6C7C31895994F0366363A@zadbn02100.vodacom.corp>
	 <45B0D454.5000808@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:13293 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932845AbXASOlD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jan 2007 09:41:03 -0500
Received: by ug-out-1314.google.com with SMTP id 44so470191uga
        for <linux-acpi@vger.kernel.org>; Fri, 19 Jan 2007 06:41:01 -0800 (PST)
In-Reply-To: <45B0D454.5000808@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Pieter De Wit <Pieter.DeWit@vodacom.co.za>, linux-acpi@vger.kernel.org

The TZ4 thermal zone on all the hp compaq line nx**** and nc**** is
not a temperature but the fan speed. You can see this information on
the web and on hp forums. I really don't know why hp has done this..
With my nx7400 I have problems with fans only when I resume from
suspend to disk and the thermal module is loaded by initramfs before
resuming the system.
I have also noticed that these laptops consume more energy on linux
than on windows.
I think that's a problem related to acpi C states. On AC I have only
C1 and C2 on both cpu cores, on battery I have C1, C2 on first core
and C1, C2, C3 on the second. Why there are no higher C-states?

Bye

2007/1/19, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>:
> Did you try patches from #5534 and #7122?
>
> Pieter De Wit wrote:
> > Hi Luming,
> >
> > This module was build into the kernel. After make it a module and making
> > sure it's not loaded, I still see the problem. Here is a more detailed
> > problem:
> >
> > If I leave ACPI to manage the system, thermal zone TZ4 stays around 80
> > C. The moment I turn on fan C318, this zone *shoots* up to 100 C and
> > stays there, no matter what. This fan I can't turn off again.
> >
> > Here is a cat of fans, thermal_zone status and temp.
> >
> > status:                  on
> > status:                  off
> > status:                  on
> > status:                  on
> > status:                  on
> > status:                  on
> > status:                  on
> > state:                   active[2]
> > state:                   ok
> > state:                   ok
> > state:                   ok
> > state:                   ok
> > temperature:             65 C
> > temperature:             61 C
> > temperature:             54 C
> > temperature:             30 C
> > temperature:             100 C
> >
> > This was taken during the compile of gcc. While not doing anything, the
> > second zone drops to 54 C (currently at 61)
> >
> > Thanks for the time,
> >
> > Pieter
> >
> > -----Original Message-----
> > From: Luming Yu [mailto:luming.yu@gmail.com]
> > Sent: 2007/01/19 10:14
> > To: Pieter De Wit
> > Cc: linux-acpi@vger.kernel.org
> > Subject: Re: Fan speeds on HP nc6400 and nc8430
> >
> > Do you have psmouse module loaded ?
> > (i.e. CONFIG_MOUSE_PS2=m)
> > If yes, Please try remove it, and re-test it.
> >
> > Thanks,
> > Luming
> >
> > On 1/19/07, Pieter De Wit <Pieter.DeWit@vodacom.co.za> wrote:
> >
> >> Hello List,
> >>
> >> I have noted that the fan speed on "idle" is much higher in Linux
> >> compared to XP. I have also noted that once fans are turned on, they
> >> never seem to return to the off state. I am currently using the 2.6.18
> >>
> >
> >
> >> kernel from Gentoo (gentoo-sources-r6). I was wondering if there is a
> >> way I can lower the fan speed, or even assist the devs to get info
> >> regarding these notebooks (if any is needed).
> >>
> >> Thanks,
> >>
> >> Pieter
> >> "This e-mail is sent on the Terms and Conditions that can be accessed
> >>
> > by Clicking on this link http://www.vodacom.co.za/legal/email.jsp "
> >
> >> -
> >> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> >> in the body of a message to majordomo@vger.kernel.org More majordomo
> >> info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> > "This e-mail is sent on the Terms and Conditions that can be accessed by Clicking on this link http://www.vodacom.co.za/legal/email.jsp "
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
