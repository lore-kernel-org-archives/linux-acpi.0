From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [RFT Part2 v2 00/24] Enable hierarchy irqdomian on x86 platforms
Date: Sun, 28 Sep 2014 19:15:03 +0800
Message-ID: <5427EDB7.9060002@linux.intel.com>
References: <1411740145-30626-1-git-send-email-jiang.liu@linux.intel.com> <20140926142931.GA10066@nazgul.tnic> <542594A6.4040504@amd.com> <20140928110531.GB7351@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2140 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940AbaI1LPK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 28 Sep 2014 07:15:10 -0400
In-Reply-To: <20140928110531.GB7351@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Borislav,
	I have prepared a git tree at:
https://github.com/jiangliu/linux.git irqdomain/p1v2
https://github.com/jiangliu/linux.git irqdomain/p2v2
https://github.com/jiangliu/linux.git irqdomain/p3v1

Branch irqdomain/p3v1 also includes all changes in p1v2/p2v2.
Regards!
Gerry

On 2014/9/28 19:05, Borislav Petkov wrote:
> On Fri, Sep 26, 2014 at 11:30:30AM -0500, Aravind Gopalakrishnan wrote:
>> Okay, I shall start looking into the patches and RFH as needed.
> 
> Btw, apparently, there's a third patchset too:
> 
> https://lkml.kernel.org/r/1411743478-31435-1-git-send-email-jiang.liu@linux.intel.com
> 
> Jiang, do you have a tree which has all required patches for testing so
> that people don't have to go hunting for them..?
> 
> Thanks.
> 
