From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: suspend/resume fails on second attempt in LNXVIDEO:00
Date: Thu, 18 Dec 2008 00:11:06 -0800
Message-ID: <494A059A.8050602@gmail.com>
References: <gi247o$iog$1@ger.gmane.org> <200812161625.37318.rjw@sisk.pl> <gi8jf1$m5f$5@ger.gmane.org> <200812161713.08451.rjw@sisk.pl> <20081216163746.GA9478@srcf.ucam.org> <gi8qoj$m5f$7@ger.gmane.org> <20081216205335.GA14332@srcf.ucam.org> <20081218075226.GD2110@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:46097 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbYLRILL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Dec 2008 03:11:11 -0500
Received: by yw-out-2324.google.com with SMTP id 9so122376ywe.1
        for <linux-acpi@vger.kernel.org>; Thu, 18 Dec 2008 00:11:10 -0800 (PST)
In-Reply-To: <20081218075226.GD2110@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Brian J. Murrell" <brian@interlinx.bc.ca>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Tue 2008-12-16 20:53:35, Matthew Garrett wrote:
>   
>> On Tue, Dec 16, 2008 at 06:07:15PM +0000, Brian J. Murrell wrote:
>>     
>>> On Tue, 16 Dec 2008 16:37:46 +0000, Matthew Garrett wrote:
>>>       
>>>> I seem to be missing the original message, but: no, s2ram doesn't exist
>>>> in Ubuntu because pm-utils handles that role.
>>>>         
>>> Well, that's *their* argument but lots of people think otherwise.  There 
>>> appears to be no shortage of people for whom pm-utils does NOT work yet 
>>> s2ram does.  https://bugs.launchpad.net/ubuntu/+source/uswsusp/+bug/134238
>>>       
>> The right answer to "This piece of software contains bugs" is not 
>> "Provide two pieces of software with the same features but different 
>> bugs". The only real functional difference between the two is that
>>     
>
> Yes, and that's why pm-utils should die: they have design problems
> (depend on hal, can't be pagelocked, unusable for suspend debugging).
> 									Pavel
>   
When using ubuntu intrepid, s2ram
did work, but instead of grabbing
the package from ubuntu, I used Debian
SID instead. (I have a tendency of mixing
packages);

regards;

Justin P. Mattock


