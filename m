From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/4] ata: ahci_platform: Add ACPI support for AMD Seattle
 SATA controller
Date: Wed, 17 Sep 2014 02:26:14 +0100
Message-ID: <20140917012614.GA31214@srcf.ucam.org>
References: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1410828446-28502-2-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1410828446-28502-2-git-send-email-suravee.suthikulpanit@amd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: suravee.suthikulpanit@amd.com
Cc: mark.rutland@arm.com, rjw@rjwysocki.net, graeme.gregory@linaro.org, arnd@arndb.de, marc.zyngier@arm.com, catalin.marinas@arm.com, olof@lixom.net, will.deacon@arm.com, linux-kernel@vger.kernel.org, astone@redhat.com, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, Sudeep.Holla@arm.com, grant.likely@linaro.org, linux-arm-kernel@lists.infradead.org, jason@lakedaemon.net
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 15, 2014 at 07:47:23PM -0500, suravee.suthikulpanit@amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> This patch adds ACPI match table in ahci_platform. The table includes
> the acpi_device_id to match AMD Seattle SATA controller with following
> asl structure in DSDT:
> 
>     Device (SATA0)
>     {
>       Name(_HID, "AMDI0600")	// Seattle AHSATA

There really ought to be a well-defined PNPID for AHCI, so you can _HID 
to AMD and _CID to something generic. That way we won't have:

> +#ifdef CONFIG_ATA_ACPI
> +static const struct acpi_device_id ahci_acpi_match[] = {
> +	{ "AMDI0600", 0 }, /* AMD Seattle AHCI */
> +	{ },
> +};

utter sadness here. Really, please don't end up in a situation where we 
need to add device-specific IDs to a generic driver.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
