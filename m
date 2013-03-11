From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH] Xen/ACPI: support sleep state entering
 on hardware reduced systems
Date: Mon, 11 Mar 2013 14:02:23 +0000
Message-ID: <513DF1FF02000078000C49D0@nat28.tlf.novell.com>
References: <513DB68E02000078000C4864@nat28.tlf.novell.com>
 <20130311132127.GH23018@phenom.dumpdata.com>
 <513DEAF102000078000C496E@nat28.tlf.novell.com>
 <20130311135322.GA25036@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:50242 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab3CKOC3 convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:7:1>);
	Mon, 11 Mar 2013 10:02:29 -0400
In-Reply-To: <20130311135322.GA25036@phenom.dumpdata.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Gang Wei <gang.wei@intel.com>, richard.l.maliszewski@intel.com, Shane Wang <shane.wang@intel.com>, Len Brown <lenb@kernel.org>, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xen.org>, rjw@sisk.pl, linux-acpi@vger.kernel.org

>>> On 11.03.13 at 14:53, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
> On Mon, Mar 11, 2013 at 01:32:17PM +0000, Jan Beulich wrote:
>> >>> On 11.03.13 at 14:21, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
>> > Could the commit should also mention what version of the Xen hypervisor
>> > supports this new flag and takes action on it?
>> 
>> Do you really think this is needed? I generally try to stay away
>> from doing such, since backports can easily invalidate such
>> statements.
> 
> Perhaps just mention the title of the patch in the Xen tree?

Okay, will send you a v2 with the hypervisor size change
referenced. Sigh.

>> > Besides that little nit-pick it looks OK to me. Are there any changes
>> > neccessary on the IA64 or ARM side for this?
>> 
>> Xen on IA64 is dead, so I don't see any need for further action
> 
> You are touching generic ACPI code. My question was in terms of
> the Linux ACPI IA64 code.

The changes there are completely benign to IA64.

Jan

