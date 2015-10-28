From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Documentation: ACPI: add copy_dsdt to ACPI format options.
Date: Wed, 28 Oct 2015 04:14:52 +0100
Message-ID: <2139676.6gR7jZf83D@vostro.rjw.lan>
References: <1443284877-7537-1-git-send-email-ramirose@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61515 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752053AbbJ1Cpz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2015 22:45:55 -0400
In-Reply-To: <1443284877-7537-1-git-send-email-ramirose@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rami Rosen <ramirose@gmail.com>
Cc: rafael.j.wysocki@intel.com, ming.m.lin@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, September 26, 2015 07:27:57 PM Rami Rosen wrote:
> commit aa2110cb1a7510f9b834adfb39b05d4843a35d35
> ("ACPI: add boot option acpi=copy_dsdt to fix corrupt DSDT") added 
> copy_dsdt as an ACPI boot option, but did not add it to ACPI format options in
> Documentation/kernel-parameters.txt. This patch fixes it.
> 
> Signed-off-by: Rami Rosen <ramirose@gmail.com>
> ---
>  Documentation/kernel-parameters.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 22a4b68..bbf4ee6c 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -167,7 +167,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  
>  	acpi=		[HW,ACPI,X86,ARM64]
>  			Advanced Configuration and Power Interface
> -			Format: { force | off | strict | noirq | rsdt }
> +			Format: { force | off | strict | noirq | rsdt |
> +				  copy_dsdt }
>  			force -- enable ACPI if default was off
>  			off -- disable ACPI if default was on
>  			noirq -- do not use ACPI for IRQ routing
> 

Applied, thanks!

Rafael

