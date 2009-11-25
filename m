From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI error during Sandybridge boot
Date: Wed, 25 Nov 2009 11:09:41 +0300
Message-ID: <4B0CE645.9000705@gmail.com>
References: <57C9024A16AD2D4C97DC78E552063EA3E39CC12C@orsmsx505.amr.corp.intel.com> <1259113351.2552.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:54556 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbZKYIJh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2009 03:09:37 -0500
Received: by fxm5 with SMTP id 5so6674717fxm.28
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2009 00:09:42 -0800 (PST)
In-Reply-To: <1259113351.2552.13.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: astarikovskiy@suse.de, linux-acpi@vger.kernel.org, "Kay, Allen M" <allen.m.kay@intel.com>, lenb@kernel.org

Hi Yakui,
May I see DSDT? What is the reason to not include ECDT while it's 
clearly needed by design?

Regards,
Alex.

ykzhao wrote:
> Hi, Alexey
>
>    The following warning message is complained on one box in the boot
> phase. And the EC opregion field is accessed in the GPE L01 method.
> After looking at the source code it seems that the GPE L01 is enabled
> before installing EC space handler.
>
>     There is no ECDT table in the acpidump. And there is no _INI object
> for the ACPI EC device. 
>     
>
> Any idea about this issue?
>     Can we also initialize the EC device and installing EC space handler
> earlier as we have done on the machine with the ECDT table?
>
> Thanks.
>     Yakui    
>
>   
>> [  371.362936] ACPI Exception: AE_NOT_EXIST, while evaluating GPE method [_L01] 
>> 20090521 evgpe-568
>> [  371.484758] ACPI Error: No handler for Region [ECF2] (ffff88006cc0b900) [Embe
>> ddedControl] 20090521 evregion-319
>> [  371.484780] ACPI Error: Region EmbeddedControl(3) has no handler 20090521 exf
>> ldio-294
>> [  371.484798] ACPI Error (psparse-0537): Method parse/execution failed [\_GPE._
>> L01] (Node ffff88006cc5c9a0), AE_NOT_EXIST
>> [  371.484917] ACPI Exception: AE_NOT_EXIST, while evaluating GPE method [_L01] 
>> 20090521 evgpe-568
>> [  371.608737] ACPI Error: No handler for Region [ECF2] (ffff88006cc0b900) [Embe
>> ddedControl] 20090521 evregion-319
>> [  371.608760] ACPI Error: Region EmbeddedControl(3) has no handler 20090521 exf
>> ldio-294
>> [  371.608785] ACPI Error (psparse-0537): Method parse/execution failed [\_GPE._
>> L01] (Node ffff88006cc5c9a0), AE_NOT_EXIST
>> [  371.609012] ACPI Exception: AE_NOT_EXIST, while evaluating GPE method [_L01] 
>> 20090521 evgpe-568
>> [  371.731704] ACPI Error: No handler for Region [ECF2] (ffff88006cc0b900) [Embe
>> ddedControl] 20090521 evregion-319
>> [  371.731726] ACPI Error: Region EmbeddedControl(3) has no handler 20090521 exf
>> ldio-294
>>     
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

