From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Improve acpi_dbg_level= documentation
Date: Thu, 19 Apr 2007 13:35:42 -0400
Message-ID: <200704191335.42445.lenb@kernel.org>
References: <200704181221.37897.ak@suse.de> <200704181626.21213.lenb@kernel.org> <20070418223513.GA20204@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39857 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1766909AbXDSRhH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Apr 2007 13:37:07 -0400
In-Reply-To: <20070418223513.GA20204@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Andi Kleen <ak@suse.de>, linux-acpi@vger.kernel.org

On Wednesday 18 April 2007 18:35, Dave Jones wrote:
> On Wed, Apr 18, 2007 at 04:26:20PM -0400, Len Brown wrote:
>  
>  > lenb@nx6325:~> cat /sys/module/acpi/parameters/debug_level
>  > Description                     Hex        SET
>  > ACPI_LV_ERROR                   0x00000001 [*]
>  > ACPI_LV_WARN                    0x00000002 [*]
>  > ACPI_LV_INIT                    0x00000004 [*]
>  > ACPI_LV_DEBUG_OBJECT            0x00000008 [*]
>  > ACPI_LV_INFO                    0x00000010 [ ]
>  > ACPI_LV_INIT_NAMES              0x00000020 [ ]
>  > ACPI_LV_PARSE                   0x00000040 [ ]
>  > ACPI_LV_LOAD                    0x00000080 [ ]
>  > ACPI_LV_DISPATCH                0x00000100 [ ]
>  > ACPI_LV_EXEC                    0x00000200 [ ]
>  > ACPI_LV_NAMES                   0x00000400 [ ]
>  > ACPI_LV_OPREGION                0x00000800 [ ]
>  > ACPI_LV_BFIELD                  0x00001000 [ ]
>  > ACPI_LV_TABLES                  0x00002000 [ ]
>  > ACPI_LV_VALUES                  0x00004000 [ ]
>  > ACPI_LV_OBJECTS                 0x00008000 [ ]
>  > ACPI_LV_RESOURCES               0x00010000 [ ]
>  > ACPI_LV_USER_REQUESTS           0x00020000 [ ]
>  > ACPI_LV_PACKAGE                 0x00040000 [ ]
>  > ACPI_LV_ALLOCATIONS             0x00100000 [ ]
>  > ACPI_LV_FUNCTIONS               0x00200000 [ ]
>  > ACPI_LV_OPTIMIZATIONS           0x00400000 [ ]
>  > ACPI_LV_MUTEX                   0x01000000 [ ]
>  > ACPI_LV_THREADS                 0x02000000 [ ]
>  > ACPI_LV_IO                      0x04000000 [ ]
>  > ACPI_LV_INTERRUPTS              0x08000000 [ ]
>  > ACPI_LV_AML_DISASSEMBLE         0x10000000 [ ]
>  > ACPI_LV_VERBOSE_INFO            0x20000000 [ ]
>  > ACPI_LV_FULL_TABLES             0x40000000 [ ]
>  > ACPI_LV_EVENTS                  0x80000000 [ ]
>  > --
>  > debug_level = 0x0000000F (* = enabled)
> 
> Seems to violate the 'one value per file' rule.

That isn't a rule, it is a convention, and the convention
is violated in other places too -- such as cpufreq stats.

basically, sysfs text files are nice for humans
but parsing text files is a pain for programs.
Indeed, one could argue that the /dev ioctl() programming model
is superior to sysfs if you care only about programs.

I think the one-value-per-file convention is basically
to address the fact that writing programs to parse
text files is a PITA.

This file will unlikely ever be read by a program,
but will be read by a human.

> ok, it's one value broken down into its component parts,
> but still, it's a bit ott, and we don't do similar
> expansion for other bitmasks in sysfs do we?

Life on the cutting edge, it is:-)
If you have a specific suggestion for improvement, just let me know.

-Len
