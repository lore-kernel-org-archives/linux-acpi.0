From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [RFC PATCH v3 3/3] acpi: apei: Warn when GHES marks correctable
 errors as "fatal"
Date: Thu, 26 Apr 2018 12:47:30 -0500
Message-ID: <e58482cf-37f6-808b-4382-fcf24c6f8db8@gmail.com>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180425203957.18224-1-mr.nuke.me@gmail.com>
 <20180425203957.18224-4-mr.nuke.me@gmail.com>
 <20180426112057.GB15009@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180426112057.GB15009@pd.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, linux-kernel@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On 04/26/2018 06:20 AM, Borislav Petkov wrote:
> Pasting the same comment from last time since you missed it:
> 
> "No, I don't want any of that crap issuing stuff in dmesg and then people
> opening bugs and running around and trying to replace hardware.
> 
> We either can handle the error and log a normal record somewhere or we
> cannot and explode. The complaining about the FW doesn't bring shit."

" Borislav, if you don't like the third patch in the series, feel free 
to leave it out. THings will work beautifully with or without it."

:)
