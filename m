From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCI / ACPI: Report _OSC control mask returned on
 failure to get control
Date: Mon, 9 May 2011 12:30:36 -0700
Message-ID: <20110509123036.170bfbd1@jbarnes-desktop>
References: <201104300021.38386.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201104300021.38386.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pci@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 30 Apr 2011 00:21:38 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> If an attempt to get _OSC control of the PCIe native features from
> the BIOS fails, report the resulting mask of control flags the BIOS
> was willing to grant in the error message.  Moreover, if the _OSC
> support mask is insufficient for requesting control of the PCIe
> native features or pcie_ports_disabled is set, print a diagnostic
> message containing the _OSC support mask.  This helps to diagnose
> obscure _OSC-related problems on a number machines.

Applied, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
