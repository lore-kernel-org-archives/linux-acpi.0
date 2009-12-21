From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 00/11] ACPI: early _PDC eval and unify x86/ia64
Date: Mon, 21 Dec 2009 09:15:50 +0100
Message-ID: <20091221081550.GA1648@isilmar.linta.de>
References: <20091220190434.4274.67855.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:57976 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752108AbZLUIPw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Dec 2009 03:15:52 -0500
Content-Disposition: inline
In-Reply-To: <20091220190434.4274.67855.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: venkatesh.pallipadi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org

Hey,

On Sun, Dec 20, 2009 at 12:19:04PM -0700, Alex Chiang wrote:
> This does introduce a boot time namespace walk for all the CPUs
> in the system, looking for and evaluating _PDC. Hopefully that
> will not make life miserable for the giant SGI clusters. If worse
> comes to worse, maybe we can quirk them and avoid the namespace
> walk.

Could this be done async, with completion before EC initialization?

Best,
	Dominik
