From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] Re: [Patch] MCE, APEI: Don't enable CMCI when Firmware
 First mode is set in
Date: Mon, 17 Jun 2013 12:30:44 +0530
Message-ID: <51BEB41C.2000808@linux.vnet.ibm.com>
References: <3908561D78D1C84285E8C5FCA982C28F2DA47F03@ORSMSX101.amr.corp.intel.com> <20130614181721.11206.95341.stgit@localhost.localdomain> <20130616122030.GA12290@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:54481 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab3FQHBQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jun 2013 03:01:16 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Mon, 17 Jun 2013 16:46:43 +1000
In-Reply-To: <20130616122030.GA12290@nazgul.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com

On 06/16/2013 05:50 PM, Borislav Petkov wrote:
> On Fri, Jun 14, 2013 at 11:47:21PM +0530, Naveen N. Rao wrote:
>> +static int __init hest_parse_cmc(struct acpi_hest_header *hest_hdr, void *data)
>> +{
>> +	int i;
>> +	struct acpi_hest_ia_corrected *cmc;
>> +	struct acpi_hest_ia_error_bank *mc_bank;
>> +
>> +	if (hest_hdr->type != ACPI_HEST_TYPE_IA32_CORRECTED_CHECK)
>> +		return 0;
>> +
>> +	if (!((struct acpi_hest_generic *)hest_hdr)->enabled)
>> +		return 0;
>> +
>> +	cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
>> +	if (!(cmc->flags & ACPI_HEST_FIRMWARE_FIRST))
>> +		return 0;
>> +
>> +	/*
>> +	 * We expect HEST to provide a list of MC banks that
>> +	 * report errors through firmware first mode.
>> +	 */
>> +	if (cmc->num_hardware_banks <= 0)
>> +		return 0;
>> +
>> +	pr_info("HEST: Enabling Firmware First mode for corrected errors\n");
>> +
>> +	mc_bank = (struct acpi_hest_ia_error_bank *)(cmc + 1);
>> +	for (i = 0; i < cmc->num_hardware_banks; i++, mc_bank++)
>> +		mce_disable_bank(mc_bank->bank_number);
>
> One more thing: we never trust the BIOS so mce_disable_bank() should
> sanity-check this mc_bank->bank_number against the number of the
> actually available banks on the system before disabling anything.

Agreed. Will add the check.

>
> Thanks.
>

Thanks,
Naveen

