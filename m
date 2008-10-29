From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: 2.6.28-rc1: rapid hotkeys break on eeepc again :(
Date: Wed, 29 Oct 2008 20:27:00 +0000
Message-ID: <4908C714.5040104@tuffmail.co.uk>
References: <4907A511.3040603@tuffmail.co.uk> <4907A856.3050204@gmail.com> <4908307C.8060503@tuffmail.co.uk> <49086F67.1030607@suse.de> <490872BF.2010908@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:26196 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbYJ2U1I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2008 16:27:08 -0400
Received: by ug-out-1314.google.com with SMTP id 39so737707ugf.37
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2008 13:27:04 -0700 (PDT)
In-Reply-To: <490872BF.2010908@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>

Alan Jenkins wrote:
> Alexey Starikovskiy wrote:
>   
>> Alan Jenkins wrote:
>>     
>>> Alexey Starikovskiy wrote:
>>>       
>>>> Please check if changing msleep to udelay helps.
>>>> Alan Jenkins wrote:
>>>>         
>>>>> Similar but different to the original symptoms of bugzilla #11089
>>>>> (which
>>>>> is closed, fixed by the specific patch I tested).  Hotkeys give up the
>>>>> ghost after being held down for a while, or pressed rapidly.  However
>>>>> they don't get "out of sync" as in that bug.  I've already tried the
>>>>> acpi-test tree, but that didn't fix it.
>>>>>           
>>> That was in acpi-test, unless I misread the changelog.  It's the main
>>> reason I tried that, I should have mentioned it, sorry.   So no, it
>>> didn't help.
>>>       
>> Any luck with bisect? 
>>     
>
> It didn't seem to like what I gave it.  I ended up at a commit which
> lacked the EC rewrite - when as far as I'm concerned, I'm tracking a
> regression from after that point.
>
> So I tried some manual fiddling, and I'm now starting a bisect between
> two different points on mainline.  That's got to work :).  It looks like
> it broke sometime after the main merge from the acpi tree.
>
> $ git-describe
> v2.6.27-7166-g765426e
> $ git-bisect good
> $ git-bisect bad v2.6.28-rc1
> Bisecting: 215 revisions left to test after this
>   

Well, that didn't work.

I wasn't quite methodical enough.  It depends on my doing something...
it might be the lid switch, or using the sound, or network, or switching
from battery to AC, or removing the battery...

So it needn't be a regression from the patches I tested before.  More
likely it's a problem with certain action(s) that I've only performed
recently.

Alan
