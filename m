From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: 2.6.24-rc1 acpi battery driver -> sysfs interface does not update
 correctly
Date: Sun, 28 Oct 2007 17:27:21 +0300
Message-ID: <47249C49.8070609@gmail.com>
References: <3e7b9f4b0710241114u73ad1d4bl34070b4fd2b18d63@mail.gmail.com>	 <471FBDF5.7000906@gmail.com>	 <3e7b9f4b0710241528j403e2ecboc29e03438034349a@mail.gmail.com>	 <3e7b9f4b0710241537i1d3db590u2220900e30ae0d1b@mail.gmail.com>	 <472008C5.8030906@gmail.com>	 <3e7b9f4b0710250231p2e562989s97033ee50d2e5ec2@mail.gmail.com>	 <3e7b9f4b0710270952r3e7ff889qe628cf9ff0c8361e@mail.gmail.com>	 <472373E9.3040207@gmail.com>	 <3e7b9f4b0710280506g18b9ec61h8cadc491877dd533@mail.gmail.com>	 <4724876C.40608@gmail.com> <3e7b9f4b0710280703x44a94ca6p8b33993e01c36b46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:47181 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbXJ1O10 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Oct 2007 10:27:26 -0400
Received: by ug-out-1314.google.com with SMTP id z38so883459ugc
        for <linux-acpi@vger.kernel.org>; Sun, 28 Oct 2007 07:27:25 -0700 (PDT)
In-Reply-To: <3e7b9f4b0710280703x44a94ca6p8b33993e01c36b46@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ash Milsted <thatistosayiseenem@gawab.com>
Cc: linux-acpi@vger.kernel.org

Ash Milsted wrote:
> I wonder how common this problem is. This laptop is quite old (Toshiba
> Satellite 1110), but if this is a common issue I guess it makes sense
I've seen only one bug report with similar issue -- DSDT required 10 false 
_BST executions before returning actual value.
So, I'd say it is rare enough.
> for either HAL or the battery driver to poll in certain cases (e.g.
> poll if we haven't been receiving events/interrupts but we should be
> charging/discharging or, if it ain't common, this could be a HAL
> 'quirk'). As long as users of the uevent interface are aware of this
> possible issue I guess they could be responsible for polling - do you
> think I should let the HAL guys know?
You decide :)
