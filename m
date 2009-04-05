From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: MacBook5,2 not supported
Date: Sun, 05 Apr 2009 10:22:41 +0400
Message-ID: <49D84E31.4050109@gmail.com>
References: <6b36610d0904041536m53cde1daje7667df5f71a9e97@mail.gmail.com>	 <49D7F040.6050109@gmail.com> <6b36610d0904042310u26027e56h88239c94707c2877@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:43513 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbZDEGWq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Apr 2009 02:22:46 -0400
Received: by bwz17 with SMTP id 17so1449324bwz.37
        for <linux-acpi@vger.kernel.org>; Sat, 04 Apr 2009 23:22:43 -0700 (PDT)
In-Reply-To: <6b36610d0904042310u26027e56h88239c94707c2877@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Silvio Sisto <sisto.silvio@gmail.com>
Cc: linux-acpi@vger.kernel.org

Silvio Sisto wrote:
>> What exactly happens if you try to boot without acpi=off flag?
>>     
>
> It crashes with a blank screen just a few seconds after starting to boot.
>
>   
>> Are you able to boot at least with acpi=ht flag?
>>     
>
> It crashes the same way as without acpi=off flag.
>
> Right now I have Linux 2.6.27-11. Should I try with latest one?
>
>   
Please first remove "quiet splash", there should be more information on 
the screen.
> Thanks for your reply.
> Best regards,
> Silvio Sisto
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

