From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 14/48] PM: Fix oops in suspend/hibernate code related
 to failing ioremap()
Date: Wed, 12 Jan 2011 19:39:19 +0100
Message-ID: <4D2DF557.8030403@suse.cz>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org> <26fcaf60fe3861409eb4c455c5c0d0f00f599b08.1294827492.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39603 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617Ab1ALSj0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 13:39:26 -0500
Received: by bwz15 with SMTP id 15so791786bwz.19
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jan 2011 10:39:24 -0800 (PST)
In-Reply-To: <26fcaf60fe3861409eb4c455c5c0d0f00f599b08.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

On 01/12/2011 11:19 AM, Len Brown wrote:
> @@ -271,7 +271,7 @@ static inline int suspend_nvs_register(unsigned long a, unsigned long b)
>  }
>  static inline int suspend_nvs_alloc(void) { return 0; }
>  static inline void suspend_nvs_free(void) {}
> -static inline void suspend_nvs_save(void) {}
> +static inline int suspend_nvs_save(void) {}

Aiee, I've just noticed, this needs to return something, otherwise a
warning is generated for !CONFIG_SUSPEND_NVS.

What's better for you, a followup or resend?

thanks,
-- 
js
suse labs
