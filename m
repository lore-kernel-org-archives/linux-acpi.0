From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH] ACPI, APEI: Add validation check before GHES error is
 recorded
Date: Sat, 31 Mar 2012 09:53:05 +0800
Message-ID: <4F766381.4040104@linux.intel.com>
References: <1333004952-12403-1-git-send-email-gong.chen@linux.intel.com> <3908561D78D1C84285E8C5FCA982C28F15B73074@ORSMSX104.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4980 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106Ab2CaBxH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Mar 2012 21:53:07 -0400
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F15B73074@ORSMSX104.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

=E4=BA=8E 2012/3/30 1:07, Luck, Tony =E5=86=99=E9=81=93:
> +	if (mem_err->validation_bits&  CPER_MEM_VALID_PHYSICAL_ADDRESS)
> +		m.addr =3D mem_err->physical_addr;
>
> At the moment "addr" is the only useful value in this record ... so
> if we find that we can't supply it because we don't know it - then th=
e
> record has no value, and we might as well not send it.
>
> E.g. start the function with:
>
> 	if (!(mem_err->validation_bits&  CPER_MEM_VALID_PHYSICAL_ADDRESS))
> 		return;
>
> -Tony
>
But as Ying said before, in theory we need to support this scenario,=20
otherwise, I prefer to
add check condition out of this function, not here.

What's your opinion, Ying?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
