From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: Fan speeds on HP nc6400 and nc8430
Date: Fri, 19 Jan 2007 16:14:17 +0800
Message-ID: <3877989d0701190014t38614d02odaf4700a6f8aea27@mail.gmail.com>
References: <C3FA62B1A90D7440B9B6C7C31895994F03663637@zadbn02100.vodacom.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:51640 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964934AbXASIOS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jan 2007 03:14:18 -0500
Received: by wx-out-0506.google.com with SMTP id h31so450494wxd
        for <linux-acpi@vger.kernel.org>; Fri, 19 Jan 2007 00:14:18 -0800 (PST)
In-Reply-To: <C3FA62B1A90D7440B9B6C7C31895994F03663637@zadbn02100.vodacom.corp>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pieter De Wit <Pieter.DeWit@vodacom.co.za>
Cc: linux-acpi@vger.kernel.org

Do you have psmouse module loaded ?
(i.e. CONFIG_MOUSE_PS2=m)
If yes, Please try remove it, and re-test it.

Thanks,
Luming

On 1/19/07, Pieter De Wit <Pieter.DeWit@vodacom.co.za> wrote:
> Hello List,
>
> I have noted that the fan speed on "idle" is much higher in Linux
> compared to XP. I have also noted that once fans are turned on, they
> never seem to return to the off state. I am currently using the 2.6.18
> kernel from Gentoo (gentoo-sources-r6). I was wondering if there is a
> way I can lower the fan speed, or even assist the devs to get info
> regarding these notebooks (if any is needed).
>
> Thanks,
>
> Pieter
> "This e-mail is sent on the Terms and Conditions that can be accessed by Clicking on this link http://www.vodacom.co.za/legal/email.jsp "
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
