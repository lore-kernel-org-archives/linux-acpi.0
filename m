From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Add Intel GMA500(Poulsbo) Stub Driver
Date: Tue, 19 Oct 2010 22:58:51 -0700
Message-ID: <1287554331.1813.3.camel@Joe-Laptop>
References: <1287553879-25897-1-git-send-email-jlee@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.perches.com ([173.55.12.10]:3177 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755717Ab0JTF6x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Oct 2010 01:58:53 -0400
In-Reply-To: <1287553879-25897-1-git-send-email-jlee@novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: dri-devel@lists.freedesktop.org, randy.dunlap@oracle.com, mjg59@srcf.ucam.org, gregkh@suse.de, trenn@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu, Dennis.Jansen@web.de, airlied@linux.ie, airlied@redhat.com, eric@anholt.net, alexdeucher@gmail.com, bskeggs@redhat.com, chris@chris-wilson.co.uk, "Lee, Chun-Yi" <jlee@novell.com>

On Wed, 2010-10-20 at 13:51 +0800, Lee, Chun-Yi wrote:
> Currently, there have no GMA500(Poulsbo) native video driver to support
> intel opregion. So, use this stub driver to enable the acpi backlight
> control sysfs entry files by requrest acpi_video_register.
[]
> diff --git a/drivers/gpu/stub/poulsbo.c b/drivers/gpu/stub/poulsbo.c
[]
> +static struct pci_device_id pciidlist[] = {

DEFINE_PCI_DEVICE_TABLE
 

