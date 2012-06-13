From: Gary Hade <garyhade@us.ibm.com>
Subject: Re: [RFC] ACPI, APEI: Fix incorrect bit width + offset check
 condition
Date: Wed, 13 Jun 2012 10:45:17 -0700
Message-ID: <20120613174517.GA2141@us.ibm.com>
References: <1339573184-3122-1-git-send-email-hui.xiao@linux.intel.com>
 <20120613104651.52ce8840@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:46993 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214Ab2FMRpq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jun 2012 13:45:46 -0400
Received: from /spool/local
	by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <garyhade@us.ibm.com>;
	Wed, 13 Jun 2012 13:45:42 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 558266E8059
	for <linux-acpi@vger.kernel.org>; Wed, 13 Jun 2012 13:45:36 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5DHjZoL141668
	for <linux-acpi@vger.kernel.org>; Wed, 13 Jun 2012 13:45:35 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5DHjYbB009283
	for <linux-acpi@vger.kernel.org>; Wed, 13 Jun 2012 14:45:35 -0300
Content-Disposition: inline
In-Reply-To: <20120613104651.52ce8840@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: "Xiao, Hui" <hui.xiao@linux.intel.com>, garyhade@us.ibm.com, tony.luck@intel.com, ying.huang@intel.com, lenb@kernel.org, pluto@agmk.net, linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

On Wed, Jun 13, 2012 at 10:46:51AM +0200, Jean Delvare wrote:
> Hi Xiao,
> 
> On Wed, 13 Jun 2012 15:39:44 +0800, Xiao, Hui wrote:
> > Fix the incorrect bit width + offset check condition in apei_check_gar()
> > function introduced by commit v3.3-5-g15afae6.
> > 
> > The bug caused regression on EINJ error injection with errors:
> > 
> > [Firmware Bug]: APEI: Invalid bit width + offset in GAR [0x1121a5000/64/0/3/0]
> > 
> > on a valid address region of:
> >     - Register bit width: 64 bits
> >     - Register bit offset: 0
> >     - Access Size: 03 [DWord Access: 32]
> 
> I don't see how this is valid, sorry. If you have a 64-bit register,
> you want 64-bit access, don't you?
> 
> If the access code is supposed to be able to read large registers in
> smaller chunks and assemble them transparently to a larger value, then
> there is no point in having any check at all, everything is valid. If
> not, then the above is just as invalid as the firmware issue discussed
> in bug #43282.
> 
> > 
> > Signed-off-by: Xiao, Hui <hui.xiao@linux.intel.com>
> > Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
> > ---
> >  drivers/acpi/apei/apei-base.c |    7 +++++--
> >  1 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> > index 5577762..95e07b2 100644
> > --- a/drivers/acpi/apei/apei-base.c
> > +++ b/drivers/acpi/apei/apei-base.c
> > @@ -586,9 +586,12 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
> >  	}
> >  	*access_bit_width = 1UL << (access_size_code + 2);
> >  
> > -	if ((bit_width + bit_offset) > *access_bit_width) {
> > +	/* bit_width and bit_offset must be zero when addressing a data
> > +	 * structure. So just check for non-zero case here */
> > +	if ((bit_width != 0 && *access_bit_width > bit_width) ||
> > +			bit_offset > *access_bit_width) {
> 
> I can't make any sense of this test, sorry. And it will trigger on
> valid cases, starting with the most frequent case where
> *access_bit_width == bit_width. So, nack.

I agree that the change will trigger firmware bug messages for
valid cases.  Here is a good example of a valid case from one
of our systems that confirms this.

[110h 0272   1]                       Action : 06 [Check Busy Status]
[111h 0273   1]                  Instruction : 01 [Read Register Value]
[112h 0274   1]        Flags (decoded below) : 00
                      Preserve Register Bits : 0
[113h 0275   1]                     Reserved : 00

[114h 0276  12]              Register Region : [Generic Address Structure]
[114h 0276   1]                     Space ID : 00 [SystemMemory]
[115h 0277   1]                    Bit Width : 01
[116h 0278   1]                   Bit Offset : 1F
[117h 0279   1]         Encoded Access Width : 03 [DWord Access:32]
[118h 0280   8]                      Address : 000000007F2D7038

[120h 0288   8]                        Value : 0000000000000001
[128h 0296   8]                         Mask : 0000000000000001

Gary

-- 
Gary Hade
System x Enablement
IBM Linux Technology Center
503-578-4503  IBM T/L: 775-4503
garyhade@us.ibm.com
http://www.ibm.com/linux/ltc

