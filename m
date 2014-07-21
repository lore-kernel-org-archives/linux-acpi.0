From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] ACPI/NVS: Not save NVS region for new machines to accelerate
 S3
Date: Mon, 21 Jul 2014 13:54:56 +0800
Message-ID: <53CCAB30.405@intel.com>
References: <1405662922-23606-1-git-send-email-tianyu.lan@intel.com> <20140718080056.GA2037@gchen.bj.intel.com> <53CC7787.2070302@intel.com> <20140721050105.GA21503@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25684 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175AbaGUF4y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jul 2014 01:56:54 -0400
In-Reply-To: <20140721050105.GA21503@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gong.chen@linux.intel.com

On 2014=E5=B9=B407=E6=9C=8821=E6=97=A5 13:01, Chen, Gong wrote:
> On Mon, Jul 21, 2014 at 10:14:31AM +0800, Lan Tianyu wrote:
>> Date: Mon, 21 Jul 2014 10:14:31 +0800
>> From: Lan Tianyu <tianyu.lan@intel.com>
>> To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
>>  linux-kernel@vger.kernel.org, gong.chen@linux.intel.com
>> Subject: Re: [PATCH] ACPI/NVS: Not save NVS region for new machines =
to
>>  accelerate S3
>> User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:14.0) Gecko/2=
0120714
>>  Thunderbird/14.0
>>
>> On 2014=E5=B9=B407=E6=9C=8818=E6=97=A5 16:00, Chen, Gong wrote:
>>> On Fri, Jul 18, 2014 at 01:55:22PM +0800, Lan Tianyu wrote:
>>>> Date:	Fri, 18 Jul 2014 13:55:22 +0800
>>>> From: Lan Tianyu <tianyu.lan@intel.com>
>>>> To: rjw@rjwysocki.net, lenb@kernel.org
>>>> Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org,
>>>>  linux-kernel@vger.kernel.org
>>>> Subject: [PATCH] ACPI/NVS: Not save NVS region for new machines to
>>>>  accelerate S3
>>>> X-Mailer: git-send-email 1.7.9.5
>>>>
>>>> NVS region is saved and restored unconditionally for machines with=
out
>>>> nvs_nosave quirk during S3. Tested some new machines and the opera=
tion
>>>> is not necessary. Saving NVS region also affects S2RAM speed. The =
time of
>>>> NVS saving and restoring depends on the size of NVS region and it =
consumes
>>>> 7~10ms normally.
>>>>
>>>> This patch is to make machines produced from 2012 to now not savin=
g NVS region
>>>> to accelerate S3.
>>>>
>>> The year 2012 is a mandatory value in the spec?
>>>
>>
>> No, spec indicates that this is only required for S4 and commit 2a6b=
697
>> added this behavior because this can fix S3 bug on some machines. Bu=
t
>> this isn't necessary for all machines and waster time for S3. So thi=
s
>> patch is to add time base quirk to change default behavior for new m=
achines.
>>
> If so, I don't think a hard-coded valud in the kernel is a good idea.
> Why not providing a quirk via a command line parameter or module para=
meter.
>=20

There is already a kernel command "acpi_sleep=3Dnonvs_s3" to do that. B=
ut
this needs to be set by user. Otherwise, saving/restoring NVS region
also breaks system suspend on some machines and we have added 14
nonvs quirks in the acpisleep_dmi_table.

=46rom the spec side, it's not necessary and the default behavior shoul=
d
follow spec. For some special machines which need saving/restoring NVS
region to workaround system suspend, it should be dealt with quirk and
do it when necessary. To avoid regressions on the old machines, the
change only applies to new machines. Other side, not saving/restoring
NVS is also helpful to accelerate S3.

--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
