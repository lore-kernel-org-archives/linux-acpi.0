From: Timo Hoenig <thoenig@nouse.net>
Subject: Re: [PATCH 2.6.18 1/1] ACPI: limit cstate on noisy thinkpad t43/p
	models
Date: Mon, 25 Sep 2006 15:50:08 +0200
Message-ID: <1159192208.4475.9.camel@nouse.suse.de>
References: <CFF307C98FEABE47A452B27C06B85BB6018F099A@hdsmsx411.amr.corp.intel.com>
	 <1159097883.5437.12.camel@nouse.suse.de>
	 <200609250306.31350.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:23438 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750817AbWIYJFB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Sep 2006 05:05:01 -0400
In-Reply-To: <200609250306.31350.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: shadow@serverart.org, linux-acpi@vger.kernel.org

Hi,

On Mon, 2006-09-25 at 03:06 -0400, Len Brown wrote:

> On Sunday 24 September 2006 07:38, Timo Hoenig wrote:
> 
> > I think it is a more general problem.  The systems with Intel Core Duo I
> > got my hands on all show the symptom:  Once the system is idle, the
> > second core begins to whine.  It's annoying in quiet environments.
> > 
> >       * Turning off the second core makes the whining stop.
> >       * Booting with processor.max_cstate=2 does also make the whining
> >         go away; but it's a bad idea on laptops if once wants to gain a
> >         long run on batteries.
> > 
> > Tested with HZ=250; I'll check whether HZ=100/1000 helps.
> 
> Curious, I have not noticed this on the Core Duo systems I have.
> 
> In the past this has been traced to the voltage switching on the motherboard
> causing the capacitors to vibrate and the motherboard to resonate.
> That is why changing HZ will likely have an effect on the problem.

Yes, that's what I have found to be the culprit, too.  Sorry that I do
not have yet been able to check with different HZ than 250 so far.

> Exactly what model system do you have that is making noise?

* Lenovo ThinkPad T60, several different models
* Fujitsu Siemens e8110

Also, I just got my hands on a Lenovo ThinkPad X60 and ran the same test
[1] as on the other machines but did not hear any noise.

   Timo

[1] Test with Linux 2.6.18-rc6 (with pwd /sys/devices/system/cpu/cpu1)
    while (true); do echo 0 > online; sleep 1; echo 1 > online; sleep 1; done;

