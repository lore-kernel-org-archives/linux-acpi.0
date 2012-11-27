From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 02/15] ACPICA: Fixes comments caused divergences.
Date: Tue, 27 Nov 2012 03:32:11 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C94828D4CE85@FMSMSX108.amr.corp.intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com>
 <c319ad8c72da810bdb81d4092dbc547cc946d0b7.1353491652.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6897 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933062Ab2K0DcO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Nov 2012 22:32:14 -0500
In-Reply-To: <c319ad8c72da810bdb81d4092dbc547cc946d0b7.1353491652.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h index c743ca4..89fcc3e
> 100644
> --- a/include/acpi/platform/acenv.h
> +++ b/include/acpi/platform/acenv.h
> @@ -1,6 +1,6 @@
>  /******************************************************************************
>   *
> - * Name: acenv.h - Generation environment specific items
> + * Name: acenv.h - Host and compiler configuration
>   *
>   *****************************************************************************/
> 
> @@ -44,6 +44,12 @@
>  #ifndef __ACENV_H__
>  #define __ACENV_H__
> 
> +/*
> + * Environment configuration. The purpose of this file is to interface
> +ACPICA
> + * to the local environment. This includes compiler-specific,
> +OS-specific,
> + * and machine-specific configuration.
> + */
> +

Looks like the syntax got messed up here and line-wrapped before creating the patch.

-L
