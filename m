From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version
 2
Date: Sun, 16 Sep 2007 14:22:55 +0200
Message-ID: <46ED201F.3060109@gmail.com>
References: <20070915030154.GA17655@srcf.ucam.org> <20070915170652.GA25504@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20070915170652.GA25504@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> +static void ata_acpi_notify(acpi_handle handle, u32 event, void *data)
> +{
> +	struct ata_port *ap = data;
> +	struct ata_eh_info *ehi = &ap->eh_info;
> +
> +	ata_ehi_clear_desc(ehi);
> +	ata_ehi_push_desc(ehi, "ACPI event");
> +	ata_ehi_hotplugged(ehi);
> +	ata_port_freeze(ap);

You probably want to wrap the above inside ap->lock.

-- 
tejun
