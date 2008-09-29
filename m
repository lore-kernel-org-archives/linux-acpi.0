From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Bug (?) in ACPI info reporting
Date: Tue, 30 Sep 2008 00:04:46 +0400
Message-ID: <48E134DE.7060308@gmail.com>
References: <1222708111.3688.15.camel@shaptop.om-md.eros-os.com>	 <48E12277.6060801@gmail.com>	 <1222714691.3688.32.camel@shaptop.om-md.eros-os.com>	 <48E12B34.804@gmail.com> <1222718070.15685.0.camel@shaptop.om-md.eros-os.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:26097 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbYI2UEu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Sep 2008 16:04:50 -0400
Received: by ug-out-1314.google.com with SMTP id k3so431116ugf.37
        for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2008 13:04:48 -0700 (PDT)
In-Reply-To: <1222718070.15685.0.camel@shaptop.om-md.eros-os.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Jonathan S. Shapiro" <shap@eros-os.com>
Cc: linux-acpi@vger.kernel.org

Jonathan S. Shapiro wrote:
> On Mon, 2008-09-29 at 23:23 +0400, Alexey Starikovskiy wrote:
>   
>> Then this is most probably shortcoming of BIOS on your machine,
>> design values are hardcoded, while actual values are read from battery 
>> itself.
>>     
>
> That would make a sad sort of sense, yes.
>
> acpidump as attachment this time, just to confirm.
>   
Ok, only two batteries are known to BIOS, one is NiMH, the other is Li-Ion.
Li-Ion has hard-coded design capacity of 0x1770 or 6000.
So, this is bug in BIOS of your machine, you might call technical 
support if you care.
I am not aware of any actual use of design values, so you are pretty 
safe while ignoring them.
                If (^^PCI0.LPCB.EC0.MBNH)
                {
                    Store (0x2328, Index (PBIF, One))
                    Store (0x1C20, Index (PBIF, 0x04))
                    Store ("OANI$", Index (PBIF, 0x09))
                    Store ("NiMH", Index (PBIF, 0x0B))
                }
                Else
                {
                    Store (0x1770, Index (PBIF, One))
                            ^^^^^^
                    Store (0x39D0, Index (PBIF, 0x04))
                    Sleep (0x32)
                    Store ("LION", Index (PBIF, 0x0B))
                }

Regards,
Alex.
