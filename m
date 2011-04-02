From: Dan Carpenter <error27@gmail.com>
Subject: Re: Regression 2.6.39-rc1 for sony-laptop
Date: Sat, 2 Apr 2011 14:55:38 +0300
Message-ID: <BANLkTikVGWM3T1y2XvwkHB+Yub5EhG1RPA@mail.gmail.com>
References: <AANLkTi=1xtjEZc2C1=W-v2oYbvvcGH9k_DGGXvJ8=swq@mail.gmail.com>
	<20110401172241.GA26851@srcf.ucam.org>
	<BANLkTikPjwowBge82viT+Ma5UnP0fA-pew@mail.gmail.com>
	<20110402100043.GA5890@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62685 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab1DBLzl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Apr 2011 07:55:41 -0400
In-Reply-To: <20110402100043.GA5890@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Andrea Gelmini <andrea.gelmini@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, anssi.hannula@iki.fi, linux-acpi@vger.kernel.org, axel.lin@gmail.com, trenn@suse.de, len.brown@intel.com, linux-kernel@vger.kernel.org

On 4/2/11, Mattia Dongili <malattia@linux.it> wrote:
> --- a/drivers/platform/x86/sony-laptop.c
> +++ b/drivers/platform/x86/sony-laptop.c
> @@ -810,6 +810,11 @@ static int sony_nc_handles_cleanup(struct
> platform_device *pd)
>  static int sony_find_snc_handle(int handle)
>  {
>  	int i;
> +
> +	/* not initialized yet, return early */
> +	if (!handles)
> +		return -1;

-1 is -EPERM.  That's not the right error code here.  Maybe -EINVAL?

regards,
dan carpenter
