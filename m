From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ACPI / sysfs: Extend ACPI sysfs to provide access to
 boot error region
Date: Fri, 18 Aug 2017 01:30:47 +0100
Message-ID: <20170818013047.427e38b7@alans-desktop>
References: <CAJZ5v0gML6bX2QW65Kv+huJtM4ZUjhw6PC=52hh8NiK-9Uqpzg@mail.gmail.com>
        <20170817213946.16939-1-tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:57936 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752872AbdHRAbD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Aug 2017 20:31:03 -0400
In-Reply-To: <20170817213946.16939-1-tony.luck@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Boris Petkov <bp@suse.de>, Tyler Baicar <tbaicar@codeaurora.org>, Punit Agrawal <punit.agrawal@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 17 Aug 2017 14:39:46 -0700
"Luck, Tony" <tony.luck@intel.com> wrote:

> From: Tony Luck <tony.luck@intel.com>
> 
> The ACPI sysfs interface provides a way to read each ACPI table from
> userspace via entries in /sys/firmware/acpi/tables/
> 
> The BERT table simply provides the size and address of the error
> record in BIOS reserved memory and users may want access to this
> record.
> 
> In an earlier age we might have used /dev/mem to retrieve this error
> record, but many systems disable /dev/mem for security reasons.
> 
> Extend this driver to provide read-only access to the data via a
> file in a new directory /sys/firmware/acpi/tables/data/BERT

Should this not also have a capability check. Assuming file permissions
are sufficient for grabbing a chunk of system memory holding error
info doesn't seem too scary but it's at odds with a lot of other cases ?

Alan
