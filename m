From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] acpi: pmic: intel: initialize result to 0
Date: Sat, 25 Jun 2016 02:25:10 +0200
Message-ID: <2611529.zfATWBQadL@vostro.rjw.lan>
References: <1466607340-88687-1-git-send-email-heikki.krogerus@linux.intel.com> <1466607340-88687-3-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466607340-88687-3-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, Bin Gao <bin.gao@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday, June 22, 2016 05:55:40 PM Heikki Krogerus wrote:
> From: Felipe Balbi <felipe.balbi@linux.intel.com>
> 
> Fixes compiler warning.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/acpi/pmic/intel_pmic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
> index 3a3d416..1742718 100644
> --- a/drivers/acpi/pmic/intel_pmic.c
> +++ b/drivers/acpi/pmic/intel_pmic.c
> @@ -215,7 +215,7 @@ static acpi_status intel_pmic_regs_handler(u32 function,
>  		void *handler_context, void *region_context)
>  {
>  	struct intel_pmic_opregion *opregion = region_context;
> -	int result;
> +	int result = 0;
>  
>  	switch (address) {
>  	case 0:

Applied, thanks!
