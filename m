From: Steven Cole <elenstev@mesatop.com>
Subject: Re: 2.6.12-rc2-mm1: ACPI=y, ACPI_BOOT=n problems
Date: Wed, 06 Apr 2005 08:00:09 -0600
Message-ID: <4253EB69.6050702@mesatop.com>
References: <fa.gcqu6i7.1o6qrhn@ifi.uio.no>	<42524D83.1080104@reub.net>	<20050405121444.GB6885@stusta.de>	<6.2.3.0.2.20050406002812.04393a30@tornado.reub.net>	<20050405132417.GD6885@stusta.de>	<4252F090.4040605@mesatop.com> <20050405183655.0c778129.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262210AbVDFOA0@vger.kernel.org>
In-Reply-To: <20050405183655.0c778129.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: bunk@stusta.de, reuben-lkml@reub.net, len.brown@intel.com, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Andrew Morton wrote:
> Steven Cole <elenstev@mesatop.com> wrote:
> 
>>arch/i386/kernel/setup.c: In function 'setup_arch':
>> arch/i386/kernel/setup.c:1571: warning: implicit declaration of function 'acpi_boot_table_init'
>> arch/i386/kernel/setup.c:1572: warning: implicit declaration of function 'acpi_boot_init'
> 
> 
> 
> diff -puN include/linux/acpi.h~no-acpi-build-fix include/linux/acpi.h
> --- 25/include/linux/acpi.h~no-acpi-build-fix	2005-04-05 00:14:46.000000000 -0700
> +++ 25-akpm/include/linux/acpi.h	2005-04-05 00:23:39.000000000 -0700
> @@ -418,16 +418,6 @@ extern int sbf_port ;
[patch snipped]

Yes, that worked with no CONFIG_ACPI.  Thanks.

On a slightly offtopic note, I'm now using this gcc:
gcc (GCC) 4.0.0 20050308 (Red Hat 4.0.0-0.32)

I don't have any quantitative data at hand, this seems SLOOOOW.
I guess that's progress.  But it slows down testing somewhat.

Steven
