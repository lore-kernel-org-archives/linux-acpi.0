From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Intel GemniLake xHCI connected devices can never wake up the
 system from suspend
Date: Sun, 18 Mar 2018 23:36:47 +0100
Message-ID: <CAJZ5v0g0DH03WYO3+7CZ2_mR+t3pJ6N9xnKL2OCOjGGRT9HiAw@mail.gmail.com>
References: <CAD8Lp45tvQP0aA=6zg+1j-_0jTxyyNxnrL=Gt0+0WrzeT6XS0Q@mail.gmail.com>
 <20180316082320.12636-1-drake@endlessm.com> <71f9b3cb-a66b-937a-8cfc-7b9127f6f5b9@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <71f9b3cb-a66b-937a-8cfc-7b9127f6f5b9@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Daniel Drake <drake@endlessm.com>, Chris Chiu <chiu@endlessm.com>, "Nyman, Mathias" <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 16, 2018 at 10:06 AM, Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
> Adding Rafael directly to CC
>
> In short, if _S3D and _S3W are missing in DSDT then a PCI device
> stays in D0 during suspend in Linux, but goes to D3 in Windows.
>
> USB wake doesn't work in Geminilake because of this.
>
> Should this be changed? reasoning below.

It can be changed if that doesn't cause problems to happen.


> On 16.03.2018 10:23, Daniel Drake wrote:
>>>
>>> I've studied the ACPI spec trying to understand better, but I'm
>>> struggling with the question:
>>> What is the maximum number (lowest power) permitted device power state
>>> for a device that is configured as able to wake the system from S3,
>>> **that does not implement the _S3W method**?
>>
>>
>> Actually the ACPI spec has an answer for the case when _S3D is present.
>> The lack of clarity is only over the situation when both _S3D and _S3W
>> are missing - like on the platforms being worked on here.
>>
>> The _S3D docs say:
>>>
>>> If the device can wake the system from the S3 system sleeping state (see
>>> _PRW) then the device must support wake in the D-state returned by this
>>> object. However, OSPM cannot assume wake from the S3 system sleeping
>>> state
>>> is supported in any deeper D-state unless specified by a corresponding
>>> _S3W object
>>
>>
>> Looking at the design of the existing Linux code, it seems like this
>> "max = min" assignment that is causing us trouble originates directly
>> from an attempt to implement that logic: if we didn't get a response from
>> _S3W, then we must clamp ourselves to the data we got from _S3D.
>>
>> If I modify the Linux code to be a little more specific in that logic
>> (only applying when we actually got something from _S3D) then the
>> problematic behaviour is avoided and USB wakeups work.
>>
>> I feel that this change makes the Linux implementation more directly
>> mirror the wording in the ACPI spec and it's associated lack of clarity
>> for when both methods are missing. Thoughts?
>>
>> ---
>>   drivers/acpi/device_pm.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
>> index a4c8ad98560d..44f12c5c75ee 100644
>> --- a/drivers/acpi/device_pm.c
>> +++ b/drivers/acpi/device_pm.c
>> @@ -543,6 +543,7 @@ static int acpi_dev_pm_get_state(struct device *dev,
>> struct acpi_device *adev,
>>         unsigned long long ret;
>>         int d_min, d_max;
>>         bool wakeup = false;
>> +       acpi_status sxd_status;
>>         acpi_status status;
>>         /*
>> @@ -565,8 +566,8 @@ static int acpi_dev_pm_get_state(struct device *dev,
>> struct acpi_device *adev,
>>                  * provided if AE_NOT_FOUND is returned.
>>                  */
>>                 ret = d_min;
>> -               status = acpi_evaluate_integer(handle, method, NULL,
>> &ret);
>> -               if ((ACPI_FAILURE(status) && status != AE_NOT_FOUND)
>> +               sxd_status = acpi_evaluate_integer(handle, method, NULL,
>> &ret);
>> +               if ((ACPI_FAILURE(sxd_status) && sxd_status !=
>> AE_NOT_FOUND)
>>                     || ret > ACPI_STATE_D3_COLD)
>>                         return -ENODATA;
>>   @@ -599,7 +600,11 @@ static int acpi_dev_pm_get_state(struct device
>> *dev, struct acpi_device *adev,
>>                 method[3] = 'W';
>>                 status = acpi_evaluate_integer(handle, method, NULL,
>> &ret);
>>                 if (status == AE_NOT_FOUND) {
>> -                       if (target_state > ACPI_STATE_S0)
>> +                       /* No _SxW. In this case, the ACPI spec says that
>> we
>> +                        * must not go into any power state deeper than
>> the
>> +                        * value returned from _SxD.
>> +                        */
>> +                       if (sxd_status == AE_OK && target_state >
>> ACPI_STATE_S0)
>>                                 d_max = d_min;
>>                 } else if (ACPI_SUCCESS(status) && ret <=
>> ACPI_STATE_D3_COLD) {
>>                         /* Fall back to D3cold if ret is not a valid
>> state. */
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
