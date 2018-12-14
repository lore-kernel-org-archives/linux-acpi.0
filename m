From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] acpi / apei: fix NULL deref during init
Date: Fri, 14 Dec 2018 21:24:06 +0100
Message-ID: <20181214202406.GI11710@zn.tnic>
References: <20181214181514.29891-1-tst@schoebel-theuer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181214181514.29891-1-tst@schoebel-theuer.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Schoebel-Theuer <tst@schoebel-theuer.de>
Cc: linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 14, 2018 at 07:15:14PM +0100, Thomas Schoebel-Theuer wrote:
> Reason is a conditional initialization of variable arch_res, which happens
> only under a specific precondition. When the condition is false, the
> variable remains uninitialized.

Are you talking about the precondition

	if (arch_apei_filter_addr)

?

Because apei_resources_fini() happens under the same condition check and
if arch_apei_filter_addr was false, it should not become true, all of a
sudden. Or?

Or does that function ptr get set in the meantime on your machine? I.e., this
hackery:

#define set_apei_filter() (arch_apei_filter_addr = pci_mmcfg_for_each_region)

being called in pci_mmcfg_early_init()...

?

Hmmm.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
