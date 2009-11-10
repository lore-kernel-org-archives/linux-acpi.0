From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the hcd
Date: Tue, 10 Nov 2009 09:20:03 +0100
Message-ID: <200911100920.03361.oliver@neukum.org>
References: <1257806610-6570-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:52899 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbZKJIRc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2009 03:17:32 -0500
In-Reply-To: <1257806610-6570-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, rjw@sisk.pl, stern@rowland.harvard.edu

Am Montag, 9. November 2009 23:43:30 schrieb Matthew Garrett:
> The PCI runtime power management code means that we can implement support
> for powering down PCI host controllers. This patchset adds core support
>  code along with a new hcd flag (HCD_RUNTIME_PM) that allows hosts to opt
>  in if they support this functionality. Successfully tested with Intel EHCI
>  and UHCI, though the UHCI code may need to pay more attention to
>  vendor-specific features.

Extremely cool. However it makes me wonder about remote wakeup.
Do you know whether that works?

	Regards
		Oliver
