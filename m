From: "Lincoln Baxter, III" <lincolnbaxter@gmail.com>
Subject: Re: HP nc6400 v.03 or v.05 laptop ACPI fails after reboot, works
 again after booting windows
Date: Thu, 21 Dec 2006 16:44:07 -0500
Message-ID: <458B0027.2000909@gmail.com>
References: <457F37C0.3090003@gmail.com> <1165966936.29844.37.camel@pcjc2lap> <457FB1A1.2030602@gmail.com> <1166012707.22903.4.camel@pcjc2lap> <4582A607.8040302@gmail.com> <1166191807.7459.16.camel@pcjc2lap> <45832339.3050307@gmail.com> <20061216043002.GA29560@tangens.sinus.cz> <4583A779.3000902@gmail.com> <20061216081757.GA3571@invalid.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.224]:33359 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423046AbWLUVoL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Dec 2006 16:44:11 -0500
Received: by wx-out-0506.google.com with SMTP id h27so2508585wxd
        for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2006 13:44:10 -0800 (PST)
In-Reply-To: <20061216081757.GA3571@invalid.invalid>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Frank Ursel wrote:
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
Is there a way to force the driver into a specific state? Or to manually 
add a state? I still cannot access C0 (max frequency), C4, or C5 power 
saving states, that are all supposed to be supported by the Intel 
Centrino Core Duo CPU

Can someone point me to the code that determines the voltage / amperage 
pairings for CPUs in power saving mode? Is this handled by the ACPI bios 
(bios function call), or does the kernel directly affect the power setting?

I'd like to take a look and see what's going on.
