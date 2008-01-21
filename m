From: Li Zefan <lizf@cn.fujitsu.com>
Subject: Re: [PATCH 9/10] introduce intel_menlow platform specific driver
Date: Mon, 21 Jan 2008 13:45:42 +0800
Message-ID: <47943186.8030001@cn.fujitsu.com>
References: <1200556278.2935.118.camel@acpi-sony.sh.intel.com>	 <20080117092030.a9dfe528.randy.dunlap@oracle.com> <1200627175.2935.174.camel@acpi-sony.sh.intel.com> <4790231C.1040805@cn.fujitsu.com> <05B550FD4BD2014E841D83547B6260080281A8A8@bgsmsx411.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:61027 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751624AbYAUFqI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 00:46:08 -0500
In-Reply-To: <05B550FD4BD2014E841D83547B6260080281A8A8@bgsmsx411.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Thomas, Sujith" <sujith.thomas@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>, sam@ravnborg.org, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org

>>> +static int __init intel_menlow_module_init(void)
>>> +{
>>> +	int result = -ENODEV;
>>> +	acpi_status status;
>>> +	unsigned long enable;
>>> +
>>> +	if (acpi_disabled)
>>> +		return result;
>>> +
>>> +	/* Looking for the \_TZ.GSTS method */
>>> +	status = acpi_evaluate_integer(NULL, BIOS_ENABLED, NULL, &enable);
>>> +	if (ACPI_FAILURE(status) || !enable)
>>> +		return -ENODEV;
>>> +
>>> +	/* Looking for ACPI device MEM0 with hardware id INT0002 */
>>> +	result = acpi_bus_register_driver(&intel_menlow_memory_driver);
>>> +	if (result)
>>> +		return result;
>>> +
>>> +	/* Looking for sensors in each ACPI thermal zone */
>>> +	status = acpi_walk_namespace(ACPI_TYPE_THERMAL, ACPI_ROOT_OBJECT,
>>> +				     ACPI_UINT32_MAX,
>>> +				     intel_menlow_register_sensor, NULL, NULL);
>>> +	if (ACPI_FAILURE(status))
>>> +		result = -ENODEV;
>>> +
>> It seems to me this should be 'return -ENODEV;'
>>
>> You can just eliminate variable result, because result will be
>> -ENODEV only.
> I disagree. "result" is required to store the return value from acpi_bus_register_driver which may be different from ENODEV. Otherwise it's all -ENODEV.
> 
> :-Sujith

Indead, I overlooked it.

But the above 'result = -ENODEV;' should be 'return -ENODEV;', right?

>>> +	return 0;
>>> +}

