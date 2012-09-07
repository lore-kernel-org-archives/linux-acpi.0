From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH] GHES: correct page protection flags in
 ghes_ioremap_pfn_...()
Date: Fri, 07 Sep 2012 09:51:28 +0100
Message-ID: <5049D1B00200007800099A6F@nat28.tlf.novell.com>
References: <5049B2FF02000078000998F3@nat28.tlf.novell.com>
 <1347001356.4673.3.camel@yhuang-mobile.sh.intel.com>
 <5049BA9B0200007800099923@nat28.tlf.novell.com>
 <1347007578.28607.13.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:40260 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932565Ab2IGIug convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:4:1>);
	Fri, 7 Sep 2012 04:50:36 -0400
In-Reply-To: <1347007578.28607.13.camel@yhuang-dev>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-acpi@vger.kernel.org

>>> On 07.09.12 at 10:46, Huang Ying <ying.huang@intel.com> wrote:
> On Fri, 2012-09-07 at 08:12 +0100, Jan Beulich wrote:
>> >>> On 07.09.12 at 09:02, Huang Ying <ying.huang@intel.com> wrote:
>> > On Fri, 2012-09-07 at 07:40 +0100, Jan Beulich wrote:
>> >> At least for Xen Dom0 it is very relevant to set the _PAGE_IO bit when
>> >> ioremap-ing (non-RAM) areas, as that flag suppresses the PFN -> MFN
>> >> translation otherwise done in PV guests. (The offending commit was
>> >> 81e88fdc432a1552401d6e91a984dcccce72b8dc.)
>> > 
>> > If my understanding were correct, ghes_ioremap_pfn_nmi normally only map
>> > RAM.
>> 
>> But not RAM in the sense of what is seen as usable memory in the
>> E820 map. What you're mapping here is reserved memory, and that
>> is (from the perspective of the kernel and Xen) non-RAM. The fact
>> that it is RAM from a machine perspective is manifested by the
>> mapping not needing to be done UC or alike.
> 
> I think the key is to keep these memory range map consistent between
> each other.  BIOS may map these memory cached.  ACPI may mapped them as
> cached (see acpi_os_ioremap) too.

But that aspect is orthogonal to the patch here - all we need
done for Xen is the proper setting of _PAGE_IO; cachability
is being dealt with independently (and correctly I think).

Jan

