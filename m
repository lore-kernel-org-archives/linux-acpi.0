From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] acpi/apei/erst: Remove "Error" from initialization and
 disable output
Date: Tue, 18 Jul 2017 18:38:17 +0200
Message-ID: <20170718163817.GA22334@nazgul.tnic>
References: <1500337283-25734-1-git-send-email-prarit@redhat.com>
 <20170718052627.GA8741@nazgul.tnic>
 <0eb11ba0-4923-5c08-d7a5-1c7a29dbfb20@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59169 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751402AbdGRQi3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Jul 2017 12:38:29 -0400
Content-Disposition: inline
In-Reply-To: <0eb11ba0-4923-5c08-d7a5-1c7a29dbfb20@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linda Knippers <linda.knippers@hpe.com>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-acpi@vger.kernel.org, Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ying.huang@intel.com

On Tue, Jul 18, 2017 at 11:46:11AM -0400, Linda Knippers wrote:
> Most ACPI tables are referenced by their 4 letter abbreviations
> anyway so this seems like a simple and helpful change, consistent
> with other ACPI table references.

I guess today is ridiculous ideas day. :-(

When are you guys going to understand that restricting dmesg *wording*
is never going to fly. It is going to be a losing game of whack-a-mole
for you. You can't really enforce it on people to stop using certain
words in dmesg just because it'll break your scripts. I can't believe
we're still *wasting* time talking about this insanity.

So let me point you in a better direction: have you guys heard of printk
loglevels? The number that gets prepended to each line in dmesg?


$ dmesg -r
...

<6>[    4.656173] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
<3>[    4.657280] irq: Invalid fwnode type (2) for irqdomain
<4>[    4.660181] ACPI Warning: SystemIO range 0x0000000000000428-0x000000000000042F conflicts with OpRegion 0x0000000000000400-0x000000000000047F (\_SB.PCI0.LPC.PMIO) (20170303/utaddress-247)
<6>[    4.662265] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver

6 is KERN_INFO, 3 is KERN_ERR, 4 is KERN_WARNING and so on.

If you really want to look for errors and warnings, you should use those
loglevels. Like everyone else does. And if messages have the wrong
loglevels, they should be fixed.

This is how it should be done reliably - the stress being on *reliably*
- not by grepping for words.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
