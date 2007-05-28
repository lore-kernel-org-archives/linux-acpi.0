From: David Brownell <david-b@pacbell.net>
Subject: Re: RTC_DRV_CMOS can break userspace interface
Date: Sun, 27 May 2007 18:36:51 -0700
Message-ID: <200705271836.55800.david-b@pacbell.net>
References: <20070527190351.GA21387@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:46422 "HELO
	smtp108.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751223AbXE1CGc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 May 2007 22:06:32 -0400
In-Reply-To: <20070527190351.GA21387@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sunday 27 May 2007, Matthew Garrett wrote:
> f5f72b46c349fefcfd4421b2213c6ffb324c5e56 appears to break the userspace 
> interface to the CMOS alarm. This could previously be accessed via 
> /proc/acpi/alarm ...

I was a bit surprised the ACPI team didn't have more comments on
that issue, myself.  Thing is, all of /proc/acpi/* is deprecated
(scheduled for removal in barely over one month!) and nobody had
found any actual users of that "alarm" file when they searched for
them a while ago.  I suppose the conclusion then was that there
are no applications using it.


> I'm not actually sure why this is the case. It doesn't look like the two 
> interfaces are fundamentally incompatible.

ISTR the issue is that ACPI only allows one chunk of code to hook
into the relevant notifications.  So:  either /proc/acpi/wakeup;
or /sys/class/rtc/rtc0/wakealarm; but not both.


> I agree that removing the  
> proc code is a good long-term aim, but it'd be nice to be able to test 
> the new RTC code without removing existing functionality.

Coexistence is unfortunately problematic here.  And with "long term"
documented to be a bit over a month ... I guess all I can say is
that if you can come up with a good patch to make both available,
please do so.

- Dave
