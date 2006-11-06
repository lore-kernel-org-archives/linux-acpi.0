From: Dave Jones <davej@redhat.com>
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
Date: Mon, 6 Nov 2006 12:20:49 -0500
Message-ID: <20061106172049.GA19283@redhat.com>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <200611051832.13285.christiand59@web.de> <20061106060021.GD5778@stusta.de> <200611061643.14217.christiand59@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753506AbWKFRWB@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200611061643.14217.christiand59@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian <christiand59@web.de>
Cc: Adrian Bunk <bunk@stusta.de>, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 06, 2006 at 04:43:13PM +0100, Christian wrote:

 > > Did you have CONFIG_ACPI_PROCESSOR=y in 2.6.18, or did
 > > CONFIG_ACPI_PROCESSOR=m, CONFIG_X86_POWERNOW_K8=y work for you in 2.6.18?
 > 
 > It worked with CONFIG_ACPI_PROCESSOR=m in 2.6.18-rc7. Since 2.6.19-rc1 it 
 > doesn't work anymore with CONFIG_ACPI_PROCESSOR=m.
 > 
 > user@ubuntu:~/Projekte/linux-2.6.18-rc7$ grep -i ACPI_PROCESSOR /boot/config-2.6.18-rc7
 > CONFIG_ACPI_PROCESSOR=m
 > 
 > user@ubuntu:~/Projekte/linux-2.6.18-rc7$ 
 > grep -Ei "POWERNOW_K8" /boot/config-2.6.18-rc7
 > CONFIG_X86_POWERNOW_K8=m
 > CONFIG_X86_POWERNOW_K8_ACPI=y
 > 
 > +++ There's a difference in 2.6.19! CONFIG_X86_POWERNOW_K8_ACPI is gone +++

I don't understand how this was allowed. Because when I try this
with a 2.6.18 tree..  (nothing changed between -rc7 and final for cpufreq)

<editted a .config to match your config>

$ grep ACPI_PROCESSOR .config
CONFIG_ACPI_PROCESSOR=m
$ grep POWERNOW_K8 .config
CONFIG_X86_POWERNOW_K8=y
CONFIG_X86_POWERNOW_K8_ACPI=y

and then after a make oldconfig the CONFIG_X86_POWERNOW_K8_ACPI is removed
as it isn't valid.

Did you edit your .config by hand ?

	Dave

-- 
http://www.codemonkey.org.uk
