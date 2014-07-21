From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] ACPI/NVS: Not save NVS region for new machines to accelerate
 S3
Date: Mon, 21 Jul 2014 10:14:31 +0800
Message-ID: <53CC7787.2070302@intel.com>
References: <1405662922-23606-1-git-send-email-tianyu.lan@intel.com> <20140718080056.GA2037@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39888 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbaGUCQ2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jul 2014 22:16:28 -0400
In-Reply-To: <20140718080056.GA2037@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gong.chen@linux.intel.com

On 2014=E5=B9=B407=E6=9C=8818=E6=97=A5 16:00, Chen, Gong wrote:
> On Fri, Jul 18, 2014 at 01:55:22PM +0800, Lan Tianyu wrote:
>> Date:	Fri, 18 Jul 2014 13:55:22 +0800
>> From: Lan Tianyu <tianyu.lan@intel.com>
>> To: rjw@rjwysocki.net, lenb@kernel.org
>> Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org,
>>  linux-kernel@vger.kernel.org
>> Subject: [PATCH] ACPI/NVS: Not save NVS region for new machines to
>>  accelerate S3
>> X-Mailer: git-send-email 1.7.9.5
>>
>> NVS region is saved and restored unconditionally for machines withou=
t
>> nvs_nosave quirk during S3. Tested some new machines and the operati=
on
>> is not necessary. Saving NVS region also affects S2RAM speed. The ti=
me of
>> NVS saving and restoring depends on the size of NVS region and it co=
nsumes
>> 7~10ms normally.
>>
>> This patch is to make machines produced from 2012 to now not saving =
NVS region
>> to accelerate S3.
>>
> The year 2012 is a mandatory value in the spec?
>=20

No, spec indicates that this is only required for S4 and commit 2a6b697
added this behavior because this can fix S3 bug on some machines. But
this isn't necessary for all machines and waster time for S3. So this
patch is to add time base quirk to change default behavior for new mach=
ines.

--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
