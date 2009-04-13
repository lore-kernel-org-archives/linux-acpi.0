From: Niel Lambrechts <niel.lambrechts@gmail.com>
Subject: Re: 2.6.30-rc1 (latest git): thinkpad-acpi: cannot control	brightness
 with hotkeys
Date: Mon, 13 Apr 2009 17:16:42 +0200
Message-ID: <49E3575A.60204@gmail.com>
References: <49E10684.5090101@gmail.com>	 <20090411150555.8b13ed18.akpm@linux-foundation.org>	 <20090412161448.GC26502@khazad-dum.debian.net> <49E234ED.5010105@gmail.com> <1239585695.5564.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:34925 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbZDMPQZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Apr 2009 11:16:25 -0400
In-Reply-To: <1239585695.5564.5.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Andrew Morton <akpm@linux-foundation.org>, "linux.kernel" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, mjg59@srcf.ucam.org

On 04/13/2009 03:21 AM, yakui_zhao wrote:
> On Mon, 2009-04-13 at 02:37 +0800, Niel Lambrechts wrote:
>   
>> On 04/12/2009 06:14 PM, Henrique de Moraes Holschuh wrote:
>>     
>>> On Sat, 11 Apr 2009, Andrew Morton wrote:
>>>   
>>>       
>>>>> With latest git kernel, I'm no longer able to control my Thinkpad (W500)
>>>>> brightness, although I can still control the backlight, bluetooth etc.
>>>>>       
>>>>>           
>>> Niels, something just occourred to me.  Is your problem the hotkeys, or the
>>> brightness control itself?  Check /sys/class/backlight/*, please.  What do
>>> you have in there?  Does it work?
>>>   
>>>       
>> Hi Henrique,
>>     
> Will you please check whether there exists the /sys/class/backlight/*/*?
>   
I already did mention that the directory does not exist when using
2.6.30 - see down below.

The directory only exists when I use 2.6.29.1 or 2.6.28.x, so there is
some type of regression.
>  
> If not, will you please load the i915 driver and see whether the
> backlight can be controlled by hotkeys?(The CONFIG_DRM_I915_KMS should
> be enabled in kernel configuration).
>   

I'm not using modeset=1, as I have even worse results with
i915.modeset=1 enabled (freezing system / black screen). So the results
I gave was using:

Graphics card: Mobile Intel GM45 Express Chipset

Option  "EXANoComposite"
Option "AccelMethod" "exa"
Option "MigrationHeuristic" "greedy"
Option "ExaNoComposite" "false"
Option "VBERestore" "true"
  
> Thanks.
>   
>> The directory is empty - this is when I used 2.6.30-rc1 (latest git)
>> from yesterday. I'll keep retrying with the latest git kernels though.
>>
>> The only additional observations I can provide is:
>> 1) pulling/plugging the power cord does actually have an effect on the
>> brightness.
>> 2) resuming form hibernate - Xorg is blank, until I simultaneously press
>> a keyboard key and touch the synaptics pad. But I have this problem in
>> 2.6.28/2.6.29 as well, and I guess it could either be vesafb or ACPI
>> related, as it also happened when I used s2disk in a console session
>> outside of X.
>>
>> In 2.6.29.1:
>> lrwxrwxrwx 1 root root 0 Apr 12 20:01 /sys/class/backlight/acpi_video0
>> -> ../../devices/virtual/backlight/acpi_video0
>>
>> which contains:
>> drwxr-xr-x 3 root root    0 Apr 12 20:01 ./
>> drwxr-xr-x 3 root root    0 Apr 12 20:01 ../
>> -r--r--r-- 1 root root 4096 Apr 12 20:02 actual_brightness
>> -rw-r--r-- 1 root root 4096 Apr 12 20:02 bl_power
>> -rw-r--r-- 1 root root 4096 Apr 12 20:02 brightness
>> -r--r--r-- 1 root root 4096 Apr 12 20:01 max_brightness
>> drwxr-xr-x 2 root root    0 Apr 12 20:02 power/
>> lrwxrwxrwx 1 root root    0 Apr 12 20:01 subsystem ->
>> ../../../../class/backlight/
>> -rw-r--r-- 1 root root 4096 Apr 12 20:01 uevent
>>
>> max_brightness = 15 and echoing values [0-15] to brightness controls it
>> as expected, or just using the standard thinkpad keys (Fn-Home to increase).
>>     
Thanks
Niel
