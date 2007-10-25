From: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: Resume problems
Date: Thu, 25 Oct 2007 15:09:50 +0200
Message-ID: <4720959E.3030805@googlemail.com>
References: <471CCC98.10101@googlemail.com> <471D3C26.3090602@googlemail.com> <471D47D2.2070707@googlemail.com> <200710240057.10131.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:21858 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbXJYNK5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Oct 2007 09:10:57 -0400
Received: by nf-out-0910.google.com with SMTP id g13so478330nfb
        for <linux-acpi@vger.kernel.org>; Thu, 25 Oct 2007 06:10:55 -0700 (PDT)
In-Reply-To: <200710240057.10131.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

Rafael J. Wysocki wrote:
>>
>> After all I think all this problems may be some who ACPI related 
>> but the question is why they get triggered by Suspend/Hibernation.
> 
> They certainly are ACPI-related, because the only difference between level 4
> and level 3 suspend testing is that some global ACPI methods are executed
> at level 3 (in addition to level 4).
> 
> Unfortunately, I have no idea what to do next, for now.
> 
> I think you can file a bug report at http://bugzilla.kernel.org and put a link
> to this thread in there (against ACPI and please add my address to the CC
> list).

Also I patched 2.6.23 with that patch and Hibernation works out of box , Suspend to Ram seems to work
fine , just my video card is acting up ( old nvidia card ) I'll play with vbe tool on weekend.

Also I can reproduce that bug in 2.6.23 when I use standby.

I've started to bisect but it will take some time. When I'm done I will post an bug report.

Thanks for your help so far.

> 
> Greetings,
> Rafael
> 

Gabriel
