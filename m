From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [RFC PATCH 1/3] pci,
 acpi: Match PCI config space accessors against
 platfrom specific ECAM quirks.
Date: Fri, 03 Jun 2016 09:57:40 -0700
Message-ID: <5751B704.7010208@gmail.com>
References: <1464856864-18049-1-git-send-email-tn@semihalf.com>
 <1464856864-18049-2-git-send-email-tn@semihalf.com>
 <57519F09.2010201@codeaurora.org>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F76E9D7@lhreml507-mbx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F76E9D7@lhreml507-mbx>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "okaya@codeaurora.org" <okaya@codeaurora.org>, Wangyijing <wangyijing@huawei.com>, "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>, "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>, Tomasz Nowicki <tn@semihalf.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>, "helgaas@kernel.org" <helgaas@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "liudongdong (C)" <liudongdong3@huawei.com>, "msalter@redhat.com" <msalter@redhat.com>, "arnd@arndb.de" <arnd@arndb.de>, Liviu.Dudau@arm.
List-Id: linux-acpi@vger.kernel.org

On 06/03/2016 08:32 AM, Gabriele Paoloni wrote:
[...]
>>> +struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
>>> +{
>>> +	int bus_num = root->secondary.start;
>>> +	int domain = root->segment;
>>> +	struct pci_cfg_fixup *f;
>>> +
>>> +	if (!mcfg_table)
>>> +		return &pci_generic_ecam_ops;
>>> +
>>> +	/*
>>> +	 * Match against platform specific quirks and return
>> corresponding
>>> +	 * CAM ops.
>>> +	 *
>>> +	 * First match against PCI topology <domain:bus> then use OEM ID
>> and
>>> +	 * OEM revision from MCFG table standard header.
>>> +	 */
>>> +	for (f = __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups;
>> f++) {
>>> +		if ((f->domain == domain || f->domain ==
>> PCI_MCFG_DOMAIN_ANY) &&
>>> +		    (f->bus_num == bus_num || f->bus_num ==
>> PCI_MCFG_BUS_ANY) &&
>>> +		    (!strncmp(f->oem_id, mcfg_table->header.oem_id,
>>> +			      ACPI_OEM_ID_SIZE)) &&
>>> +		    (f->oem_revision == mcfg_table->header.oem_revision))
>>
>> Is this more likely to be updated between quirky and fixed platforms
>> than oem_table_id? What do folks think about using oem_table_id instead
>> of, or in addition to, oem_revision?
>
>  From my understanding we need to stick to this mechanism as (otherwise)
> there are platforms out in the field that would need a FW update.
>
> So I don't think that using oem_table_id "instead" is possible; about
> "in addition" I think it is doable, but I do not see the advantage much.
> I mean that if a platform gets fixed the oem revision should change too,
> Right?

I think you are correct.  My take away on discussions about using this 
style of quirk matching was that we would require the oem_revision to 
change as different quirks (or lack of quirks) were required.

David Daney


>
> Thanks
>
> Gab
>
