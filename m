From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH v3 1/3] ACPI : introduce macros for using the ACPI specification
 version
Date: Fri, 03 Jul 2015 13:32:33 -0600
Message-ID: <5596E351.5090100@redhat.com>
References: <1435880916-2153-1-git-send-email-al.stone@linaro.org> <1435880916-2153-2-git-send-email-al.stone@linaro.org> <55961AB3.70801@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48155 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211AbbGCTcf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Jul 2015 15:32:35 -0400
In-Reply-To: <55961AB3.70801@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Al Stone <al.stone@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org

On 07/02/2015 11:16 PM, Hanjun Guo wrote:
> Hi Al,
> 
> On 2015/7/3 7:48, Al Stone wrote:
>> Add the __ACPI_FADT_SPEC_VERSION() helper macro to build a proper version
>> number from a major and minor revision number.  Add also macros that use
>> the helper to construct the current version from the values in the FADT
>> (i.e., ACPI_FADT_SPEC_VERSION) and both the 5.1 and 6.0 versions.
>>
>> These macros are added in order to simplify retrieving and comparing ACPI
>> specification version numbers, since this is becoming a more frequent need.
>> In particular, there are some architectures that require at least a certain
>> version of the spec, and there are differences in some structure sizes that
>> have changed with recent versions but can only be tracked by spec version
>> number.
>>
>> Fixes: aeb823bbacc2 (ACPICA: ACPI 6.0: Add changes for FADT table.)
> 
> If I understand correctly, will it be (and for next two patches as well):
> 
> 0cff8dc0099f (ACPICA: ACPI 6.0: Add changes for MADT table.)?
> 
> FADT table update was not introduce any regressions for ARM64
> I think.
> 
> Thanks
> Hanjun
> 

Right.  As I noted in the discussion over v2 of these patches, the FADT
change is correctly implementing a change for ACPI 6.0.  However, it is this
change which adds eight bytes to the GICC subtable so that the struct length
and the length field in the GICC subtable no longer match, which is what
causes BAD_MADT_ENTRY to fail.

So, while this commit is correct, the patches in this set are needed to work
around the ambiguity this causes in the spec and the ACPICA implementation of
it.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
