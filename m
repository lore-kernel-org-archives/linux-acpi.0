From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH 3/5] x86, acpi, cpu-hotplug: Introduce apicid_to_cpuid[]
 array to store persistent cpuid <-> apicid mapping.
Date: Wed, 15 Jul 2015 13:35:05 +0800
Message-ID: <55A5F109.3020705@linux.intel.com>
References: <1436261425-29881-1-git-send-email-tangchen@cn.fujitsu.com>	<1436261425-29881-4-git-send-email-tangchen@cn.fujitsu.com> <CAChTCPw6ZLs7XgApfN1exeB6TVcQji6ryq+HrK-admp=FGfiTA@mail.gmail.com> <55A5D4A5.8040806@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34654 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbbGOFfI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jul 2015 01:35:08 -0400
In-Reply-To: <55A5D4A5.8040806@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>, =?UTF-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.j.penttila@gmail.com>
Cc: rjw@rjwysocki.net, gongzhaogang@inspur.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org

On 2015/7/15 11:33, Tang Chen wrote:
> Hi Mika,
>=20
> On 07/07/2015 07:14 PM, Mika Penttil=C3=A4 wrote:
>> I think you forgot to reserve CPU 0 for BSP in cpuid mask.
>=20
> Sorry for the late reply.
>=20
> I'm not familiar with BSP.  Do you mean in get_cpuid(),
> I should reserve 0 for physical cpu0 in BSP ?
>=20
> Would you please share more detail ?

BSP stands for "Bootstrapping Processor". In other word,
BSP is CPU0.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
