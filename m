From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error trace
 event
Date: Tue, 13 Aug 2013 17:11:18 +0530
Message-ID: <520A1B5E.8040105@linux.vnet.ibm.com>
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com> <1375986471-27113-4-git-send-email-naveen.n.rao@linux.vnet.ibm.com> <20130808163822.67e0828a@samsung.com> <20130810180322.GC4155@pd.tnic> <20130812083355.47c1bae8@samsung.com> <5208D80D.5030206@linux.vnet.ibm.com> <20130812114404.3bd64fa0@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20130812114404.3bd64fa0@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: Borislav Petkov <bp@alien8.de>, tony.luck@intel.com, bhelgaas@google.com, rostedt@goodmis.org, rjw@sisk.pl, lance.ortiz@hp.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Aristeu Rozanski Filho <arozansk@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On 08/12/2013 08:14 PM, Mauro Carvalho Chehab wrote:
>> But, this only seems to expose the APEI data as a string
>> and doesn't look to really make all the fields available to user-space
>> in a raw manner. Not sure how well this can be utilised by a user-space
>> tool. Do you have suggestions on how we can do this?
>
> There's already an userspace tool that handes it:
> 	https://git.fedorahosted.org/cgit/rasdaemon.git/
>
> What is missing there on the current version is the bits that would allow
> to translate from APEI way to report an error (memory node, card, module,
> bank, device) into a DIMM label[1].

If I'm reading this right, all APEI data seems to be squashed into a 
string in mc_event. Also, the fru id/text don't seem to be passed to 
user-space.

- Naveen
