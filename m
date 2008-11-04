From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH]: ACPI Cleanup :Initialize EC global lock based on the
 return status
Date: Tue, 04 Nov 2008 12:21:19 +0300
Message-ID: <4910140F.6010400@suse.de>
References: <20081031184233.8588.42241.stgit@thinkpad> <1225784509.26020.73.camel@yakui_zhao.sh.intel.com> <49100241.2030205@suse.de> <200811040958.18262.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:55358 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754878AbYKDJVY (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 4 Nov 2008 04:21:24 -0500
In-Reply-To: <200811040958.18262.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhao Yakui <yakui.zhao@intel.com>, LenBrown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>, alan-jenkins@tuffmail.co.uk

Rafael J. Wysocki wrote:
> On Tuesday, 4 of November 2008, Alexey Starikovskiy wrote:
>> NAK
> 
> Can you elaborate, a bit, please?
This patch does not fix anything, just adds several lines of code.
It appeared as a concurrent patch to 11917 bug several days later, what I don't understand completely.
If Yakui has nothing else to do, this is not _my_ problem.
ec->global_lock is zero before entering ec_parse_device (zero alloced as part of acpi_ec struct),
thus there is no need to set it explicitely once again.
We don't care if call to _GLK succeeds or not, this is reflected in current design, so there is
no need in inserting the check either.

Overall, "don't fix it if it is not broken".

Regards,
Alex.
> 
>> Zhao Yakui wrote:
>>> Subject: ACPI: Cleanup :Initialize EC global lock based on the return status
>>> From: Zhao Yakui <yakui.zhao@intel.com>
>>>
>>> Initialize the EC global lock based on the returned value of _GLK object.
>>> Only when AE_OK is returned by the acpi_evaluate_integer, the EC global lock
>>> will be assigned based on the return value of _GLK object.Otherwise it means
>>> that there is no _GLK object and the global lock won't be required when EC
>>> is accessed.
>>> If the return value of _GLK object is not zero, it means that GLobal lock
>>> will be required when EC is accessed.
>>> If the return value of _GLK object is zero, it means that GLobal lock
>>> won't be required when EC is accessed.
>>>
>>> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
>>> cc: Alexey Starikovskiy <astarikovskiy@suse.de>
>>> cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
>>>
>>> ---
>>>  drivers/acpi/ec.c |   24 ++++++++++++++++++++++--
>>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>>
>>> Index: linux-2.6/drivers/acpi/ec.c
>>> ===================================================================
>>> --- linux-2.6.orig/drivers/acpi/ec.c
>>> +++ linux-2.6/drivers/acpi/ec.c
>>> @@ -752,8 +752,28 @@ ec_parse_device(acpi_handle handle, u32 
>>>  	ec->gpe = tmp;
>>>  	/* Use the global lock for all EC transactions? */
>>>  	tmp = 0;
>>> -	acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
>>> -	ec->global_lock = tmp;
>>> +	/*
>>> +	 * Only when AE_OK is returned by acpi_evaluate_interger,
>>> +	 * the ec->global_lock will be assigned based on the returned
>>> +	 * value by _GLK. Otherwise it means that there is no _GLK object
>>> +	 * and global lock won't be required when EC is accessed.
>>> +	 * If the return value of _GLK object is not zero, it means that
>>> +	 * global lock will be required when EC is accessed.
>>> +	 * If the return value of _GLK object is zero, it means that
>>> +	 * global lock won't be required when EC is accessed.
>>> +	 */
>>> +	status = acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
>>> +	if (ACPI_SUCCESS(status)) {
>>> +		/*
>>> +		 * If the return value is not zero, it means that global lock
>>> +		 * is required when EC is accessed
>>> +		 */
>>> +		if (tmp)
>>> +			ec->global_lock = 1;
>>> +		else
>>> +			ec->global_lock = 0;
>>> +	} else
>>> +		ec->global_lock = 0;
>>>  	ec->handle = handle;
>>>  	return AE_CTRL_TERMINATE;
>>>  }
>>>
>>>

