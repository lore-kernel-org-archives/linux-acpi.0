From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [PATCH v2] Xen/ACPI: support sleep state entering on
 hardware reduced systems
Date: Mon, 11 Mar 2013 16:12:42 +0000
Message-ID: <513E108A02000078000C4AB3@nat28.tlf.novell.com>
References: <513DB68E02000078000C4864@nat28.tlf.novell.com>
 <20130311135322.GA25036@phenom.dumpdata.com>
 <513DF30B02000078000C49EB@nat28.tlf.novell.com>
 <2127236.DctbS7jp3r@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:55725 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab3CKQMq convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:6:1>);
	Mon, 11 Mar 2013 12:12:46 -0400
In-Reply-To: <2127236.DctbS7jp3r@vostro.rjw.lan>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Gang Wei <gang.wei@intel.com>, Lv Zheng <lv.zheng@intel.com>, richard.l.maliszewski@intel.com, Shane Wang <shane.wang@intel.com>, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xen.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-acpi@vger.kernel.org

>>> On 11.03.13 at 15:51, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> On Monday, March 11, 2013 02:06:51 PM Jan Beulich wrote:
>> In version 3.4 acpi_os_prepare_sleep() got introduced in parallel with
>> reduced hardware sleep support, and the two changes didn't get
>> synchronized: The new code doesn't call the hook function (if so
>> requested). Fix this, requiring a boolean parameter to be added to the
>> hook function to distinguish "extended" from "legacy" sleep.
>> 
>> This requires adjusting TXT, but the adjustments only go as far as
>> failing the extended mode call (since, looking at the TXT interface,
>> there doesn't even appear to be precautions to deal with that
>> alternative interface).
>> 
>> The hypervisor change underlying this is commit 62d1a69 ("ACPI: support
>> v5 (reduced HW) sleep interface") on the master branch of
>> git://xenbits.xen.org/xen.git.
>> 
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>> Cc: Richard L Maliszewski <richard.l.maliszewski@intel.com>
>> Cc: Gang Wei <gang.wei@intel.com>
>> Cc: Shane Wang <shane.wang@intel.com>
>> ---
>> v2: Extend description to include reference to hypervisor side change.
>> 
>> ---
>>  arch/x86/kernel/tboot.c          |    6 +++++-
>>  drivers/acpi/acpica/hwesleep.c   |    8 ++++++++
>>  drivers/acpi/acpica/hwsleep.c    |    2 +-
>>  drivers/acpi/osl.c               |   16 ++++++++--------
>>  drivers/xen/acpi.c               |   26 +++++++++++++-------------
>>  include/linux/acpi.h             |   10 +++++-----
>>  include/xen/acpi.h               |    4 ++--
>>  include/xen/interface/platform.h |    7 ++++---
>>  8 files changed, 46 insertions(+), 33 deletions(-)
> 
> ACPICA changes (hwesleep.c and hwsleep.c) need to go separately and through 
> the
> upstream ACPICA before we can take them into the kernel.  Sorry about that.

Looking at 09f98a8 (the change originally introducing the hook)
and comparing with the rest of the changes to hwsleep.c, I would
think this one didn't come from the ACPICA tree either.

But anyway - if I really need to do that, are there any pointers as
to where to submit this to, and how to make sure it gets picked up
rather sooner than later?

Jan

