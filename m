From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 05/13] libata-acpi: s/CONFIG_SATA_ACPI/CONFIG_ATA_ACPI/
Date: Sat, 28 Apr 2007 14:54:57 -0400
Message-ID: <46339881.2020403@garzik.org>
References: <11772636664152-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <11772636664152-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Tejun Heo wrote:
> ACPI applies to both SATA and PATA.  Drop the 'S' from the config
> variable.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/Kconfig    |   26 +++++++++++++-------------
>  drivers/ata/Makefile   |    2 +-
>  drivers/ata/libata.h   |    2 +-
>  include/linux/libata.h |    2 +-
>  4 files changed, 16 insertions(+), 16 deletions(-)

ACK patches 4-5


