Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788AE2DEA6B;
	Wed, 15 Apr 2026 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776242117; cv=none; b=gzVC6Pkeiz3smGQptrWCalaVjx6HQJvaqr9To7JCAyQgAPDEh89Ilh7dsFRw/cio5ESaJLEt93BMKfubqO2lJbQ768hMTGMAuZ9Us9nOWKG51cuv9XV75/j+vVkcOXV0bFVKJeUkkM/yJ4azuGAE4EHg8GoDs1Jn/YtOh3e5tvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776242117; c=relaxed/simple;
	bh=BGNkUMK+RyXSyyBoGxSWfMyTqZY5e8RPZ0Ee7o4McVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpbZD8acY5cZI5zGLG+/vZVbo/CcXjW8eRuly3rJR87abXf28VymYrMzOZFWAcKWncE5oIDJcBQn9JkeCTyYYVG17HjoE3RG8yMQ7Zh3nHz9UqPeelRx8RA03rFM1DMdD5T3yyUw/NmBC0VTsaiQn7TqKbx6yQ6rwcjPNxDeD5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L4T88hlU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L4T88hlU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F6ZgSm1859930;
	Wed, 15 Apr 2026 08:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2IjIcO
	AHsaTv1L19m/3HXaImGx28qHJfjVKkY9vifRY=; b=L4T88hlUC7CAR9KvYAwDQH
	YvZfUahr0jn73iLRjEJ4i1Npd8l/WehCAlh9+rXrUFkuQ5pXSRx9ZKsRZDf0Gv0p
	HuodJl3CQuJlE3Dy9aaaozSxVVOl9wEYCanPIPeArSZhwsJhL84UclvuLhCK0e4G
	hRrTk+RKm9ahiJb1JiqVa0seMLdARXIBvsQ6LIvKWMCeW24omcRA3S78YzspoANp
	1eKAeGHVlZ50sYEnNiNxqrqw4nTKwOMkHi0AhCveaplBy2+K5+3S520MYvK7LYt8
	grhYJhlTynT9O1G+tAM0hxE+TnAMghLMa0OkTL4rHE27fMG/gqIYrHPeEj2wiUzQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pep73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 08:35:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F7GtYv015158;
	Wed, 15 Apr 2026 08:35:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msnh03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 08:35:09 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63F8Z7tt18743870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 08:35:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98D2458064;
	Wed, 15 Apr 2026 08:35:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 033FC5805E;
	Wed, 15 Apr 2026 08:35:05 +0000 (GMT)
Received: from [9.123.12.79] (unknown [9.123.12.79])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 08:35:04 +0000 (GMT)
Message-ID: <755caa0d-c574-4c58-a274-ce8f6f04aa9c@linux.ibm.com>
Date: Wed, 15 Apr 2026 14:05:03 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build failure in linux-next: implicit declaration of
 acpi_has_method
Content-Language: en-GB
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        lenb@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        luiz.dentz@gmail.com, Ritesh Harjani <riteshh@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <ad624e0d-cfd7-4521-ae33-c5c3287b4204@linux.ibm.com>
 <CAJZ5v0g4R+X+JXf1JB=3b_gqAdbyOv0drF242MCKkuNx1n4oow@mail.gmail.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <CAJZ5v0g4R+X+JXf1JB=3b_gqAdbyOv0drF242MCKkuNx1n4oow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: B0ZM7lO4gG56ctbOsRV23ozakcW1v8C3
X-Proofpoint-ORIG-GUID: TAQc_sj3RL9Ylp3xgO7WfkCt1uWIeNWO
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69df4dbe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=GhIUMZ6QRDI1o5qoBBoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA3NSBTYWx0ZWRfX3pIB+umLq0mF
 JFzqKG90pi4q1wJFpvn1Zuz2jjLxIN+KTLksp27efHLg8tSW8nsh/hp5MKIUZc1peHExLuIwnwD
 Yt97BUmla+3suh+bUTAccssi1lHEyY98i72GpTuCQtMBAbgJxQ9mRnuAhs/Bm81BeX6WphIhOGn
 n9k0y7cM3wuhJrRqmSQHFuZ/Q7Am1Cclc2E+scwhnOHbzclqKS8n+37+J+zkEJKzzoLzp+Z+171
 KG1uWIL/rrZkANhLKWTmsFBBpraOAPbtCc4fPYf/8HdDepXiEQdpbGnECGL0aE0jbo3FFF+Z2uq
 gmfqqmzdpMddvdXor6R0ZrX+IAEFl6Job6Dh+Ku5yXJtGlI2i9rXAKQtNTpwHlUyu7TvqN8Zt+H
 Ce/xcOkoUi2RFNJmK10ctx1ucOiM2ev1/YhBxJlRcWckMymBtAQlDuFZK/WzOqaUtksbgrQW236
 EU7h+aMO1oLQo6i1ChA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150075


On 15/04/26 12:50 pm, Rafael J. Wysocki wrote:
> On Wed, Apr 15, 2026 at 9:16 AM Venkat Rao Bagalkote
> <venkat88@linux.ibm.com> wrote:
>> Greetings!!!
>>
>> IBM CI has reported a build failure on linux-next repo.
>>
>> Failures:
>>
>> drivers/bluetooth/btintel_pcie.c: In function
>> ‘btintel_pcie_acpi_reset_method’:
>> drivers/bluetooth/btintel_pcie.c:2309:14: error: implicit declaration of
>> function ‘acpi_has_method’; did you mean ‘acpi_has_watchdog’?
>> [-Werror=implicit-function-declaration]
>>    2309 |         if (!acpi_has_method(handle, "_PRR")) {
>>         |              ^~~~~~~~~~~~~~~
>>         |              acpi_has_watchdog
>>
>>
>> The function acpi_has_method() lacks a stub definition in
>> include/linux/acpi.h
>> for the !CONFIG_ACPI case, unlike other ACPI utility functions.
> Code that calls acpi_has_method() clearly depends on ACPI though, so
> building it in the !CONFIG_ACPI case is questionable.


Thank you so much for the review and explanation!!

Adding the stub, would just hide the real issue. I guess, proper fix is 
to add the ACPI dependency in Kconfig.



# git diff
diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index c5d45cf91f88..fc1b37044a9b 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -502,7 +502,7 @@ config BT_NXPUART

  config BT_INTEL_PCIE
         tristate "Intel HCI PCIe driver"
-       depends on PCI
+       depends on PCI && ACPI
         select BT_INTEL
         select FW_LOADER
         help


Can you please confirm, if this the right approach before I submit a 
formal patch.

Thank you again for your patience and guidance.


Regards,

Venkat.

>> Below diff fixes the build failure.
>>
>>
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index bfacb9475aac..d3804f7f2610 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1100,6 +1100,11 @@ static inline const char
>> *acpi_get_subsystem_id(acpi_handle handle)
>>           return ERR_PTR(-ENODEV);
>>    }
>>
>> +static inline bool acpi_has_method(acpi_handle handle, char *name)
>> +{
>> +        return false;
>> +}
>> +
> This doesn't belong in include/linux/acpi.h.
>
> It might go into include/acpi/acpi_bus.h, but see above.
>
>>    static inline int acpi_register_wakeup_handler(int wake_irq,
>>           bool (*wakeup)(void *context), void *context)
>>    {
