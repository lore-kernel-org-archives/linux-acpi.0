From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 2/2] PCI/AER: Determine AER ownership based on _OSC
 instead of HEST
Date: Thu, 15 Nov 2018 16:43:38 -0700
Message-ID: <20181115234338.GE13334@localhost.localdomain>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <20181115231605.24352-3-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115231605.24352-3-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: helgaas@google.com, austin_bolen@dell.com, alex_gagniuc@dellteam.com, Shyam_Iyer@Dell.com, lukas@wunner.de, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell Currey <ruscur@russell.cc>, Sam Bobroff <sbobroff@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 15, 2018 at 05:16:03PM -0600, Alexandru Gagniuc wrote:
>  static void aer_set_firmware_first(struct pci_dev *pci_dev)
>  {
> -	int rc;
> -	struct aer_hest_parse_info info = {
> -		.pci_dev	= pci_dev,
> -		.firmware_first	= 0,
> -	};
> +	struct pci_host_bridge *host = pci_find_host_bridge(pci_dev->bus);
>  
> -	rc = apei_hest_parse(aer_hest_parse, &info);
> -
> -	if (rc)
> -		pci_dev->__aer_firmware_first = 0;
> -	else
> -		pci_dev->__aer_firmware_first = info.firmware_first;
> +	pci_dev->__aer_firmware_first = !host->native_aer;
>  	pci_dev->__aer_firmware_first_valid = 1;
>  }

I think we can clean this up even more by removing the setter and the
__aer_firmware_first fields, and have the pcie_aer_get_firmware_first()
go directly to the host bride->native_aer.
