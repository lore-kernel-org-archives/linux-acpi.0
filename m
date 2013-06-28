From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH v2 2/2] mce: acpi/apei: Add a boot option to disable ff
 mode for corrected errors
Date: Fri, 28 Jun 2013 10:31:57 -0700
Message-ID: <CA+8MBbJNY7G+q=kBgOA=+jVtugrfteoMvwLtfwvCno5xg+dm-Q@mail.gmail.com>
References: <20130621072725.GB22006@pd.tnic>
	<20130628120224.7781.45438.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130628120224.7781.45438.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Borislav Petkov <bp@alien8.de>, ananth@in.ibm.com, masbock@linux.vnet.ibm.com, lcm@linux.vnet.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Huang Ying <ying.huang@intel.com>
List-Id: linux-acpi@vger.kernel.org

> +                       if (sec_sev == GHES_SEV_CORRECTED &&
> +                           (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED) &&
> +                           (mem_err->validation_bits & CPER_MEM_VALID_PHYSICAL_ADDRESS)) {
> +                               unsigned long pfn;
> +                               pfn = mem_err->physical_addr >> PAGE_SHIFT;

As Reagan said "Trust ... but verify" ... we should make sure BIOS
gave us a good pfn
                                    if (pfn_valid(pfn))
                                         soft_memory_failure_queue(pfn, 0, 0);
                                    else
                                         printk( ...something about
BIOS giving us bad pfn = %lu\n", pfn);
> +                       }
