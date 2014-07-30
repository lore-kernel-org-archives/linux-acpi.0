From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ACPI: fix test for hex digit.
Date: Wed, 30 Jul 2014 13:00:12 -0700
Message-ID: <1406750412.12100.65.camel@joe-AO725>
References: <1406749932-1709-1-git-send-email-arjun024@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0181.hostedemail.com ([216.40.44.181]:33937 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751325AbaG3UAQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2014 16:00:16 -0400
In-Reply-To: <1406749932-1709-1-git-send-email-arjun024@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjun Sreedharan <arjun024@gmail.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2014-07-31 at 01:22 +0530, Arjun Sreedharan wrote:
> decimal 0 is ascii for NULL. Hex digit matching should be from '0'
> (decimal 30 of ascii) to '9' and 'A' to 'F'.
> Unfixed version returns true for #,$,%,& etc.
[]
> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
[]
> @@ -322,7 +322,7 @@ static const struct acpi_device_id acpi_pnp_device_ids[] = {
>  
>  static bool is_hex_digit(char c)
>  {
> -	return (c >= 0 && c <= '9') || (c >= 'A' && c <= 'F');
> +	return (c >= '0' && c <= '9') || (c >= 'A' && c <= 'F');
>  }

Maybe delete this and do s/is_hex_digit/isxdigit/ ?


