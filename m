From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [2.624-rc1 regression] lost battery information
Date: Sat, 27 Oct 2007 01:07:52 +0400
Message-ID: <47225728.2070808@gmail.com>
References: <200710262024.06012.arvidjaar@mail.ru> <200710262120.22536.arvidjaar@mail.ru> <47222DF3.3040208@gmail.com> <200710262215.42939.arvidjaar@mail.ru> <472232D3.6000807@gmail.com> <E1IlWFd-0002fD-6c@faramir.fjphome.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:14417 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbXJZVIL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Oct 2007 17:08:11 -0400
Received: by ug-out-1314.google.com with SMTP id z38so751906ugc
        for <linux-acpi@vger.kernel.org>; Fri, 26 Oct 2007 14:08:08 -0700 (PDT)
In-Reply-To: <E1IlWFd-0002fD-6c@faramir.fjphome.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: arvidjaar@mail.ru, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Frans Pop wrote:
> Alexey Starikovskiy wrote:
>> Andrey Borzenkov wrote:
>>> is it in -rc1 or can you point me to the patch (I'd rather avoid having
>>> to pull from different git trees). Thank you.
>> No, it should be rc1.
>>> And what about ACPI_PROCFS case? It still needs attention I believe.
>> As you can see, there is info in /proc too:
> 
> I'm missing the info in /sys too, so it looks like the error in proc and
> the missing info in /sys are related.
> 
> Alexey: do you have POWER_SUPPLY and/or AC/BATTERY compiled in or modular?
> I wonder if that could make the difference.
> 
Currently everything is module.
