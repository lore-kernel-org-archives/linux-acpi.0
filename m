From: Alan Jenkins <aj504@student.cs.york.ac.uk>
Subject: Re: Patch needed for ASUS EEEPC 701 2.6.27 (perhaps a regession)
Date: Tue, 14 Oct 2008 09:50:26 +0100
Message-ID: <48F45D52.2010407@tuffmail.co.uk>
References: <48F0BD2D.8000001@tuffmail.co.uk> <20081013203648.GA3260@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:38122 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755039AbYJNIu5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Oct 2008 04:50:57 -0400
Received: by nf-out-0910.google.com with SMTP id d3so904044nfc.21
        for <linux-acpi@vger.kernel.org>; Tue, 14 Oct 2008 01:50:55 -0700 (PDT)
In-Reply-To: <20081013203648.GA3260@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Robert Goldner <robert@au-79.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, linux-stable@vger.kernel.org

Pavel Machek wrote:
> On Sat 2008-10-11 15:50:21, Alan Jenkins wrote:
>> Robert Goldner wrote:
>>
>>> Hi,
>>>
>>> I am a happy user of an asus eeepc 701 with an self-made kernel 2.6.27.
>>> Its working quite good, but there is one patch needed to avoid problems
>>> related to ACPI and Hotkeys.
>>> After using a few hotkeys there comes a message in syslog like:
>>> ACPI: EC: GPE storm detected, disabling EC GPE
>>> and no hotkey event is recognized any more. This is quite bad on a nettop.
>> Hi, I reported the original bug.  It is a regression, though the issue
>> has been present for a few kernel versions now.
>>
>> I recommend that you avoid reproducing the problem.  I now have to add
>> "noapic" to the boot options on my EeePC, otherwise it randomly hangs /
>> reboots when I press hotkeys - I think it  damaged the hardware.
> 
> I guess your hw went bad for some other reason. Restore original
> system and if it is still broken, RMA?
> 

It could be a coincidence.  But it's suspicious enough to advise caution.  We know what the bug is, and we have a very nice workaround queued up now.  There's no reason to test any more of these specific systems to destruction :).

I did try re-installing off the vendor DVD and it was still broken.  I fear I bought it from the wrong place to get sympathetic _frontline_ support / warrantee.  I'm not interested in RMA back to Asus - too much work and downtime for a cheap system, when I have an easy workaround.  I haven't noticed any problems with "noapic".


The symptoms strongly suggest overflow in an event buffer or counter maintained by the Embedded Controller.  So the EC firmware may have a bug, of the sort that results in "unspecified behaviour".  A bug in a special purpose (read: not subject to wide testing) subsystem which has direct connections to things like frequency and voltage control.

Hopefully I'm wrong, and I don't really know what I'm talking about here.

Regards
Alan
