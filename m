From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Thu, 27 Jul 2006 00:52:42 +0100
Message-ID: <20060726235242.GA27638@srcf.ucam.org>
References: <CFF307C98FEABE47A452B27C06B85BB601125524@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:51342 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751821AbWGZXxE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Jul 2006 19:53:04 -0400
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB601125524@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Richard Hughes <hughsient@gmail.com>, Dmitry Torokhov <dtor_core@ameritech.net>, linux-acpi@vger.kernel.org, gnome-power-manager-list@gnome.org, hal@lists.freedesktop.org, desktop_portables@lists.osdl.org

On Wed, Jul 26, 2006 at 07:41:26PM -0400, Brown, Len wrote:

> The only question I have is how to transition.
> If I replace the acpi_bus_generate_event() calls for
> power/sleep/lid/hotkeys
> and replace them with input_report_key(), will there be something up
> there
> listening for these events when acpid does not get them?

Right now, hal will get those events and transmit them to further 
applications. I don't think there's a drop in acpid replacement yet, but 
gnome-power-manager (for instance) will currently react accordingly.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
