From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH] [PATCH] wmi: Add support for module autoloading
Date: Sat, 7 Nov 2009 19:14:20 +0000
Message-ID: <9b2b86520911071114w262c8f5fo7a462f0f8b6abefb@mail.gmail.com>
References: <1257362273-15405-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:57652 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbZKGTU5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2009 14:20:57 -0500
Received: by bwz27 with SMTP id 27so2226615bwz.21
        for <linux-acpi@vger.kernel.org>; Sat, 07 Nov 2009 11:21:01 -0800 (PST)
In-Reply-To: <1257362273-15405-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, carlos@strangeworlds.co.uk, lenb@kernel.org

Hi Matthew

On 11/4/09, Matthew Garrett <mjg@redhat.com> wrote:
> WMI provides interface-specific GUIDs that are exported from modules as
> modalises, but the core currently generates no events to trigger module
> loading. This patch adds support for registering devices for each WMI GUID
> and generating the appropriate uevent.

I just realized there is no mention of "parent" in this patch.  Are
the WMI devices created without a parent device?  If so I believe they
would show up in /sys/devices/virtual, which seems wrong.  I think the
WMI devices ought to be children of the relevant ACPI device.

I also wonder if WMI should be a bus, instead of a class.  I guess
that's more work, but perhaps it can be fixed up some time in the
future.

Regards
Alan
