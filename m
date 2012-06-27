From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [PATCH v6 5/6] ACPI: Add _OST support for ACPI container hotplug
Date: Wed, 27 Jun 2012 15:05:52 +0900
Message-ID: <4FEAA2C0.5060804@jp.fujitsu.com>
References: <1340743374-18535-1-git-send-email-toshi.kani@hp.com> <1340743374-18535-6-git-send-email-toshi.kani@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:60105 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab2F0GGO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jun 2012 02:06:14 -0400
In-Reply-To: <1340743374-18535-6-git-send-email-toshi.kani@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, bhelgaas@google.com, shuahkhan@gmail.com, liuj97@gmail.com, andi@firstfloor.org, linux-kernel@vger.kernel.org

2012/06/27 5:42, Toshi Kani wrote:
> Changed container_notify_cb() to call ACPI _OST method when ACPI
> container hotplug operation has completed. Slightly restructured
> the code with the same logic except that the hot-add case will
> fail a request whenever device is set. This makes the error check
> to be more comprehensive.
> 
> The function sets eject_pending bit for an eject request since it
> does not initiate hot-remove operation. This bit is checked by the
> sysfs eject handler to determine if the request is originated from
> an ACPI eject notification.
> 
> Signed-off-by: Toshi Kani <toshi.kani@hp.com>

Thank you for updating the change log.

Reviewed-by: <isimatu.yasuaki@jp.fujitsu.com>

