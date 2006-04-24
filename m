From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Date: Mon, 24 Apr 2006 16:09:27 +0100
Message-ID: <20060424150927.GA21096@srcf.ucam.org>
References: <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <mj+md-20060420.165714.18107.albireo@ucw.cz> <4447C020.3010003@linux.intel.com> <20060420220731.GF2352@ucw.cz> <444C761F.6010603@linux.intel.com> <20060424083102.GE26345@elf.ucw.cz> <444CE310.7030006@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:4791 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750901AbWDXPJo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Apr 2006 11:09:44 -0400
Content-Disposition: inline
In-Reply-To: <444CE310.7030006@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Pavel Machek <pavel@suse.cz>, Martin Mares <mj@ucw.cz>, "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 06:39:12PM +0400, Alexey Starikovskiy wrote:

> Any new machine will have this same functionality if booted with 
> acpi=off,ht etc, and this is done automatically on recent SUSE installs.

Machines booted without acpi will have different functionality to 
machines booted with acpi. That's a feature, not a bug.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
