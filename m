From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH - Resend] PNPACPI: only parse device that have CRS method
Date: Mon, 12 Sep 2005 08:39:27 -0600
Message-ID: <200509120839.27115.bjorn.helgaas@hp.com>
References: <4324030F.3090406@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751158AbVILOqX@vger.kernel.org>
In-Reply-To: <4324030F.3090406@free.fr>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: matthieu castet <castet.matthieu@free.fr>
Cc: acpi-devel@lists.sourceforge.net, Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>
List-Id: linux-acpi@vger.kernel.org

On Sunday 11 September 2005 4:12 am, matthieu castet wrote:
> this patch blacklist device that don't have CRS method as there are
> useless for pnp layer as they don't provide any resource.
> 
> Please comment and consider for inclusion.

Looks reasonable to me.
