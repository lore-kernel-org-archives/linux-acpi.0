From: "Ash Milsted" <thatistosayiseenem@gawab.com>
Subject: Re: 2.6.24-rc1 acpi battery driver -> sysfs interface does not update correctly
Date: Sun, 28 Oct 2007 15:03:54 +0100
Message-ID: <3e7b9f4b0710280703x44a94ca6p8b33993e01c36b46@mail.gmail.com>
References: <3e7b9f4b0710241114u73ad1d4bl34070b4fd2b18d63@mail.gmail.com>
	 <471FBDF5.7000906@gmail.com>
	 <3e7b9f4b0710241528j403e2ecboc29e03438034349a@mail.gmail.com>
	 <3e7b9f4b0710241537i1d3db590u2220900e30ae0d1b@mail.gmail.com>
	 <472008C5.8030906@gmail.com>
	 <3e7b9f4b0710250231p2e562989s97033ee50d2e5ec2@mail.gmail.com>
	 <3e7b9f4b0710270952r3e7ff889qe628cf9ff0c8361e@mail.gmail.com>
	 <472373E9.3040207@gmail.com>
	 <3e7b9f4b0710280506g18b9ec61h8cadc491877dd533@mail.gmail.com>
	 <4724876C.40608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:50032 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbXJ1ODz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Oct 2007 10:03:55 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1436840wxd
        for <linux-acpi@vger.kernel.org>; Sun, 28 Oct 2007 07:03:54 -0700 (PDT)
In-Reply-To: <4724876C.40608@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 28/10/2007, Alexey Starikovskiy <aystarik@gmail.com> wrote:
> Ok, it seems to be related with ECDY variable of your DSDT.
> It is equal to 5 by default, but could be set to 0 or 3 if _OS string matches
> some magic length (guess Linux does not match).
> BST (method for reading state out of memory) may send notify event if ECDY
> is 1 (it will become this only uevent you see at very start).
> I do not see how battery driver could help in this situation.
> What you could do is try to play with acpi_os variable so that ECDY becomes 0.
> You also could patch your DSDT to have ECDY=0 always (or try to update BIOS, it might be done already).
>

I see. I'll see what I can do to get that fixed, although I think I'm
using the latest bios for this machine. I guess I'll play with the
acpi_os value.

I wonder how common this problem is. This laptop is quite old (Toshiba
Satellite 1110), but if this is a common issue I guess it makes sense
for either HAL or the battery driver to poll in certain cases (e.g.
poll if we haven't been receiving events/interrupts but we should be
charging/discharging or, if it ain't common, this could be a HAL
'quirk'). As long as users of the uevent interface are aware of this
possible issue I guess they could be responsible for polling - do you
think I should let the HAL guys know?

Ash
