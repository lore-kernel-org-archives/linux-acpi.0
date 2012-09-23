From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ACPI: Override arbitrary ACPI tables via initrd for
 debugging
Date: Sun, 23 Sep 2012 00:25:40 -0400
Message-ID: <505E8F44.9020208@kernel.org>
References: <1348234085-39220-1-git-send-email-trenn@suse.de> <1348234085-39220-3-git-send-email-trenn@suse.de> <505DD65F.9080203@kernel.org> <201209230317.04050.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201209230317.04050.trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, vojcek-wYtBgQxc//8@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> +config ACPI_INITRD_TABLE_OVERRIDE
> +       bool
> +       default y

Do distros in addition to SuSE concur they want to ship this way?

The last time we tried to make debugging easier we added
ACPI_CUSTOM_METHOD, which allowed root to over-ride an AML method
on a running system.  Distro security-minded people were not amused.

thanks,
-Len Brown, Intel Open Source Technology Center

ps I noticed your reference to acpidump in the README.
That reminded me to push it to the kernel source tree.
Its new home will be tools/power/acpi/
