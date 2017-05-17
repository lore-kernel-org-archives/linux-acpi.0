From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] x86/MCE: Export memory_error()
Date: Wed, 17 May 2017 21:20:55 +0200
Message-ID: <20170517192055.mk2v27wos7n5m7zm@pd.tnic>
References: <20170510200406.mphusoidfuyq24ee@pd.tnic>
 <1494446729.20330.4.camel@intel.com>
 <20170510200851.mhz3434jauxdq2u5@pd.tnic>
 <1494450649.20330.6.camel@intel.com>
 <20170510215707.v7zywrslma4o7jao@pd.tnic>
 <1494453738.20330.8.camel@intel.com>
 <20170510221631.3ue63iw3mgh2d6xt@pd.tnic>
 <1494454869.20330.9.camel@intel.com>
 <20170517123839.xkd25bcj3bf7rdlc@pd.tnic>
 <1495047396.20330.16.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:44066 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754032AbdEQTVD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 May 2017 15:21:03 -0400
Content-Disposition: inline
In-Reply-To: <1495047396.20330.16.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, May 17, 2017 at 06:58:00PM +0000, Verma, Vishal L wrote:
> Quick/minor observation - you moved the EXPORT_SYMBOL_GPL into your

Yes, it belongs there conceptually.

> original patch, but the commit message of mine still talks about
> exporting. Perhaps it should read:
> 
> "Use the new mce_is_memory_error() helper.."

Fixed, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
