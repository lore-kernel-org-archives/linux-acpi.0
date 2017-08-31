From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 3/5] ghes_edac: add platform check to enable ghes_edac
Date: Thu, 31 Aug 2017 18:52:01 +0200
Message-ID: <20170831165201.rbbkacrz3vt7xuqg@pd.tnic>
References: <20170823225447.15608-1-toshi.kani@hpe.com>
 <20170823225447.15608-4-toshi.kani@hpe.com>
 <20170831105647.a7ypixekv6jybqyu@pd.tnic>
 <1504195625.2042.179.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:38112 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751776AbdHaQwT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 31 Aug 2017 12:52:19 -0400
Content-Disposition: inline
In-Reply-To: <1504195625.2042.179.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Aug 31, 2017 at 04:17:07PM +0000, Kani, Toshimitsu wrote:
> I followed in the footsteps of 'ghes_disable', which is also a kernel
> boot option and uses 0.

Ok, ghes_disable comment says that using module_param() is easier.
ghes_edac is not a module but then __setup() is for "really core code".

Documentation/admin-guide/kernel-parameters.rst also talks about
core_param() but that's #ifndef MODULE. So module_param() it is.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
