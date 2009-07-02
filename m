From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: EC
Date: Thu, 02 Jul 2009 11:45:13 +0400
Message-ID: <4A4C6589.4070108@suse.de>
References: <76780B19A496DC4B80439008DAD7076C03453A5BFC@PDSMSX501.ccr.corp.intel.com> <4A4C51AF.8080206@suse.de> <76780B19A496DC4B80439008DAD7076C03453A5CB9@PDSMSX501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:51030 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753109AbZGBHpN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2009 03:45:13 -0400
In-Reply-To: <76780B19A496DC4B80439008DAD7076C03453A5CB9@PDSMSX501.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Li, Shaohua =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
>> -----Original Message-----
>> From: Alexey Starikovskiy [mailto:astarikovskiy@suse.de]
>> Sent: Thursday, July 02, 2009 2:21 PM
>> To: Li, Shaohua
>> Cc: lenb@kernel.org; linux-acpi@vger.kernel.org
>> Subject: Re: EC
>>
>> Li, Shaohua =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> Hi,
>>> Preempt isn't disabled between ec_burst_enable()/ec_burst_disable()=
, so
>> it's very likely there is a preemption between them and make the tim=
ing
>> for burst mode not comply with ACPI spec (400ms for first access and=
 50ms
>> for subsequent access).
>>> We have a system with broken EC and the BIOS engineer identified it=
's
>> the timing issue.
>>> What's the judgment why Linux doesn't comply with ACPI spec?
>> Please disable ec_burst_* and check again. Judgement is that ec_burs=
t_* is
>> irrelevant to the protocol.
> What did you about 'irrelevant to the protocol'? This is what the spe=
c defines.
I mean, that EC may drop out of burst mode if timeout happens, and it s=
hould not change
the flow of reads and writes to EC (the protocol). More, EC should work=
 properly even if
we do not enter burst mode at all (my suggestion to disable calls to bu=
rst functions).=20
>=20
>> What platform and what other symptoms do you have? How exactly this =
EC is
>> broken?
> The temperature is wrong when we get it from reading EC. The BIOS eng=
ineer measured
> A lot of EC timeout in EC firmware, and they measured the timing how =
Linux accesses
> EC. The data they captured in oscilloscope shows Linux has long delay=
 to access
> Ec with burst mode enabled, this occurs more often when another appli=
cation is running.
Do they have any document about implemented EC timeouts? State diagram?=
 Other than burst timeout, do they have any other timeouts? What happen=
s if they get timeout, do they abort transaction? What do they write in=
 status register?
Do they send GPE? Please collect as much as you can, I was looking for =
such info for a very long time.

Thanks,
Alex.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
