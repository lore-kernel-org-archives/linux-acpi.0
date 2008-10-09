From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH] ACPICA: Add hard limit to while loop
Date: Thu, 09 Oct 2008 21:42:55 +0400
Message-ID: <48EE429F.8030903@gmail.com>
References: <20081009103539.1238.81357.stgit@thinkpad> <4911F71203A09E4D9981D27F9D83085803123152@orsmsx503.amr.corp.intel.com> <4911F71203A09E4D9981D27F9D83085803123249@orsmsx503.amr.corp.intel.com> <alpine.LFD.1.10.0810091230001.3007@localhost.localdomain> <4911F71203A09E4D9981D27F9D830858031232DF@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:57651 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754710AbYJIRmb (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 9 Oct 2008 13:42:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so82642fgg.17
        for <Linux-acpi@vger.kernel.org>; Thu, 09 Oct 2008 10:42:29 -0700 (PDT)
In-Reply-To: <4911F71203A09E4D9981D27F9D830858031232DF@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

Moore, Robert wrote:
> The mutex and event opcodes come to mind, the AML can wait forever on these (Acquire, Wait). However, the interpreter is released when these opcodes block, quite unlike a spinning while loop.
>
> As far as infinite spin loops, I think While() is the only case. There is no GoTo AML operator, so loops cannot be artificially created.
>
> So, I think the loop counter idea is ok. Of course, picking a maximum number might be a bit difficult. 64K loop iterations takes 4-5 seconds on my machine here (in Ring 3). That is a lot of loops for AML code, it might be ok.
>
> Besides, we can say "nobody would ever need more than 64K loop iterations", and get ourselves in the computer hall of fame.  :-)
>
>   
Well, AML is not intended as general purpose OS/language, so we might be 
safe saying such things. :)
I would be extremely glad if Phoenix did not have enough 
resources/features to implement EC driver in AML in
first place :)

Regards,
Alex.
