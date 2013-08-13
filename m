From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error trace
 event
Date: Tue, 13 Aug 2013 16:51:33 +0530
Message-ID: <520A16BD.30201@linux.vnet.ibm.com>
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com> <1375986471-27113-4-git-send-email-naveen.n.rao@linux.vnet.ibm.com> <20130808163822.67e0828a@samsung.com> <20130810180322.GC4155@pd.tnic> <20130812083355.47c1bae8@samsung.com> <5208D80D.5030206@linux.vnet.ibm.com> <20130812125343.GE18018@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20130812125343.GE18018@pd.tnic>
Sender: linux-pci-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>, tony.luck@intel.com, bhelgaas@google.com, rostedt@goodmis.org, rjw@sisk.pl, lance.ortiz@hp.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 08/12/2013 06:23 PM, Borislav Petkov wrote:
> On Mon, Aug 12, 2013 at 06:11:49PM +0530, Naveen N. Rao wrote:
>> So, I looked at ghes_edac and it basically seems to boil down to
>> trace_mc_event. But, this only seems to expose the APEI data as a
>> string and doesn't look to really make all the fields available to
>> user-space in a raw manner. Not sure how well this can be utilised
>> by a user-space tool.
>
> Well, your tracepoint dumps the decoded memory error too. So all the
> information we need is already there, without edac. Or am I missing some
> bits?
>
> Thus why I'm saying is that we don't need the additional edac layer.
>

You're right - my trace point makes all the data provided by apei as-is 
to userspace. However, ghes_edac seems to squash some of this data into 
a string when reporting through mc_event.

Regards,
Naveen
