From: =?ISO-8859-1?Q?Paul-J=FCrgen_Wagner?= <paul-juergen.wagner@gmx.at>
Subject: Re: DSDT on Averatec 1050
Date: Thu, 11 May 2006 19:17:56 +0200
Message-ID: <446371C4.70009@gmx.at>
References: <44635E8A.406@gmx.at> <1147365765.9319.271.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:25265 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030377AbWEKRR6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 May 2006 13:17:58 -0400
In-Reply-To: <1147365765.9319.271.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi@vger.kernel.org

Hi Thomas,

thanks for your prompt reply!

>>dsdt.dsl  1657:                         Field (IO, ByteAcc, Lock, Preserve)
>>Error    4094 -                                 ^ parse error, 
>>unexpected PARSEOP_IO, expecting error or PARSEOP_NAMESEG or 
>>PARSEOP_NAMESTRING
> 
> 
> You can workaround by renaming the field to XIO...

I thought of that for a microsecond, but was to anxious to rename things 
I do not understand ;-)

> For these object not exist messages:
> dsdt.dsl  1929:                                     Store (Arg0, DAT0)
> Error    4062 -                               Object does not exist ^ 
> (DAT0)
> 
> You need to add addtional external (DAT0) statements at the beginning of
> your DSDT.
> These variables are probably defined in SSDT. I think you have to
> replace DAT0 with the whole path e.g. \_SB.xy.DAT0.

Sorry, but what is 'xy'?

> The kernel sometimes (at boot and during operation) says:
> 
>      ACPI-0142: *** Error: Store into Alias - should never happen
>      ACPI-1172: *** Error: Method execution failed 
> [\_SB_.PCI0.SBRG.EC0_._Q0C] (Node c14b4c20), AE_AML_INTERNAL
> 
> This sounds unrelated to your DSDT errors, but sever. Robert extended
> the Alias stuff some months ago, maybe something slipped in...
> 
> Best is you point us to the whole acpidump and whole dmesg output.

OK, will do that when I'm on my laptop again; may take some days.

BTW, does it hurt that I'm not using the latest kernel?

Paul

