From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: [PATCH] Repost: asus strict model checking
Date: Tue, 01 Aug 2006 20:11:18 +0400
Message-ID: <44CF7D26.5050208@linux.intel.com>
References: <1154438122.4302.354.camel@queen.suse.de>	 <44CF5DF6.9090603@linux.intel.com> <1154446149.4302.386.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:2083 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750794AbWHAQLZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Aug 2006 12:11:25 -0400
In-Reply-To: <1154446149.4302.386.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, acpi4asus-user@lists.sourceforge.net

Checks for Samsung P30/P35 are real hacks IMHO.

Thomas Renninger wrote:
> On Tue, 2006-08-01 at 17:58 +0400, Alexey Starikovskiy wrote:
>> Thomas,
>> Is it possible to use DMI interface for this kind of system identification?
> 
> IMO it should be sufficient to use the already provided Asus hotkey
> model identification.
> Using dmidecode to check for Asus and then fallback to the default model
> if the model is unknown (which does not work for a lot new Asus anyway?)
> sounds like the wrong way for me.
> Better to have a not supported system (it's easy to white list an
> additional model) than to fall back to default and have a broken system
> (reading/writing to wrong EC registers,..).
> 
>     Thomas
> 
>> Regards,
>> 	Alex.
>>
>> Thomas Renninger wrote:
>>> These are some minor patches I already posted...
>>> All are patched against 2.6.18-rc2.
>>>
>>> Do only load asus acpi module when model is listed
>>>
>>> Description: There are machines that have a device with HID: ATK0100
>>> (Asus) and a device with HID SNY5001 (Sony). Bad things happen if sony
>>> and asus driver are loaded there.
>>>
>>> Reference: https://bugzilla.novell.org/show_bug.cgi?id=166920
>>>
>>> Signed-off-by: Timo Hoenig <thoenig@suse.de>
>>> Signed-off-by: Thomas Renninger<mail@renninger.de>
>>>
>>>
>>>  drivers/acpi/asus_acpi.c |   25 ++++++++++++++++++++-----
>>>  1 files changed, 20 insertions(+), 5 deletions(-)
>>>
>>> Index: linux-2.6.18-rc2/drivers/acpi/asus_acpi.c
>>> ===================================================================
>>> --- linux-2.6.18-rc2.orig/drivers/acpi/asus_acpi.c
>>> +++ linux-2.6.18-rc2/drivers/acpi/asus_acpi.c
>>> @@ -77,10 +77,14 @@ MODULE_LICENSE("GPL");
>>>  
>>>  static uid_t asus_uid;
>>>  static gid_t asus_gid;
>>> +static int force;
>>>  module_param(asus_uid, uint, 0);
>>>  MODULE_PARM_DESC(asus_uid, "UID for entries in /proc/acpi/asus.\n");
>>>  module_param(asus_gid, uint, 0);
>>>  MODULE_PARM_DESC(asus_gid, "GID for entries in /proc/acpi/asus.\n");
>>> +module_param(force, int, 0);
>>> +MODULE_PARM_DESC(force, "Force loading of the module even if the laptop"
>>> +		 "model is not listed.\n");
>>>  
>>>  /* For each model, all features implemented, 
>>>   * those marked with R are relative to HOTK, A for absolute */
>>> @@ -1171,11 +1175,22 @@ static int asus_hotk_get_info(void)
>>>  			printk(KERN_NOTICE
>>>  			       "  Samsung P30 detected, supported\n");
>>>  		} else {
>>> -			hotk->model = M2E;
>>> -			printk(KERN_NOTICE "  unsupported model %s, trying "
>>> -			       "default values\n", string);
>>> -			printk(KERN_NOTICE
>>> -			       "  send /proc/acpi/dsdt to the developers\n");
>>> +			if (force){
>>> +				hotk->model = M2E;
>>> +				printk(KERN_NOTICE "  unsupported model"
>>> +				       "%s, trying default values\n",
>>> +				       string);
>>> +				printk(KERN_NOTICE
>>> +				       "  send /proc/acpi/dsdt"
>>> +				       " to the developers\n");
>>> +			}
>>> +			else{
>>> +				printk(KERN_NOTICE "  %s unsupported model %s,"
>>> +				       " aborting.\nForce loading with force=1"
>>> +				       " parameter\n",
>>> +				       ACPI_HOTK_NAME, string);
>>> +				return -ENODEV;
>>> +			}
>>>  		}
>>>  		hotk->methods = &model_conf[hotk->model];
>>>  		return AE_OK;
>>>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
