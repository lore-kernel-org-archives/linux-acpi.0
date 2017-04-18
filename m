From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] tools/power/acpi: Add .gitignore file
Date: Tue, 18 Apr 2017 16:39:07 +0200
Message-ID: <20176923.YlBd9EUYdy@aspire.rjw.lan>
References: <1488552251-20573-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41858 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751378AbdDROpL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Apr 2017 10:45:11 -0400
In-Reply-To: <1488552251-20573-1-git-send-email-prarit@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>, Lv Zheng <lv.zheng@intel.com>
Cc: linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, devel@acpica.org

On Friday, March 03, 2017 09:44:11 AM Prarit Bhargava wrote:
> v2: added sign off .. oops.  Sorry about that.
> 
> P.
> 
> ---8<---
> 
> Add a .gitignore file so that git commands do not pick up the resulting
> binaries and directories.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Lv Zheng <lv.zheng@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: devel@acpica.org
> ---
>  tools/power/acpi/.gitignore |    4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100644 tools/power/acpi/.gitignore
> 
> diff --git a/tools/power/acpi/.gitignore b/tools/power/acpi/.gitignore
> new file mode 100644
> index 000000000000..cba3d994995c
> --- /dev/null
> +++ b/tools/power/acpi/.gitignore
> @@ -0,0 +1,4 @@
> +acpidbg
> +acpidump
> +ec
> +include

Lv, any concerns here?

Thanks,
Rafael

