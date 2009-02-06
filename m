From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 1/2] PCI/ACPI: move _OSC code to pci_root.c
Date: Fri, 06 Feb 2009 14:43:06 +0900
Message-ID: <498BCDEA.6030307@jp.fujitsu.com>
References: <498AF51F.7070200@jp.fujitsu.com> <498AF557.4040601@jp.fujitsu.com> <20090205154936.GC24033@ldl.fc.hp.com> <4911F71203A09E4D9981D27F9D830858142EB3B4@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4911F71203A09E4D9981D27F9D830858142EB3B4@orsmsx503.amr.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Alex Chiang <achiang@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Andrew Patterson <andrew.patterson@hp.com>
List-Id: linux-acpi@vger.kernel.org

Moore, Robert wrote:
> The acpi_evaluate_object_typed interface automatically handles the two error cases you check for:
> 
> 1) Checks for the case where no object is returned
> 2) Checks for the correct return object type (buffer in this case)
> 
> Use of this interface would simplify and shrink the code.
> 

Sounds good to me, but I have a question.

The acpi_evaluate_object_typed() function seems to be compiled
only when ACPI_FUTURE_USAGE is defined. And it seems that there
is no prototype declaration. I don't know about ACPI_FUTURE_USAGE
at all. Could you please tell me what I should do to use
acpi_evaluate_object_typed()?

Thanks,
Kenji Kaneshige
