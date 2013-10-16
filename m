From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 3/9] bitops: Introduce a more generic BITMASK macro
Date: Wed, 16 Oct 2013 18:41:19 +0200
Message-ID: <20131016164119.GI13608@pd.tnic>
References: <1381935366-11731-1-git-send-email-gong.chen@linux.intel.com>
 <1381935366-11731-4-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:53713 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755386Ab3JPQle (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Oct 2013 12:41:34 -0400
Content-Disposition: inline
In-Reply-To: <1381935366-11731-4-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, joe@perches.com, naveen.n.rao@linux.vnet.ibm.com, m.chehab@samsung.com, arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Winischhofer <thomas@winischhofer.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Wed, Oct 16, 2013 at 10:56:00AM -0400, Chen, Gong wrote:
> GENMASK is used to create a contiguous bitmask([hi:lo]). It is
> implemented twice in current kernel. One is in EDAC driver, the other
> is in SiS/XGI FB driver. Move it to a more generic place for other
> usage.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Winischhofer <thomas@winischhofer.net>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
