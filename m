From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH, resend] ACPI/HEST: avoid stack traces when	
	 encountering duplicate source IDs
Date: Wed, 08 Dec 2010 07:37:48 +0000
Message-ID: <4CFF43DC0200007800026A59@vpn.id2.novell.com>
References: <4CFE59A50200007800026700@vpn.id2.novell.com>
 <1291768601.12648.663.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1291768601.12648.663.camel@yhuang-dev>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

>>> On 08.12.10 at 01:36, Huang Ying <ying.huang@intel.com> wrote:
> On Tue, 2010-12-07 at 22:58 +0800, Jan Beulich wrote:
>> Rather than trying to create duplicate platform devices, check for
>> duplication up front.
>> 
>> Generally the kernel doesn't require uniqueness of the source IDs
>> other than for obtaining unique platform device names (and making log
>> message non-ambiguous) - therefore, it would be possible to simply
>> replace eventual duplicate IDs with kernel assigned ones.
> 
> Do you have a machine with duplicated source ID in HEST?

Yes (all IDs are identical), albeit one for which I'm not sure it (or
its BIOS) are really fully production level. It's in any case quite
a bit older than the code in Linux.

Jan

