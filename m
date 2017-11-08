From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH V2] acpi: apei: call into AER handling regardless of
 severity
Date: Wed, 8 Nov 2017 11:59:15 +0100
Message-ID: <20171108105915.teb4bgvkyndson5l@pd.tnic>
References: <1508254115-27945-1-git-send-email-tbaicar@codeaurora.org>
 <01fff9c1-8cd5-14d3-5d90-c0dab8e62a52@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <01fff9c1-8cd5-14d3-5d90-c0dab8e62a52@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, prarit@redhat.com, punit.agrawal@arm.com, shiju.jose@huawei.com, andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 07, 2017 at 06:21:31PM -0500, Tyler Baicar wrote:
> Do you think this patch is good now?

Yes, it looks ok to me but please split it in two patches:

1. Only code movement without any functional changes
2. Make the change to severity checking and add the comment.

This will make the git history clean and understandable.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
