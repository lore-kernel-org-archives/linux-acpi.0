From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH] ACPICA: Add hard limit to while loop
Date: Thu, 09 Oct 2008 21:38:26 +0400
Message-ID: <48EE4192.8060709@gmail.com>
References: <20081009103539.1238.81357.stgit@thinkpad> <4911F71203A09E4D9981D27F9D83085803123152@orsmsx503.amr.corp.intel.com> <4911F71203A09E4D9981D27F9D83085803123249@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:52619 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbYJIRiZ (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 9 Oct 2008 13:38:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so81657fgg.17
        for <Linux-acpi@vger.kernel.org>; Thu, 09 Oct 2008 10:38:01 -0700 (PDT)
In-Reply-To: <4911F71203A09E4D9981D27F9D83085803123249@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, LenBrown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

Moore, Robert wrote:
> I can take this from here.
>
> I see an opportunity here to implement a nice optimization for while loops. We currently allocate and free a control state for each iteration of the loop. This is overkill, we should just reuse the existing control state and only delete it when the loop terminates.
>
> Once this is done, we can add the loop counter to the control state to implement a loop counter on a per-while basis.
>
>   
Sounds great.
Thanks,
Alex.

