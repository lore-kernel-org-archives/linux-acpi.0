From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: a problem about the EC driver
Date: Tue, 22 Jan 2008 12:13:21 +0300
Message-ID: <4795B3B1.6010702@suse.de>
References: <1200928644.17879.49.camel@yakui_zhao.sh.intel.com>	 <47946D5A.5020307@suse.de> <1200995351.22292.24.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:54027 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754120AbYAVJNt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2008 04:13:49 -0500
In-Reply-To: <1200995351.22292.24.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

Zhao Yakui wrote:
> On Mon, 2008-01-21 at 13:00 +0300, Alexey Starikovskiy wrote:
> Thanks for the response.
>> Hi Zhao,
>>
>> All patches have relevant bugzilla entries, so you could read them for full
>> understanding.
>> Summary:
>> acpi_ec_probe/boot_ec_enable are workarounds for same situation then
>> EC driver should be inited early, but ECDT was not provided. Half of this
>> workaround was enabled earlier with fake ECDT.
>>
>> Having a kernel parameter to enable a workaround is not good, as it requires too
>> much knowledge from the users, while the problem seem to be not one or two notebooks,
>> but whole MSI and ASUS lines.
>>
>> Spec only covers case of ECDT for early init of EC, so whole series of patches do not 
>> have anything to do with spec, that should be clear.
> The spec only emphasizes that OSPM should make EC operation region
> accessed via EC described in ECDT table. It doesn't cover the EC defined
> in DSDT. Maybe it is better to use the similar flowchart.
What do you mean by "similar flowchart"? You are certainly welcome to write your own debug patches
and ask reporters of all mentioned bugs to test them, if you have something better in your mind. 
>> EC could be used in either _INI methods for some devices at device init stage, 
>> or in _STA methods, then devices are scanned and attached to drivers.
> Whether EC operation region can be accessed is only related to the _REG
> method. After the _REG method for EC is called, it means that AML can
> access the data fields in EC region. According to spec the _REG method
> should be called before calling other methods including _INI. The spec
> doesn't cover whether the _STA method is also included.   
I'm not talking about calling _INI or _STA method of EC itself, I'm talking
about _other_ devices, which fail initialization due to us following the spec.
> 
>> It was found, that in absence of ECDT, if some _INI requires presence of
>> EC op region, there will be empty _INI method in EC scope.
>> It was also found that many EC will fail to initialize before all _INI methods
>> are done. This is why the registration of EC op region is done only if _INI method
>> is present in EC scope.
> If EC fails to initialize before all _INI methods, EC still can't be
> initialized successfully even when there is _INI method under its scope.
Well, I have report, that it works. Do you have another report, or is it your thoughts?
> So I think that it is unnecessary to not initialize EC even when there
> is no _INI method under the scope of EC.
There are too many negatives in one sentence. Please do a patch.
>> For _STA methods during device scan it is completely safe to enable EC op region
>> before, just because this is only a priority of driver assignment. We could be
>> very smart and add several priority passes to scan, but enabling EC before scan
>> does exactly what we need.
> OK. This can solve the problem. But maybe it is better to enable boot EC
> after the ACPI full initialization.

IMHO, you still don't understand why it is all needed... If EC is enabled after full ACPI init,
all bug reporters will have broken ACPI subsystems, just because all of their ACPI drivers will not be 
found or functioning. 
  
Write a patch, test it. It is that easy.

Regards,
Alex.
