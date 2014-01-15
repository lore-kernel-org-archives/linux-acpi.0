From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH 0/3] ACPI: Integrate tools/power/acpi Makefile into tools
 Makefile.
Date: Wed, 15 Jan 2014 14:48:34 -0700
Message-ID: <52D70232.2030809@redhat.com>
References: <cover.1376378577.git.lv.zheng@intel.com> <cover.1389676901.git.lv.zheng@intel.com> <52D6BFA9.80609@redhat.com> <1A7043D5F58CCB44A599DFD55ED4C948452C20CD@FMSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24521 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354AbaAOVsg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jan 2014 16:48:36 -0500
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C948452C20CD@FMSMSX106.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 01/15/2014 02:43 PM, Brown, Len wrote:
>> Is there any work going on to reconcile (or merge or ...) this
>> version of acpidump with the version in upstream ACPICA?  The
>> sources are very different yet they seem to me to provide more
>> or less the same functionality.
>
> Yes, that is exactly what is going on.
> The acpidump in the kernel tree today is what we've been using for years.

Right.

> The acpidump in the ACPICA tree its newly developed replacement.
> When we cut over to the new, it will replace the old.

Ah, okay.

> There is no big feature change here -- mostly the idea is
> simply that more benefit from sharing the code maintained in the
> upstream ACPICA source tree.
>
> cheers,
> -Len
>

Thanks, Len.  I suspected that might be the case.  That's good to
hear -- it makes my life a little easier maintaining the distro
packages for the ACPCICA user space tools.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
