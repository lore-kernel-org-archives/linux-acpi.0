From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v11 2/7] ACPI / OSL: Stub out
 acpi_os_(read/write)_pci_configurations()
Date: Wed, 19 Dec 2018 23:22:21 +0100
Message-ID: <24aefa0d-743c-dd06-79b7-ebcc01dbbb12@kernel.org>
References: <20181218025606.32668-1-okaya@kernel.org>
 <20181218025606.32668-3-okaya@kernel.org>
 <20181218073231.GB8612@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218073231.GB8612@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/18/2018 8:32 AM, Christoph Hellwig wrote:
>> +
>> +	rc = pr_warn_once("PCI configuration space access is not supported\n");
>> +	return rc ? AE_SUPPORT : AE_OK;
>> +#endif
> Normally we provide a full separate stub version.  If we have enough
> of them in a separate file.
> 

I removed the dependent functions from ACPICA and moved #ifdef outside of these
two function scopes.

Got rid of the inline piece.
