From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error trace
 event
Date: Wed, 14 Aug 2013 16:27:06 +0530
Message-ID: <520B6282.6030906@linux.vnet.ibm.com>
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com> <1375986471-27113-4-git-send-email-naveen.n.rao@linux.vnet.ibm.com> <20130808163822.67e0828a@samsung.com> <20130810180322.GC4155@pd.tnic> <20130812083355.47c1bae8@samsung.com> <5208D80D.5030206@linux.vnet.ibm.com> <20130812125343.GE18018@pd.tnic> <520A16BD.30201@linux.vnet.ibm.com> <20130813124258.GC4077@pd.tnic> <520A6D98.9060204@linux.vnet.ibm.com> <20130813175809.GE4077@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130813175809.GE4077@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>, tony.luck@intel.com, bhelgaas@google.com, rostedt@goodmis.org, rjw@sisk.pl, lance.ortiz@hp.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 08/13/2013 11:28 PM, Borislav Petkov wrote:
> On Tue, Aug 13, 2013 at 11:02:08PM +0530, Naveen N. Rao wrote:
>> If I'm not mistaken, even for systems that have EDAC drivers, it looks
>> to me like EDAC can't really decode to the DIMM given what is provided
>> by the bios in the APEI report currently. If and when ghes_edac gains
>> this capability, users will have a choice between raw APEI reports vs.
>> edac processed ones.
>
> Which kinda makes that APEI tracepoint not really useful and we can call
> the one we have already - trace_mc_event - from APEI...

This looks like a nice option. Mauro, what do you think?


Thanks,
Naveen
