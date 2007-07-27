From: Jan Dittmer <jdi@l4x.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.23-rc1
Date: Fri, 27 Jul 2007 08:26:01 +0200
Message-ID: <46A98FF9.8060801@l4x.org>
References: <200707251238.50218.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S936458AbXG0G0X@vger.kernel.org>
In-Reply-To: <200707251238.50218.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Len Brown wrote:
> Hi Linus,
> 
> please pull from: 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

This seems to break ia64 defconfig:

   Building modules, stage 2.
   MODPOST 157 modules
FATAL: drivers/acpi/button: sizeof(struct acpi_device_id)=20 is not a modulo of the size of section __mod_acpi_device_table=144.
Fix definition of struct acpi_device_id in mod_devicetable.h
make[2]: *** [__modpost] Error 1
make[1]: *** [modules] Error 2
make: *** [_all] Error 2

gcc 3.3.6, binutils 2.15.94

http://l4x.org/k/?d=32569

Jan
