From: "Jan Beulich" <JBeulich@suse.com>
Subject: RE: [PATCH v2] Xen/ACPI: support sleep state entering on
 hardware reduced systems
Date: Tue, 12 Mar 2013 07:58:14 +0000
Message-ID: <513EEE2602000078000C4C62@nat28.tlf.novell.com>
References: <513DB68E02000078000C4864@nat28.tlf.novell.com>
 <20130311132127.GH23018@phenom.dumpdata.com>
 <513DEAF102000078000C496E@nat28.tlf.novell.com>
 <20130311135322.GA25036@phenom.dumpdata.com>
 <513DF30B02000078000C49EB@nat28.tlf.novell.com>
 <D0B11485C64D4B47B66902F8A4E901BE573E5E@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:36790 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180Ab3CLH6S convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:6:1>);
	Tue, 12 Mar 2013 03:58:18 -0400
In-Reply-To: <D0B11485C64D4B47B66902F8A4E901BE573E5E@SHSMSX101.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gang Wei <gang.wei@intel.com>
Cc: Richard L Maliszewski <richard.l.maliszewski@intel.com>, Shane Wang <shane.wang@intel.com>, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xen.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

>>> On 12.03.13 at 07:39, "Wei, Gang" <gang.wei@intel.com> wrote:
> Jan Beulich wrote on 2013-03-11:
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
>> --- 3.9-rc2/arch/x86/kernel/tboot.c
>> +++ 3.9-rc2-xen-ACPI-v5-sleep/arch/x86/kernel/tboot.c
>> @@ -273,7 +273,8 @@ static void tboot_copy_fadt(const struct
>>  		offsetof(struct acpi_table_facs, firmware_waking_vector);
>>  }
>> -static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32
> pm1b_control)
>> +static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32
> pm1b_control,
>> +		       bool extended)
>>  { 	static u32 acpi_shutdown_map[ACPI_S_STATE_COUNT] = { 		/*
> S0,1,2: */
>>  -1, -1, -1, @@ -284,6 +285,9 @@ static int tboot_sleep(u8 sleep_state,
>>  u 	if (!tboot_enabled()) 		return 0;
>> +	if (extended)
>> +		return -1;
>> +
>>  	tboot_copy_fadt(&acpi_gbl_FADT);
>>  	tboot->acpi_sinfo.pm1a_cnt_val = pm1a_control;
>>  	tboot->acpi_sinfo.pm1b_cnt_val = pm1b_control;
> 
> So looks like to make the extended way go further with TXT case other than
> failing, tboot & its' interface have to be modified to support Reduced
> Hardware sleeping first, is that true?

Yes, afaict.

Jan

