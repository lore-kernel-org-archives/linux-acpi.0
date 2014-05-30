From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPICA: Tables: Add mechanism to control early table checksum verification.
Date: Sat, 31 May 2014 00:29:52 +0200
Message-ID: <5036363.2JsBlNKmXC@vostro.rjw.lan>
References: <e28682572e0736657b0120aeec5f64ac21159faf.1401415540.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62837 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932299AbaE3WMn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 May 2014 18:12:43 -0400
In-Reply-To: <e28682572e0736657b0120aeec5f64ac21159faf.1401415540.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, lkp@vger.linux-kernel.cn, x86@kernel.org

On Friday, May 30, 2014 10:07:31 AM Lv Zheng wrote:

[cut]

> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index b5f7132..380828d 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -162,6 +162,14 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_create_osi_method, TRUE);
>  ACPI_INIT_GLOBAL(u8, acpi_gbl_use_default_register_widths, TRUE);
>  
>  /*
> + * Optionally verify the table checksum before installation. Set this to

What about "Whether or not to verify ..." instead of "Optionally verify ..."?

> + * TRUE to verify the table checksum before install it to the table
> + * manager. Note that some OSPMs cannot do large mappings during the
> + * certain stages.

The "Note that ..." thing is completely unuseful here, because it is not
particularly clear why being unable to use large mappings is related to
this option (I know it is, but a casual reader may not know that).

What about "Note that enabling this option causes errors to happen in
some OSPMs during early initialization stages" instead?

> Default is behavior is to do such verification.
> + */

Please fix the double "is".

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
