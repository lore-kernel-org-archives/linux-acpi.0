From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Bisection result: eeepc hotk breakage
Date: Fri, 31 Oct 2008 19:05:44 +0300
Message-ID: <490B2CD8.3000607@gmail.com>
References: <4907A511.3040603@tuffmail.co.uk> <4907A856.3050204@gmail.com> <4908307C.8060503@tuffmail.co.uk> <49086F67.1030607@suse.de> <490872BF.2010908@tuffmail.co.uk> <4908C714.5040104@tuffmail.co.uk> <4908C8EB.1010403@suse.de> <490ADD62.7090507@tuffmail.co.uk> <490B0D48.7040209@suse.de> <490B0DCB.40009@tuffmail.co.uk> <490B12F2.9050903@suse.de> <490B132A.3000904@tuffmail.co.uk> <490B1C3C.2080305@suse.de> <490B2863.7040602@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:23749 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbYJaQHN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Oct 2008 12:07:13 -0400
Received: by ug-out-1314.google.com with SMTP id 39so1280192ugf.37
        for <linux-acpi@vger.kernel.org>; Fri, 31 Oct 2008 09:05:45 -0700 (PDT)
In-Reply-To: <490B2863.7040602@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux acpi <linux-acpi@vger.kernel.org>, Matthew Wilcox <willy@linux.intel.com>

Alan Jenkins wrote:
> Nice.  Yes, that fixes it, thanks!
>
>   
great, I've updated #11917.
> I checked the commit diff for any similar potential errors.  Most of the
> changes are "obviously correct".  However, there are changes in
> thermal.c which look similar to the one that caused the problem in the
> EC driver.
>
> I think someone knowledgeable needs to audit the changes to the thermal
> driver, in case the Thinkpads start melting again :-P.  The commit#
> again: 27663c5855b10af9ec67bc7dfba001426ba21222.
>
>   
no, everything is fine in thermal -- they check status after every call.

Thanks again,
Alex.

