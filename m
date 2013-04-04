From: Aaron Lu <aaron.lwe@gmail.com>
Subject: Re: [PATCH 3/5] acpi_video: Add workaround for broken Windows 8 backlight
 implementations
Date: Thu, 04 Apr 2013 21:46:47 +0800
Message-ID: <515D8447.7040806@gmail.com>
References: <20130307193812.GD24233@thinkpad-t410> <1362685180-7768-1-git-send-email-seth.forshee@canonical.com> <1362685180-7768-3-git-send-email-seth.forshee@canonical.com> <515D6784.4010900@gmail.com> <20130404123506.GB22945@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44835 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760635Ab3DDNvE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Apr 2013 09:51:04 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1439692pbb.33
        for <linux-acpi@vger.kernel.org>; Thu, 04 Apr 2013 06:51:04 -0700 (PDT)
In-Reply-To: <20130404123506.GB22945@thinkpad-t410>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>

On 04/04/2013 08:35 PM, Seth Forshee wrote:
> On Thu, Apr 04, 2013 at 07:44:04PM +0800, Aaron Lu wrote:
>> On 03/08/2013 03:39 AM, Seth Forshee wrote:
>>> Windows 8 requires that all backlights report 101 brightness levels.
>>> When Lenovo updated the firmware for some machines for Windows 8 they
>>> met this requirement my making _BCL return a larger set of values for
>>> Windows 8 than for other OSes. However, only the values in the smaller
>>> set actually change the brightness at all. The rest of the values are
>>> silently discarded.
>>>
>>> As a workaround, change acpi_video to set all intermediate backlight
>>> levels when setting the brightness. This isn't perfect, but it will mean
>>> that most brightness changes done by common userspace utilities will hit
>>> at least one valid brightness value.
>>>
>>> [1] http://msdn.microsoft.com/en-us/library/windows/hardware/jj128256.aspx
>>>
>>> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
>>> ---
>>>  drivers/acpi/video.c |   51 ++++++++++++++++++++++++++++++++++++++++----------
>>>  1 file changed, 41 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
>>> index edfcd74..b83fbbd 100644
>>> --- a/drivers/acpi/video.c
>>> +++ b/drivers/acpi/video.c
>>> @@ -352,25 +352,56 @@ acpi_video_device_lcd_query_levels(struct acpi_video_device *device,
>>>  static int
>>>  acpi_video_device_lcd_set_state(struct acpi_video_device *device, int state)
>>>  {
>>> -	int level = device->brightness->levels[state];
>>>  	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
>>>  	struct acpi_object_list args = { 1, &arg0 };
>>> +	int curr_state, offset;
>>>  	acpi_status status;
>>> +	int result = 0;
>>>  
>>> -	arg0.integer.value = level;
>>> +	curr_state = device->brightness->curr_state;
>>>  
>>> -	status = acpi_evaluate_object(device->dev->handle, "_BCM",
>>> -				      &args, NULL);
>>> -	if (ACPI_FAILURE(status)) {
>>> -		ACPI_ERROR((AE_INFO, "Evaluating _BCM failed"));
>>> -		return -EIO;
>>> +	/*
>>> +	 * Some Lenovo firmware has a broken backlight implementation
>>> +	 * for Windows 8 where _BCL returns 101 backlight levels but
>>> +	 * only 16 or so levels actually change the brightness at all.
>>> +	 * As a workaround for these machines we set every intermediate
>>> +	 * value between the old and new brightness levels whenever the
>>> +	 * system has made the Windows 8 OSI call, hoping that at least
>>> +	 * one of them will cause a change in brightness.
>>> +	 */
>>> +	if (acpi_osi_windows_version() == ACPI_OSI_WIN_8) {
>>
>> What do you think of testing br->count > 100 instead of OSI version? It
>> looks like only win8 systems will try to claim so many brightness levels.
> 
> I agree that it would be roughly the same set of machines today. But if
> we assume Microsoft will keep the same requirement in the future then it
> begins to expand beyond Windows 8.

Right, and the br->count > 100 test should also work, so it seems to be
a better condition check than OSI version.

> 
> If anything I'd prefer reducing the number of machines we apply this
> workaround to. Like say limiting it to Lenovo Win8 machines, if we can
> reasonably assume that Lenovo will be the only vendor with this
> ridiculous implementation.

This is probably not the case. I saw a Dell system also claims to have
100 levels in win8 mode:
https://bugzilla.kernel.org/show_bug.cgi?id=55071

Thanks,
Aaron

