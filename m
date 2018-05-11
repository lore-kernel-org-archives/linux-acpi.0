From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [RFC PATCH v4 2/3] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
Date: Fri, 11 May 2018 10:45:49 -0500
Message-ID: <56d445b2-ace3-6ee2-9699-f2a684518de9@gmail.com>
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-2-mr.nuke.me@gmail.com> <20180511153947.GC12705@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511153947.GC12705@pd.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org



On 05/11/2018 10:39 AM, Borislav Petkov wrote:
> On Mon, Apr 30, 2018 at 04:33:51PM -0500, Alexandru Gagniuc wrote:
>> ghes_severity() is a misnomer in this case, as it implies the severity
>> of the entire GHES structure. Instead, it maps one CPER value to a
>> monotonically increasing number.
> 
> ... as opposed to CPER severity which is something else or what is this
> formulation trying to express?
> 

CPER madness goes like this:
	0 - Recoverable
	1 - Fatal
	2 - Corrected
	3 - None

As you can see, the numbering was created by crackmonkeys. GHES_* is an
internal enum that goes up in order of severity, as you'd expect.

If you're confused, you're not alone. I've seen several commit messages
that get this terminology wrong.

Alex
