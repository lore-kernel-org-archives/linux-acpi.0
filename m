From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH] [PATCH] wmi: Add support for module autoloading
Date: Wed, 4 Nov 2009 20:40:51 +0000
Message-ID: <200911042040.51113.carlos@strangeworlds.co.uk>
References: <1257362273-15405-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:39447 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331AbZKDUko (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Nov 2009 15:40:44 -0500
Received: by ewy3 with SMTP id 3so3548931ewy.37
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2009 12:40:48 -0800 (PST)
In-Reply-To: <1257362273-15405-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Wednesday 04 November 2009 19:17:53 Matthew Garrett wrote:
> WMI provides interface-specific GUIDs that are exported from modules as
> modalises, but the core currently generates no events to trigger module
> loading. This patch adds support for registering devices for each WMI GUID
> and generating the appropriate uevent.
> 
> Based heavily on a patch by Carlos Corbacho (<carlos@strangeworlds.co.uk>).
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>

Works fine on my old Acer Aspire 5020:

Tested-by: Carlos Corbacho <carlos@strangeworlds.co.uk>

And FWIW:

Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
