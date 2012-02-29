From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH] ACPI, APEI, EINJ, limit the range of einj_param
Date: Wed, 29 Feb 2012 10:44:33 +0800
Message-ID: <4F4D9111.2010701@linux.intel.com>
References: <1330418695-8005-1-git-send-email-gong.chen@linux.intel.com> <1330419255.7432.11.camel@yhuang-dev> <3908561D78D1C84285E8C5FCA982C28F03F983@ORSMSX104.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63509 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965501Ab2B2Cog (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Feb 2012 21:44:36 -0500
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F03F983@ORSMSX104.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

=E4=BA=8E 2012/2/29 2:33, Luck, Tony =E5=86=99=E9=81=93:
>> parameter support.  Or we can fix einj_get_parameter_address() to re=
turn
>> NULL if param_extension is 0 and paddrv5 is 0.
>
> That was my intent ... but it looks like I managed to lose that in
> some code re-arrangement.
>
> Perhaps (Outlook will white-space mangle, but it is only one line):
>
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 4ca087d..3d3816f 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -238,7 +238,7 @@ static void *einj_get_parameter_address(void)
>   			return v5param;
>   		}
>   	}
> -	if (paddrv4) {
> +	if (param_extension&&  paddrv4) {
>   		struct einj_parameter *v4param;
>
>   		v4param =3D acpi_os_map_memory(paddrv4, sizeof(*v4param));
>
>

After combination the opinions from Ying and Tony, the current fix is t=
he
simplest. Any other changes will make codes more complex. So I prefer t=
o
keep current style. What's your opinion?

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
