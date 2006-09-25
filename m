From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 2.6.18 1/1] ACPI: limit cstate on noisy thinkpad t43/p models
Date: Mon, 25 Sep 2006 03:06:30 -0400
Message-ID: <200609250306.31350.len.brown@intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB6018F099A@hdsmsx411.amr.corp.intel.com> <1159097883.5437.12.camel@nouse.suse.de>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:18669 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751383AbWIYHEm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Sep 2006 03:04:42 -0400
In-Reply-To: <1159097883.5437.12.camel@nouse.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timo Hoenig <thoenig@nouse.net>
Cc: shadow@serverart.org, linux-acpi@vger.kernel.org

On Sunday 24 September 2006 07:38, Timo Hoenig wrote:

> I think it is a more general problem.  The systems with Intel Core Duo I
> got my hands on all show the symptom:  Once the system is idle, the
> second core begins to whine.  It's annoying in quiet environments.
> 
>       * Turning off the second core makes the whining stop.
>       * Booting with processor.max_cstate=2 does also make the whining
>         go away; but it's a bad idea on laptops if once wants to gain a
>         long run on batteries.
> 
> Tested with HZ=250; I'll check whether HZ=100/1000 helps.

Curious, I have not noticed this on the Core Duo systems I have.

In the past this has been traced to the voltage switching on the motherboard
causing the capacitors to vibrate and the motherboard to resonate.
That is why changing HZ will likely have an effect on the problem.

Exactly what model system do you have that is making noise?

-Len
