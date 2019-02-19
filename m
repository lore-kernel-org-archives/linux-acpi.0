From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / processor: Set P_LVL{2,3} idle state descriptions
Date: Tue, 19 Feb 2019 10:57:02 +0100
Message-ID: <3670654.07UQUedC4A@aspire.rjw.lan>
References: <20190218013335.233265-1-Yazen.Ghannam@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218013335.233265-1-Yazen.Ghannam@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Monday, February 18, 2019 2:33:49 AM CET Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> The ACPI idle driver will fallback to using the legacy P_LVL* SystemIO
> method of entering C-states if the _CST method is disabled and P_BLK is
> defined. However, in this case the C2 and C3 states won't have a
> description set, so the user will see "<null>" when reading the
> description from sysfs.
> 
> Give each of these states a description.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/acpi/processor_idle.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index b2131c4ea124..98d4ec5bf450 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -282,6 +282,13 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
>  			  pr->power.states[ACPI_STATE_C2].address,
>  			  pr->power.states[ACPI_STATE_C3].address));
>  
> +	snprintf(pr->power.states[ACPI_STATE_C2].desc,
> +			 ACPI_CX_DESC_LEN, "ACPI P_LVL2 IOPORT 0x%x",
> +			 pr->power.states[ACPI_STATE_C2].address);
> +	snprintf(pr->power.states[ACPI_STATE_C3].desc,
> +			 ACPI_CX_DESC_LEN, "ACPI P_LVL3 IOPORT 0x%x",
> +			 pr->power.states[ACPI_STATE_C3].address);
> +
>  	return 0;
>  }
>  
> 

Applied, thanks!
