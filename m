From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH (resend)] acpiphp: Identify more removable slots
Date: Mon, 1 Dec 2008 12:40:45 -0800
Message-ID: <200812011240.45795.jbarnes@virtuousgeek.org>
References: <20081113235255.GA17709@srcf.ucam.org> <20081117134952.GA12932@srcf.ucam.org> <20081125214814.GA17248@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-156.bluehost.com ([67.222.39.36]:56335 "HELO
	outbound-mail-156.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750980AbYLAUkr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 15:40:47 -0500
In-Reply-To: <20081125214814.GA17248@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kristen.c.accardi@intel.com

On Tuesday, November 25, 2008 1:48 pm Matthew Garrett wrote:
> According to section 6.3.6 of the ACPI spec, the presence of an _RMV
> method that evaluates to 1 is sufficient to indicate that a slot is
> removable without needing an eject method. This patch refactors the
> ejectable slot detection code a little in order to flag these slots as
> ejectable and register them. Acpihp then binds to the expresscard slot
> on my HP test machine.
>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>

Applied to my linux-next branch, thanks Matthew.

-- 
Jesse Barnes, Intel Open Source Technology Center

