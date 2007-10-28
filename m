From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: 2.6.24-rc1 acpi battery driver -> sysfs interface does not update
 correctly
Date: Sun, 28 Oct 2007 15:58:20 +0300
Message-ID: <4724876C.40608@gmail.com>
References: <3e7b9f4b0710241114u73ad1d4bl34070b4fd2b18d63@mail.gmail.com>	 <471FABF5.1030406@gmail.com>	 <3e7b9f4b0710241417i7f0edeel6d11b8a3e4048243@mail.gmail.com>	 <471FBDF5.7000906@gmail.com>	 <3e7b9f4b0710241528j403e2ecboc29e03438034349a@mail.gmail.com>	 <3e7b9f4b0710241537i1d3db590u2220900e30ae0d1b@mail.gmail.com>	 <472008C5.8030906@gmail.com>	 <3e7b9f4b0710250231p2e562989s97033ee50d2e5ec2@mail.gmail.com>	 <3e7b9f4b0710270952r3e7ff889qe628cf9ff0c8361e@mail.gmail.com>	 <472373E9.3040207@gmail.com> <3e7b9f4b0710280506g18b9ec61h8cadc491877dd533@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:31227 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbXJ1M6q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Oct 2007 08:58:46 -0400
Received: by ug-out-1314.google.com with SMTP id z38so877821ugc
        for <linux-acpi@vger.kernel.org>; Sun, 28 Oct 2007 05:58:44 -0700 (PDT)
In-Reply-To: <3e7b9f4b0710280506g18b9ec61h8cadc491877dd533@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ash Milsted <thatistosayiseenem@gawab.com>
Cc: linux-acpi@vger.kernel.org

Ash Milsted wrote:
> On 27/10/2007, Alexey Starikovskiy <aystarik@gmail.com> wrote:
>> Ash Milsted wrote:
>>> Hi again,
>>> I just thought I'd say that this is still occuring with the current
>>> linux-acpi-2.6 git tree on top of Linus' latest.. I don't get
>>> (dis)charge uevents and, oddly, the sysfs charge_now value is
>> As I remember, you did not found uevents in 2.6.23 as well?
> 
> Yeah, no uevents for (dis)charges or (un)plugs in 2.6.23.
> 
>>> initially wrong on boot-up. For some reason it gives a value of about
>>> half the full charge of the battery (no matter what the true value is)
>>> until I read it a couple of times, at which point it corrects itself.
> 
> Reading the sysfs value is, it turns out, not necessary to trigger
> this single update (which also sends a change uevent). I guess this is
> just the battery driver grabbing the initial value - after that there
> are no more change uevents.
> 
>>> I attach a few extra details, in case they help.
>> your acpidump output might be usefull at this point.
> 
> Attached.
> 
Ok, it seems to be related with ECDY variable of your DSDT.
It is equal to 5 by default, but could be set to 0 or 3 if _OS string matches 
some magic length (guess Linux does not match).
BST (method for reading state out of memory) may send notify event if ECDY 
is 1 (it will become this only uevent you see at very start).
I do not see how battery driver could help in this situation.
What you could do is try to play with acpi_os variable so that ECDY becomes 0.
You also could patch your DSDT to have ECDY=0 always (or try to update BIOS, it might be done already).







 
