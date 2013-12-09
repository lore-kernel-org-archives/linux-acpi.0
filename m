From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: full battery charge cannot exceed current one
Date: Mon, 9 Dec 2013 17:02:14 +0000
Message-ID: <20131209170214.GB30717@srcf.ucam.org>
References: <1386419801-10091-1-git-send-email-jan.vcelak@nic.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44804 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab3LIRCT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Dec 2013 12:02:19 -0500
Content-Disposition: inline
In-Reply-To: <1386419801-10091-1-git-send-email-jan.vcelak@nic.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Vcelak <jan.vcelak@nic.cz>
Cc: lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Dec 07, 2013 at 01:36:41PM +0100, Jan Vcelak wrote:
> Some degraded batteries report maximal capacity to be smaller than
> current charge of the battery. This can confuse some user space
> applications (like upower).

Can't we just fix upower?

> +
> +	/* Some degraded batteries report lower full charge than current one. */
> +	if (battery->capacity_now > battery->full_charge_capacity)
> +		battery->full_charge_capacity = battery->capacity_now;
> +

Does upower read *_full on every read of the value? How do we guarantee 
that it won't read energy_now without updating energy_full and still 
come up with an incorrect calculation?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
