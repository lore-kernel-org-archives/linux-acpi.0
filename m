From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
Date: Tue, 22 May 2018 11:33:36 -0700
Message-ID: <20180522183336.GA4177@agluck-desk>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-2-mr.nuke.me@gmail.com>
 <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com>
 <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com>
 <20180522135015.GF5512@pd.tnic>
 <0b758a1c-90e3-6f76-4f83-1e22c8fc9cd6@gmail.com>
 <20180522145426.GG5512@pd.tnic>
 <20180522175742.GA3543@agluck-desk>
 <CAJZ5v0j1E-kg3RPcasSJn=uZj9uaZcL4Zw9tp4mJgnsbWcPWbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j1E-kg3RPcasSJn=uZj9uaZcL4Zw9tp4mJgnsbWcPWbw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, "Alex G." <mr.nuke.me@gmail.com>, alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 22, 2018 at 08:10:47PM +0200, Rafael J. Wysocki wrote:
> > PCIe fatal means that the link or the device is broken.
> 
> And that may really mean that the component in question is on fire.
> We just don't know.

Components on fire could be the root cause of many errors. If we really
believe that is a problem we should power the system off rather than
just calling panic() [not just for PCIe errors, but also for machine
checks, and perhaps a bunch of other places in the kernel].

True story: I used to work for Stratus Computer on fault tolerant
systems. A customer once called in with a "my computer is on fire"
report and asked what to do. The support person told them to power it
off. Customer asked "Isn't there something else? It's still running
just fine".

-Tony
