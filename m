From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
Date: Tue, 22 May 2018 10:57:42 -0700
Message-ID: <20180522175742.GA3543@agluck-desk>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-2-mr.nuke.me@gmail.com>
 <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com>
 <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com>
 <20180522135015.GF5512@pd.tnic>
 <0b758a1c-90e3-6f76-4f83-1e22c8fc9cd6@gmail.com>
 <20180522145426.GG5512@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180522145426.GG5512@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Alex G." <mr.nuke.me@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Shiju Jose <shiju.jose@huawei.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 22, 2018 at 04:54:26PM +0200, Borislav Petkov wrote:
> I especially don't want to have the case where a PCIe error is *really*
> fatal and then we noodle in some handlers debating about the severity
> because it got marked as recoverable intermittently and end up causing
> data corruption on the storage device. Here's a real no-no for ya.

All that we have is a message from the BIOS that this is a "fatal"
error.  When did we start trusting the BIOS to give us accurate
information?

PCIe fatal means that the link or the device is broken. But that
seems a poor reason to take down a large server that may have
dozens of devices (some of them set up specifically to handle
errors ... e.g. mirrored disks on separate controllers, or NIC
devices that have been "bonded" together).

So, as long as the action for a "fatal" error is to mark a link
down and offline the device, that seems a pretty reasonable course
of action.

The argument gets a lot more marginal if you simply reset the
link and re-enable the device to "fix" it. That might be enough,
but I don't think the OS has enough data to make the call.

-Tony

P.S. I deliberately put "fatal" in quotes above because to
quote "The Princess Bride" -- "that word, I do not think it
means what you think it means". :-)
