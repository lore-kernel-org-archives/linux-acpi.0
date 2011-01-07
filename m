From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [Resend][PATCH] PCI / ACPI: Request _OSC control once for each
 root bridge (v3)
Date: Fri, 7 Jan 2011 14:28:32 -0800
Message-ID: <20110107142832.5f4f1ae5@jbarnes-desktop>
References: <201101070055.10065.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201101070055.10065.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ozan Caglayan <ozan@pardus.org.tr>
List-Id: linux-acpi@vger.kernel.org

On Fri, 7 Jan 2011 00:55:09 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Move the evaluation of acpi_pci_osc_control_set() (to request control
> of PCI Express native features) into acpi_pci_root_add() to avoid
> calling it many times for the same root complex with the same
> arguments.  Additionally, check if all of the requisite _OSC
> support bits are set before calling acpi_pci_osc_control_set() for
> a given root complex.
> 
> References: https://bugzilla.kernel.org/show_bug.cgi?id=20232
> Reported-by: Ozan Caglayan <ozan@pardus.org.tr>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> 
> Hi,
> 
> This fixes a post-2.6.35 regression for Ozan, possibly -stable material.
> 

Applied, thanks, but I forgot the cc: stable, so please send the commit
id to stable@ once it lands in Linus's tree, if you still think it's
appropriate.

-- 
Jesse Barnes, Intel Open Source Technology Center
