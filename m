From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] include/acpi/processor.h: replace __attribute__((packed)) by __packed
Date: Thu, 19 Jun 2014 02:06:11 +0200
Message-ID: <1825061.Gkc4YambJC@vostro.rjw.lan>
References: <1401642977-3745-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50151 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756218AbaFRXsf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jun 2014 19:48:35 -0400
In-Reply-To: <1401642977-3745-1-git-send-email-fabf@skynet.be>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Sunday, June 01, 2014 07:16:17 PM Fabian Frederick wrote:
> This patch fixes checkpatch warnings:
> 
> "WARNING: __packed is preferred over __attribute__((packed))"
> 
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Applied, thanks!

> ---
>  include/acpi/processor.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 6eb1d3c..9b9b6f2 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -53,7 +53,7 @@ struct acpi_power_register {
>  	u8 bit_offset;
>  	u8 access_size;
>  	u64 address;
> -} __attribute__ ((packed));
> +} __packed;
>  
>  struct acpi_processor_cx {
>  	u8 valid;
> @@ -83,7 +83,7 @@ struct acpi_psd_package {
>  	u64 domain;
>  	u64 coord_type;
>  	u64 num_processors;
> -} __attribute__ ((packed));
> +} __packed;
>  
>  struct acpi_pct_register {
>  	u8 descriptor;
> @@ -93,7 +93,7 @@ struct acpi_pct_register {
>  	u8 bit_offset;
>  	u8 reserved;
>  	u64 address;
> -} __attribute__ ((packed));
> +} __packed;
>  
>  struct acpi_processor_px {
>  	u64 core_frequency;	/* megahertz */
> @@ -124,7 +124,7 @@ struct acpi_tsd_package {
>  	u64 domain;
>  	u64 coord_type;
>  	u64 num_processors;
> -} __attribute__ ((packed));
> +} __packed;
>  
>  struct acpi_ptc_register {
>  	u8 descriptor;
> @@ -134,7 +134,7 @@ struct acpi_ptc_register {
>  	u8 bit_offset;
>  	u8 reserved;
>  	u64 address;
> -} __attribute__ ((packed));
> +} __packed;
>  
>  struct acpi_processor_tx_tss {
>  	u64 freqpercentage;	/* */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
