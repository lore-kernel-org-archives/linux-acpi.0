From: James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH v2 3/4] acpi: apei: Do not panic() when correctable
 errors are marked as fatal.
Date: Thu, 19 Apr 2018 16:35:52 +0100
Message-ID: <e5e107e7-e18e-725a-8f9b-95e6f033ab45@arm.com>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-4-mr.nuke.me@gmail.com> <20180418175415.GJ4795@pd.tnic>
 <bdc1d19b-3cc1-3f90-d276-414aaacdbd3a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bdc1d19b-3cc1-3f90-d276-414aaacdbd3a@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, tbaicar@codeaurora.org, will.deacon@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com, linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org, mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
List-Id: linux-acpi@vger.kernel.org

Hi Alex,

(I haven't read through all this yet, just on this one:)

On 04/19/2018 03:57 PM, Alex G. wrote:
 > Maybe it's better move the AER handling to NMI/IRQ context, since
 > ghes_handle_aer() is only scheduling the real AER andler, and is irq
 > safe. I'm scratching my head about why we're messing with IRQ work from
 > NMI context, instead of just scheduling a regular handler to take care
 > of things.

We can't touch schedule_work_on() from NMI context as it takes spinlocks and
disables interrupts. (see __queue_work()) The NMI may have interrupted 
IRQ-context code
that was already holding the same locks.

IRQ-work behaves differently, it uses an llist for the work and an arch 
code hook
to raise a self-IPI.


Thanks,

James
