From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] tools/power/acpi: Add .gitignore file
Date: Mon, 27 Feb 2017 22:57:01 +0100
Message-ID: <CAJZ5v0gpOKYZRh1kJmTAz3DEyP=48XboELU1TtQwrh7mbwr0qQ@mail.gmail.com>
References: <1487541473-21479-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36432 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbdB0WEF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Feb 2017 17:04:05 -0500
Received: by mail-oi0-f68.google.com with SMTP id f192so1554672oic.3
        for <linux-acpi@vger.kernel.org>; Mon, 27 Feb 2017 14:03:47 -0800 (PST)
In-Reply-To: <1487541473-21479-1-git-send-email-prarit@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Sun, Feb 19, 2017 at 10:57 PM, Prarit Bhargava <prarit@redhat.com> wrote:
> Add a .gitignore file so that git commands do not pick up the resulting
> binaries and directories.
>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Lv Zheng <lv.zheng@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: devel@acpica.org

Missing sign-off.

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
> --
> 1.7.9.3

Thanks,
Rafael
