From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 4] mce: acpi/apei: Add a sysctl to control page offlining
 on firmware report
Date: Wed, 10 Jul 2013 14:47:13 +0530
Message-ID: <51DD2699.7000804@linux.vnet.ibm.com>
References: <20130701153728.6197.14022.stgit@localhost.localdomain> <20130702125137.7388.97225.stgit@localhost.localdomain> <20130703144641.GC13951@pd.tnic> <51D44752.3000303@linux.vnet.ibm.com> <3908561D78D1C84285E8C5FCA982C28F31C76B19@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31C76B19@ORSMSX106.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, "ananth@in.ibm.com" <ananth@in.ibm.com>, "masbock@linux.vnet.ibm.com" <masbock@linux.vnet.ibm.com>, "lcm@linux.vnet.ibm.com" <lcm@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On 07/09/2013 01:56 AM, Luck, Tony wrote:
> I'm happy with just the acpi=nocmcff to avoid a BIOS that does weird
> stuff.  Or do you think we might still have to deal with a string of APEI
> messages?

Agreed - and I don't think this patch can help with a string of APEI 
messages either. So yes, I think we can leave this out for now.

Thanks,
Naveen
