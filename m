From: Yinghai Lu <yinghai.lu@oracle.com>
Subject: Re: [PATCH]: x86: use acpi flags for apic mapping
Date: Thu, 03 Jun 2010 14:30:52 -0700
Message-ID: <4C081F0C.8060504@oracle.com>
References: <20100602192418.2706.35192.sendpatchset@prarit.bos.redhat.com> <20100602194956.GB5264@lenovo> <4C06D91F.2060105@redhat.com> <20100603172126.GA5502@lenovo> <4C07EF69.6050301@redhat.com> <4C0817CE.6050006@oracle.com> <4C081B4A.4060801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:64516 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754710Ab0FCVcb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jun 2010 17:32:31 -0400
In-Reply-To: <4C081B4A.4060801@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mjg@redhat.com, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Suresh Siddha <suresh.b.siddha@intel.com>

On 06/03/2010 02:14 PM, Prarit Bhargava wrote:
> 
>> It seems we don't need this patch.
>>
>> so all system should support phys apic mode, but system with less 8 cpus is supposed to support cluster mode for better performance.
>>
>> current kernel will try to use cluster mode if nr_cpus is less than 8.
>>
>> some system have problem like IBM and NCR only support phys apic mode even cpus < 8 ...
>>
>>   
> 
> What about systems that have set the ACPI values?  We just ignore those
> then?
we checked the value to see if it only support phys apic mode.

Yinghai
