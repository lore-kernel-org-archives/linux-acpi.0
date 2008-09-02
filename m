From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Tue, 02 Sep 2008 10:26:17 +0100
Message-ID: <48BD06B9.4060204@tuffmail.co.uk>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>	 <48BB9E86.7070503@suse.de>	 <1220320791.4039.128.camel@yakui_zhao.sh.intel.com>	 <48BCFB18.60706@suse.de> <1220347864.4039.189.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:64108 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbYIBJ0X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Sep 2008 05:26:23 -0400
Received: by an-out-0708.google.com with SMTP id d40so369960and.103
        for <linux-acpi@vger.kernel.org>; Tue, 02 Sep 2008 02:26:22 -0700 (PDT)
In-Reply-To: <1220347864.4039.189.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, lenb@kernel.org

Zhao Yakui wrote:
> On Tue, 2008-09-02 at 12:36 +0400, Alexey Starikovskiy wrote:   
>   
>>>     In fact when EC timeout happens in interrupt mode, it indicates that
>>> EC controller can't return response in time.
>>>       
>> Wrong. Some EC controllers are "optimized" to not send interrupts for each confirmation.
>> See history of EC patches for these optimization workarounds.
>>     
> Maybe what you said is right. But in fact as is defined in ACPI spec, EC
> controller should issue an interrupt according to the status of IBF and
> OBF.  More detailed info about EC interrupt model can be found in the
> section 12.6.2 of ACPI 3.0b spec.
> If some EC controller are "optimized" to not send interrupts, is it
> appropriate to reject such bugs?
>   
Not really.  If it works on "The Other OS", it is a bug that it doesn't
work on this one.  That's a specific policy of the linux ACPI
implementation.  Given both the complexity and importance of ACPI I
think it is the right policy.

Alan
