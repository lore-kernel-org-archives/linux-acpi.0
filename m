From: <Rezwanul_Kabir@Dell.com>
Subject: RE: [PATCH] acpi: Fall back to manually changing SCI_EN
Date: Tue, 20 Apr 2010 12:31:52 -0500
Message-ID: <57DF5FDC2DC0634FA2A310BC5B81A68D01DC9F1850@AUSX7MCPC108.AMER.DELL.COM>
References: <1271711614-15527-1-git-send-email-mjg@redhat.com>
 <20100420150010.GA17935@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausxippc101.us.dell.com ([143.166.85.207]:25419 "EHLO
	ausxippc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990Ab0DTRlx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Apr 2010 13:41:53 -0400
In-Reply-To: <20100420150010.GA17935@canonical.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: achiang@canonical.com, mjg@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org

Agree with getting Matthew's patch to fall back on force setting SCI_EN bit. I have discovered this issue recently with New Gen Dell systems where the systems were suspending right the first time around and then resorted to rebooting ( instead of resuming ) the second time. Also, the system would come with SCI interrupt disabled the first time around.
 I worked with the BIOS teams to get this fixed in the latest BIOS revs but just as Alex pointed out Matthew's approach seems to be the default bahaviour in the "Other OS". The problem may be more widespread than the limited set of blacklisted platforms..

Thanks..
   --rez
 

Rezwanul Kabir
Dell Inc.
512-725-0766
 

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org 
>[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Alex Chiang
>Sent: Tuesday, April 20, 2010 10:00 AM
>To: Matthew Garrett
>Cc: linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; 
>lenb@kernel.org
>Subject: Re: [PATCH] acpi: Fall back to manually changing SCI_EN
>
>* Matthew Garrett <mjg@redhat.com>:
>> The ACPI spec tells us that the ACPI SCI_EN bit is under hardware 
>> control and shouldn't be touched by the OS. It seems that 
>the Leading 
>> Other OS ignores this and some machines expect this 
>behaviour. We have 
>> a blacklist for these, but given that we're able to detect 
>the failure 
>> case and the alternative to breaking the spec is letting the machine 
>> crash and burn, let's try falling back when we know the 
>alternative is 
>> a mostly-dead machine.
>
>Yes, we got a hint from a Lenovo BIOS developer:
>
>	A SCI_EN bit had not been set at S3 resume post. It
>	should be set as ACPI defines. It seems that Windows OS
>	sets SCI_EN bit by itself after S3 resume....
>
>So I believe that Matthew's approach is reasonably safe and correct.
>
>Acked-by: Alex Chiang <achiang@canonical.com>
>
>/ac
>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-acpi" in the body of a message to 
>majordomo@vger.kernel.org More majordomo info at  
>http://vger.kernel.org/majordomo-info.html
>