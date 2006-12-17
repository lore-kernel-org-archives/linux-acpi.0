From: "Lincoln Baxter, III" <lincolnbaxter@gmail.com>
Subject: Re: HP nc6400 v.03 or v.05 laptop ACPI fails after reboot, works
 again after booting windows
Date: Sun, 17 Dec 2006 13:51:06 -0500
Message-ID: <4585919A.9060907@gmail.com>
References: <457F37C0.3090003@gmail.com> <1165966936.29844.37.camel@pcjc2lap> <457FB1A1.2030602@gmail.com> <1166012707.22903.4.camel@pcjc2lap> <4582A607.8040302@gmail.com> <1166191807.7459.16.camel@pcjc2lap> <45832339.3050307@gmail.com> <20061216043002.GA29560@tangens.sinus.cz> <4583A779.3000902@gmail.com> <20061216081757.GA3571@invalid.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:17107 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbWLQSvL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Dec 2006 13:51:11 -0500
Received: by wx-out-0506.google.com with SMTP id h27so1173575wxd
        for <linux-acpi@vger.kernel.org>; Sun, 17 Dec 2006 10:51:10 -0800 (PST)
In-Reply-To: <20061216081757.GA3571@invalid.invalid>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


> As far as i know, the humming appears in windows too. I tested it with
> the RMClock utility and on my laptop, switching to C4 was making the
> humming. But every other C-State was quite. You should tune the timing
> frquencies, like Pavel pointed out.
>
> But i'm curios, why on linux the C4-State does not show up. The maximum
> working C-State on my system, on AC or battery is C3. Is there any
> hidden switch to enable it?
>
> with regards, frank
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Ok, thank you. With regard to the timing frequencies Is that in 
reference to the Kernel Frequency for Latency?
Eg. 1000 / 250 / 100 ?

There's nothing that I've found the enable the C4 state. It would be 
nice, since that is definitely the most power saving state. And do you 
have any ideas why the sound would not occur in windows? I'm pretty sure 
it's using the lower power states, because battery lasts a heck of a lot 
longer than in gentoo.

I'm not sure if I was using RMClock correctly, but it seems like the 
humming did not occur in windows. Perhaps you could give me a little 
guidance on how to use the tool properly?

Thanks.
Lincoln
