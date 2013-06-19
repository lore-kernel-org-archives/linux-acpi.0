From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] Re: [Patch] MCE, APEI: Don't enable CMCI when Firmware
 First mode is set in
Date: Wed, 19 Jun 2013 12:28:56 +0530
Message-ID: <51C156B0.1080102@linux.vnet.ibm.com>
References: <20130617082135.GB7203@pd.tnic> <20130618063858.3645.75676.stgit@localhost.localdomain> <CA+8MBbL+iLkAXp0ytQwydpuow05jMzSDFMogx1RcMN715yBFbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:39725 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933863Ab3FSG7H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jun 2013 02:59:07 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Wed, 19 Jun 2013 12:24:33 +0530
In-Reply-To: <CA+8MBbL+iLkAXp0ytQwydpuow05jMzSDFMogx1RcMN715yBFbQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Luck <tony.luck@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Huang Ying <ying.huang@intel.com>

On 06/19/2013 03:59 AM, Tony Luck wrote:
> On Mon, Jun 17, 2013 at 11:43 PM, Naveen N. Rao
> <naveen.n.rao@linux.vnet.ibm.com> wrote:
>> +       if (bank >= mca_cfg.banks) {
>> +               pr_info("mce_disable_bank: Invalid MCA bank %d ignored.\n", bank);
>
> Let's have a FW_BUG in that message to point a finger at the source of
> the problem.

Ok.

>
>
> +       apei_hest_parse(hest_parse_cmc, NULL);
>
> I think we want a boot command line option to opt out of this. "nohestcmc"??

Ok, I will add a boot option for this.


Thanks,
Naveen

