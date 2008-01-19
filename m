From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 6/5] ACPI: DMI blacklist for OSI(Linux)
Date: Sat, 19 Jan 2008 09:16:52 +0100
Message-ID: <p73abn29qmj.fsf@bingen.suse.de>
References: <1200565490-29619-1-git-send-email-lenb@kernel.org>
	<0bf08de2227cabeb40a6ea72b3fa188a2e325335.1200565331.git.len.brown@intel.com>
	<200801190250.28250.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42239 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775AbYASIQz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 03:16:55 -0500
In-Reply-To: <200801190250.28250.lenb@kernel.org> (Len Brown's message of "Sat\, 19 Jan 2008 02\:50\:28 -0500")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Len Brown <lenb@kernel.org> writes:
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -1,6 +1,8 @@
>  /*
>   *  blacklist.c
>   *
> + *  X86 specific ACPI blacklists.
> + *
>   *  Check to see if the given machine has a known bad ACPI BIOS
>   *  or if the BIOS is too old.
>   *
> @@ -165,3 +167,578 @@ int __init acpi_blacklisted(void)
>  
>  	return blacklisted;
>  }
> +#ifdef CONFIG_DMI

IA64 sets CONFIG_DMI too. So it won't be x86 specific as written.
Probably shoud check for CONFIG_X86 too.

> +extern void dmi_osi_linux(int enable, const struct dmi_system_id *d);

That should be in some include, shouldn't it?

-Andi

