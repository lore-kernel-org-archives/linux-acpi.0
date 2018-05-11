From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v4 3/3] acpi: apei: Do not panic() on PCIe errors
 reported through GHES
Date: Fri, 11 May 2018 19:41:12 +0200
Message-ID: <20180511174112.GI12705@pd.tnic>
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-3-mr.nuke.me@gmail.com>
 <20180511154039.GD12705@pd.tnic>
 <8e3c0cc6-9c5c-85ce-650c-8f498f5907da@gmail.com>
 <20180511160253.GF12705@pd.tnic>
 <45b7be09-c9b3-8006-6ea0-36b4ff38607c@gmail.com>
 <20180511162951.GH12705@pd.tnic>
 <95bcbc2d-0f8c-e51a-f0fc-08ea8c5fca26@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <95bcbc2d-0f8c-e51a-f0fc-08ea8c5fca26@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On Fri, May 11, 2018 at 12:01:52PM -0500, Alex G. wrote:
> I understand your concern with unhandled AER errors evolving into MCE's.
> That's extremely rare, but when it happens you still panic due to the
> MCE.

I don't like leaving holes in the handling of PCIe errors. You need to
handle only those errors which are caused by hot-removal and not affect
other error types. Or do a comprehensive PCIe errors handling of all
errors in the AER driver.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
